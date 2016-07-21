
select InsertedVersion, AggregateId, InsertedVersion, ExpectedVersion, AfterNewSchemaVersionIncrement, FirstNewSchemaEventVersion  from
(
	select 
		*, 	
		(select min(InsertedVersion) from Event e2 where e2.AggregateId = temp.AggregateId and LegacySqlTimeStamp is null) as FirstNewSchemaEventVersion,
		(select min(InsertedVersion) from Event e2 where e2.AggregateId = temp.AggregateId and LegacySqlTimeStamp is null) -1  + AfterNewSchemaVersionIncrement as ExpectedVersion
	from 
	(
		select *, row_number() over (partition by AggregateId order by InsertionOrder ) AfterNewSchemaVersionIncrement
		from Event
		where LegacySqlTimestamp is null
	) temp 
) ExpectedVersions
where ExpectedVersion != InsertedVersion



--	and aggregateid = '2193fd1e-f884-4ce6-8423-7423e65a42c9'-- '97d19c9d-9cab-4857-ad97-512644e72b1e'