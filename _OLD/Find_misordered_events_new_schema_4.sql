

select 
	e.InsertionOrder, 	
	cast(e.EffectiveReadOrder as float) EffectiveReadOrder, 
	e.AggregateId, 
	e.InsertedVersion,
	e.EffectiveVersion,
	Broken.SqlTimeStampBasedEffectiveVersion, 
	e.ManualVersion,
	e.* from
Event e
inner Join 
(
select distinct EffectiveVersions.Aggregateid, EffectiveVersions.SqlTimeStampBasedEffectiveVersion from Event e 
inner join 
	(
		select  
		e2.AggregateId,
		e2.LegacySqlTimeStamp,
		e2.EventId,
		ROW_NUMBER() over (partition by AggregateId order by EffectiveReadOrder) as SqlTimeStampBasedEffectiveVersion,
		e2.InsertedVersion
		from event e2
	) as EffectiveVersions

	on e.EventId = EffectiveVersions.EventId

	where e.EffectiveVersion != EffectiveVersions.SqlTimeStampBasedEffectiveVersion
) Broken

on e.AggregateId = Broken.AggregateId
order by e.InsertionOrder asc
