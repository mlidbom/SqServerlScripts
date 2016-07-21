select Host, Domain, Logger, Date, Level, ExceptionType, ExceptionMessage, Exception, Message, ExceptionMessage, Class, Line, Method, [File], [User], Thread from Log 
where ExceptionMessage like '%Timeout expired%'
and Date > dateadd(hour, -48, getdate())
/*
and Exception not Like '%Manpower.Applications.Intake.UI.Web.Views.IntakeProcess.JobAdvertisement.Api.IntakeProcessJobAdvertisementController.JobAdvertisement%' --37
and Exception not like '%Manpower.Applications.JobAdvertising.Web.Views.JobAdvertisement.EditJobContact.EditJobContactController.EditContact%' --16
and Exception not like '%Manpower.Applications.JobAdvertising.Web.Views.JobAdvertisement.JobAdvertisementController.Overview%' --28
and Exception not like '%Manpower.Applications.JobManagement.ViewModels.Services.Implementation.JobAdvertisingQueryModelsReader.GetJobAdvertisement%' --52
and Exception not like '%Manpower.Applications.JobAdvertising.Web.Views.JobAdvertisement.EditJobAdvertisement.EditJobAdvertisementController.ChangeJobCollaborationLogoTypes%' -- 21
and Exception not like '%Manpower.Applications.JobAdvertising.Web.Views.JobAdvertisement.EditJobContact.EditJobContactController.SendEditContactCommand%' --7
*/

and Exception like '%Composable.CQRS.EventSourcing.MicrosoftSQLServer.SqlServerEventStoreEventReader.GetAggregateHistory%'


order by Date desc