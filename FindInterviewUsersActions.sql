set transaction isolation level read committed

go

alter function JsonProperty (@json nvarchar(max), @propertyName nvarchar(max))

RETURNS nvarchar(max)

begin
	declare @startIndex integer
	declare @endIndex integer
	declare @valueLength integer

	declare @innerPropertyIndex integer
	set @innerPropertyIndex = charindex('.', @propertyName)
	if @innerPropertyIndex > 0
	begin
		declare @firstPropertyName nvarchar(max)
		declare @remainingPropertyName nvarchar(max)

		set @firstPropertyName = substring(@propertyName, 0, @innerPropertyIndex) 
		set @remainingPropertyName = substring(@propertyName, len(@firstPropertyName) + 2, 99999)

		set @firstPropertyName = '"'+ @firstPropertyName + '"'
		set @startIndex = charindex( @firstPropertyName, @json)
	
		if @startIndex = 0
			return null

		set @StartIndex = charindex('"', @json, @startIndex + len(@firstPropertyName))


		return dbo.JsonProperty(substring(@json, @StartIndex, 99999999), @remainingPropertyName)
	end 

	set @propertyName = '"'+ @propertyName + '": '
	set @startIndex = charindex( @propertyName, @json)
	
	if @startIndex = 0
	  return null

	set @StartIndex = @startIndex + len(@propertyName) + 1
	set @endIndex = charindex(','+char(13), @json, @startIndex)
	set @valueLength = @endIndex - @startIndex

	return substring(@json, @startIndex, @valueLength)
end 

--WORKING

go



set transaction isolation level read uncommitted

select top 100 e.TimeStamp, e.AggregateId, e.AggregateVersion, e.EventType, e2.* from Events e
inner join 
(
select AggregateId,
	AggregateVersion, 
	dbo.JsonProperty(Event, 'ActorResourceId') as ActorResourceId
from intakedomain..Events
) e2
on e.AggregateId = e2.AggregateId and e.AggregateVersion = e2.AggregateVersion
where 1=1
and ActorResourceId in ('"BFAECBF2-5861-4237-AC12-A53525ADBDC8"',
'"6488AD97-6CBF-48AF-BD3A-BEBC11E9ACBB"',
'"28FE3F51-E03F-49EC-8F3D-56CDE072F094"',
'"24EA68F4-0B4F-43D0-8E9F-CF0C84A25AB5"',
'"CA6275C2-35B2-460D-9A56-D107445DA290"')
order by e.TimeStamp
