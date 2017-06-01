USE [IntakeDomain]
GO

--/****** Object:  Table [dbo].[CompressedEvents]    Script Date: 2015-11-10 10:56:55 ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO

--SET ANSI_PADDING ON
--GO

--CREATE TABLE [dbo].[CompressedEvents](
--	[AggregateId] [uniqueidentifier] NOT NULL,
--	[AggregateVersion] [int] NOT NULL,
--	[EventType] [varchar](300) NOT NULL,
--	[Event01] [nvarchar](4000) NULL,
--	[Event02] [nvarchar](4000) NULL,
--	[Event03] [nvarchar](4000) NULL,
--	[Event04] [nvarchar](4000) NULL,
--	[Event05] [nvarchar](4000) NULL,
--	[Event06] [nvarchar](4000) NULL,
--	[Event07] [nvarchar](4000) NULL,
--	[Event08] [nvarchar](4000) NULL,
--	[Event09] [nvarchar](4000) NULL,
--	[Event10] [nvarchar](4000) NULL,
--	[Event11] [nvarchar](4000) NULL,
--	[Event12] [nvarchar](4000) NULL,
--	[Event13] [nvarchar](4000) NULL,
--	[Event14] [nvarchar](4000) NULL
--) 

--GO

--ALTER TABLE dbo.CompressedEvents ADD CONSTRAINT
--	PK_CompressedEvents PRIMARY KEY CLUSTERED 
--	(
--	AggregateId,
--	AggregateVersion
--	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]


--SET ANSI_PADDING OFF

--GO 

--ALTER TABLE [dbo].[CompressedEvents] REBUILD PARTITION = ALL
--WITH 
--(DATA_COMPRESSION = PAGE
--)

USE [IntakeDomain]
ALTER TABLE [dbo].[CompressedEvents] REBUILD PARTITION = ALL
WITH 
(DATA_COMPRESSION = NONE
)


--GO


declare @ColumnLength int
set @ColumnLength = 4000

insert CompressedEvents
select 
--top 10000
	e.AggregateId,
	e.AggregateVersion,
	e.EventType,
	--e.EventId,
	substring(e.Event,0, @ColumnLength * 1) as Event01,
	substring(e.Event, @ColumnLength * 1, @ColumnLength) as Event02,
	substring(e.Event, @ColumnLength * 2, @ColumnLength) as Event03,
	substring(e.Event, @ColumnLength * 3, @ColumnLength) as Event04,
	substring(e.Event, @ColumnLength * 4, @ColumnLength) as Event05,
	substring(e.Event, @ColumnLength * 5, @ColumnLength) as Event06,
	substring(e.Event, @ColumnLength * 6, @ColumnLength) as Event07,
	substring(e.Event, @ColumnLength * 7, @ColumnLength) as Event08,
	substring(e.Event, @ColumnLength * 8, @ColumnLength) as Event09,
	substring(e.Event, @ColumnLength * 9, @ColumnLength) as Event10,
	substring(e.Event, @ColumnLength * 10, @ColumnLength) as Event11,
	substring(e.Event, @ColumnLength * 11, @ColumnLength) as Event12,
	substring(e.Event, @ColumnLength * 12, @ColumnLength) as Event13,
	substring(e.Event, @ColumnLength * 13, @ColumnLength) as Event14
from events e

insert CompressedEvents2
select 
top 10
	e.AggregateId,
	e.AggregateVersion,
	e.EventType,
	e.Event
from events e

insert CompressedEvents3
select
top 100000
	e.AggregateId,
	e.AggregateVersion,
	e.EventType,
	substring(e.Event,0, 4000) as Event01
from events e


--delete compressedevents
--drop table CompressedEvents



exec sp_estimate_data_compression_savings 'dbo', 'CompressedEvents', null, null, 'page'


--ALTER TABLE [dbo].[CompressedEvents2] REBUILD WITH  (DATA_COMPRESSION = NONE )
--ALTER TABLE [dbo].[CompressedEvents3] REBUILD WITH  (DATA_COMPRESSION = NONE )

exec sp_estimate_data_compression_savings 'dbo', 'CompressedEvents2', null, null, 'none'
exec sp_estimate_data_compression_savings 'dbo', 'CompressedEvents2', null, null, 'row'
exec sp_estimate_data_compression_savings 'dbo', 'CompressedEvents2', null, null, 'page'



exec sp_estimate_data_compression_savings 'dbo', 'CompressedEvents3', null, null, 'none'
exec sp_estimate_data_compression_savings 'dbo', 'CompressedEvents3', null, null, 'row'
exec sp_estimate_data_compression_savings 'dbo', 'CompressedEvents3', null, null, 'page'

