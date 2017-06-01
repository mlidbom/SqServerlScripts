select * from 

EventType et 
inner join Event e
on et.Id = e.EventType

where e.AggregateId = '2665DCBC-1B77-4CA0-9B9A-2A0C43C6E809' --'75DF2763-B953-4B27-8BA2-B969FB98190B'