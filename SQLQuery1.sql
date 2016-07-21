/*Database is using a legacy schema. You need to migrate your data into the new schema.
Paste this whole log mesage into a sql management studio window and it will uppgrade the database for you
1: Create new tables: */

USE CVManagementDomain

GO

BEGIN TRANSACTION


    CREATE TABLE [dbo].[EventType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EventType] [varchar](300) NOT NULL,
    CONSTRAINT [PK_EventType] PRIMARY KEY CLUSTERED 
    (
    	[Id] ASC
    )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
    CONSTRAINT [IX_Uniq_EventType] UNIQUE
    (
	    EventType
    )
    ) ON [PRIMARY]


GO


CREATE TABLE [dbo].[Event](
    InsertionOrder [bigint] IDENTITY(10,10) NOT NULL,
	AggregateId [uniqueidentifier] NOT NULL,
	AggregateVersion [int] NOT NULL,
	TimeStamp [datetime] NOT NULL,
    SqlTimeStamp [datetime] NOT NULL,
    EventType [int] NOT NULL,
	EventId [uniqueidentifier] NOT NULL,
	Event [nvarchar](max) NOT NULL,
CONSTRAINT [IX_Uniq2_EventId] UNIQUE
(
	EventId
),
CONSTRAINT [IX_Uniq_InsertionOrder] UNIQUE
(
	InsertionOrder
),
CONSTRAINT [PK_Event] PRIMARY KEY CLUSTERED 
(
	AggregateId ASC,
	AggregateVersion ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = OFF) ON [PRIMARY],
CONSTRAINT FK_Events_EventType FOREIGN KEY (EventType) 
    REFERENCES EventType (Id) 
) ON [PRIMARY]
CREATE UNIQUE NONCLUSTERED INDEX [InsertionOrder] ON [dbo].[Event]
(
	[InsertionOrder] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]


ALTER TABLE Event 
Add LegacySqlTimeStamp Bigint NULL

GO


INSERT INTO EventType ( EventType )
SELECT EventType 
FROM Events
GROUP BY EventType 


GO


INSERT INTO Event 
(      AggregateId, AggregateVersion, TimeStamp, EventType, EventId, Event, LegacySqlTimeStamp, SqlTimeStamp)
SELECT AggregateId, AggregateVersion,TimeStamp, EventType.Id, EventId, Event, CAST(SqlTimeStamp AS BIGINT), TimeStamp
FROM Events
INNER JOIN EventType
ON Events.EventType = EventType.EventType
ORDER BY SqlTimeStamp ASC


GO



COMMIT TRANSACTION

GO

/*
DROP TABLE Event
DROP TABLE EventType

DBCC SHRINKDATABASE ( IntakeDomain )

*/

