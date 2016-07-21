select top 100

l.Date, 
--l.Level, 
--l.Logger, 
l.Message, 

l.Exception
, l.Logger
, l. Domain
--, l.[User], l.Host, l.Class, l.Method, l.[File], l.Line
-- , l.*
from vLog l

where 1 = 1
--and l.Domain like '%Intake%'
and Logger like '%intake%'
--and l.Level = 'ERROR'
--and l.Exception like '%GenericSubprocessConfiguration%'

order by Date desc