--delete TemporaryLocalDbManager..Databases
select * from TemporaryLocalDbManager..Databases

select * from sys.databases
where create_date > '2016-07-27 09:20:36.023'