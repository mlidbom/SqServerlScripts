exec EnsurePersistedMigrationsHaveConsistentEffectiveReadOrdersAndEffectiveVersions 0

select InsertedVersion, EffectiveVersion, row_number() over (order by EffectiveReadOrder) rownumber,  * from Event
--update Event
--set InsertBefore = 1625813, InsertAfter = null
where AggregateId = '7C1BC789-E747-4887-A875-D722807D4F87'
--and rownumber != InsertedVersion
--and InsertAfter = 1625813
--and InsertedVersion = 33
order by EffectiveReadOrder


/*



update event 
Set InsertBefore = 1625884 where insertionorder in (	
1625887
)




'C8126A51-49BB-4614-94C4-A58AF3C3203B'
'2AB050C9-D516-4B52-AB4C-5A30C87D88B3'
'85810692-57E6-47A9-8D04-474096422AE5'
'7C1BC789-E747-4887-A875-D722807D4F87'
'048A314B-3A3F-4A50-A02E-3896649108C6'
'C536FD0A-3E9B-4AD1-B7F0-CAAB8C6ADFFC'



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



*/