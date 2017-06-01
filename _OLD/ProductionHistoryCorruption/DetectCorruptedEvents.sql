
select InsertedVersion, AggregateId, InsertedVersion, ExpectedVersion, AfterNewSchemaVersionIncrement  from
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



--select * from Event where aggregateid = '2193fd1e-f884-4ce6-8423-7423e65a42c9' and InsertedVersion > 1000