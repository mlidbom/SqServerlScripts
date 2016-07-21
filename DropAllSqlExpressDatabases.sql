
--select * from sysdatabases


declare @name nvarchar(max)
declare @dropStatement nvarchar(max)
set @name = (select top 1 name from sysdatabases where name like '%mdf')

while @name is not null
begin 
 set @dropStatement = 'drop database [' + @name + ']'
 select @dropStatement
 exec sp_executesql @dropStatement
 set @name = (select top 1 name from sysdatabases where name like '%mdf')
end


