IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_getPharmacyFields]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_getPharmacyFields]
GO
/****** Object:  StoredProcedure [dbo].[sp_getPharmacyFields]    Script Date: 5/20/2018 10:52:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		John Macharia
-- Create date: 14th Feb 2017
-- Description:	get pharmacy fields
-- =============================================
CREATE PROCEDURE [dbo].[sp_getPharmacyFields]
	-- Add the parameters for the stored procedure here
	@PatientMasterVisitID int = null

AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
Set Nocount On;

		--13 Pharmacy Parameters
	select b.ProgID, b.pharmacyPeriodTaken ,a.TreatmentStatusId,a.TreatmentStatusReasonId, a.RegimenLineId, a.RegimenId,
	convert(varchar(30),b.OrderedByDate,106) OrderedByDate,convert(varchar(30),b.DispensedByDate,106) DispensedByDate
	from ARVTreatmentTracker a right join ord_PatientPharmacyOrder b on a.PatientMasterVisitId = b.PatientMasterVisitId
	where b.PatientMasterVisitId = @PatientMasterVisitID
End








