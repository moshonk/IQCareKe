DECLARE @differentiatedCare INT 
SELECT @differentiatedCare = id from LookupMaster WHERE Name = 'DifferentiatedCare'

IF NOT EXISTS (SELECT * FROM LookupItem WHERE DisplayName = 'Facility Based Group Dispensing')
	INSERT INTO LookupItem (Name,DisplayName,DeleteFlag) VALUES ('FacilityBasedARTGroup','Facility Based Group Dispensing',0)


IF NOT EXISTS (SELECT * FROM LookupMasterItem WHERE LookupMasterId = @differentiatedCare AND LookupItemId = (SELECT top 1 Id FROM LookupItem WHERE DisplayName = 'Facility Based Group Dispensing'))
	INSERT INTO LookupMasterItem (LookupMasterId,LookupItemId,DisplayName,OrdRank) VALUES (@differentiatedCare,(SELECT top 1 Id FROM LookupItem WHERE DisplayName = 'Facility Based Group Dispensing'),'Facility Based Group Dispensing',4)
