set transaction isolation level read uncommitted 

select * from Eventtype et 
inner join Event e
on et.Id = e.EventType
where 
1 = 1
and e.AggregateId in ('fbbf30a7-71ec-4009-8da2-51f72f14d0a3', '47C65D67-EA56-4367-9C73-CC5CB6028144', 'DB6ACA7B-4DB3-4713-800F-0C77C8A0DEC8')
--and (et.EventType like '%Assess%' and et.EventType like '%configuration%')
--and  (e.Event like '%85A3BB0C-CE5E-4333-8E78-98918FACE347%' or e.Event like '%F1927A11-5021-44CE-8D94-EEE4BB5A4D57%')
order by e.AggregateId, e.InsertionOrder

