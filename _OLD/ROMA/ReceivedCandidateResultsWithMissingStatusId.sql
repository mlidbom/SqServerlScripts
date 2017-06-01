select * from RomaMessage
where id in (
'50003b86-9e81-49a9-a583-5e1953942ac1',
'7d54fcd5-132d-45b1-a992-f5e2bdbf80fd',
'59520879-fd07-4818-9035-cda0f1e034e6',
'ffb845dc-0096-48fe-af9b-4db4ce7beba2',
'd38b9a35-cee1-45e5-8c16-63a12ae7746e',
'1a98f01d-723a-4c89-81ca-1e35e01913da',
'f63723f0-1104-43d0-86f9-a812d1b39e7f',
'06ccabae-3ab3-4d55-996b-3025e99b4d66',
'd94ab946-ab3a-4ecd-9134-ce5175255b87',
'd9a09997-3875-42e7-a8a7-e55e26c981c8'
) and Body  not like '%StatusId="%'


select * from RomaMessage where body like '%CH_CandidateId="183B97A2-27A8-422F-B79E-0035F2068A08"%'
select * from RomaMessage where MessageType = 'CandidateResult' and Body not like '%StatusId="%'

select * from RomaMessage where body like '%CH_CandidateId="59B96FB7-B394-4E45-837B-47E4CEE81592"%'