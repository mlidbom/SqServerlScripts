SELECT top 200 
 bs.backup_set_id,
 bs.database_name,
 bs.backup_start_date,
 bs.backup_finish_date,
 CAST(CAST(bs.backup_size/1000000 AS INT) AS VARCHAR(14)) + ' ' + 'MB' AS [Size],
 CAST(DATEDIFF(second, bs.backup_start_date,
 bs.backup_finish_date) AS VARCHAR(4)) + ' ' + 'Seconds' [TimeTaken],
 CASE bs.[type]
 WHEN 'D' THEN 'Full Backup'
 WHEN 'I' THEN 'Differential Backup'
 WHEN 'L' THEN 'TLog Backup'
 WHEN 'F' THEN 'File or filegroup'
 WHEN 'G' THEN 'Differential file'
 WHEN 'P' THEN 'Partial'
 WHEN 'Q' THEN 'Differential Partial'
 END AS BackupType,
 bmf.physical_device_name,
 CAST(bs.first_lsn AS VARCHAR(50)) AS first_lsn,
 CAST(bs.last_lsn AS VARCHAR(50)) AS last_lsn,
 bs.server_name,
 bs.recovery_model
 From msdb.dbo.backupset bs
 INNER JOIN msdb.dbo.backupmediafamily bmf 
 ON bs.media_set_id = bmf.media_set_id
 where database_name = 'CVManagementDomain'
 --where database_name = 'jobmanagementdomain'
 ORDER BY bs.backup_start_date desc, bs.database_name;
 GO