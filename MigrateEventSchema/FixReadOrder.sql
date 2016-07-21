/*
delete Event

DBCC CHECKIDENT ( Event, Reseed, 0  )

go

DECLARE @Count int
set @Count = 1

set nocount on

insert Event(Event)
select 'Something1' union select 'Something2' union select 'Something3' union select 'Something4' union select 'Something5' union select 'Something6' union select 'Something7' union select 'Something8' union select 'Something9'


insert Event(Event, Replaces) select 'Replace 2-1', 2

insert Event(Event, Replaces) select 'Replace 5-1', 5 union select 'Replace 5-2', 5

insert Event(Event, InsertBefore) select '', 1


insert Event(Event, InsertAfter) select 'InsertAfter 3-1', 3 union select 'InsertAfter 3-2', 3

insert Event(Event, InsertBefore) select 'InsertBefore 9-1', 9 union select 'InsertBefore 9-2', 9



insert Event(InsertBefore, Event)
select top 2 InsertionOrder, 'Insertbefore ' + CAST(InsertionOrder as varchar) from Event where InsertBefore is null and InsertAfter is null and Replaces is null and EffectiveReadOrder > 0


insert Event(Replaces, Event)
select top 2 InsertionOrder, 'Insertbefore ' + CAST(InsertionOrder as varchar) from Event where InsertBefore is null and InsertAfter is null and Replaces is null and EffectiveReadOrder > 0


insert Event(InsertAfter, Event)
select top 2 InsertionOrder, 'Insertbefore ' + CAST(InsertionOrder as varchar) from Event where InsertBefore is null and InsertAfter is null and Replaces is null and EffectiveReadOrder > 0


*/

--update Event SET ManualReadOrder = null

/*
delete Event

DBCC CHECKIDENT ( Event, Reseed, 0  )

insert Event(Event) select ''
insert Event(Event) select ''

insert Event(Event, Replaces) select '', 1
insert Event(Event, InsertBefore) select '', 1

insert Event(Event, InsertAfter) select '', 1
insert Event(Event, InsertBefore) select '', 1
insert Event(Event, Replaces) select '', 1


insert Event(Event) select ''

insert Event(Event, Replaces) select '', 20
insert Event(Event, InsertAfter) select '', 20

insert Event(Event, Replaces) select '', 22

insert Event(Event, InsertBefore) select '', 24
insert Event(Event, InsertBefore) select '', 31

insert Event(Event, InsertBefore) select '', 20

insert Event(Event, InsertBefore) select top 5000 '', 9 from Event

*/

--update Event SET ManualReadOrder = null



EXEC dbo.CreateReadOrders

go

select case when EffectiveReadOrder > 0 then '' when EffectiveReadOrder is null then '_unitiated_' else '##REPLACED##' end as Status, InsertionOrder as Inserted, InsertAfter After, InsertBefore Before, Replaces, 
EffectiveReadOrder Effective, ManualReadOrder Manual

 from Event 
--cast(EffectiveReadOrder as float) Effective, cast(ManualReadOrder as float) Manual from Event 
where 1=1 
and EffectiveReadOrder > 0
order by abs(EffectiveReadOrder), InsertionOrder





