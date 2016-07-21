select logger, count(*) from log
group by logger
order by count(*) desc


/*

delete log where logger in(
'Manpower.Applications.CVManagement.Medium.Web.Common.Providers.HardCodedWebSiteOverideNameProvider',
'Manpower.Web.Controllers.Pages.JobDetailsController',
'Manpower.Web.Utils.RowRenderer',
'Manpower.Applications.CVManagement.Medium.Web.Common.Providers.SiteOverideViewEngine',
'Composable.CQRS.EventSourcing.SQLServer.LegacyEventTableSchemaManager',
'NServiceBus.Faults.Forwarder.FaultManager')

delete log
where exceptiontype	='System.InvalidOperationException'
and exceptionmessage = ' Unrecognized user identity.  The user identity cannot change during an active SignalR connection.'

delete log
where exceptiontype	='System.InvalidOperationException'
and exceptionmessage = ' The view ''Error'' or its master was not found or no view engine supports the searched locations. The following locations were searched:'

delete log
where ExceptionMessage in(
 ' Unable to connect to the remote server ---> System.Net.WebException: Unable to connect to the remote server ---> System.Net.Sockets.SocketException: No connection could be made because the target machine actively refused it 10.213.40.2:8983',
 ' HttpContext.Current is null. PerWebRequestLifestyle can only be used in ASP.Net')

 delete log 
 where ExceptionType = 'SolrNet.Exceptions.SolrConnectionException'


 delete log where exceptionmessage like ' The controller for path %'

 delete log where ExceptionMessage in( 
 ' Invalid cursor.',
 ' The controller for path ''/Content/Images/manpower-favicon.ico'' could not be found.',
 ' Exception thrown while invoking event handlers for OnTransportMessageReceived ---> System.AggregateException: One or more errors occurred. ---> System.InvalidOperationException: No handlers could be found for message type: Composable.CQRS.Command.CommandExecutionExceptionResponse',
 ' Server cannot append header after HTTP headers have been sent.',
 ' Unable to connect to the remote server ---> System.Net.WebException: Unable to connect to the remote server ---> System.Net.Sockets.SocketException: No connection could be made because the target machine actively refused it 10.213.40.2:8983',
 ' Required active directory property "co" (Country) is missing or invalid (null) for the authenticated user: .'
 )


 delete log where ExceptionType in (
 'Composable.CQRS.Command.DomainCommandValidationException',
 'SolrNet.Exceptions.SolrConnectionException'
 )

 delete log where  ExceptionType = 'System.InvalidCastException' and Logger in ( 'Manpower.Web.Business.Jobs.JobListModelBinder', 'Manpower.Web.Business.Jobs.JobDetailsModelBinder')

 delete log where ExceptionMessage = ' Exception thrown while invoking event handlers for OnTransportMessageReceived ---> System.AggregateException: One or more errors occurred. ---> System.Exception: Recieved message from other environment: production in environment developer'

 delete log where ExceptionMessage like ' Unable to connect to the remote server ---> System.Net.Sockets.SocketException: A connection attempt failed because the connected party did not properly respond after a period of time, or established connection failed because connected host has failed to respond%'

 )

*/ 