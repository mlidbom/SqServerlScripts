select top 100 * from JobManagementDomain..Events e
order by e.SqlTimeStamp desc



select top 100 * from JobManagementReadModels..Store s
where s.ValueTypeId = 3

select top 100 * from JobManagementReadModels..Store s
where s.Id in ('8302BDE9-ACA4-4465-B149-4F22449C40AB', 'b552ac9b-ed41-4957-ae32-f11aff77dbdd', '9265B411-254B-42AB-A0B7-543C29F5A4D9')

select * from JobManagementReadModels..ValueType v


select * from MPDB..WebCACClient cc
where cc.GlobalID = 'b552ac9b-ed41-4957-ae32-f11aff77dbdd'