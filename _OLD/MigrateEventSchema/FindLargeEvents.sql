

use AuthenticationDomain
set transaction isolation level read uncommitted
select (Cast((select count(*) from Events e where len(e.Event) > 64000) as float) / (select count(*) from Events e where len(e.Event) < 64000)) * 100

use CVManagementDomain
set transaction isolation level read uncommitted
select (Cast((select count(*) from Events e where len(e.Event) > 64000) as float) / (select count(*) from Events e where len(e.Event) < 64000)) * 100

use ExternalJobsDomain
set transaction isolation level read uncommitted
select (Cast((select count(*) from Events e where len(e.Event) > 64000) as float) / (select count(*) from Events e where len(e.Event) < 64000)) * 100

use IntakeDomain
set transaction isolation level read uncommitted
select (Cast((select count(*) from Events e where len(e.Event) > 64000) as float) / (select count(*) from Events e where len(e.Event) < 64000)) * 100

use JobCommunicationDomain
set transaction isolation level read uncommitted
select (Cast((select count(*) from Events e where len(e.Event) > 64000) as float) / (select count(*) from Events e where len(e.Event) < 64000)) * 100

use JobManagementDomain
set transaction isolation level read uncommitted
select (Cast((select count(*) from Events e where len(e.Event) > 64000) as float) / (select count(*) from Events e where len(e.Event) < 64000)) * 100

use JobSearchDomain
set transaction isolation level read uncommitted
select (Cast((select count(*) from Events e where len(e.Event) > 64000) as float) / (select count(*) from Events e where len(e.Event) < 64000)) * 100

use PowerbaseDomain
set transaction isolation level read uncommitted
select (Cast((select count(*) from Events e where len(e.Event) > 64000) as float) / (select count(*) from Events e where len(e.Event) < 64000)) * 100

use ReferenceDataManagementDomain
set transaction isolation level read uncommitted
select (Cast((select count(*) from Events e where len(e.Event) > 64000) as float) / (select count(*) from Events e where len(e.Event) < 64000)) * 100

use SyncAdminDomain
set transaction isolation level read uncommitted
select (Cast((select count(*) from Events e where len(e.Event) > 64000) as float) / (select count(*) from Events e where len(e.Event) < 64000)) * 100
