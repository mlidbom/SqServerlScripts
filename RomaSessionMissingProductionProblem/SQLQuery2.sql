--Id	EventType
--4	Manpower.Applications.CandidateAssessment.Domain.Events.CandidateEvent+AssessmentTestSession+Implementation+StartRequested
--5	Manpower.Applications.CandidateAssessment.Domain.Events.CandidateEvent+AssessmentTestSession+Implementation+Started

select 
startRequested.UtcTimeStamp as StartRequestedAt, startedEvent.UtcTimeStamp as StartedAt,

DATEDIFF(HOUR, startRequested.UtcTimeStamp, startedEvent.UtcTimeStamp), startRequested.Event as StartRequestedEvent, startedEvent.Event as StartedEvent, * from 
Event startRequested
inner join Event startedEvent 
on startedEvent.AggregateId = startRequested.AggregateId
where 
1=1
and startRequested.EventType = 4
and startedEvent.EventType = 5
and DATEDIFF(HOUR, startRequested.UtcTimeStamp, startedEvent.UtcTimeStamp) > 1
and substring(startRequested.Event, charindex('AssessmentTestId":', startRequested.Event, 0) + 20, 36) = substring(startedEvent.Event, charindex('AssessmentTestId":', startedEvent.Event, 0) + 20, 36)
and startRequested.AggregateId = '403ba064-2945-4465-b70b-d84d4b0703d8'