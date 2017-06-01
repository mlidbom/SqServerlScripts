select 
		cast(substring(e.event, charindex('"CopiedFrom": "', e.Event) + 15, 36) as uniqueidentifier) as SourceId,
		e.AggregateId as CopyId,
		e.TimeStamp as CopyTime
into #copyactions
	from intakedomain..events e
		where e.eventtype = 'Manpower.Applications.Intake.Domain.Events.IntakeProcessEvent+Implementation+Copied'

select #copyactions.SourceId, #copyactions.CopyId, #copyactions.CopyTime
into #potentiallyBrokenCopies1
from IntakeDomain..Events sources
inner join #copyactions
	on sources.aggregateId = #copyactions.SourceId 
where sources.Eventtype like 'Manpower.Applications.Intake.Domain.Events.IntakeProcessEvent+CandidateProcessConfiguration+Implementation+GenericSubProcessConfigurationRemoved%'


select #copyactions.SourceId, #copyactions.CopyId, #copyactions.CopyTime into #potentiallyBrokenCopies2 from #potentiallyBrokenCopies1 inner join #copyactions on #potentiallyBrokenCopies1.CopyId = #copyactions.SourceId 
select #copyactions.SourceId, #copyactions.CopyId, #copyactions.CopyTime into #potentiallyBrokenCopies3 from #potentiallyBrokenCopies2 inner join #copyactions on #potentiallyBrokenCopies2.CopyId = #copyactions.SourceId 
select #copyactions.SourceId, #copyactions.CopyId, #copyactions.CopyTime into #potentiallyBrokenCopies4 from #potentiallyBrokenCopies3 inner join #copyactions on #potentiallyBrokenCopies3.CopyId = #copyactions.SourceId
select #copyactions.SourceId, #copyactions.CopyId, #copyactions.CopyTime into #potentiallyBrokenCopies5 from #potentiallyBrokenCopies4 inner join #copyactions on #potentiallyBrokenCopies4.CopyId = #copyactions.SourceId 
select #copyactions.SourceId, #copyactions.CopyId, #copyactions.CopyTime into #potentiallyBrokenCopies6 from #potentiallyBrokenCopies5 inner join #copyactions on #potentiallyBrokenCopies5.CopyId = #copyactions.SourceId
select #copyactions.SourceId, #copyactions.CopyId, #copyactions.CopyTime into #potentiallyBrokenCopies7 from #potentiallyBrokenCopies6 inner join #copyactions on #potentiallyBrokenCopies6.CopyId = #copyactions.SourceId
select #copyactions.SourceId, #copyactions.CopyId, #copyactions.CopyTime into #potentiallyBrokenCopies8 from #potentiallyBrokenCopies7 inner join #copyactions on #potentiallyBrokenCopies7.CopyId = #copyactions.SourceId

select SourceId, CopyId, CopyTime
into #allPotentiallyBrokenCopies
from
(select * from #potentiallyBrokenCopies1
union
select * from #potentiallyBrokenCopies2
union
select * from #potentiallyBrokenCopies3
union
select * from #potentiallyBrokenCopies4
union
select * from #potentiallyBrokenCopies5
union
select * from #potentiallyBrokenCopies6
union
select * from #potentiallyBrokenCopies7
union
select * from #potentiallyBrokenCopies8) allPotentiallyBrokenCopies

select distinct 
	--#allPotentiallyBrokenCopies.CopyTime,
	--brokenCopies.TimeStamp AddTime,
	#allPotentiallyBrokenCopies.SourceId, 	
	brokenCopies.AggregateId CopyId
from
	#allPotentiallyBrokenCopies
	inner join IntakeDomain..Events brokenCopies
			on brokenCopies.AggregateId = #allPotentiallyBrokenCopies.CopyId
where 1 = 1
and brokenCopies.Eventtype like 'Manpower.Applications.Intake.Domain.Events.IntakeProcessEvent+CandidateProcessConfiguration+Implementation+GenericSubProcessConfigurationAdded%' 
--order by CopyTime, SourceId, CopyId, AddTime

drop table #copyactions
drop table #potentiallyBrokenCopies1
drop table #potentiallyBrokenCopies2
drop table #potentiallyBrokenCopies3
drop table #potentiallyBrokenCopies4
drop table #potentiallyBrokenCopies5
drop table #potentiallyBrokenCopies6
drop table #potentiallyBrokenCopies7
drop table #potentiallyBrokenCopies8
drop table #allPotentiallyBrokenCopies