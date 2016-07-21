begin tran

update Event
Set InsertedVersion = ExpectedVersions.ExpectedVersion
from 
(
	select 
		*, 	
		(select min(InsertedVersion) from Event e2 where e2.AggregateId = temp.AggregateId and LegacySqlTimeStamp is null) -1  + AfterNewSchemaVersionIncrement as ExpectedVersion
	from 
	(
		select *, row_number() over (partition by AggregateId order by InsertionOrder ) AfterNewSchemaVersionIncrement
		from Event
		where LegacySqlTimestamp is null
	) temp 
) ExpectedVersions
where ExpectedVersions.ExpectedVersion != ExpectedVersions.InsertedVersion
and Event.AggregateId = ExpectedVersions.AggregateId
and Event.InsertedVersion = ExpectedVersions.InsertedVersion

select InsertedVersion, AggregateId, InsertedVersion, ExpectedVersion, AfterNewSchemaVersionIncrement from
(
	select 
		*, 	
		(select min(InsertedVersion) from Event e2 where e2.AggregateId = temp.AggregateId and LegacySqlTimeStamp is null) -1  + AfterNewSchemaVersionIncrement as ExpectedVersion
	from 
	(
		select *, row_number() over (partition by AggregateId order by InsertionOrder ) AfterNewSchemaVersionIncrement
		from Event
		where LegacySqlTimestamp is null
	) temp 
) ExpectedVersions
where ExpectedVersion != InsertedVersion


rollback tran

