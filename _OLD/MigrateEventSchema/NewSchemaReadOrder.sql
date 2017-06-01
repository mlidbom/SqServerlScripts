--drop view vEventOrder
drop table [Event]


CREATE TABLE [dbo].[Event](
    InsertionOrder [bigint] IDENTITY(1,1) NOT NULL,
    InsertAfter [bigint] null,
    InsertBefore [bigint] null,
    Replaces [bigint] null,
    ManualReadOrder decimal(38,19) null,
	EventId uniqueidentifier not null default newsequentialid(),
	Event nvarchar(4000) not null,
	Version int not null,
	ManualVersion int null,
	EffectiveReadOrder as case
		when ManualReadOrder is not null then ManualReadOrder
		when InsertAfter is null and InsertBefore is null and Replaces is null then cast(InsertionOrder as decimal(38,19))
		else null
	end,
	EffectiveVersion as case 
		when InsertAfter is null and InsertBefore is null and Replaces is null then Version
		else ManualVersion
	end

CONSTRAINT [IX_Uniq2_InsertionOrder] UNIQUE
(
	InsertionOrder
),
CONSTRAINT CK_Only_one_reordering_column_specified
CHECK (
	(InsertAfter is null and InsertBefore is null)
	or
	(InsertAfter is null and Replaces is null)
	or
	(InsertBefore is null and Replaces is null) ),

CONSTRAINT FK_Replaces FOREIGN KEY ( Replaces ) 
    REFERENCES Event (InsertionOrder),

CONSTRAINT FK_InsertBefore FOREIGN KEY ( InsertBefore )
    REFERENCES Event (InsertionOrder),

CONSTRAINT FK_InsertAfter FOREIGN KEY ( InsertAfter ) 
    REFERENCES Event (InsertionOrder)
)

GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_Unique_ManualReadOrder] ON [dbo].[Event]
(
	ManualReadOrder ASC
) WHERE ManualReadOrder IS NOT NULL

go 

CREATE NONCLUSTERED INDEX [IX_Unique_Effective_ReadOrder] ON [dbo].[Event]
(
	EffectiveReadOrder ASC
)INCLUDE (InsertionOrder)

GO

CREATE NONCLUSTERED INDEX [IX_ManualReadOrder] ON [dbo].[Event]
(
	ManualReadOrder ASC,
	InsertionOrder ASC
)

CREATE NONCLUSTERED INDEX [IX_Replaces]	ON [dbo].[Event] 
	([Replaces])
	INCLUDE ([InsertionOrder])

CREATE NONCLUSTERED INDEX [IX_InsertAfter]	ON [dbo].[Event] 
	([InsertAfter])
	INCLUDE ([InsertionOrder])

CREATE NONCLUSTERED INDEX [IX_InsertBefore]	ON [dbo].[Event] 
	([InsertBefore])
	INCLUDE ([InsertionOrder])


GO


GO


DECLARE @Count int
set @Count = 1

set nocount on

insert Event(Event)
select 'Something1' union select 'Something2' union select 'Something3' union select 'Something4' union select 'Something5' union select 'Something6' union select 'Something7' union select 'Something8' union select 'Something9'

while @Count < 1
begin 
	insert Event(Event) select Event from Event
	set @Count = @Count + 1
end

set nocount off

GO
