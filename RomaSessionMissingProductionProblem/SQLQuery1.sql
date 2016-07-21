select * from 
EventType et 
inner join Event e
on et.Id = e.EventType
where e.EventType = 5