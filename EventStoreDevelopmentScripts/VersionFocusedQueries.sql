set transaction isolation level read uncommitted
--exec EnsurePersistedMigrationsHaveConsistentEffectiveReadOrdersAndEffectiveVersions

declare @lastOldEvent BigInt = 3199940

/*
delete Event where InsertionOrder >  @lastOldEvent
update event set ManualReadOrder = null where ManualReadOrder is not null
update event set ManualVersion = null where ManualVersion is not null
*/

select
(select SYSUTCDATETIME()) CurrentTime,
(select count(*) from Event where InsertionOrder > @lastOldEvent) NewEvents,
(select max(insertionorder) from Event) MaxInsertionOrder,
(select count(distinct AggregateId) ModifiedAggregates from Event where InsertionOrder > @lastOldEvent) ModifiedAggregates

select max( e.InsertionOrder) HighestInsertionOrderOfFirstEventFromModifiedAggregate from Event e
inner join (select AggregateId from Event where InsertionOrder > @lastOldEvent) new
on e.AggregateId = new.AggregateId
and e.InsertedVersion = 1


--SELECT AggregateId, EffectiveVersion EV, InsertedVersion IV, ManualVersion MV, InsertionOrder, InsertAfter, InsertBefore, Replaces, EffectiveReadOrder, SqlInsertTimeStamp 
--from Event 
--where InsertionOrder > @lastOldEvent







