select host, domain, logger, level, exceptiontype, exceptionmessage, count(*) Count from log
where 1=1
--and exceptiontype != ''
and Date > dateadd(hour, -12, getdate())
--and level in ('error', 'fatal', 'warn')
group by host, domain, logger, level, exceptiontype, exceptionmessage
order by count(*) desc


/*

delete log where logger in ( 'NServiceBus.Licensing.LicenseManager', 'NServiceBus.Licensing.LicenseInitializer')
delete log where exceptionmessage = ' Could not enumerate all types for ''C:\Manpower\MP.A.Intake.Web\bin\Composable.CQRS.Windsor.dll''.'

 select count(*) from Log
 where ExceptionMessage in(
 ' Unable to connect to the remote server ---> System.Net.WebException: Unable to connect to the remote server ---> System.Net.Sockets.SocketException: No connection could be made because the target machine actively refused it 10.213.40.2:8983',
 ' HttpContext.Current is null. PerWebRequestLifestyle can only be used in ASP.Net')

 */

 
 --select count(*) from Log where  ExceptionType = 'System.InvalidCastException' and Logger in ( 'Manpower.Web.Business.Jobs.JobListModelBinder', 'Manpower.Web.Business.Jobs.JobDetailsModelBinder')

 --select top 100 * from Log where ExceptionMessage like ' Unable to connect to the remote server ---> System.Net.Sockets.SocketException: A connection attempt failed because the connected party did not properly respond after a period of time, or established connection failed because connected host has failed to respond%'
 --order by Date desc

 --select top 100 * from log where Exceptionmessage =  ' Participant accessed by wrong UnitOfWork' order by Date desc