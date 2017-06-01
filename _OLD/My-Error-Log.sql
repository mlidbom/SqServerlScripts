select top 100 * from Log l
where 1=1
and Host = 'mlidbo-online'
and Logger != 'NServiceBus.Licensing.LicenseManager'
and Date  > '2015-11-22 13:50:51.727'
order by l.Date desc
