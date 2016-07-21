select * from Eventtype et 
inner join Event e
on et.Id = e.EventType
where 
1 = 1
and 
(e.Event like '%85A3BB0C-CE5E-4333-8E78-98918FACE347%' or e.Event like '%F1927A11-5021-44CE-8D94-EEE4BB5A4D57%')
order by e.InsertionOrder desc

