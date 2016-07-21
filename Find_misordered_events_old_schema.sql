

select distinct AggregateId from
Events e
inner Join 
(
select EffectiveVersions.SqlTimeStampBasedEffectiveVersion, EffectiveVersions.AggregateVersion, EffectiveVersions.EventId from Events e 
inner join 
	(
		select  
		e2.SqlTimeStamp,
		e2.EventId,
		ROW_NUMBER() over (partition by AggregateId order by SqlTimeStamp) as SqlTimeStampBasedEffectiveVersion,
		e2.AggregateVersion
		from events e2
	) as EffectiveVersions

	on e.EventId = EffectiveVersions.EventId

	where e.AggregateVersion != EffectiveVersions.SqlTimeStampBasedEffectiveVersion
) Broken

on e.EventId = Broken.EventId
