Create Table ##RawData
(
    dbname sysname,
	type nvarchar(5),
    sizebytes decimal (18,2),
    usedbytes decimal (18,2)
)  

EXEC sp_msforeachdb  
'USE [?];  
insert into ##RawData (dbname, type, Sizebytes, usedbytes)
SELECT DB_NAME(), type_desc, size * 8, FILEPROPERTY(name,''SpaceUsed'') * 8
FROM sys.database_files  
GROUP BY name, type_desc, physical_name, size'

Select dbname, type,
sizebytes,
usedbytes,
cast((sizebytes / 1024 ) as integer) as SizeMB,
cast((usedbytes / 1024 ) as integer) as UsedMB,
cast((sizebytes / 1024 / 1024 ) as integer) as SizeGB,
cast((usedbytes / 1024 / 1024) as integer) as UsedGB,
cast((100 * usedbytes / sizebytes) as integer) as [%used]
into ##Stats
From ##RawData

--System drives space information
SELECT DISTINCT
  cast(vs.volume_mount_point as nvarchar) AS drive,
  cast(vs.logical_volume_name as nvarchar) AS name,
  vs.total_bytes/1024/1024/1024 AS SizeGB,
  vs.available_bytes/1024/1024/1024 AS FreeGB,
  (vs.total_bytes - vs.available_bytes) /1024/1024/1024 as UsedGB
FROM sys.master_files AS f
CROSS APPLY sys.dm_os_volume_stats(f.database_id, f.file_id) AS vs


select 
type,
cast(sum(SizeMb) / 1024 as integer) GB, 
cast(sum(SizeMb) /1024 - sum(UsedMB) / 1024 as integer) GBFree,
cast(sum(UsedMB) / 1024 as integer) GBUsed,
cast((100 * sum(UsedBytes) / sum(SizeBytes)) as integer) PercentUsed,
100 - cast((100 * sum(UsedBytes) / sum(SizeBytes)) as integer) PercentFree
from ##Stats
where 1=1
group by Type
order by type desc


select cast(dbname as nvarchar),type, SizeGB, [%used], SizeMB from ##Stats
where 1=1
and dbname not in ('master', 'msdb', 'model', 'tempdb') --exclude system dbs that don't normally matter. Watch out for tempdb though. Size changes there can matter!
and dbname not in ('dba', 'litespeedlocal') --exclude dbs specific to this installation that we don't care about in this context
and SizeGB > 0 --Let's only look at files large enough to matter
--and dbname not like '%domain' --REMOVE THIS TEMPORARY FILTER!
order by 
	Type, 
	[%used] desc
	--SizeMB desc	

drop table ##RawData
drop table ##Stats
