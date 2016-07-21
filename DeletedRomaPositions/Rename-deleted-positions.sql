select * from Eventtype et 
inner join Event e
on et.Id = e.EventType
where e.AggregateId in ('85A3BB0C-CE5E-4333-8E78-98918FACE347', 'F1927A11-5021-44CE-8D94-EEE4BB5A4D57')
order by e.AggregateId, e.InsertionOrder asc







begin tran

insert event( AggregateId,                            UtcTimeStamp, EventType,	Event, EventId,                                 InsertedVersion, SqlInsertTimeStamp)
	 values ( '85A3BB0C-CE5E-4333-8E78-98918FACE347', SYSUTCDATETIME()   , 8        , '{
  "UsergroupId": "0000001f-0002-1000-8000-19064ca065ba",
  "ProviderId": "562882fb-6a31-437b-89ec-f3bc70d1dd87",
  "Name": "DELETED-DO-NOT-USE: Test - Contact Center Multiprofiler"
}',                                                                                     '4926E56E-40CF-40D0-9C66-B55BFD8FF915', 3              , SYSUTCDATETIME())


insert event( AggregateId,                            UtcTimeStamp, EventType,	Event, EventId,                                 InsertedVersion, SqlInsertTimeStamp)
	 values ( 'F1927A11-5021-44CE-8D94-EEE4BB5A4D57', SYSUTCDATETIME()   , 8        , '{
  "UsergroupId": "0000001f-0002-1000-8000-19064ca065ba",
  "ProviderId": "562882fb-6a31-437b-89ec-f3bc70d1dd87",
  "Name": "DELETED-DO-NOT-USE:Test - Contact Center Multiprofiler Plus"
}',                                                                                     '61AB79D8-9B4C-40FB-BCDF-2E2B92A7F356', 3              , SYSUTCDATETIME())


select * from Eventtype et 
inner join Event e
on et.Id = e.EventType
where e.AggregateId in ('85A3BB0C-CE5E-4333-8E78-98918FACE347', 'F1927A11-5021-44CE-8D94-EEE4BB5A4D57')
order by e.AggregateId, e.InsertionOrder asc




rollback tran



select * from Eventtype et 
inner join Event e
on et.Id = e.EventType
where e.AggregateId in ('85A3BB0C-CE5E-4333-8E78-98918FACE347', 'F1927A11-5021-44CE-8D94-EEE4BB5A4D57')
order by e.AggregateId, e.InsertionOrder asc