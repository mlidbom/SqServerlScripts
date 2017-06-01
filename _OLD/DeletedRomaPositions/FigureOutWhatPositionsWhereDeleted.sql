select * from RomaMessage 

where 1=1
--and messagetype != 'PositionDetails'
--and body like '%PositionStatus="1"%'
--and ( body like '%85A3BB0C-CE5E-4333-8E78-98918FACE347%' or body like '%F1927A11-5021-44CE-8D94-EEE4BB5A4D57%')
and (
	1!=1
	or Body like '%PositionId="85A3BB0C-CE5E-4333-8E78-98918FACE347"%' --Deleted?  "Test - Contact Center Multiprofiler"
	--or Body like '%PositionId="F1927A11-5021-44CE-8D94-EEE4BB5A4D57"%' --Deleted? "Test - Contact Center Multiprofiler Plus"

	--or Body like '%PositionId="69463DE2-2A8A-442E-BCFC-714A92E3CD3B"%' --"Test - Contact Center Multiprofiler"
	--or Body like '%PositionId="31A7F069-9F6E-4FF2-A0F0-36AC8880E19A"%' --"Test - Contact Center Multiprofiler Plus"

	--or Body like '%PositionId="5BEFFD10-F603-4484-A682-47C427032936"%'
	--or Body like '%PositionId="4C65AD04-E971-4A24-A2B8-A29F6C9AD015"%'
	--or Body like '%PositionId="AD1FF9C4-AEF7-4777-9527-C8B47207870A"%'
)

order by ReceivedUtc
