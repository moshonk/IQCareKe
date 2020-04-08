--select * FROM LookupItemView where MasterName like '%Regimen%' order by MasterName


If Not Exists(Select 1 From LookupItem where Name='AF1E') 
Begin INSERT INTO LookupItem (Name, DisplayName, DeleteFlag) VALUES ('AF1E','AZT + 3TC + LPV/r',0); End

If Not Exists(Select 1 From LookupMasterItem where LookupMasterId=(SELECT TOP 1 Id FROM LookupMaster WHERE Name='AdultFirstLineRegimen') 
and LookupItemId=(SELECT TOP 1 Id FROM LookupItem WHERE Name='AF1E')) 
Begin Insert Into LookupMasterItem(LookupMasterId ,LookupItemId,DisplayName, OrdRank)
VALUES((SELECT TOP 1 Id FROM LookupMaster WHERE Name='AdultFirstLineRegimen'),
(SELECT TOP 1 Id FROM LookupItem WHERE Name='AF1E'),'AZT + 3TC + LPV/r',3); end

If Not Exists(Select 1 From LookupItem where Name='AF1F') 
Begin INSERT INTO LookupItem (Name, DisplayName, DeleteFlag) VALUES ('AF1F','AZT + 3TC + ATV/r',0); End
If Not Exists(Select 1 From LookupMasterItem where LookupMasterId=(SELECT TOP 1 Id FROM LookupMaster WHERE Name='AdultFirstLineRegimen') 
and LookupItemId=(SELECT TOP 1 Id FROM LookupItem WHERE Name='AF1F')) 
Begin Insert Into LookupMasterItem(LookupMasterId ,LookupItemId,DisplayName, OrdRank)
VALUES((SELECT TOP 1 Id FROM LookupMaster WHERE Name='AdultFirstLineRegimen'),
(SELECT TOP 1 Id FROM LookupItem WHERE Name='AF1F'),'AZT + 3TC + ATV/r',3); end


If Not Exists(Select 1 From LookupItem where Name='AS1C') 
Begin INSERT INTO LookupItem (Name, DisplayName, DeleteFlag) VALUES ('AS1C','AZT + 3TC + DTG',0); End
If Not Exists(Select 1 From LookupMasterItem where LookupMasterId=(SELECT TOP 1 Id FROM LookupMaster WHERE Name='AdultSecondlineRegimen') 
and LookupItemId=(SELECT TOP 1 Id FROM LookupItem WHERE Name='AS1C')) 
Begin Insert Into LookupMasterItem(LookupMasterId ,LookupItemId,DisplayName, OrdRank)
VALUES((SELECT TOP 1 Id FROM LookupMaster WHERE Name='AdultSecondlineRegimen'),
(SELECT TOP 1 Id FROM LookupItem WHERE Name='AS1C'),'AZT + 3TC + DTG',2); end




If Not Exists(Select 1 From LookupItem where Name='AS2B') 
Begin INSERT INTO LookupItem (Name, DisplayName, DeleteFlag) VALUES ('AS2B','TDF + 3TC + DTG',0); End

If Not Exists(Select 1 From LookupMasterItem where LookupMasterId=(SELECT TOP 1 Id FROM LookupMaster WHERE Name='AdultSecondlineRegimen') 
and LookupItemId=(SELECT TOP 1 Id FROM LookupItem WHERE Name='AS2B')) 
Begin Insert Into LookupMasterItem(LookupMasterId ,LookupItemId,DisplayName, OrdRank)
VALUES((SELECT TOP 1 Id FROM LookupMaster WHERE Name='AdultSecondlineRegimen'),
(SELECT TOP 1 Id FROM LookupItem WHERE Name='AS2B'),'TDF + 3TC + DTG',4); end





If Not Exists(Select 1 From LookupItem where Name='AS5C') 
Begin INSERT INTO LookupItem (Name, DisplayName, DeleteFlag) VALUES ('AS5C','ABC + 3TC + DTG',0); End

If Not Exists(Select 1 From LookupMasterItem where LookupMasterId=(SELECT TOP 1 Id FROM LookupMaster WHERE Name='AdultSecondlineRegimen') 
and LookupItemId=(SELECT TOP 1 Id FROM LookupItem WHERE Name='AS5C')) 
Begin Insert Into LookupMasterItem(LookupMasterId ,LookupItemId,DisplayName, OrdRank)
VALUES((SELECT TOP 1 Id FROM LookupMaster WHERE Name='AdultSecondlineRegimen'),
(SELECT TOP 1 Id FROM LookupItem WHERE Name='AS5C'),'ABC + 3TC + DTG',6); end





If Not Exists(Select 1 From LookupItem where Name='AT2D') 
Begin INSERT INTO LookupItem (Name, DisplayName, DeleteFlag) VALUES ('AT2D','TDF + 3TC + DTG + DRV/r',0); End


If Not Exists(Select 1 From LookupMasterItem where LookupMasterId=(SELECT TOP 1 Id FROM LookupMaster WHERE Name='AdultThirdlineRegimen') 
and LookupItemId=(SELECT TOP 1 Id FROM LookupItem WHERE Name='AT2D')) 
Begin Insert Into LookupMasterItem(LookupMasterId ,LookupItemId,DisplayName, OrdRank)
VALUES((SELECT TOP 1 Id FROM LookupMaster WHERE Name='AdultThirdlineRegimen'),
(SELECT TOP 1 Id FROM LookupItem WHERE Name='AT2D'),'TDF + 3TC + DTG + DRV/r',6); end





If Not Exists(Select 1 From LookupItem where Name='AT2E') 
Begin INSERT INTO LookupItem (Name, DisplayName, DeleteFlag) VALUES ('AT2E','TDF + 3TC + RAL + DRV/r',0); End

If Not Exists(Select 1 From LookupMasterItem where LookupMasterId=(SELECT TOP 1 Id FROM LookupMaster WHERE Name='AdultThirdlineRegimen') 
and LookupItemId=(SELECT TOP 1 Id FROM LookupItem WHERE Name='AT2E')) 
Begin Insert Into LookupMasterItem(LookupMasterId ,LookupItemId,DisplayName, OrdRank)
VALUES((SELECT TOP 1 Id FROM LookupMaster WHERE Name='AdultThirdlineRegimen'),
(SELECT TOP 1 Id FROM LookupItem WHERE Name='AT2E'),'TDF + 3TC + RAL + DRV/r',7); end


If Not Exists(Select 1 From LookupItem where Name='AT2F') 
Begin INSERT INTO LookupItem (Name, DisplayName, DeleteFlag) VALUES ('AT2F','TDF + 3TC + DTG + EFV + DRV/r',0); End
If Not Exists(Select 1 From LookupMasterItem where LookupMasterId=(SELECT TOP 1 Id FROM LookupMaster WHERE Name='AdultThirdlineRegimen') 
and LookupItemId=(SELECT TOP 1 Id FROM LookupItem WHERE Name='AT2F')) 
Begin Insert Into LookupMasterItem(LookupMasterId ,LookupItemId,DisplayName, OrdRank)
VALUES((SELECT TOP 1 Id FROM LookupMaster WHERE Name='AdultThirdlineRegimen'),
(SELECT TOP 1 Id FROM LookupItem WHERE Name='AT2F'),'TDF + 3TC + DTG + EFV + DRV/r',7); end



If Not Exists(Select 1 From LookupItem where Name='CT1H') 
Begin INSERT INTO LookupItem (Name, DisplayName, DeleteFlag) VALUES ('CT1H','AZT + 3TC + RAL + DRV/r',0); End
If Not Exists(Select 1 From LookupMasterItem where LookupMasterId=(SELECT TOP 1 Id FROM LookupMaster WHERE Name='PaedsThirdlineRegimen') 
and LookupItemId=(SELECT TOP 1 Id FROM LookupItem WHERE Name='CT1H')) 
Begin Insert Into LookupMasterItem(LookupMasterId ,LookupItemId,DisplayName, OrdRank)
VALUES((SELECT TOP 1 Id FROM LookupMaster WHERE Name='PaedsThirdlineRegimen'),
(SELECT TOP 1 Id FROM LookupItem WHERE Name='CT1H'),'AZT + 3TC + RAL + DRV/r',4); end


If Not Exists(Select 1 From LookupItem where Name='CT2D') 
Begin INSERT INTO LookupItem (Name, DisplayName, DeleteFlag) VALUES ('CT2D','ABC + 3TC + RAL + DRV/r',0); End
If Not Exists(Select 1 From LookupMasterItem where LookupMasterId=(SELECT TOP 1 Id FROM LookupMaster WHERE Name='PaedsThirdlineRegimen') 
and LookupItemId=(SELECT TOP 1 Id FROM LookupItem WHERE Name='CT2D')) 
Begin Insert Into LookupMasterItem(LookupMasterId ,LookupItemId,DisplayName, OrdRank)
VALUES((SELECT TOP 1 Id FROM LookupMaster WHERE Name='PaedsThirdlineRegimen'),
(SELECT TOP 1 Id FROM LookupItem WHERE Name='CT2D'),'ABC + 3TC + RAL + DRV/r',6); end