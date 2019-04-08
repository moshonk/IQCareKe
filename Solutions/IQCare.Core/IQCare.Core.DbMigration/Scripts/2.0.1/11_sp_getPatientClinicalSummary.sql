-- =============================================
-- Author:		Kenneth O Ochieng
-- Create date: 31-03-2019
-- Description:	SP to get patient clinical summary
-- =============================================
CREATE PROCEDURE sp_getPatientClinicalSummary 
	-- Add the parameters for the stored procedure here
	@patientId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

exec pr_OpenDecryptedSession

-- exec sp_getCurrentRegimen @PatientId

--1. DEMOGRAPHICS
SELECT  EnrollmentNumber AS CCCNumber, UPPER(CONCAT(FirstName, ' ', MiddleName, ' ', LastName)) AS PatientName, l.Name AS Sex, CAST(DateOfBirth AS DATE) AS DOB  
FROM gcPatientView g
INNER JOIN LookupItem l ON l.id = g.Sex
WHERE g.id = @PatientId

--2. BMI
SELECT TOP 3 CAST(VisitDate AS DATE) AS VisitDate, Weight, Height,BMI FROM PatientVitals WHERE PatientId = @PatientId ORDER BY VisitDate DESC;

--REGIMEN
--3. Current ART
WITH all_treatmenttracker_cte AS (
	SELECT * FROM (
		SELECT RegimenId, ROW_NUMBER() OVER(PARTITION BY PatientId ORDER BY t.RegimenStartDate DESC) as rowNum, t.PatientId,t.RegimenLine,t.Regimen,t.RegimenStartDate as RegimenDate,  CASE WHEN t.RegimenLine LIKE '%First%' THEN '1' WHEN t.RegimenLine LIKE '%Second%' THEN '2' WHEN t.regimenLine LIKE '%third%' THEN 3 ELSE  NULL END as Line FROM PatientTreatmentTrackerViewD4T t WHERE t.Regimen IS NOT NULL AND YEAR(t.RegimenStartDate) >= 2000 AND t.PatientId = @PatientId
	) t
),

curr_treatmenttracker_cte AS (
	SELECT PatientId,Regimen,RegimenId, RegimenDate, Line as regimenLine FROM (
		SELECT RegimenId,ROW_NUMBER() OVER(PARTITION BY PatientId ORDER BY t.RegimenStartDate DESC,t.PatientMasterVisitId DESC, t.id DESC) as rowNum, t.PatientId,t.RegimenLine,t.Regimen,t.RegimenStartDate as RegimenDate, CASE WHEN t.RegimenLine LIKE '%First%' THEN '1' WHEN t.RegimenLine LIKE '%Second%' THEN '2' WHEN t.regimenLine LIKE '%third%' THEN 3 ELSE  NULL END as Line
		 FROM PatientTreatmentTrackerViewD4T t WHERE t.Regimen IS NOT NULL AND YEAR(t.RegimenStartDate) >= 2000 AND t.PatientId = @PatientId
	) t WHERE t.rowNum = 1
),
curr_regimen_date_cte AS (
	SELECT attx.PatientId, MIN(attx.RegimenDate) as Regimendate 
	FROM all_treatmenttracker_cte attx 
		INNER JOIN curr_treatmenttracker_cte pttx ON attx.PatientId = pttx.PatientId AND pttx.RegimenId = attx.RegimenId
	WHERE attx.PatientId = @PatientId
	GROUP BY attx.PatientId
)

SELECT c.Regimen,c.RegimenDate FROM curr_treatmenttracker_cte c INNER JOIN curr_regimen_date_cte d ON c.PatientId = d.PatientId

-- 4. Previous ART
--RegimenType,DispensedByDate
exec Pharmacy_History @PatientId


--5. Baseline CD4
SELECT TOP 3 CAST(CD4Date AS DATE) AS CD4Date, CD4Results FROM (
	SELECT        patientId,SampleDate as CD4Date, ResultValues  as CD4Results
	FROM            dbo.PatientLabTracker
	WHERE        (Results = 'Complete')
	AND         (LabTestId = 1) AND PatientId = @PatientId
	UNION 
	SELECT patientId,CreateDate,CD4Count from PatientBaselineAssessment WHERE CD4Count > 0 AND PatientId = @PatientId
) cd4 ORDER BY CD4Date DESC

--6. Viral Load test
SELECT   TOP 3    CAST(SampleDate AS DATE) as VLDate, ResultValues  as VLResults
FROM            dbo.PatientLabTracker
WHERE        (Results = 'Complete')
AND         (LabTestId = 3) AND PatientId = @PatientId
ORDER BY SampleDate DESC

--7. Drug Resistance Testing
--How is this one captured
SELECT TOP 3 DrtDate, DrtResult FROM [PatientClinicalReviewChecklist] WHERE PatientId = @PatientId

--8. IPT
SELECT w.IptStartDate, o.IPTOutComeDate, l1.DisplayName as IptOutcome, o.IptDiscontinuationReason 
FROM (SELECT TOP 1 * FROM PatientIptWorkup WHERE PatientId = @PatientId ORDER BY IptStartDate DESC) w
LEFT JOIN (SELECT TOP 1 * FROM PatientIptOutcome WHERE PatientId = @PatientId ORDER BY IPTOutComeDate DESC, CreateDate DESC) o ON w.PatientId = o.PatientId
INNER JOIN LookupItem l1 ON l1.Id = o.IptEvent
 WHERE w.IptStartDate IS NOT NULL AND w.PatientId = @PatientId

 --9. INVESTIGATIONS

END
GO
