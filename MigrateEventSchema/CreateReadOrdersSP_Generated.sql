
ALTER PROCEDURE CreateReadOrders
AS

set nocount on

declare @InsertBefore bigint
declare @InsertAfter bigint
declare @Replaces bigint
declare @EventsToReorder bigint
declare @BeforeReadOrder decimal(38,19)
declare @AfterReadOrder decimal(38,19)
declare @AvailableSpaceBetwenReadOrders decimal(38,19)
declare @Increment decimal(38,19)
declare @Done bit 
declare @Error nvarchar(4000)
set @Done = 0

WHILE @Done = 0
begin
	set @InsertAfter = null
	set @InsertBefore = null
	set @Replaces = null
	select top 1 @InsertAfter = InsertAfter,  @InsertBefore = InsertBefore, @Replaces = Replaces
	from Event where EffectiveReadOrder is null
	order by InsertionOrder asc

	if @Replaces is not null
		begin 
		   select @EventsToReorder = count(*) from Event where Replaces = @Replaces
		   select @BeforeReadOrder = abs(EffectiveReadOrder) from Event where InsertionOrder = @Replaces
		   select top 1 @AfterReadOrder = EffectiveReadOrder from Event where EffectiveReadOrder > @BeforeReadOrder and (Replaces is null or Replaces != @Replaces) order by EffectiveReadOrder          

           if @AfterReadOrder is null
           begin 
            set @Error = 'Failed to find AfterReadOrder during replacement of InsertionOrder: ' + cast(@Replaces as nvarchar) + ' you are probably trying to replace the last event in the event store. That is not supported.'
            break
           end
           

		   set @AvailableSpaceBetwenReadOrders = @AfterReadOrder - @BeforeReadOrder
		   set @Increment = @AvailableSpaceBetwenReadOrders / @EventsToReorder

		   update Event set ManualReadOrder = -EffectiveReadOrder where InsertionOrder = @Replaces AND EffectiveReadOrder > 0

			update Event
				set ManualReadOrder = ReadOrders.EffectiveReadOrder
			from Event
			inner join 		
				(select InsertionOrder, (@BeforeReadOrder + ((ROW_NUMBER() over (order by InsertionOrder asc)) -1) *  @Increment) as EffectiveReadOrder
				from Event
				where Replaces = @Replaces) ReadOrders
				on Event.InsertionOrder = ReadOrders.InsertionOrder
		end 
	else if @InsertAfter is not null
		begin 
		   select @EventsToReorder = count(*) from Event where InsertAfter = @InsertAfter
		   select @BeforeReadOrder = EffectiveReadOrder from Event where InsertionOrder = @InsertAfter
           if @BeforeReadOrder < 0 --The event we are inserting after has been replaced and it might be by multiple events, so get the highest of the replacing readorders
              select @BeforeReadOrder = max(EffectiveReadOrder) from Event where Replaces = @InsertAfter

		   select top 1 @AfterReadOrder = EffectiveReadOrder from Event where EffectiveReadOrder > @BeforeReadOrder and (InsertAfter is null or InsertAfter != @InsertAfter) order by EffectiveReadOrder
           if @AfterReadOrder is null
           begin 
            set @Error = 'Failed to find AfterReadOrder inserting events after InsertionOrder: ' + cast(@InsertAfter as nvarchar) + ' you are probably trying to insert after the last event in the event store. That is not supported.'
            break
           end

		   set @AvailableSpaceBetwenReadOrders = @AfterReadOrder - @BeforeReadOrder
		   set @Increment = @AvailableSpaceBetwenReadOrders / (@EventsToReorder + 1)

			update Event
				set ManualReadOrder = ReadOrders.EffectiveReadOrder
			from Event
			inner join 		
				(select InsertionOrder, (@BeforeReadOrder + (ROW_NUMBER() over (order by InsertionOrder asc)) *  @Increment) as EffectiveReadOrder
				from Event
				where InsertAfter = @InsertAfter) ReadOrders
				on Event.InsertionOrder = ReadOrders.InsertionOrder
		end								
	else if @InsertBefore is not null
		begin 
		   select @EventsToReorder = count(*) from Event where InsertBefore = @InsertBefore
		   
		   select @AfterReadOrder = abs(EffectiveReadOrder) from Event where InsertionOrder = @InsertBefore


		   select top 1 @BeforeReadOrder = EffectiveReadOrder from Event where EffectiveReadOrder < @AfterReadOrder and (InsertBefore is null or InsertBefore != @InsertBefore) order by EffectiveReadOrder desc
		   if(@BeforeReadOrder is null or @BeforeReadOrder < 0)
				set @BeforeReadOrder = cast(0 as decimal(38,19)) --We are inserting before the first event in the whole event store and possibly the original first event has been replaced and thus has a negative EffectiveReadOrder

		   set @AvailableSpaceBetwenReadOrders = @AfterReadOrder - @BeforeReadOrder
		   set @Increment = @AvailableSpaceBetwenReadOrders / (@EventsToReorder + 1)


			update Event
				set ManualReadOrder = ReadOrders.EffectiveReadOrder
			from Event
			inner join 		
				(select InsertionOrder, (@BeforeReadOrder + (ROW_NUMBER() over (order by InsertionOrder asc)) *  @Increment) As EffectiveReadOrder
				from Event
				where InsertBefore = @InsertBefore) ReadOrders
				on Event.InsertionOrder = ReadOrders.InsertionOrder
		end
	else
	    begin 
	     set @Done = 1
	    end 
end

set nocount off

if @Error is not null 
    raiserror (@Error, 18, -1);


