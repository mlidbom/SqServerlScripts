select e.AggregateId, InsertedVersion, row_number() over (partition by e.AggregateId order by e.EffectiveReadOrder) NewVersion, EffectiveVersion
	        from Event e