--select * from LookupMasterItem
--select * FROM LookupItemView where MasterName like '%Regimen%' order by MasterName,ItemName,OrdRank




If Not Exists(Select 1 From LookupItem where Name='AF3A') 
Begin INSERT INTO LookupItem (Name, DisplayName, DeleteFlag) VALUES ('AF3A','d4T + 3TC + NVP',0); End

If Not Exists(Select 1 From LookupMasterItem where LookupMasterId=(SELECT TOP 1 Id FROM LookupMaster WHERE Name='AdultFirstLineRegimen') 
and LookupItemId=(SELECT TOP 1 Id FROM LookupItem WHERE Name='AF3A')) 
Begin Insert Into LookupMasterItem(LookupMasterId ,LookupItemId,DisplayName, OrdRank)
VALUES((SELECT TOP 1 Id FROM LookupMaster WHERE Name='AdultFirstLineRegimen'),
(SELECT TOP 1 Id FROM LookupItem WHERE Name='AF3A'),'d4T + 3TC + NVP',10); end


If Not Exists(Select 1 From LookupItem where Name='AF3B') 
Begin INSERT INTO LookupItem (Name, DisplayName, DeleteFlag) VALUES ('AF3B','d4T + 3TC + EFV',0); End

If Not Exists(Select 1 From LookupMasterItem where LookupMasterId=(SELECT TOP 1 Id FROM LookupMaster WHERE Name='AdultFirstLineRegimen') 
and LookupItemId=(SELECT TOP 1 Id FROM LookupItem WHERE Name='AF3B')) 
Begin Insert Into LookupMasterItem(LookupMasterId ,LookupItemId,DisplayName, OrdRank)
VALUES((SELECT TOP 1 Id FROM LookupMaster WHERE Name='AdultFirstLineRegimen'),
(SELECT TOP 1 Id FROM LookupItem WHERE Name='AF3B'),'d4T + 3TC + EFV',10); end


---PaedsFirstLine


If Not Exists(Select 1 From LookupItem where Name='CF3A') 
Begin INSERT INTO LookupItem (Name, DisplayName, DeleteFlag) VALUES ('CF3A',
'd4T + 3TC + NVP',0); End

If Not Exists(Select 1 From LookupMasterItem where LookupMasterId=(SELECT TOP 1 Id FROM LookupMaster WHERE Name='PaedsFirstLineRegimen') 
and LookupItemId=(SELECT TOP 1 Id FROM LookupItem WHERE Name='CF3A')) 
Begin Insert Into LookupMasterItem(LookupMasterId ,LookupItemId,DisplayName, OrdRank)
VALUES((SELECT TOP 1 Id FROM LookupMaster WHERE Name='PaedsFirstLineRegimen'),
(SELECT TOP 1 Id FROM LookupItem WHERE Name='CF3A'),'d4T + 3TC + NVP',20); end



--


If Not Exists(Select 1 From LookupItem where Name='CF3B') 
Begin INSERT INTO LookupItem (Name, DisplayName, DeleteFlag) VALUES ('CF3B',
'd4T + 3TC + EFV',0); End

If Not Exists(Select 1 From LookupMasterItem where LookupMasterId=(SELECT TOP 1 Id FROM LookupMaster WHERE Name='PaedsFirstLineRegimen') 
and LookupItemId=(SELECT TOP 1 Id FROM LookupItem WHERE Name='CF3B')) 
Begin Insert Into LookupMasterItem(LookupMasterId ,LookupItemId,DisplayName, OrdRank)
VALUES((SELECT TOP 1 Id FROM LookupMaster WHERE Name='PaedsFirstLineRegimen'),
(SELECT TOP 1 Id FROM LookupItem WHERE Name='CF3B'),'d4T + 3TC + EFV',20); end

--go



update LookupItem
 set DisplayName='AZT + 3TC + RAL + DRV/r' where [Name]='CS1C'

update lmi set  lmi.DisplayName ='AZT + 3TC + RAL + DRV/r' from LookupMasterItem  lmi
 inner join LookupItem li on li.Id=lmi.LookupItemId
 where li.[Name] ='CS1C'


--go


If Not Exists(Select 1 From LookupItem where Name='AT1A') 
Begin INSERT INTO LookupItem (Name, DisplayName, DeleteFlag) VALUES ('AT1A',
'RAL + 3TC + DRV + RTV',0); End

If Not Exists(Select 1 From LookupMasterItem where LookupMasterId=(SELECT TOP 1 Id FROM LookupMaster WHERE Name='AdultThirdlineRegimen') 
and LookupItemId=(SELECT TOP 1 Id FROM LookupItem WHERE Name='AT1A')) 
Begin Insert Into LookupMasterItem(LookupMasterId ,LookupItemId,DisplayName, OrdRank)
VALUES((SELECT TOP 1 Id FROM LookupMaster WHERE Name='AdultThirdlineRegimen'),
(SELECT TOP 1 Id FROM LookupItem WHERE Name='AT1A'),'RAL + 3TC + DRV + RTV',20); end


--

If Not Exists(Select 1 From LookupItem where Name='AT1B') 
Begin INSERT INTO LookupItem (Name, DisplayName, DeleteFlag) VALUES ('AT1B',
'RAL + 3TC + DRV + RTV + AZT',0); End

If Not Exists(Select 1 From LookupMasterItem where LookupMasterId=(SELECT TOP 1 Id FROM LookupMaster WHERE Name='AdultThirdlineRegimen') 
and LookupItemId=(SELECT TOP 1 Id FROM LookupItem WHERE Name='AT1B')) 
Begin Insert Into LookupMasterItem(LookupMasterId ,LookupItemId,DisplayName, OrdRank)
VALUES((SELECT TOP 1 Id FROM LookupMaster WHERE Name='AdultThirdlineRegimen'),
(SELECT TOP 1 Id FROM LookupItem WHERE Name='AT1B'),'RAL + 3TC + DRV + RTV + AZT',20); end




If Not Exists(Select 1 From LookupItem where Name='AT1C') 
Begin INSERT INTO LookupItem (Name, DisplayName, DeleteFlag) VALUES ('AT1C',
'RAL + 3TC + DRV + RTV + TDF',0); End

If Not Exists(Select 1 From LookupMasterItem where LookupMasterId=(SELECT TOP 1 Id FROM LookupMaster WHERE Name='AdultThirdlineRegimen') 
and LookupItemId=(SELECT TOP 1 Id FROM LookupItem WHERE Name='AT1C')) 
Begin Insert Into LookupMasterItem(LookupMasterId ,LookupItemId,DisplayName, OrdRank)
VALUES((SELECT TOP 1 Id FROM LookupMaster WHERE Name='AdultThirdlineRegimen'),
(SELECT TOP 1 Id FROM LookupItem WHERE Name='AT1C'),'RAL + 3TC + DRV + RTV + TDF',20); end





If Not Exists(Select 1 From LookupItem where Name='AT2A') 
Begin INSERT INTO LookupItem (Name, DisplayName, DeleteFlag) VALUES ('AT2A',
'ETV + 3TC + DRV + RTV',0); End

If Not Exists(Select 1 From LookupMasterItem where LookupMasterId=(SELECT TOP 1 Id FROM LookupMaster WHERE Name='AdultThirdlineRegimen') 
and LookupItemId=(SELECT TOP 1 Id FROM LookupItem WHERE Name='AT2A')) 
Begin Insert Into LookupMasterItem(LookupMasterId ,LookupItemId,DisplayName, OrdRank)
VALUES((SELECT TOP 1 Id FROM LookupMaster WHERE Name='AdultThirdlineRegimen'),
(SELECT TOP 1 Id FROM LookupItem WHERE Name='AT2A'),'ETV + 3TC + DRV + RTV',20); end

--go






If Not Exists(Select 1 From LookupItem where Name='CS2D') 
Begin INSERT INTO LookupItem (Name, DisplayName, DeleteFlag) VALUES ('CS2D',
'ABC + 3TC + RAL + DRV/r',0); End

If Not Exists(Select 1 From LookupMasterItem where LookupMasterId=(SELECT TOP 1 Id FROM LookupMaster WHERE Name='PaedsSecondlineRegimen') 
and LookupItemId=(SELECT TOP 1 Id FROM LookupItem WHERE Name='CS2D')) 
Begin Insert Into LookupMasterItem(LookupMasterId ,LookupItemId,DisplayName, OrdRank)
VALUES((SELECT TOP 1 Id FROM LookupMaster WHERE Name='PaedsSecondlineRegimen'),
(SELECT TOP 1 Id FROM LookupItem WHERE Name='CS2D'),'ABC + 3TC + RAL + DRV/r',20); end
--

If Not Exists(Select 1 From LookupItem where Name='CT1A') 
Begin INSERT INTO LookupItem (Name, DisplayName, DeleteFlag) VALUES ('CT1A',
'RAL + 3TC + DRV + RTV',0); End

If Not Exists(Select 1 From LookupMasterItem where LookupMasterId=(SELECT TOP 1 Id FROM LookupMaster WHERE Name='PaedsThirdlineRegimen') 
and LookupItemId=(SELECT TOP 1 Id FROM LookupItem WHERE Name='CT1A')) 
Begin Insert Into LookupMasterItem(LookupMasterId ,LookupItemId,DisplayName, OrdRank)
VALUES((SELECT TOP 1 Id FROM LookupMaster WHERE Name='PaedsThirdlineRegimen'),
(SELECT TOP 1 Id FROM LookupItem WHERE Name='CT1A'),'RAL + 3TC + DRV + RTV',20); end
--


If Not Exists(Select 1 From LookupItem where Name='CT1B') 
Begin INSERT INTO LookupItem (Name, DisplayName, DeleteFlag) VALUES ('CT1B',
'RAL + 3TC + DRV + RTV + AZT',0); End

If Not Exists(Select 1 From LookupMasterItem where LookupMasterId=(SELECT TOP 1 Id FROM LookupMaster WHERE Name='PaedsThirdlineRegimen') 
and LookupItemId=(SELECT TOP 1 Id FROM LookupItem WHERE Name='CT1B')) 
Begin Insert Into LookupMasterItem(LookupMasterId ,LookupItemId,DisplayName, OrdRank)
VALUES((SELECT TOP 1 Id FROM LookupMaster WHERE Name='PaedsThirdlineRegimen'),
(SELECT TOP 1 Id FROM LookupItem WHERE Name='CT1B'),'RAL + 3TC + DRV + RTV + AZT',20); end

--


If Not Exists(Select 1 From LookupItem where Name='CT1C') 
Begin INSERT INTO LookupItem (Name, DisplayName, DeleteFlag) VALUES ('CT1C',
'RAL + 3TC + DRV + RTV + ABC',0); End

If Not Exists(Select 1 From LookupMasterItem where LookupMasterId=(SELECT TOP 1 Id FROM LookupMaster WHERE Name='PaedsThirdlineRegimen') 
and LookupItemId=(SELECT TOP 1 Id FROM LookupItem WHERE Name='CT1C')) 
Begin Insert Into LookupMasterItem(LookupMasterId ,LookupItemId,DisplayName, OrdRank)
VALUES((SELECT TOP 1 Id FROM LookupMaster WHERE Name='PaedsThirdlineRegimen'),
(SELECT TOP 1 Id FROM LookupItem WHERE Name='CT1C'),'RAL + 3TC + DRV + RTV + ABC',20); end


--

If Not Exists(Select 1 From LookupItem where Name='CT2A') 
Begin INSERT INTO LookupItem (Name, DisplayName, DeleteFlag) VALUES ('CT2A',
'ETV + 3TC + DRV + RTV',0); End

If Not Exists(Select 1 From LookupMasterItem where LookupMasterId=(SELECT TOP 1 Id FROM LookupMaster WHERE Name='PaedsThirdlineRegimen') 
and LookupItemId=(SELECT TOP 1 Id FROM LookupItem WHERE Name='CT2A')) 
Begin Insert Into LookupMasterItem(LookupMasterId ,LookupItemId,DisplayName, OrdRank)
VALUES((SELECT TOP 1 Id FROM LookupMaster WHERE Name='PaedsThirdlineRegimen'),
(SELECT TOP 1 Id FROM LookupItem WHERE Name='CT2A'),'ETV + 3TC + DRV + RTV',20); end



--


If Not Exists(Select 1 From LookupItem where Name='PC1') 
Begin INSERT INTO LookupItem (Name, DisplayName, DeleteFlag) VALUES ('PC1',
'NVP OD up to 6 Weeks of age',0); End

If Not Exists(Select 1 From LookupMasterItem where LookupMasterId=(SELECT TOP 1 Id FROM LookupMaster WHERE Name='PMTCTInfantRegimens') 
and LookupItemId=(SELECT TOP 1 Id FROM LookupItem WHERE Name='PC1')) 
Begin Insert Into LookupMasterItem(LookupMasterId ,LookupItemId,DisplayName, OrdRank)
VALUES((SELECT TOP 1 Id FROM LookupMaster WHERE Name='PMTCTInfantRegimens'),
(SELECT TOP 1 Id FROM LookupItem WHERE Name='PC1'),'PC1',20); end


--




If Not Exists(Select 1 From LookupItem where Name='PC2') 
Begin INSERT INTO LookupItem (Name, DisplayName, DeleteFlag) VALUES ('PC2',
'NVP OD up to 1 Weeks after complete ceasation of breast feeding',0); End

If Not Exists(Select 1 From LookupMasterItem where LookupMasterId=(SELECT TOP 1 Id FROM LookupMaster WHERE Name='PMTCTInfantRegimens') 
and LookupItemId=(SELECT TOP 1 Id FROM LookupItem WHERE Name='PC2')) 
Begin Insert Into LookupMasterItem(LookupMasterId ,LookupItemId,DisplayName, OrdRank)
VALUES((SELECT TOP 1 Id FROM LookupMaster WHERE Name='PMTCTInfantRegimens'),
(SELECT TOP 1 Id FROM LookupItem WHERE Name='PC2'),'PC2',20); end



--


If Not Exists(Select 1 From LookupItem where Name='PC4') 
Begin INSERT INTO LookupItem (Name, DisplayName, DeleteFlag) VALUES ('PC4',
'AZT Liquid BD up to 6 weeks',0); End

If Not Exists(Select 1 From LookupMasterItem where LookupMasterId=(SELECT TOP 1 Id FROM LookupMaster WHERE Name='PMTCTInfantRegimens') 
and LookupItemId=(SELECT TOP 1 Id FROM LookupItem WHERE Name='PC4')) 
Begin Insert Into LookupMasterItem(LookupMasterId ,LookupItemId,DisplayName, OrdRank)
VALUES((SELECT TOP 1 Id FROM LookupMaster WHERE Name='PMTCTInfantRegimens'),
(SELECT TOP 1 Id FROM LookupItem WHERE Name='PC4'),'PC4',20); end
--


If Not Exists(Select 1 From LookupItem where Name='PC5') 
Begin INSERT INTO LookupItem (Name, DisplayName, DeleteFlag) VALUES ('PC5',
'3TC Liquid BD',0); End

If Not Exists(Select 1 From LookupMasterItem where LookupMasterId=(SELECT TOP 1 Id FROM LookupMaster WHERE Name='PMTCTInfantRegimens') 
and LookupItemId=(SELECT TOP 1 Id FROM LookupItem WHERE Name='PC5')) 
Begin Insert Into LookupMasterItem(LookupMasterId ,LookupItemId,DisplayName, OrdRank)
VALUES((SELECT TOP 1 Id FROM LookupMaster WHERE Name='PMTCTInfantRegimens'),
(SELECT TOP 1 Id FROM LookupItem WHERE Name='PC5'),'PC5',20); end

--



If Not Exists(Select 1 From LookupItem where Name='PA1B') 
Begin INSERT INTO LookupItem (Name, DisplayName, DeleteFlag) VALUES ('PA1B',
'AZT + 3TC + LPV/r (Adult PEP)',0); End

If Not Exists(Select 1 From LookupMasterItem where LookupMasterId=(SELECT TOP 1 Id FROM LookupMaster WHERE Name='PEPRegimens') 
and LookupItemId=(SELECT TOP 1 Id FROM LookupItem WHERE Name='PA1B')) 
Begin Insert Into LookupMasterItem(LookupMasterId ,LookupItemId,DisplayName, OrdRank)
VALUES((SELECT TOP 1 Id FROM LookupMaster WHERE Name='PEPRegimens'),
(SELECT TOP 1 Id FROM LookupItem WHERE Name='PA1B'),'AZT + 3TC + LPV/r (Adult PEP)',20); end

--
If Not Exists(Select 1 From LookupMasterItem where LookupMasterId=(SELECT TOP 1 Id FROM LookupMaster WHERE Name='PePRegimen') 
and LookupItemId=(SELECT TOP 1 Id FROM LookupItem WHERE Name='PA1B')) 
Begin Insert Into LookupMasterItem(LookupMasterId ,LookupItemId,DisplayName, OrdRank)
VALUES((SELECT TOP 1 Id FROM LookupMaster WHERE Name='PePRegimen'),
(SELECT TOP 1 Id FROM LookupItem WHERE Name='PA1B'),'AZT + 3TC + LPV/r (Adult PEP)',20); end
--

--




If Not Exists(Select 1 From LookupItem where Name='PA1C') 
Begin INSERT INTO LookupItem (Name, DisplayName, DeleteFlag) VALUES ('PA1C',
'AZT + 3TC + ATV/r (Adult PEP)',0); End

If Not Exists(Select 1 From LookupMasterItem where LookupMasterId=(SELECT TOP 1 Id FROM LookupMaster WHERE Name='PEPRegimens') 
and LookupItemId=(SELECT TOP 1 Id FROM LookupItem WHERE Name='PA1C')) 
Begin Insert Into LookupMasterItem(LookupMasterId ,LookupItemId,DisplayName, OrdRank)
VALUES((SELECT TOP 1 Id FROM LookupMaster WHERE Name='PEPRegimens'),
(SELECT TOP 1 Id FROM LookupItem WHERE Name='PA1C'),'AZT + 3TC + ATV/r (Adult PEP)',20); end


--

If Not Exists(Select 1 From LookupMasterItem where LookupMasterId=(SELECT TOP 1 Id FROM LookupMaster WHERE Name='PePRegimen') 
and LookupItemId=(SELECT TOP 1 Id FROM LookupItem WHERE Name='PA1C')) 
Begin Insert Into LookupMasterItem(LookupMasterId ,LookupItemId,DisplayName, OrdRank)
VALUES((SELECT TOP 1 Id FROM LookupMaster WHERE Name='PePRegimen'),
(SELECT TOP 1 Id FROM LookupItem WHERE Name='PA1C'),'AZT + 3TC + ATV/r (Adult PEP)',20); end


--


If Not Exists(Select 1 From LookupItem where Name='PA3B') 
Begin INSERT INTO LookupItem (Name, DisplayName, DeleteFlag) VALUES ('PA3B',
'TDF + 3TC + LPV/r (Adult PEP)',0); End

If Not Exists(Select 1 From LookupMasterItem where LookupMasterId=(SELECT TOP 1 Id FROM LookupMaster WHERE Name='PEPRegimens') 
and LookupItemId=(SELECT TOP 1 Id FROM LookupItem WHERE Name='PA3B')) 
Begin Insert Into LookupMasterItem(LookupMasterId ,LookupItemId,DisplayName, OrdRank)
VALUES((SELECT TOP 1 Id FROM LookupMaster WHERE Name='PEPRegimens'),
(SELECT TOP 1 Id FROM LookupItem WHERE Name='PA3B'),'TDF + 3TC + LPV/r (Adult PEP)',20); end

--


If Not Exists(Select 1 From LookupMasterItem where LookupMasterId=(SELECT TOP 1 Id FROM LookupMaster WHERE Name='PePRegimen') 
and LookupItemId=(SELECT TOP 1 Id FROM LookupItem WHERE Name='PA3B')) 
Begin Insert Into LookupMasterItem(LookupMasterId ,LookupItemId,DisplayName, OrdRank)
VALUES((SELECT TOP 1 Id FROM LookupMaster WHERE Name='PePRegimen'),
(SELECT TOP 1 Id FROM LookupItem WHERE Name='PA3B'),'TDF + 3TC + LPV/r (Adult PEP)',20); end


update LookupItem
 set DisplayName='AZT + 3TC + LPV/r (Paed PEP)' where [Name]='PC1A'

update lmi set  lmi.DisplayName ='AZT + 3TC + LPV/r (Paed PEP)' from LookupMasterItem  lmi
 inner join LookupItem li on li.Id=lmi.LookupItemId
 where li.[Name] ='PC1A'