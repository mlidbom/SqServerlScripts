/*
DROP TABLE Event
DROP TABLE EventType

*/


BEGIN TRANSACTION


    CREATE TABLE [dbo].[EventType](
	    [Id] [int] IDENTITY(1,1) NOT NULL,
	    [EventType] [nvarchar](450) NOT NULL,
        CONSTRAINT [PK_EventType] PRIMARY KEY CLUSTERED 
        (
    	    [Id] ASC
        )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
        CONSTRAINT [IX_Uniq_EventType] UNIQUE
        (
	        EventType
        )
    )


GO


CREATE TABLE dbo.Event(
    InsertionOrder bigint IDENTITY(1,1) NOT NULL,
    InsertAfter bigint null,
    InsertBefore bigint null,
    Replaces bigint null,
    ManualReadOrder decimal(38,19) null,
    AggregateId uniqueidentifier NOT NULL,
    InsertedVersion int NOT NULL,
    ManualVersion int NULL,
    TimeStamp datetime NOT NULL,
    SqlInsertDateTime datetime2 default SYSUTCDATETIME(),
    EventType int NOT NULL,
    EventId uniqueidentifier NOT NULL,
    Event nvarchar(max) NOT NULL,
    EffectiveReadOrder as case 
        when ManualReadOrder is not null then ManualReadOrder
        when InsertAfter is null and InsertBefore is null and Replaces is null then cast(InsertionOrder as decimal(38,19))
        else null
    end,
    EffectiveVersion as case 
        when ManualVersion is not null then ManualVersion
        when InsertAfter is null and InsertBefore is null and Replaces is null then InsertedVersion
        else null
    end,

    CONSTRAINT PK_Event PRIMARY KEY CLUSTERED 
    (
        AggregateId ASC,
        InsertedVersion ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = OFF),

    CONSTRAINT IX_Event_Unique_EventId UNIQUE
    (
        EventId
    ),

    CONSTRAINT IX_Event_Unique_InsertionOrder UNIQUE
    (
        InsertionOrder
    ),

    CONSTRAINT CK_Event_Only_one_reordering_column_allowed_for_use
    CHECK 
    (
        (InsertAfter is null and InsertBefore is null)
        or
        (InsertAfter is null and Replaces is null)
        or
        (InsertBefore is null and Replaces is null) 
    ),

    CONSTRAINT FK_Event_EventType FOREIGN KEY (EventType) 
        REFERENCES EventType (Id),

    CONSTRAINT FK_Event_Replaces FOREIGN KEY ( Replaces ) 
        REFERENCES Event (InsertionOrder),

    CONSTRAINT FK_Event_InsertBefore FOREIGN KEY ( InsertBefore )
        REFERENCES Event (InsertionOrder),

    CONSTRAINT FK_Event_InsertAfter FOREIGN KEY ( InsertAfter ) 
        REFERENCES Event (InsertionOrder) 
)

    CREATE NONCLUSTERED INDEX IX_Event_EffectiveReadOrder ON dbo.Event
        (EffectiveReadOrder)
        INCLUDE (EventType, InsertionOrder)

    CREATE NONCLUSTERED INDEX IX_Event_Replaces	ON dbo.Event
        (Replaces)
        INCLUDE (InsertionOrder)

    CREATE NONCLUSTERED INDEX IX_Event_InsertAfter	ON dbo.Event
        (InsertAfter)
        INCLUDE (InsertionOrder)

    CREATE NONCLUSTERED INDEX IX_Event_InsertBefore	ON dbo.Event 
        (InsertBefore)
        INCLUDE (InsertionOrder)

    CREATE NONCLUSTERED INDEX IX_Event_EffectiveVersion	ON dbo.Event 
        (EffectiveVersion)



ALTER TABLE Event 
Add LegacySqlTimeStamp Bigint NULL

GO


INSERT INTO EventType ( EventType )
SELECT EventType 
FROM Events
GROUP BY EventType 


GO


INSERT INTO Event 
(      AggregateId, InsertedVersion, TimeStamp, EventType, EventId, Event, LegacySqlTimeStamp, SqlInsertDateTime)
SELECT top 1000 AggregateId, AggregateVersion,TimeStamp, EventType.Id, EventId, Event, CAST(SqlTimeStamp AS BIGINT), TimeStamp
FROM Events
INNER JOIN EventType
ON Events.EventType = EventType.EventType
ORDER BY SqlTimeStamp ASC


GO

--DROP TABLE Events


