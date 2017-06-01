--Slow requests by month
select substring([date-string], 0, 8), count(*)
from Log
where [time-taken] > 5000
and [cs-uri-stem] not like '/api/candidatesearch/searchresult/%'
group by substring([date-string], 0, 8)
order by substring([date-string], 0, 8)

--requests by month/1000
select substring([date-string], 0, 8), count(*) / 1000
from Log
group by substring([date-string], 0, 8)
order by substring([date-string], 0, 8)