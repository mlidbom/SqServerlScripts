select * from Events e

where e.AggregateId = '7C1BC789-E747-4887-A875-D722807D4F87'
order by AggregateVersion

/*

select * from mlidbo_BrokenProcess e
where e.EventType like '%generic%added%'

update mlidbo_BrokenProcess
set event = '{
  "ActorResourceId": "0393b2c6-0f71-460a-9a48-bf7dbd11605e",
  "GenericSubProcess": {
    "Id": 12,
    "DisplayOrder": 12,
    "Name": "Matchningsdokument",
    "Instructions": null
  },
  "EventId": "44fa58d2-ce13-49bb-b125-a166730f6dd7",
  "AggregateRootVersion": 69,
  "AggregateRootId": "7c1bc789-e747-4887-a875-d722807d4f87",
  "TimeStamp": "2015-11-02T15:11:25.0036982+00:00"
}'
where eventId = '44FA58D2-CE13-49BB-B125-A166730F6DD7'


select * 
into mlidbo_BrokenProcess
from  Events e 
where e.AggregateId = '7C1BC789-E747-4887-A875-D722807D4F87'


insert Events(AggregateId, AggregateVersion, TimeStamp, EventType, EventId, Event)
select AggregateId, AggregateVersion, TimeStamp, EventType, EventId, Event
 from mlidbo_BrokenProcess

 */