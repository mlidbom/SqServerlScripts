select e.LegacySqlTimeStamp, EffectiveVersions.SqlTimeStampBasedEffectiveVersion, EffectiveVersions.InsertedVersion, EffectiveVersions.EventId, e.* from Event e 
inner join 
	(
		select  
		e2.LegacySqlTimeStamp,
		e2.EventId,
		ROW_NUMBER() over (partition by AggregateId order by EffectiveReadOrder) as SqlTimeStampBasedEffectiveVersion,
		e2.InsertedVersion
		from event e2
	) as EffectiveVersions

	on e.EventId = EffectiveVersions.EventId
	where e.EffectiveVersion != EffectiveVersions.SqlTimeStampBasedEffectiveVersion
	order by e.LegacySqlTimeStamp