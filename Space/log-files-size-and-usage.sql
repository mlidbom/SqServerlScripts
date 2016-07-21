select * from (
	SELECT instance_name AS DatabaseName, 
		   [Data File(s) Size (KB)] / (1024 * 1024) as DataGB, 
		   [LOG File(s) Size (KB)] / (1024 * 1024) as LogGB, 
		   [Percent Log Used] LogUsedPercent,
		   [Log File(s) Used Size (KB)] / (1024 * 1024) as LogUsedGB		   
	FROM 
	( 
	   SELECT * 
	   FROM sys.dm_os_performance_counters 
	   WHERE counter_name IN ( 'Data File(s) Size (KB)',  'Log File(s) Size (KB)', 'Log File(s) Used Size (KB)', 'Percent Log Used' ) 
		 AND instance_name != '_Total' 
	) AS Src 
	PIVOT 
	( 
	   MAX(cntr_value) 
	   FOR counter_name IN ( [Data File(s) Size (KB)], [LOG File(s) Size (KB)], [Log File(s) Used Size (KB)], [Percent Log Used] ) 
	) AS pvt
)  as LogFiles
order by LogGB desc