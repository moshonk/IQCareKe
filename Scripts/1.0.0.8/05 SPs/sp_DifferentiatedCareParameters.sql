IF EXISTS (SELECT * from sys.objects WHERE OBJECT_ID = OBJECT_ID('sp_DifferentiatedCareParameters') and type= 'P')
	DROP PROCEDURE sp_DifferentiatedCareParameters
GO

/****** Object:  StoredProcedure [dbo].[sp_DifferentiatedCareParameters]    Script Date: 11/26/2018 5:27:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		John Macharia
-- Create date: 13th May 2018
-- Description:	Differentiated Care Parameters
-- =============================================
CREATE PROCEDURE [dbo].[sp_DifferentiatedCareParameters] 
	-- Add the parameters for the stored procedure here
	@PatientId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	declare @ptn_pk int = (select ptn_pk from patient where id = @PatientId)

    -- Age
	Select datediff(year, DateOfBirth, getdate()) Age from Patient where Id = @PatientId

	-- BMI
	select top 1 BMI from patientvitals where PatientId = @PatientId order by VisitDate desc

	-- Viral Load
	select top 1 a.orderdate,c.ResultDate,b.ResultValue,Undetectable from ord_laborder a inner join [dtl_LabOrderTestResult] b on a.id = b.laborderid inner join dtl_LabOrderTest c on a.id = c.laborderid
	where a.ptn_pk = @ptn_pk and b.labtestid = 3 and c.labtestid = 3 and (b.ResultValue is not null or b.Undetectable is not null)
	order by a.orderdate desc

	-- Current Regimen for > 12 months
		DECLARE @CurrentRegimen varchar(20) = (select top 1 RegimenType from ord_PatientPharmacyOrder a inner join dtl_regimenmap b on a.ptn_pharmacy_pk = b.orderID where a.ptn_pk = @ptn_pk and a.deleteflag = 0 order by a.DispensedByDate desc);
	DECLARE @RegimenYearAgo varchar(20) = (select top 1 RegimenType from ord_PatientPharmacyOrder a inner join dtl_regimenmap b on a.ptn_pharmacy_pk = b.orderID where a.ptn_pk = @ptn_pk and a.deleteflag = 0 and a.DispensedByDate <= dateadd(year, -1, getdate()) order by a.DispensedByDate desc);
	DECLARE @counter int = 1;
	DECLARE @SumCurrentRegimen int = 0;
	DECLARE @SumRegimenYearAgo int = 0;

	WHILE @counter <= DATALENGTH(@CurrentRegimen)
	   BEGIN
	   SET @SumCurrentRegimen = @SumCurrentRegimen + ASCII(SUBSTRING(@CurrentRegimen, @counter, 1))
	   SET @counter = @counter + 1
	   END
	   

	SET @counter = 1
	WHILE @counter <= DATALENGTH(@RegimenYearAgo)
	   BEGIN
	   SET @SumRegimenYearAgo = @SumRegimenYearAgo + ASCII(SUBSTRING(@RegimenYearAgo, @counter, 1))
	   SET @counter = @counter + 1
	   END
	   
	If(@SumCurrentRegimen > 0)
	BEGIN
		If(@SumCurrentRegimen = @SumRegimenYearAgo)
		BEGIN
			SELECT 1 SameRegimenFor12Months
		END
		ELSE
		BEGIN
			SELECT 0 SameRegimenFor12Months
		END
	END
	ELSE
	BEGIN
		SELECT 0 SameRegimenFor12Months
	END

	--- Completed 6 months of IPT
	/*	
	select sum(duration) TotalIPTDuration
	from ord_patientpharmacyorder a inner join dtl_patientpharmacyorder b on a.ptn_pharmacy_pk = b.ptn_pharmacy_pk
	inner join mst_drug c on b.Drug_pk = c.Drug_pk
	where drugname like '%isonia%' and ptn_pk = @ptn_pk
	UNION 
	*/
	SELECT 180 as TotalIPTDuration FROM PatientIptOutcome i WHERE i.IptEvent = 525 /*Completed*/ AND PatientId = @PatientId -- Assign 180 if Patient has IPT outcome

	-- No Active OIs
	select top 1 cast(a.AnyComplaint as varchar) AnyComplaint from ComplaintsHistory a inner join patientmastervisit b on a.patientmastervisitid = b.id
	where a.PatientId = @PatientId and a.deleteflag = 0 and a.AnyComplaint = 1 and PatientMasterVisitId in (select Id from patientmastervisit where PatientId = @PatientId and deleteflag = 0 and VisitDate >= dateadd(month, -6, getdate()))
	UNION
	select b.Name from PhysicalExamination a inner join lookupitem b on a.ExamId = b.Id inner join patientmastervisit c on a.PatientMasterVisitId = c.Id
	where a.PatientId = @PatientId and a.deleteflag = 0 and b.Name <> 'None' and PatientMasterVisitId in (select Id from patientmastervisit where PatientId = @PatientId and deleteflag = 0 and VisitDate >= dateadd(month, -6, getdate()))
	UNION
	select top 1 cast(a.OnAntiTbDrugs as varchar) OnAntiTbDrugs from PatientICF a inner join patientmastervisit b on a.patientmastervisitid = b.id
	where a.PatientId = @PatientId and a.deleteflag = 0 and a.OnAntiTbDrugs = 1 and PatientMasterVisitId in (select Id from patientmastervisit where PatientId = @PatientId and deleteflag = 0 and VisitDate >= dateadd(month, -6, getdate()))
END
