/*
Marie Eriksson: '403ba064-2945-4465-b70b-d84d4b0703d8'

*/


select  
startRequested.UtcTimeStamp StartRequested,
started.UtcTimeStamp Started,
DATEDIFF(HOUR, startRequested.UtcTimeStamp, started.UtcTimeStamp),* from 
(
	select substring(e.Event, charindex('AssessmentTestId":', e.Event, 0) + 20, 36) as AssessmentTestId, * from Event e
	where e.EventType = 4
) startRequested
left outer join 
(
	select substring(e.Event, charindex('AssessmentTestId":', e.Event, 0) + 20, 36) as AssessmentTestId, * from Event e
	where e.EventType = 5
) started
on startRequested.AggregateId = started.AggregateId
	and startRequested.AssessmentTestId = started.AssessmentTestId
where 1=1
--and started.AssessmentTestId is null
and DATEDIFF(HOUR, startRequested.UtcTimeStamp, started.UtcTimeStamp) > 1
and started.AggregateId = '403ba064-2945-4465-b70b-d84d4b0703d8'
