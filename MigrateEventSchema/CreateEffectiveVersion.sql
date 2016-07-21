
exec CreateReadOrders

update Event 
set ManualVersion = ChangedReadOrders.NewVersion
from Event 
	inner join 
(
	select * from
	(select e.AggregateId, InsertedVersion, row_number() over (partition by e.AggregateId order by e.EffectiveReadOrder) NewVersion, EffectiveVersion 
	 from Event e
	 inner join (select distinct AggregateId from Event where EffectiveVersion is null) NeedsFixing
		on e.AggregateId = NeedsFixing.AggregateId
	 where e.EffectiveReadOrder > 0) NewReadOrders
	where NewReadOrders.EffectiveVersion is null or ( NewReadOrders.NewVersion != NewReadOrders.EffectiveVersion)
) ChangedReadOrders

on Event.AggregateId = ChangedReadOrders.AggregateId and Event.InsertedVersion = ChangedReadOrders.InsertedVersion


update Event
set ManualVersion = -EffectiveVersion
where EffectiveVersion > 0 and EffectiveReadOrder < 0