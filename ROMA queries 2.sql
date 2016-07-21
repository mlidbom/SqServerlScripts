select * from MPDB..WebCACRegions r
inner join mpdb..WebCACRegionName rn
on r.RegionID = rn.RegionID
where r.DefaultRegionName like '%sweden%'