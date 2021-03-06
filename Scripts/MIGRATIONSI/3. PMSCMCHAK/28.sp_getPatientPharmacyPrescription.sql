	



 IF NOT EXISTS(SELECT * FROM sys.columns 
          WHERE Name = N'MorningDose'
          AND Object_ID = Object_ID(N'Dtl_PatientPharmacyOrder'))
BEGIN
ALTER TABLE Dtl_PatientPharmacyOrder
ADD MorningDose decimal(10,2)
END

 IF NOT EXISTS(SELECT * FROM sys.columns 
          WHERE Name = N'MiddayDose'
          AND Object_ID = Object_ID(N'Dtl_PatientPharmacyOrder'))
BEGIN
ALTER TABLE Dtl_PatientPharmacyOrder ADD MiddayDose decimal(10,2)
END



 IF NOT EXISTS(SELECT * FROM sys.columns 
          WHERE Name = N'EveningDose'
          AND Object_ID = Object_ID(N'Dtl_PatientPharmacyOrder'))
BEGIN
ALTER TABLE Dtl_PatientPharmacyOrder ADD EveningDose decimal(10,2)
END

 IF NOT EXISTS(SELECT * FROM sys.columns 
          WHERE Name = N'NightDose'
          AND Object_ID = Object_ID(N'Dtl_PatientPharmacyOrder'))
BEGIN
ALTER TABLE Dtl_PatientPharmacyOrder ADD NightDose  decimal(10,2)
END



 IF NOT EXISTS(SELECT * FROM sys.columns 
          WHERE Name = N'comments'
          AND Object_ID = Object_ID(N'Dtl_PatientPharmacyOrder'))
BEGIN
ALTER TABLE Dtl_PatientPharmacyOrder ADD comments varchar(500)
END

IF   EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_getPatientPharmacyPrescription]') AND type in (N'P', N'PC'))
BEGIN
EXEC('
ALTER PROCEDURE [dbo].[sp_getPatientPharmacyPrescription]

	@PatientMasterVisitID int = null

AS
BEGIN

Set Nocount On;
	declare @pharmacy_pk int
	set @pharmacy_pk = (select top 1 ptn_pharmacy_pk from ord_PatientPharmacyOrder 
						where PatientMasterVisitId = @PatientMasterVisitID and DeleteFlag <> 1)

	select a.Drug_Pk,
	
	a.BatchNo batchId,
	a.FrequencyID, b.abbreviation abbr, b.DrugName, c.Name batchName, a.SingleDose dose, 
	d.Name freq,

	a.MorningDose, a.MiddayDose, a.EveningDose, a.NightDose,
	a.duration, a.OrderedQuantity, a.DispensedQuantity,
	
	a.Prophylaxis
	from dtl_PatientPharmacyOrder a inner join mst_drug b on a.Drug_Pk = b.Drug_pk
	left join Mst_Batch c on a.BatchNo = c.ID
	left join mst_Frequency d on a.FrequencyID = d.ID

	where a.ptn_pharmacy_pk IN(SELECT ptn_pharmacy_pk from ord_PatientPharmacyOrder WHERE PatientMasterVisitId=@PatientMasterVisitID) 
	
End	')
	END


IF NOT  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_getPatientPharmacyPrescription]') AND type in (N'P', N'PC'))
BEGIN
EXEC('
CREATE PROCEDURE [dbo].[sp_getPatientPharmacyPrescription]

	@PatientMasterVisitID int = null

AS
BEGIN

Set Nocount On;
	declare @pharmacy_pk int
	set @pharmacy_pk = (select top 1 ptn_pharmacy_pk from ord_PatientPharmacyOrder 
						where PatientMasterVisitId = @PatientMasterVisitID and DeleteFlag <> 1)

	select a.Drug_Pk,
	
	a.BatchNo batchId,
	a.FrequencyID, b.abbreviation abbr, b.DrugName, c.Name batchName, 
	a.SingleDose dose, 
	d.Name freq,

	a.MorningDose, a.MiddayDose, a.EveningDose, a.NightDose,
	a.duration, a.OrderedQuantity, a.DispensedQuantity,
	
	a.Prophylaxis
	from dtl_PatientPharmacyOrder a inner join mst_drug b on a.Drug_Pk = b.Drug_pk
	left join Mst_Batch c on a.BatchNo = c.ID
	left join mst_Frequency d on a.FrequencyID = d.ID

	where a.ptn_pharmacy_pk IN(SELECT ptn_pharmacy_pk from ord_PatientPharmacyOrder WHERE PatientMasterVisitId=@PatientMasterVisitID) 
	
End	')
	END