/****** Object:  StoredProcedure [dbo].[sp_getCurrentRegimen]    Script Date: 2/8/2019 9:52:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		John Macharia
-- Create date: 14th Feb 2017
-- Description:	get current regimen
-- =============================================
ALTER PROCEDURE [dbo].[sp_getCurrentRegimen]
	-- Add the parameters for the stored procedure here
	@PatientID int = null

AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
Set Nocount On;

	--select top 1 a.RegimenId, a.RegimenLineId, b.VisitDate
	--from ARVTreatmentTracker a inner join PatientMasterVisit b on a.PatientMasterVisitId = b.id
	--where a.PatientId = @PatientID
	--order by b.VisitDate desc

	--select top 1 V.RegimenId,V.RegimenLineId, V.RegimenStartDate from PatientTreatmentTrackerView V
	--where v.PatientId=@PatientID AND v.RegimenId <> 0
	--order by V.RegimenStartDate desc

	SELECT V.RegimenId,V.RegimenLineId, V.RegimenStartDate FROM (
		select  V.RegimenId,V.RegimenLineId, V.RegimenStartDate, ROW_NUMBER() OVER (PARTITION BY PatientId ORDER BY RegimenStartDate DESC, id desc) as RowNum from PatientTreatmentTrackerView V
		where v.PatientId=@PatientID AND v.RegimenId <> 0
    ) v WHERE v.RowNum = 1
	
End








