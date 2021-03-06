GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pr_GetPharmacypriorPrescription_Web]') AND type in (N'P', N'PC'))
BEGIN

EXEC ('ALTER PROCEDURE [dbo].[pr_GetPharmacypriorPrescription_Web] @ptn_pk INT
AS

BEGIN
 SELECT DISTINCT ''0'' AS orderId
  ,a.Drug_Pk [DrugId]
  ,a.DrugName [DrugName]
  ,a.[Dispensing Unit Id] [DispensingUnitId]
  ,a.[Dispensing Unit] [Unit]
  ,a.BatchNo
  ,a.BatchId
  ,convert(VARCHAR(11), a.ExpiryDate, 113) [ExpiryDate]
  ,a.MorningDose AS Morning
  ,a.MiddayDose AS Midday
  ,a.EveningDose AS Evening
  ,a.NightDose AS Night
  ,a.Duration
  ,a.PillCount
  ,a.OrderedQuantity AS [QtyPrescribed]
  ,a.DispensedQuantity [QtyDispensed]
  ,a.Prophylaxis
  ,a.comments
  ,a.PatientInstructions AS [Instructions]
  ,a.PrintPrescriptionStatus
  ,a.RegimenType [GenericAbbrevation]
  ,isnull(a.QtyUnitDisp, 0) QtyUnitDisp
  ,isnull(a.syrup, 0) syrup
  ,a.UserID
  ,a.StoreId
  ,a.RegimenLine
  ,a.RegimenId
 FROM [dbo].[VW_PatientPharmacy] a
 WHERE a.VisitID IN (
   SELECT MAX(VisitId)
   FROM ord_PatientPharmacyOrder
   WHERE Ptn_pk = @ptn_pk and (DeleteFlag=0 or DeleteFlag IS NULL)
   )
 
END
')
END

GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pr_GetPharmacypriorPrescription_Web]') AND type in (N'P', N'PC'))
BEGIN

EXEC ('Create PROCEDURE [dbo].[pr_GetPharmacypriorPrescription_Web] @ptn_pk INT
AS

BEGIN
 SELECT DISTINCT ''0'' AS orderId
  ,a.Drug_Pk [DrugId]
  ,a.DrugName [DrugName]
  ,a.[Dispensing Unit Id] [DispensingUnitId]
  ,a.[Dispensing Unit] [Unit]
  ,a.BatchNo
  ,a.BatchId
  ,convert(VARCHAR(11), a.ExpiryDate, 113) [ExpiryDate]
  ,a.MorningDose AS Morning
  ,a.MiddayDose AS Midday
  ,a.EveningDose AS Evening
  ,a.NightDose AS Night
  ,a.Duration
  ,a.PillCount
  ,a.OrderedQuantity AS [QtyPrescribed]
  ,a.DispensedQuantity [QtyDispensed]
  ,a.Prophylaxis
  ,a.comments
  ,a.PatientInstructions AS [Instructions]
  ,a.PrintPrescriptionStatus
  ,a.RegimenType [GenericAbbrevation]
  ,isnull(a.QtyUnitDisp, 0) QtyUnitDisp
  ,isnull(a.syrup, 0) syrup
  ,a.UserID
  ,a.StoreId
  ,a.RegimenLine
  ,a.RegimenId
 FROM [dbo].[VW_PatientPharmacy] a
 WHERE a.VisitID IN (
   SELECT MAX(VisitId)
   FROM ord_PatientPharmacyOrder
   WHERE Ptn_pk = @ptn_pk and (DeleteFlag=0 or DeleteFlag IS NULL)
   )
 
END
')
END