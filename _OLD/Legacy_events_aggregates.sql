



--select AggregateId from
--(
	select distinct e.AggregateId, e.EventType
	from
	Event e
	inner join EventType et
	on e.EventType = et.Id

	 where et.EventType in (
	--'Manpower.Applications.Intake.Domain.Events.IntakeProcessEvent+CandidateProcess+CandidateInvitation+Implementation+CandidateDeclinedInvitation'
	--Manpower.Applications.Intake.Domain.Events.IntakeProcessEvent+CandidateProcess+CandidateInvitation+Implementation+CandidateDeclinedInvitationAutomaticallyByOptingOutFromJobOffers'
	--'Manpower.Applications.Intake.Domain.Events.IntakeProcessEvent+CandidateProcess+Implementation+UninitiatedCandidateAppliedForJob'
	--'Manpower.Applications.Intake.Domain.Events.IntakeProcessEvent+CandidateProcess+CVEvaluation+Implementation+InitiatedForSearchResultCandidate'
	--'Manpower.Applications.Intake.Domain.Events.IntakeProcessEvent+CandidateProcess+CVEvaluation+Implementation+EvaluatedAsGoodMatch'
	--'Manpower.Applications.Intake.Domain.Events.IntakeProcessEvent+CandidateProcess+CVEvaluation+Implementation+EvaluatedAsSufficientMatch'
	--'Manpower.Applications.Intake.Domain.Events.IntakeProcessEvent+CandidateProcess+Questionnaire+Implementation+FailedEvaluation'
	
	)
--) AggregateEventTypes

--group by AggregateId
--having count(*) > 4

