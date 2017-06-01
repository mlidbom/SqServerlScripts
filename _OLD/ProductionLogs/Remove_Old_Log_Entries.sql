declare @DELETED_ROWS INTEGER
set @DELETED_ROWS = 1


while @DELETED_ROWS > 0
begin 	
	delete Log where Id in ( 

		select top 1000 Id 
		from log 
		where Date < '2016-05-01'
		--order by Date
	)

set @DELETED_ROWS = @@ROWCOUNT
select @DELETED_ROWS
--WAITFOR DELAY '00:00:01';

end 


select count(*) LogEntries from Log

	