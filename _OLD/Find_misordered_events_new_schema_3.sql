select hello.InsertedVersion, hello.EffectiveVersion, * from Event hello
inner join
(
select distinct e.AggregateId from
Event e
inner Join 
(
select EffectiveVersions.AggregateBasedEffectiveVersion, EffectiveVersions.EffectiveVersion, EffectiveVersions.EventId, EffectiveVersions.AggregateId from Event e 
inner join 
	(
		select  
		e2.AggregateId,
		e2.EffectiveVersion,
		e2.EventId,
		ROW_NUMBER() over (partition by AggregateId order by EffectiveReadOrder) as AggregateBasedEffectiveVersion
		from event e2
	) as EffectiveVersions

	on e.EventId = EffectiveVersions.EventId

	where e.EffectiveVersion != EffectiveVersions.AggregateBasedEffectiveVersion
) Broken

on e.EventId = Broken.EventId
)brokenAggregates

on hello.AggregateId = brokenAggregates.Aggregateid
order by hello.AggregateId, hello.InsertedVersion