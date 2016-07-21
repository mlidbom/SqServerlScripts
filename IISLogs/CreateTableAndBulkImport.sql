drop table Log

CREATE TABLE [dbo].[Log] (
	[date-string] [varchar] (50) NULL,
	[time-string] [datetime] NULL,	
	[s-ip] [varchar] (50) NULL ,
	[cs-method] [varchar] (50) NULL ,
	[cs-uri-stem] [varchar] (2048) NULL ,
	[cs-uri-query] [varchar] (2048) NULL ,
	[s-port] [integer] NULL,
	[cs-username] [varchar] (2048) NULL,
	[c-ip] [varchar] (50) NULL,
	[cs(User-Agent)] [varchar] (2048) NULL ,
	[cs(Referer)] [varchar] (2048) NULL,
	[sc-status] [int] NULL ,
	[sc-substatus] [int] NULL ,
	[sc-win32-status] [bigint] NULL,
	[time-taken] [int] NULL
	)	  


BULK INSERT [dbo].[Log] FROM 'c:\prepped.log'
WITH (
    FIELDTERMINATOR = ' ',
    ROWTERMINATOR = '\n'
)
		

alter table Log 
add [time] datetime null

update Log 
set time = cast([date-string] + ' ' + [time-string] as datetime)

create nonclustered index IX_time on Log (time)

create nonclustered index [IX_time-taken] on Log ([time-taken])

create nonclustered index [IX_s-ip] on Log ([s-ip])

create nonclustered index [IX_c-ip] on Log ([c-ip])

select top 10 * from Log