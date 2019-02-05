-- Lookuo Items
IF NOT EXISTS (SELECT * FROM LookupItem WHERE Name = 'CervicalCancerScreening')
	INSERT INTO LookupItem (Name,DisplayName,DeleteFlag) VALUES ('CervicalCancerScreening','Cervical Cancer Screening',0)

IF NOT EXISTS (SELECT * FROM LookupItem WHERE Name = 'ScreenedInLastOneYear')
	INSERT INTO LookupItem (Name,DisplayName,DeleteFlag) VALUES ('ScreenedInLastOneYear','Have you been screened for cervical cancer within the past one year?',0)

IF NOT EXISTS (SELECT * FROM LookupItem WHERE Name = 'ReferForScreening')
	INSERT INTO LookupItem (Name,DisplayName,DeleteFlag) VALUES ('ReferForScreening','Refer client for screening?',0)

IF NOT EXISTS (SELECT * FROM LookupItem WHERE Name = 'CxCaScreeningVisitType')
	INSERT INTO LookupItem (Name,DisplayName,DeleteFlag) VALUES ('CxCaScreeningVisitType','Visit Type', 1)

IF NOT EXISTS (SELECT * FROM LookupItem WHERE Name = 'Screening')
	INSERT INTO LookupItem (Name,DisplayName,DeleteFlag) VALUES ('Screening','Screening', 1)

IF NOT EXISTS (SELECT * FROM LookupItem WHERE Name = 'PostponedCryotherapyVisit')
	INSERT INTO LookupItem (Name,DisplayName,DeleteFlag) VALUES ('PostponedCryotherapyVisit','Postponed cryotherapy visit', 2)

IF NOT EXISTS (SELECT * FROM LookupItem WHERE Name = 'PostTxComplication')
	INSERT INTO LookupItem (Name,DisplayName,DeleteFlag) VALUES ('PostTxComplication','Post treatment complication, related to', 3)

IF NOT EXISTS (SELECT * FROM LookupItem WHERE Name = 'OtherCxCaTreatment')
	INSERT INTO LookupItem (Name,DisplayName,DeleteFlag) VALUES ('OtherCxCaTreatment','Other cervical cancer related treatment (Advanced care sites only)', 4)

IF NOT EXISTS (SELECT * FROM LookupItem WHERE Name = 'CxCaScreening')
	INSERT INTO LookupItem (Name,DisplayName,DeleteFlag) VALUES ('CxCaScreening','Screening', 1)

IF NOT EXISTS (SELECT * FROM LookupItem WHERE Name = 'Initial')
	INSERT INTO LookupItem (Name,DisplayName,DeleteFlag) VALUES ('Initial','Initial', 1)

IF NOT EXISTS (SELECT * FROM LookupItem WHERE Name = 'RoutineRescreening')
	INSERT INTO LookupItem (Name,DisplayName,DeleteFlag) VALUES ('RoutineRescreening','Routine Rescreening', 2)

IF NOT EXISTS (SELECT * FROM LookupItem WHERE Name = '1YearFollowUpPostTx')
	INSERT INTO LookupItem (Name,DisplayName,DeleteFlag) VALUES ('1YearFollowUpPostTx','1 Year follow-up Visit Post treatment', 3)

IF NOT EXISTS (SELECT * FROM LookupItem WHERE Name = 'CxCaScreeningMethod')
	INSERT INTO LookupItem (Name,DisplayName,DeleteFlag) VALUES ('CxCaScreeningMethod','Screening method', 2)

IF NOT EXISTS (SELECT * FROM LookupItem WHERE Name = 'VIA')
	INSERT INTO LookupItem (Name,DisplayName,DeleteFlag) VALUES ('VIA','VIA', 1)

IF NOT EXISTS (SELECT * FROM LookupItem WHERE Name = 'VILI')
	INSERT INTO LookupItem (Name,DisplayName,DeleteFlag) VALUES ('VILI','VILI', 2)

IF NOT EXISTS (SELECT * FROM LookupItem WHERE Name = 'PapSmear')
	INSERT INTO LookupItem (Name,DisplayName,DeleteFlag) VALUES ('PapSmear','PAP Smear', 3)

IF NOT EXISTS (SELECT * FROM LookupItem WHERE Name = 'HPVTest')
	INSERT INTO LookupItem (Name,DisplayName,DeleteFlag) VALUES ('HPVTest','HPV Test', 4)

IF NOT EXISTS (SELECT * FROM LookupItem WHERE Name = 'VIANegative')
	INSERT INTO LookupItem (Name,DisplayName,DeleteFlag) VALUES ('VIANegative','VIA Negative', 1)

IF NOT EXISTS (SELECT * FROM LookupItem WHERE Name = 'VIAPositive')
	INSERT INTO LookupItem (Name,DisplayName,DeleteFlag) VALUES ('VIAPositive','VIA Positive', 2)

IF NOT EXISTS (SELECT * FROM LookupItem WHERE Name = 'SuspiciousForCa')
	INSERT INTO LookupItem (Name,DisplayName,DeleteFlag) VALUES ('SuspiciousForCa','Suspcious for cancer', 3)

IF NOT EXISTS (SELECT * FROM LookupItem WHERE Name = 'Other')
	INSERT INTO LookupItem (Name,DisplayName,DeleteFlag) VALUES ('Other','Other', 4)

IF NOT EXISTS (SELECT * FROM LookupItem WHERE Name = 'LowGradeLesion')
	INSERT INTO LookupItem (Name,DisplayName,DeleteFlag) VALUES ('LowGradeLesion','Low grade lesion', 1)

IF NOT EXISTS (SELECT * FROM LookupItem WHERE Name = 'HighGradeLesion')
	INSERT INTO LookupItem (Name,DisplayName,DeleteFlag) VALUES ('HighGradeLesion','High grade lesion', 2)

IF NOT EXISTS (SELECT * FROM LookupItem WHERE Name = 'InvasiveCancer')
	INSERT INTO LookupItem (Name,DisplayName,DeleteFlag) VALUES ('InvasiveCancer','Invasive Cancer', 3)

IF NOT EXISTS (SELECT * FROM LookupItem WHERE Name = 'Negative')
	INSERT INTO LookupItem (Name,DisplayName,DeleteFlag) VALUES ('Negative','Negative', 1)

IF NOT EXISTS (SELECT * FROM LookupItem WHERE Name = 'Positive')
	INSERT INTO LookupItem (Name,DisplayName,DeleteFlag) VALUES ('Positive','Positive', 2)

IF NOT EXISTS (SELECT * FROM LookupItem WHERE Name = 'CxCaTreatment')
	INSERT INTO LookupItem (Name,DisplayName,DeleteFlag) VALUES ('CxCaTreatment','Treatment',7)

IF NOT EXISTS (SELECT * FROM LookupItem WHERE Name = 'CxCaScreeningTodayCryotherapyPerformed')
	INSERT INTO LookupItem (Name,DisplayName,DeleteFlag) VALUES ('CxCaScreeningTodayCryotherapyPerformed','Screening today, cryotherapy performed today (Single visit approach - SVA)', 5)

IF NOT EXISTS (SELECT * FROM LookupItem WHERE Name = 'CxCaScreeningTodayCryotherapyPostponed')
	INSERT INTO LookupItem (Name,DisplayName,DeleteFlag) VALUES ('CxCaScreeningTodayCryotherapyPostponed','Screening today, cryotherapy postponed', 6)

IF NOT EXISTS (SELECT * FROM LookupItem WHERE Name = 'PostponedCryotherapyDoneToday')
	INSERT INTO LookupItem (Name,DisplayName,DeleteFlag) VALUES ('PostponedCryotherapyDoneToday','Postponed cryotherapy done today', 7)

IF NOT EXISTS (SELECT * FROM LookupItem WHERE Name = 'OtherCxCaTxToday')
	INSERT INTO LookupItem (Name,DisplayName,DeleteFlag) VALUES ('OtherCxCaTxToday','Other cervical cancer specific treatment done today(e.g. LEEP)', 8)

IF NOT EXISTS (SELECT * FROM LookupItem WHERE Name = 'TxOtherAilment')
	INSERT INTO LookupItem (Name,DisplayName,DeleteFlag) VALUES ('TxOtherAilment','Treatment for other ailment', 9)

IF NOT EXISTS (SELECT * FROM LookupItem WHERE Name = 'CxCaReferralReasons')
	INSERT INTO LookupItem (Name,DisplayName,DeleteFlag) VALUES ('CxCaReferralReasons','Referral reasons',10)

IF NOT EXISTS (SELECT * FROM LookupItem WHERE Name = 'NoCryotherapyMachine')
	INSERT INTO LookupItem (Name,DisplayName,DeleteFlag) VALUES ('NoCryotherapyMachine','Site does not have cryotherapy machine', 11)

IF NOT EXISTS (SELECT * FROM LookupItem WHERE Name = 'LargeLesion')
	INSERT INTO LookupItem (Name,DisplayName,DeleteFlag) VALUES ('LargeLesion','Large lesion', 12)

IF NOT EXISTS (SELECT * FROM LookupItem WHERE Name = 'SuspectCancer')
	INSERT INTO LookupItem (Name,DisplayName,DeleteFlag) VALUES ('SuspectCancer','Suspect cancer', 13)

IF NOT EXISTS (SELECT * FROM LookupItem WHERE Name = 'OtherGynaProblem')
	INSERT INTO LookupItem (Name,DisplayName,DeleteFlag) VALUES ('OtherGynaProblem','Other gynaecolological problem', 14)

IF NOT EXISTS (SELECT * FROM LookupItem WHERE Name = 'LargeLesionReferralResults')
	INSERT INTO LookupItem (Name,DisplayName,DeleteFlag) VALUES ('LargeLesionReferralResults','Large Lesion Referral Results', 1)

IF NOT EXISTS (SELECT * FROM LookupItem WHERE Name = 'SuspectCaReferralResults')
	INSERT INTO LookupItem (Name,DisplayName,DeleteFlag) VALUES ('SuspectCaReferralResults','Suspect Cancer Referral Results', 2)

IF NOT EXISTS (SELECT * FROM LookupItem WHERE Name = 'LEEPPerformed')
	INSERT INTO LookupItem (Name,DisplayName,DeleteFlag) VALUES ('LEEPPerformed','LEEP performed', 1)

IF NOT EXISTS (SELECT * FROM LookupItem WHERE Name = 'CancerConfirmed')
	INSERT INTO LookupItem (Name,DisplayName,DeleteFlag) VALUES ('CancerConfirmed','Cancer confirmed', 1)

IF NOT EXISTS (SELECT * FROM LookupItem WHERE Name = 'CancerNotConfirmed')
	INSERT INTO LookupItem (Name,DisplayName,DeleteFlag) VALUES ('CancerNotConfirmed','Cancer not confirmed', 2)

IF NOT EXISTS (SELECT * FROM LookupItem WHERE Name = 'Cryotherapy')
	INSERT INTO LookupItem (Name,DisplayName,DeleteFlag) VALUES ('Cryotherapy','Cryotherapy', 2)

IF NOT EXISTS (SELECT * FROM LookupItem WHERE Name = 'LEEP')
	INSERT INTO LookupItem (Name,DisplayName,DeleteFlag) VALUES ('LEEP','LEEP', 2)

IF NOT EXISTS (SELECT * FROM LookupItem WHERE [Name] = 'VILINegative')
	INSERT INTO LookupItem (Name,DisplayName,DeleteFlag) VALUES ('VILINegative','VILI Negative',0)	

IF NOT EXISTS (SELECT * FROM LookupItem WHERE [Name] = 'VILIPositive')
	INSERT INTO LookupItem (Name,DisplayName,DeleteFlag) VALUES ('VILIPositive','VILI Positive',0)

-- Lookup master
IF NOT EXISTS (SELECT * FROM LookupMaster WHERE [Name] = 'ScreenedInLastOneYear')
	INSERT INTO LookupMaster (Name,DisplayName,DeleteFlag) VALUES ('ScreenedInLastOneYear','ScreenedInLastOneYear',0)

IF NOT EXISTS (SELECT * FROM LookupMaster WHERE [Name] = 'ReferForScreening')
	INSERT INTO LookupMaster (Name,DisplayName,DeleteFlag) VALUES ('ReferForScreening','Refer for screening?',0)

IF NOT EXISTS (SELECT * FROM LookupMaster WHERE [Name] = 'CervicalCancerScreeningAssessment')
	INSERT INTO LookupMaster (Name,DisplayName,DeleteFlag) VALUES ('CervicalCancerScreeningAssessment','Cervical Cancer Screening Assessment',0)

IF NOT EXISTS (SELECT * FROM LookupMaster WHERE [Name] = 'CervicalCancerScreening')
	INSERT INTO LookupMaster (Name,DisplayName,DeleteFlag) VALUES ('CervicalCancerScreening','CervicalCancerScreening',0)
	
IF NOT EXISTS (SELECT * FROM LookupMaster WHERE [Name] = 'CxCaScreeningVisitType')
	INSERT INTO LookupMaster (Name,DisplayName,DeleteFlag) VALUES ('CxCaScreeningVisitType','Visit Type',0)
		
IF NOT EXISTS (SELECT * FROM LookupMaster WHERE [Name] = 'Screening')
	INSERT INTO LookupMaster (Name,DisplayName,DeleteFlag) VALUES ('Screening','Screening Method',0)
	
IF NOT EXISTS (SELECT * FROM LookupMaster WHERE [Name] = 'PostTxComplication')
	INSERT INTO LookupMaster (Name,DisplayName,DeleteFlag) VALUES ('PostTxComplication','Post Treatment Complication',0)

IF NOT EXISTS (SELECT * FROM LookupMaster WHERE [Name] = 'CxCaScreeningMethod')
	INSERT INTO LookupMaster (Name,DisplayName,DeleteFlag) VALUES ('CxCaScreeningMethod','Screening Method',0)
		
IF NOT EXISTS (SELECT * FROM LookupMaster WHERE [Name] = 'VIA')
	INSERT INTO LookupMaster (Name,DisplayName,DeleteFlag) VALUES ('VIA','VIA',0)
	
IF NOT EXISTS (SELECT * FROM LookupMaster WHERE [Name] = 'VILI')
	INSERT INTO LookupMaster (Name,DisplayName,DeleteFlag) VALUES ('VILI','VILI',0)
	
IF NOT EXISTS (SELECT * FROM LookupMaster WHERE [Name] = 'PapSmear')
	INSERT INTO LookupMaster (Name,DisplayName,DeleteFlag) VALUES ('PapSmear','PapSmear',0)
		
IF NOT EXISTS (SELECT * FROM LookupMaster WHERE [Name] = 'HPVTest')
	INSERT INTO LookupMaster (Name,DisplayName,DeleteFlag) VALUES ('HPVTest','HPVTest',0)
		
IF NOT EXISTS (SELECT * FROM LookupMaster WHERE [Name] = 'CxCaReferralReasons')
	INSERT INTO LookupMaster (Name,DisplayName,DeleteFlag) VALUES ('CxCaReferralReasons','Referral Reasons',0)
	
IF NOT EXISTS (SELECT * FROM LookupMaster WHERE [Name] = 'LargeLesionReferralResults')
	INSERT INTO LookupMaster (Name,DisplayName,DeleteFlag) VALUES ('LargeLesionReferralResults','LargeLesionReferralResults',0)
	
IF NOT EXISTS (SELECT * FROM LookupMaster WHERE [Name] = 'SuspectCaReferralResults')
	INSERT INTO LookupMaster (Name,DisplayName,DeleteFlag) VALUES ('SuspectCaReferralResults','SuspectCaReferralResults',0)

IF NOT EXISTS (SELECT * FROM LookupMaster WHERE Name = 'CxCaTreatment')
	INSERT INTO LookupMaster (Name,DisplayName,DeleteFlag) VALUES ('CxCaTreatment','Treatment',1)

IF NOT EXISTS (SELECT * FROM LookupMaster WHERE Name = 'Referred')
	INSERT INTO LookupMaster (Name,DisplayName,DeleteFlag) VALUES ('Referred','Referred?',1)

-- LookupItemMaster
-- Screening Category = Cervical Cancer Screening
DECLARE @ScreeningCategory INT 
SELECT @ScreeningCategory = id from LookupMaster WHERE Name = 'ScreeningCategory'

IF @ScreeningCategory IS NOT NULL AND NOT EXISTS (SELECT * FROM LookupMasterItem WHERE LookupMasterId = @ScreeningCategory AND LookupItemId = (SELECT top 1 Id FROM LookupItem WHERE [Name] = 'CervicalCancerScreening'))
	INSERT INTO LookupMasterItem (LookupMasterId,LookupItemId,DisplayName,OrdRank) VALUES (@ScreeningCategory,(SELECT top 1 Id FROM LookupItem WHERE [Name] = 'CervicalCancerScreening'),(SELECT top 1 DisplayName FROM LookupItem WHERE [Name] = 'CervicalCancerScreening'), 1)


--Screening Questions and responses
DECLARE @ScreenedInLastOneYear INT 
SELECT @ScreenedInLastOneYear = id from LookupMaster WHERE Name = 'ScreenedInLastOneYear'

IF @ScreenedInLastOneYear IS NOT NULL AND NOT EXISTS (SELECT * FROM LookupMasterItem WHERE LookupMasterId = @ScreenedInLastOneYear AND LookupItemId = (SELECT top 1 Id FROM LookupItem WHERE [Name] = 'Yes'))
	INSERT INTO LookupMasterItem (LookupMasterId,LookupItemId,DisplayName,OrdRank) VALUES (@ScreenedInLastOneYear,(SELECT top 1 Id FROM LookupItem WHERE [Name] = 'Yes'),'Yes',1)

IF @ScreenedInLastOneYear IS NOT NULL AND NOT EXISTS (SELECT * FROM LookupMasterItem WHERE LookupMasterId = @ScreenedInLastOneYear AND LookupItemId = (SELECT top 1 Id FROM LookupItem WHERE [Name] = 'No'))
	INSERT INTO LookupMasterItem (LookupMasterId,LookupItemId,DisplayName,OrdRank) VALUES (@ScreenedInLastOneYear,(SELECT top 1 Id FROM LookupItem WHERE [Name] = 'No'),'No',2)

DECLARE @ReferForScreening INT 
SELECT @ReferForScreening = id from LookupMaster WHERE Name = 'ReferForScreening'

IF @ReferForScreening IS NOT NULL AND NOT EXISTS (SELECT * FROM LookupMasterItem WHERE LookupMasterId = @ReferForScreening AND LookupItemId = (SELECT top 1 Id FROM LookupItem WHERE [Name] = 'Yes'))
	INSERT INTO LookupMasterItem (LookupMasterId,LookupItemId,DisplayName,OrdRank) VALUES (@ReferForScreening,(SELECT top 1 Id FROM LookupItem WHERE [Name] = 'Yes'),'Yes',1)

IF @ReferForScreening IS NOT NULL AND NOT EXISTS (SELECT * FROM LookupMasterItem WHERE LookupMasterId = @ReferForScreening AND LookupItemId = (SELECT top 1 Id FROM LookupItem WHERE [Name] = 'No'))
	INSERT INTO LookupMasterItem (LookupMasterId,LookupItemId,DisplayName,OrdRank) VALUES (@ReferForScreening,(SELECT top 1 Id FROM LookupItem WHERE [Name] = 'No'),'No',2)



DECLARE @CxCaScreening INT 
SELECT @CxCaScreening = id from LookupMaster WHERE Name = 'CervicalCancerScreening'

IF @CxCaScreening IS NOT NULL AND NOT EXISTS (SELECT * FROM LookupMasterItem WHERE LookupMasterId = @CxCaScreening AND LookupItemId = (SELECT top 1 Id FROM LookupItem WHERE [Name] = 'ScreenedInLastOneYear'))
	INSERT INTO LookupMasterItem (LookupMasterId,LookupItemId,DisplayName,OrdRank) VALUES (@CxCaScreening,(SELECT top 1 Id FROM LookupItem WHERE [Name] = 'ScreenedInLastOneYear'),(SELECT top 1 DisplayName FROM LookupItem WHERE [Name] = 'ScreenedInLastOneYear'),1)

IF @CxCaScreening IS NOT NULL AND NOT EXISTS (SELECT * FROM LookupMasterItem WHERE LookupMasterId = @CxCaScreening AND LookupItemId = (SELECT top 1 Id FROM LookupItem WHERE [Name] = 'CxCaScreeningVisitType'))
	INSERT INTO LookupMasterItem (LookupMasterId,LookupItemId,DisplayName,OrdRank) VALUES (@CxCaScreening,(SELECT top 1 Id FROM LookupItem WHERE [Name] = 'CxCaScreeningVisitType'),(SELECT top 1 DisplayName FROM LookupItem WHERE [Name] = 'CxCaScreeningVisitType'),2)

IF @CxCaScreening IS NOT NULL AND NOT EXISTS (SELECT * FROM LookupMasterItem WHERE LookupMasterId = @CxCaScreening AND LookupItemId = (SELECT top 1 Id FROM LookupItem WHERE [Name] = 'CxCaScreeningMethod'))
	INSERT INTO LookupMasterItem (LookupMasterId,LookupItemId,DisplayName,OrdRank) VALUES (@CxCaScreening,(SELECT top 1 Id FROM LookupItem WHERE [Name] = 'CxCaScreeningMethod'),(SELECT top 1 DisplayName FROM LookupItem WHERE [Name] = 'CxCaScreeningMethod'),3)

IF @CxCaScreening IS NOT NULL AND NOT EXISTS (SELECT * FROM LookupMasterItem WHERE LookupMasterId = @CxCaScreening AND LookupItemId = (SELECT top 1 Id FROM LookupItem WHERE [Name] = 'CxCaTreatment'))
	INSERT INTO LookupMasterItem (LookupMasterId,LookupItemId,DisplayName,OrdRank) VALUES (@CxCaScreening,(SELECT top 1 Id FROM LookupItem WHERE [Name] = 'CxCaTreatment'),(SELECT top 1 DisplayName FROM LookupItem WHERE [Name] = 'CxCaTreatment'),4)

IF @CxCaScreening IS NOT NULL AND NOT EXISTS (SELECT * FROM LookupMasterItem WHERE LookupMasterId = @CxCaScreening AND LookupItemId = (SELECT top 1 Id FROM LookupItem WHERE [Name] = 'CxCaTreatment'))
	INSERT INTO LookupMasterItem (LookupMasterId,LookupItemId,DisplayName,OrdRank) VALUES (@CxCaScreening,(SELECT top 1 Id FROM LookupItem WHERE [Name] = 'CxCaTreatment'),(SELECT top 1 DisplayName FROM LookupItem WHERE [Name] = 'CxCaTreatment'),1)


DECLARE @CervicalCancerScreeningAssessment INT
SELECT @CervicalCancerScreeningAssessment = id from LookupMaster WHERE Name = 'CervicalCancerScreeningAssessment'

IF @CervicalCancerScreeningAssessment IS NOT NULL AND NOT EXISTS (SELECT * FROM LookupMasterItem WHERE LookupMasterId = @CervicalCancerScreeningAssessment AND LookupItemId = (SELECT top 1 Id FROM LookupItem WHERE [Name] = 'ScreenedInLastOneYear'))
	INSERT INTO LookupMasterItem (LookupMasterId,LookupItemId,DisplayName,OrdRank) VALUES (@CervicalCancerScreeningAssessment,(SELECT top 1 Id FROM LookupItem WHERE [Name] = 'ScreenedInLastOneYear'),(SELECT top 1 DisplayName FROM LookupItem WHERE [Name] = 'ScreenedInLastOneYear'),1)

IF @CervicalCancerScreeningAssessment IS NOT NULL AND NOT EXISTS (SELECT * FROM LookupMasterItem WHERE LookupMasterId = @CervicalCancerScreeningAssessment AND LookupItemId = (SELECT top 1 Id FROM LookupItem WHERE [Name] = 'ReferForScreening'))
	INSERT INTO LookupMasterItem (LookupMasterId,LookupItemId,DisplayName,OrdRank) VALUES (@CervicalCancerScreeningAssessment,(SELECT top 1 Id FROM LookupItem WHERE [Name] = 'ReferForScreening'),(SELECT top 1 DisplayName FROM LookupItem WHERE [Name] = 'ReferForScreening'),2)


DECLARE @CxCaScreeningVisitType INT 
SELECT @CxCaScreeningVisitType = id from LookupMaster WHERE Name = 'CxCaScreeningVisitType'

IF @CxCaScreeningVisitType IS NOT NULL AND NOT EXISTS (SELECT * FROM LookupMasterItem WHERE LookupMasterId = @CxCaScreeningVisitType AND LookupItemId = (SELECT top 1 Id FROM LookupItem WHERE [Name] = 'Screening'))
	INSERT INTO LookupMasterItem (LookupMasterId,LookupItemId,DisplayName,OrdRank) VALUES (@CxCaScreeningVisitType,(SELECT top 1 Id FROM LookupItem WHERE [Name] = 'Screening'),(SELECT top 1 DisplayName FROM LookupItem WHERE [Name] = 'Screening'),1)

IF @CxCaScreeningVisitType IS NOT NULL AND NOT EXISTS (SELECT * FROM LookupMasterItem WHERE LookupMasterId = @CxCaScreeningVisitType AND LookupItemId = (SELECT top 1 Id FROM LookupItem WHERE [Name] = 'PostponedCryotherapyVisit'))
	INSERT INTO LookupMasterItem (LookupMasterId,LookupItemId,DisplayName,OrdRank) VALUES (@CxCaScreeningVisitType,(SELECT top 1 Id FROM LookupItem WHERE [Name] = 'PostponedCryotherapyVisit'),(SELECT top 1 DisplayName FROM LookupItem WHERE [Name] = 'PostponedCryotherapyVisit'),2)

IF @CxCaScreeningVisitType IS NOT NULL AND NOT EXISTS (SELECT * FROM LookupMasterItem WHERE LookupMasterId = @CxCaScreeningVisitType AND LookupItemId = (SELECT top 1 Id FROM LookupItem WHERE [Name] = 'PostTxComplication'))
	INSERT INTO LookupMasterItem (LookupMasterId,LookupItemId,DisplayName,OrdRank) VALUES (@CxCaScreeningVisitType,(SELECT top 1 Id FROM LookupItem WHERE [Name] = 'PostTxComplication'),(SELECT top 1 DisplayName FROM LookupItem WHERE [Name] = 'PostTxComplication'),3)

IF @CxCaScreeningVisitType IS NOT NULL AND NOT EXISTS (SELECT * FROM LookupMasterItem WHERE LookupMasterId = @CxCaScreeningVisitType AND LookupItemId = (SELECT top 1 Id FROM LookupItem WHERE [Name] = 'OtherCxCaTreatment'))
	INSERT INTO LookupMasterItem (LookupMasterId,LookupItemId,DisplayName,OrdRank) VALUES (@CxCaScreeningVisitType,(SELECT top 1 Id FROM LookupItem WHERE [Name] = 'OtherCxCaTreatment'),(SELECT top 1 DisplayName FROM LookupItem WHERE [Name] = 'OtherCxCaTreatment'),4)

DECLARE @Screening INT 
SELECT @Screening = id from LookupMaster WHERE Name = 'Screening'

IF @Screening IS NOT NULL AND NOT EXISTS (SELECT * FROM LookupMasterItem WHERE LookupMasterId = @Screening AND LookupItemId = (SELECT top 1 Id FROM LookupItem WHERE [Name] = 'Initial'))
	INSERT INTO LookupMasterItem (LookupMasterId,LookupItemId,DisplayName,OrdRank) VALUES (@Screening,(SELECT top 1 Id FROM LookupItem WHERE [Name] = 'Initial'),(SELECT top 1 DisplayName FROM LookupItem WHERE [Name] = 'Initial'),1)

IF @Screening IS NOT NULL AND NOT EXISTS (SELECT * FROM LookupMasterItem WHERE LookupMasterId = @Screening AND LookupItemId = (SELECT top 1 Id FROM LookupItem WHERE [Name] = 'RoutineRescreening'))
	INSERT INTO LookupMasterItem (LookupMasterId,LookupItemId,DisplayName,OrdRank) VALUES (@Screening,(SELECT top 1 Id FROM LookupItem WHERE [Name] = 'RoutineRescreening'),(SELECT top 1 DisplayName FROM LookupItem WHERE [Name] = 'RoutineRescreening'),2)

IF @Screening IS NOT NULL AND NOT EXISTS (SELECT * FROM LookupMasterItem WHERE LookupMasterId = @Screening AND LookupItemId = (SELECT top 1 Id FROM LookupItem WHERE [Name] = '1YearFollowUpPostTx'))
	INSERT INTO LookupMasterItem (LookupMasterId,LookupItemId,DisplayName,OrdRank) VALUES (@Screening,(SELECT top 1 Id FROM LookupItem WHERE [Name] = '1YearFollowUpPostTx'),(SELECT top 1 DisplayName FROM LookupItem WHERE [Name] = '1YearFollowUpPostTx'),3)

DECLARE @PostTxComplication INT 
SELECT @PostTxComplication = id from LookupMaster WHERE Name = 'PostTxComplication'

IF @PostTxComplication IS NOT NULL AND NOT EXISTS (SELECT * FROM LookupMasterItem WHERE LookupMasterId = @PostTxComplication AND LookupItemId = (SELECT top 1 Id FROM LookupItem WHERE [Name] = 'Cryotherapy'))
	INSERT INTO LookupMasterItem (LookupMasterId,LookupItemId,DisplayName,OrdRank) VALUES (@PostTxComplication,(SELECT top 1 Id FROM LookupItem WHERE [Name] = 'Cryotherapy'),(SELECT top 1 DisplayName FROM LookupItem WHERE [Name] = 'Cryotherapy'),1)

IF @PostTxComplication IS NOT NULL AND NOT EXISTS (SELECT * FROM LookupMasterItem WHERE LookupMasterId = @PostTxComplication AND LookupItemId = (SELECT top 1 Id FROM LookupItem WHERE [Name] = 'LEEP'))
	INSERT INTO LookupMasterItem (LookupMasterId,LookupItemId,DisplayName,OrdRank) VALUES (@PostTxComplication,(SELECT top 1 Id FROM LookupItem WHERE [Name] = 'LEEP'),(SELECT top 1 DisplayName FROM LookupItem WHERE [Name] = 'LEEP'),2)

IF @PostTxComplication IS NOT NULL AND NOT EXISTS (SELECT * FROM LookupMasterItem WHERE LookupMasterId = @PostTxComplication AND LookupItemId = (SELECT top 1 Id FROM LookupItem WHERE [Name] = 'Other'))
	INSERT INTO LookupMasterItem (LookupMasterId,LookupItemId,DisplayName,OrdRank) VALUES (@PostTxComplication,(SELECT top 1 Id FROM LookupItem WHERE [Name] = 'Other'),(SELECT top 1 DisplayName FROM LookupItem WHERE [Name] = 'Other'),3)

DECLARE @CxCaScreeningMethod INT 
SELECT @CxCaScreeningMethod = id from LookupMaster WHERE Name = 'CxCaScreeningMethod'

IF @CxCaScreeningMethod IS NOT NULL AND NOT EXISTS (SELECT * FROM LookupMasterItem WHERE LookupMasterId = @CxCaScreeningMethod AND LookupItemId = (SELECT top 1 Id FROM LookupItem WHERE [Name] = 'VIA'))
	INSERT INTO LookupMasterItem (LookupMasterId,LookupItemId,DisplayName,OrdRank) VALUES (@CxCaScreeningMethod,(SELECT top 1 Id FROM LookupItem WHERE [Name] = 'VIA'),(SELECT top 1 DisplayName FROM LookupItem WHERE [Name] = 'VIA'),1)

IF @CxCaScreeningMethod IS NOT NULL AND NOT EXISTS (SELECT * FROM LookupMasterItem WHERE LookupMasterId = @CxCaScreeningMethod AND LookupItemId = (SELECT top 1 Id FROM LookupItem WHERE [Name] = 'VILI'))
	INSERT INTO LookupMasterItem (LookupMasterId,LookupItemId,DisplayName,OrdRank) VALUES (@CxCaScreeningMethod,(SELECT top 1 Id FROM LookupItem WHERE [Name] = 'VILI'),(SELECT top 1 DisplayName FROM LookupItem WHERE [Name] = 'VILI'),2)

IF @CxCaScreeningMethod IS NOT NULL AND NOT EXISTS (SELECT * FROM LookupMasterItem WHERE LookupMasterId = @CxCaScreeningMethod AND LookupItemId = (SELECT top 1 Id FROM LookupItem WHERE [Name] = 'PapSmear'))
	INSERT INTO LookupMasterItem (LookupMasterId,LookupItemId,DisplayName,OrdRank) VALUES (@CxCaScreeningMethod,(SELECT top 1 Id FROM LookupItem WHERE [Name] = 'PapSmear'),(SELECT top 1 DisplayName FROM LookupItem WHERE [Name] = 'PapSmear'),3)

IF @CxCaScreeningMethod IS NOT NULL AND NOT EXISTS (SELECT * FROM LookupMasterItem WHERE LookupMasterId = @CxCaScreeningMethod AND LookupItemId = (SELECT top 1 Id FROM LookupItem WHERE [Name] = 'HPVTest'))
	INSERT INTO LookupMasterItem (LookupMasterId,LookupItemId,DisplayName,OrdRank) VALUES (@CxCaScreeningMethod,(SELECT top 1 Id FROM LookupItem WHERE [Name] = 'HPVTest'),(SELECT top 1 DisplayName FROM LookupItem WHERE [Name] = 'HPVTest'),4)


DECLARE @VIA INT 
SELECT @VIA = id from LookupMaster WHERE Name = 'VIA'

IF @VIA IS NOT NULL AND NOT EXISTS (SELECT * FROM LookupMasterItem WHERE LookupMasterId = @VIA AND LookupItemId = (SELECT top 1 Id FROM LookupItem WHERE [Name] = 'VIANegative'))
	INSERT INTO LookupMasterItem (LookupMasterId,LookupItemId,DisplayName,OrdRank) VALUES (@VIA,(SELECT top 1 Id FROM LookupItem WHERE [Name] = 'VIANegative'),(SELECT top 1 DisplayName FROM LookupItem WHERE [Name] = 'VIANegative'),1)

IF @VIA IS NOT NULL AND NOT EXISTS (SELECT * FROM LookupMasterItem WHERE LookupMasterId = @VIA AND LookupItemId = (SELECT top 1 Id FROM LookupItem WHERE [Name] = 'VIAPositive'))
	INSERT INTO LookupMasterItem (LookupMasterId,LookupItemId,DisplayName,OrdRank) VALUES (@VIA,(SELECT top 1 Id FROM LookupItem WHERE [Name] = 'VIAPositive'),(SELECT top 1 DisplayName FROM LookupItem WHERE [Name] = 'VIAPositive'),2)

IF @VIA IS NOT NULL AND NOT EXISTS (SELECT * FROM LookupMasterItem WHERE LookupMasterId = @VIA AND LookupItemId = (SELECT top 1 Id FROM LookupItem WHERE [Name] = 'SuspiciousForCa'))
	INSERT INTO LookupMasterItem (LookupMasterId,LookupItemId,DisplayName,OrdRank) VALUES (@VIA,(SELECT top 1 Id FROM LookupItem WHERE [Name] = 'SuspiciousForCa'),(SELECT top 1 DisplayName FROM LookupItem WHERE [Name] = 'SuspiciousForCa'),3)

IF @VIA IS NOT NULL AND NOT EXISTS (SELECT * FROM LookupMasterItem WHERE LookupMasterId = @VIA AND LookupItemId = (SELECT top 1 Id FROM LookupItem WHERE [Name] = 'Other'))
	INSERT INTO LookupMasterItem (LookupMasterId,LookupItemId,DisplayName,OrdRank) VALUES (@VIA,(SELECT top 1 Id FROM LookupItem WHERE [Name] = 'Other'),(SELECT top 1 DisplayName FROM LookupItem WHERE [Name] = 'Other'),4)

DECLARE @VILI INT 
SELECT @VILI = id from LookupMaster WHERE Name = 'VILI'

IF @VILI IS NOT NULL AND NOT EXISTS (SELECT * FROM LookupMasterItem WHERE LookupMasterId = @VILI AND LookupItemId = (SELECT top 1 Id FROM LookupItem WHERE [Name] = 'VILINegative'))
	INSERT INTO LookupMasterItem (LookupMasterId,LookupItemId,DisplayName,OrdRank) VALUES (@VILI,(SELECT top 1 Id FROM LookupItem WHERE [Name] = 'VILINegative'),(SELECT top 1 DisplayName FROM LookupItem WHERE [Name] = 'VILINegative'),1)

IF @VILI IS NOT NULL AND NOT EXISTS (SELECT * FROM LookupMasterItem WHERE LookupMasterId = @VILI AND LookupItemId = (SELECT top 1 Id FROM LookupItem WHERE [Name] = 'VILIPositive'))
	INSERT INTO LookupMasterItem (LookupMasterId,LookupItemId,DisplayName,OrdRank) VALUES (@VILI,(SELECT top 1 Id FROM LookupItem WHERE [Name] = 'VILIPositive'),(SELECT top 1 DisplayName FROM LookupItem WHERE [Name] = 'VILIPositive'),2)

IF @VILI IS NOT NULL AND NOT EXISTS (SELECT * FROM LookupMasterItem WHERE LookupMasterId = @VILI AND LookupItemId = (SELECT top 1 Id FROM LookupItem WHERE [Name] = 'SuspiciousForCa'))
	INSERT INTO LookupMasterItem (LookupMasterId,LookupItemId,DisplayName,OrdRank) VALUES (@VILI,(SELECT top 1 Id FROM LookupItem WHERE [Name] = 'SuspiciousForCa'),(SELECT top 1 DisplayName FROM LookupItem WHERE [Name] = 'SuspiciousForCa'),3)

IF @VILI IS NOT NULL AND NOT EXISTS (SELECT * FROM LookupMasterItem WHERE LookupMasterId = @VILI AND LookupItemId = (SELECT top 1 Id FROM LookupItem WHERE [Name] = 'Other'))
	INSERT INTO LookupMasterItem (LookupMasterId,LookupItemId,DisplayName,OrdRank) VALUES (@VILI,(SELECT top 1 Id FROM LookupItem WHERE [Name] = 'Other'),(SELECT top 1 DisplayName FROM LookupItem WHERE [Name] = 'Other'),4)

DECLARE @PapSmear INT 
SELECT @PapSmear = id from LookupMaster WHERE Name = 'PapSmear'

IF @PapSmear IS NOT NULL AND NOT EXISTS (SELECT * FROM LookupMasterItem WHERE LookupMasterId = @PapSmear AND LookupItemId = (SELECT top 1 Id FROM LookupItem WHERE [Name] = 'LowGradeLesion'))
	INSERT INTO LookupMasterItem (LookupMasterId,LookupItemId,DisplayName,OrdRank) VALUES (@PapSmear,(SELECT top 1 Id FROM LookupItem WHERE [Name] = 'LowGradeLesion'),(SELECT top 1 DisplayName FROM LookupItem WHERE [Name] = 'LowGradeLesion'),1)

IF @PapSmear IS NOT NULL AND NOT EXISTS (SELECT * FROM LookupMasterItem WHERE LookupMasterId = @PapSmear AND LookupItemId = (SELECT top 1 Id FROM LookupItem WHERE [Name] = 'HighGradeLesion'))
	INSERT INTO LookupMasterItem (LookupMasterId,LookupItemId,DisplayName,OrdRank) VALUES (@PapSmear,(SELECT top 1 Id FROM LookupItem WHERE [Name] = 'HighGradeLesion'),(SELECT top 1 DisplayName FROM LookupItem WHERE [Name] = 'HighGradeLesion'),2)

IF @PapSmear IS NOT NULL AND NOT EXISTS (SELECT * FROM LookupMasterItem WHERE LookupMasterId = @PapSmear AND LookupItemId = (SELECT top 1 Id FROM LookupItem WHERE [Name] = 'InvasiveCancer'))
	INSERT INTO LookupMasterItem (LookupMasterId,LookupItemId,DisplayName,OrdRank) VALUES (@PapSmear,(SELECT top 1 Id FROM LookupItem WHERE [Name] = 'InvasiveCancer'),(SELECT top 1 DisplayName FROM LookupItem WHERE [Name] = 'InvasiveCancer'),3)

IF @PapSmear IS NOT NULL AND NOT EXISTS (SELECT * FROM LookupMasterItem WHERE LookupMasterId = @PapSmear AND LookupItemId = (SELECT top 1 Id FROM LookupItem WHERE [Name] = 'Other'))
	INSERT INTO LookupMasterItem (LookupMasterId,LookupItemId,DisplayName,OrdRank) VALUES (@PapSmear,(SELECT top 1 Id FROM LookupItem WHERE [Name] = 'Other'),(SELECT top 1 DisplayName FROM LookupItem WHERE [Name] = 'Other'),4)

DECLARE @HPVTest INT 
SELECT @HPVTest = id from LookupMaster WHERE Name = 'HPVTest'

IF @HPVTest IS NOT NULL AND NOT EXISTS (SELECT * FROM LookupMasterItem WHERE LookupMasterId = @HPVTest AND LookupItemId = (SELECT top 1 Id FROM LookupItem WHERE [Name] = 'Positive'))
	INSERT INTO LookupMasterItem (LookupMasterId,LookupItemId,DisplayName,OrdRank) VALUES (@HPVTest,(SELECT top 1 Id FROM LookupItem WHERE [Name] = 'Positive'),(SELECT top 1 DisplayName FROM LookupItem WHERE [Name] = 'Positive'),1)

IF @HPVTest IS NOT NULL AND NOT EXISTS (SELECT * FROM LookupMasterItem WHERE LookupMasterId = @HPVTest AND LookupItemId = (SELECT top 1 Id FROM LookupItem WHERE [Name] = 'Negative'))
	INSERT INTO LookupMasterItem (LookupMasterId,LookupItemId,DisplayName,OrdRank) VALUES (@HPVTest,(SELECT top 1 Id FROM LookupItem WHERE [Name] = 'Negative'),(SELECT top 1 DisplayName FROM LookupItem WHERE [Name] = 'Negative'),2)

DECLARE @ReferralReasons INT 
SELECT @ReferralReasons = id from LookupMaster WHERE Name = 'CxCaReferralReasons'

IF @ReferralReasons IS NOT NULL AND NOT EXISTS (SELECT * FROM LookupMasterItem WHERE LookupMasterId = @ReferralReasons AND LookupItemId = (SELECT top 1 Id FROM LookupItem WHERE [Name] = 'NoCryotherapyMachine'))
	INSERT INTO LookupMasterItem (LookupMasterId,LookupItemId,DisplayName,OrdRank) VALUES (@ReferralReasons,(SELECT top 1 Id FROM LookupItem WHERE [Name] = 'NoCryotherapyMachine'),(SELECT top 1 DisplayName FROM LookupItem WHERE [Name] = 'NoCryotherapyMachine'),1)

IF @ReferralReasons IS NOT NULL AND NOT EXISTS (SELECT * FROM LookupMasterItem WHERE LookupMasterId = @ReferralReasons AND LookupItemId = (SELECT top 1 Id FROM LookupItem WHERE [Name] = 'LargeLesion'))
	INSERT INTO LookupMasterItem (LookupMasterId,LookupItemId,DisplayName,OrdRank) VALUES (@ReferralReasons,(SELECT top 1 Id FROM LookupItem WHERE [Name] = 'LargeLesion'),(SELECT top 1 DisplayName FROM LookupItem WHERE [Name] = 'LargeLesion'),2)

IF @ReferralReasons IS NOT NULL AND NOT EXISTS (SELECT * FROM LookupMasterItem WHERE LookupMasterId = @ReferralReasons AND LookupItemId = (SELECT top 1 Id FROM LookupItem WHERE [Name] = 'SuspectCancer'))
	INSERT INTO LookupMasterItem (LookupMasterId,LookupItemId,DisplayName,OrdRank) VALUES (@ReferralReasons,(SELECT top 1 Id FROM LookupItem WHERE [Name] = 'SuspectCancer'),(SELECT top 1 DisplayName FROM LookupItem WHERE [Name] = 'SuspectCancer'),3)

IF @ReferralReasons IS NOT NULL AND NOT EXISTS (SELECT * FROM LookupMasterItem WHERE LookupMasterId = @ReferralReasons AND LookupItemId = (SELECT top 1 Id FROM LookupItem WHERE [Name] = 'OtherGynaProblem'))
	INSERT INTO LookupMasterItem (LookupMasterId,LookupItemId,DisplayName,OrdRank) VALUES (@ReferralReasons,(SELECT top 1 Id FROM LookupItem WHERE [Name] = 'OtherGynaProblem'),(SELECT top 1 DisplayName FROM LookupItem WHERE [Name] = 'OtherGynaProblem'),4)

DECLARE @LargeLesionReferralResults INT 
SELECT @LargeLesionReferralResults = id from LookupMaster WHERE Name = 'LargeLesion'

IF @LargeLesionReferralResults IS NOT NULL AND NOT EXISTS (SELECT * FROM LookupMasterItem WHERE LookupMasterId = @LargeLesionReferralResults AND LookupItemId = (SELECT top 1 Id FROM LookupItem WHERE [Name] = 'LEEPPerformed'))
	INSERT INTO LookupMasterItem (LookupMasterId,LookupItemId,DisplayName,OrdRank) VALUES (@LargeLesionReferralResults,(SELECT top 1 Id FROM LookupItem WHERE [Name] = 'LEEPPerformed'),(SELECT top 1 DisplayName FROM LookupItem WHERE [Name] = 'LEEPPerformed'),1)

IF @LargeLesionReferralResults IS NOT NULL AND NOT EXISTS (SELECT * FROM LookupMasterItem WHERE LookupMasterId = @LargeLesionReferralResults AND LookupItemId = (SELECT top 1 Id FROM LookupItem WHERE [Name] = 'Other'))
	INSERT INTO LookupMasterItem (LookupMasterId,LookupItemId,DisplayName,OrdRank) VALUES (@LargeLesionReferralResults,(SELECT top 1 Id FROM LookupItem WHERE [Name] = 'Other'),(SELECT top 1 DisplayName FROM LookupItem WHERE [Name] = 'Other'),2)


DECLARE @SuspectCaReferralResults INT 
SELECT @SuspectCaReferralResults = id from LookupMaster WHERE Name = 'SuspectCancer'

IF @SuspectCaReferralResults IS NOT NULL AND NOT EXISTS (SELECT * FROM LookupMasterItem WHERE LookupMasterId = @SuspectCaReferralResults AND LookupItemId = (SELECT top 1 Id FROM LookupItem WHERE [Name] = 'CancerConfirmed'))
	INSERT INTO LookupMasterItem (LookupMasterId,LookupItemId,DisplayName,OrdRank) VALUES (@SuspectCaReferralResults,(SELECT top 1 Id FROM LookupItem WHERE [Name] = 'CancerConfirmed'),(SELECT top 1 DisplayName FROM LookupItem WHERE [Name] = 'CancerConfirmed'),1)

IF @SuspectCaReferralResults IS NOT NULL AND NOT EXISTS (SELECT * FROM LookupMasterItem WHERE LookupMasterId = @SuspectCaReferralResults AND LookupItemId = (SELECT top 1 Id FROM LookupItem WHERE [Name] = 'CancerNotConfirmed'))
	INSERT INTO LookupMasterItem (LookupMasterId,LookupItemId,DisplayName,OrdRank) VALUES (@SuspectCaReferralResults,(SELECT top 1 Id FROM LookupItem WHERE [Name] = 'CancerNotConfirmed'),(SELECT top 1 DisplayName FROM LookupItem WHERE [Name] = 'CancerNotConfirmed'),2)

DECLARE @CxCaTreatment INT 
SELECT @CxCaTreatment = id from LookupMaster WHERE Name = 'CxCaTreatment'

IF @CxCaTreatment IS NOT NULL AND NOT EXISTS (SELECT * FROM LookupMasterItem WHERE LookupMasterId = @CxCaTreatment AND LookupItemId = (SELECT top 1 Id FROM LookupItem WHERE [Name] = 'CxCaScreeningTodayCryotherapyPerformed'))
	INSERT INTO LookupMasterItem (LookupMasterId,LookupItemId,DisplayName,OrdRank) VALUES (@CxCaTreatment,(SELECT top 1 Id FROM LookupItem WHERE [Name] = 'CxCaScreeningTodayCryotherapyPerformed'),(SELECT top 1 DisplayName FROM LookupItem WHERE [Name] = 'CxCaScreeningTodayCryotherapyPerformed'),1)

IF @CxCaTreatment IS NOT NULL AND NOT EXISTS (SELECT * FROM LookupMasterItem WHERE LookupMasterId = @CxCaTreatment AND LookupItemId = (SELECT top 1 Id FROM LookupItem WHERE [Name] = 'CxCaScreeningTodayCryotherapyPostponed'))
	INSERT INTO LookupMasterItem (LookupMasterId,LookupItemId,DisplayName,OrdRank) VALUES (@CxCaTreatment,(SELECT top 1 Id FROM LookupItem WHERE [Name] = 'CxCaScreeningTodayCryotherapyPostponed'),(SELECT top 1 DisplayName FROM LookupItem WHERE [Name] = 'CxCaScreeningTodayCryotherapyPostponed'),2)

IF @CxCaTreatment IS NOT NULL AND NOT EXISTS (SELECT * FROM LookupMasterItem WHERE LookupMasterId = @CxCaTreatment AND LookupItemId = (SELECT top 1 Id FROM LookupItem WHERE [Name] = 'PostponedCryotherapyDoneToday'))
	INSERT INTO LookupMasterItem (LookupMasterId,LookupItemId,DisplayName,OrdRank) VALUES (@CxCaTreatment,(SELECT top 1 Id FROM LookupItem WHERE [Name] = 'PostponedCryotherapyDoneToday'),(SELECT top 1 DisplayName FROM LookupItem WHERE [Name] = 'PostponedCryotherapyDoneToday'),3)

IF @CxCaTreatment IS NOT NULL AND NOT EXISTS (SELECT * FROM LookupMasterItem WHERE LookupMasterId = @CxCaTreatment AND LookupItemId = (SELECT top 1 Id FROM LookupItem WHERE [Name] = 'OtherCxCaTxToday'))
	INSERT INTO LookupMasterItem (LookupMasterId,LookupItemId,DisplayName,OrdRank) VALUES (@CxCaTreatment,(SELECT top 1 Id FROM LookupItem WHERE [Name] = 'OtherCxCaTxToday'),(SELECT top 1 DisplayName FROM LookupItem WHERE [Name] = 'OtherCxCaTxToday'),4)

IF @CxCaTreatment IS NOT NULL AND NOT EXISTS (SELECT * FROM LookupMasterItem WHERE LookupMasterId = @CxCaTreatment AND LookupItemId = (SELECT top 1 Id FROM LookupItem WHERE [Name] = 'TxOtherAilment'))
	INSERT INTO LookupMasterItem (LookupMasterId,LookupItemId,DisplayName,OrdRank) VALUES (@CxCaTreatment,(SELECT top 1 Id FROM LookupItem WHERE [Name] = 'TxOtherAilment'),(SELECT top 1 DisplayName FROM LookupItem WHERE [Name] = 'TxOtherAilment'),5)

DECLARE @Referred INT 
SELECT @Referred = id from LookupMaster WHERE Name = 'Referred'

IF @Referred IS NOT NULL AND NOT EXISTS (SELECT * FROM LookupMasterItem WHERE LookupMasterId = @Referred AND LookupItemId = (SELECT top 1 Id FROM LookupItem WHERE [Name] = 'Yes'))
	INSERT INTO LookupMasterItem (LookupMasterId,LookupItemId,DisplayName,OrdRank) VALUES (@Referred,(SELECT top 1 Id FROM LookupItem WHERE [Name] = 'Yes'),'Yes', 1)

IF @Referred IS NOT NULL AND NOT EXISTS (SELECT * FROM LookupMasterItem WHERE LookupMasterId = @Referred AND LookupItemId = (SELECT top 1 Id FROM LookupItem WHERE [Name] = 'No'))
	INSERT INTO LookupMasterItem (LookupMasterId,LookupItemId,DisplayName,OrdRank) VALUES (@Referred,(SELECT top 1 Id FROM LookupItem WHERE [Name] = 'No'),'No', 2)
