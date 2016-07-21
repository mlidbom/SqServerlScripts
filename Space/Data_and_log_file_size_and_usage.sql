DBCC SQLPERF(logspace) 

--Data file used and free space in GB
EXEC sp_msforeachdb  
'USE [?];  
SELECT left(DB_NAME() + ''_'' + type_desc + ''__________________________________________________________'', 60) AS [Database Name],
    CAST(SUM(size) /(128.0*1024) AS integer) AS [size(GB)], 
	100 - CAST(CAST(SUM(FILEPROPERTY(name,''SpaceUsed'')) AS decimal(18,2)) / SUM(size) * 100 AS integer) AS [Free space(%)],
	CAST(CAST(SUM(FILEPROPERTY(name,''SpaceUsed'')) AS decimal(18,2)) / SUM(size) * 100 AS integer) AS [Used space(%)],	
    CAST(SUM(FILEPROPERTY(name, ''SpaceUsed''))/(128.0*1024) AS integer) AS [Used space(GB)], 
    cast(CAST(SUM(size)/(128.0*1024) AS DECIMAL(18,2)) - CAST(SUM(FILEPROPERTY(name,''SpaceUsed''))/(128.0*1024) AS decimal(18,2)) as integer) AS [Free space(GB)]	
FROM sys.database_files  
GROUP BY type_desc'


EXEC sp_msforeachdb  
'USE [?];  
SELECT left(DB_NAME() + ''_'' + type_desc + ''__________________________________________________________'', 60) AS [Database Name],  
    CAST(SUM(size) /(128.0*1024) AS integer) AS [size(GB)], 
	100 - CAST(CAST(SUM(FILEPROPERTY(name,''SpaceUsed'')) AS decimal(18,2)) / SUM(size) * 100 AS integer) AS [Free space(%)],
	CAST(CAST(SUM(FILEPROPERTY(name,''SpaceUsed'')) AS decimal(18,2)) / SUM(size) * 100 AS integer) AS [Used space(%)],	
    CAST(SUM(FILEPROPERTY(name, ''SpaceUsed''))/(128.0*1024) AS integer) AS [Used space(GB)], 
    cast(CAST(SUM(size)/(128.0*1024) AS DECIMAL(18,2)) - CAST(SUM(FILEPROPERTY(name,''SpaceUsed''))/(128.0*1024) AS decimal(18,2)) as integer) AS [Free space(GB)]	
FROM sys.database_files  
WHERE type_desc = ''log''
GROUP BY type_desc'

EXEC sp_msforeachdb  
'USE [?];  
SELECT left(DB_NAME() + ''_'' + type_desc + ''__________________________________________________________'', 60) AS [Database Name],
    CAST(SUM(size) /(128.0*1024) AS integer) AS [size(GB)], 
	100 - CAST(CAST(SUM(FILEPROPERTY(name,''SpaceUsed'')) AS decimal(18,2)) / SUM(size) * 100 AS integer) AS [Free space(%)],
	CAST(CAST(SUM(FILEPROPERTY(name,''SpaceUsed'')) AS decimal(18,2)) / SUM(size) * 100 AS integer) AS [Used space(%)],	
    CAST(SUM(FILEPROPERTY(name, ''SpaceUsed''))/(128.0*1024) AS integer) AS [Used space(GB)], 
    cast(CAST(SUM(size)/(128.0*1024) AS DECIMAL(18,2)) - CAST(SUM(FILEPROPERTY(name,''SpaceUsed''))/(128.0*1024) AS decimal(18,2)) as integer) AS [Free space(GB)]	
FROM sys.database_files  
WHERE type_desc = ''rows''
GROUP BY type_desc'


