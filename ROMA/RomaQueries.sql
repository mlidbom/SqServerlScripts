select 
replace(et.EventType, 'Manpower.Applications.CandidateAssessment.Domain.Events.', ''),

e.AggregateId, e.EffectiveVersion, e.Event, * from Event e
inner join EventType et
on et.Id = e.EventType
where et.EventType like 'Manpower.Applications.CandidateAssessment.Domain.Events.Candi%'


select * from Store s
where Value like '%"Type":1%'

