update  lmi 
set 
lmi.OrdRank =lmpp.rownum

FROM LookupMasterItem lmi
inner join (
select lmi.LookupItemId,lm.[Name] as MasterName,li.[Name] as itemName,
lmi.LookupMasterId,lmi.DisplayName,lmi.OrdRank,Convert(DECIMAL(10,2),ROW_NUMBER() OVER(Order by li.Name asc))as  rownum  from LookupMasterItem lmi
inner join LookupMaster lm on lm.Id=lmi.LookupMasterId
inner join LookupItem li on li.Id=lmi.LookupItemId
where lm.[Name] ='AdultFirstLineRegimen'
--order by li.[Name]  asc
)lmpp on lmpp.LookupMasterId=lmi.LookupMasterId 
and lmpp.LookupItemId=lmi.LookupItemId

go

--
update  lmi 
set 
lmi.OrdRank =lmpp.rownum

FROM LookupMasterItem lmi
inner join (
select lmi.LookupItemId,lm.[Name] as MasterName,li.[Name] as itemName,
lmi.LookupMasterId,lmi.DisplayName,lmi.OrdRank,Convert(DECIMAL(10,2),ROW_NUMBER() OVER(Order by li.Name asc))as  rownum  from LookupMasterItem lmi
inner join LookupMaster lm on lm.Id=lmi.LookupMasterId
inner join LookupItem li on li.Id=lmi.LookupItemId
where lm.[Name] ='AdultSecondlineRegimen'
--order by li.[Name]  asc
)lmpp on lmpp.LookupMasterId=lmi.LookupMasterId 
and lmpp.LookupItemId=lmi.LookupItemId

--

update  lmi 
set 
lmi.OrdRank =lmpp.rownum

FROM LookupMasterItem lmi
inner join (
select lmi.LookupItemId,lm.[Name] as MasterName,li.[Name] as itemName,
lmi.LookupMasterId,lmi.DisplayName,lmi.OrdRank,Convert(DECIMAL(10,2),ROW_NUMBER() OVER(Order by li.Name asc))as  rownum  from LookupMasterItem lmi
inner join LookupMaster lm on lm.Id=lmi.LookupMasterId
inner join LookupItem li on li.Id=lmi.LookupItemId
where lm.[Name] ='PaedsFirstLineRegimen'
--order by li.[Name]  asc
)lmpp on lmpp.LookupMasterId=lmi.LookupMasterId 
and lmpp.LookupItemId=lmi.LookupItemId


go



update  lmi 
set 
lmi.OrdRank =lmpp.rownum

FROM LookupMasterItem lmi
inner join (
select lmi.LookupItemId,lm.[Name] as MasterName,li.[Name] as itemName,
lmi.LookupMasterId,lmi.DisplayName,lmi.OrdRank,Convert(DECIMAL(10,2),ROW_NUMBER() OVER(Order by li.Name asc))as  rownum  from LookupMasterItem lmi
inner join LookupMaster lm on lm.Id=lmi.LookupMasterId
inner join LookupItem li on li.Id=lmi.LookupItemId
where lm.[Name] ='PaedsSecondlineRegimen'
--order by li.[Name]  asc
)lmpp on lmpp.LookupMasterId=lmi.LookupMasterId 
and lmpp.LookupItemId=lmi.LookupItemId

go



update  lmi 
set 
lmi.OrdRank =lmpp.rownum

FROM LookupMasterItem lmi
inner join (
select lmi.LookupItemId,lm.[Name] as MasterName,li.[Name] as itemName,
lmi.LookupMasterId,lmi.DisplayName,lmi.OrdRank,Convert(DECIMAL(10,2),ROW_NUMBER() OVER(Order by li.Name asc))as  rownum  from LookupMasterItem lmi
inner join LookupMaster lm on lm.Id=lmi.LookupMasterId
inner join LookupItem li on li.Id=lmi.LookupItemId
where lm.[Name] ='AdultThirdlineRegimen'
--order by li.[Name]  asc
)lmpp on lmpp.LookupMasterId=lmi.LookupMasterId 
and lmpp.LookupItemId=lmi.LookupItemId








update  lmi 
set 
lmi.OrdRank =lmpp.rownum

FROM LookupMasterItem lmi
inner join (
select lmi.LookupItemId,lm.[Name] as MasterName,li.[Name] as itemName,
lmi.LookupMasterId,lmi.DisplayName,lmi.OrdRank,Convert(DECIMAL(10,2),ROW_NUMBER() OVER(Order by li.Name asc))as  rownum  from LookupMasterItem lmi
inner join LookupMaster lm on lm.Id=lmi.LookupMasterId
inner join LookupItem li on li.Id=lmi.LookupItemId
where lm.[Name] ='PaedsThirdlineRegimen'
--order by li.[Name]  asc
)lmpp on lmpp.LookupMasterId=lmi.LookupMasterId 
and lmpp.LookupItemId=lmi.LookupItemId


--



update  lmi 
set 
lmi.OrdRank =lmpp.rownum

FROM LookupMasterItem lmi
inner join (
select lmi.LookupItemId,lm.[Name] as MasterName,li.[Name] as itemName,
lmi.LookupMasterId,lmi.DisplayName,lmi.OrdRank,Convert(DECIMAL(10,2),ROW_NUMBER() OVER(Order by li.Name asc))as  rownum  from LookupMasterItem lmi
inner join LookupMaster lm on lm.Id=lmi.LookupMasterId
inner join LookupItem li on li.Id=lmi.LookupItemId
where lm.[Name] ='PaedsSecondlineRegimen'
--order by li.[Name]  asc
)lmpp on lmpp.LookupMasterId=lmi.LookupMasterId 
and lmpp.LookupItemId=lmi.LookupItemId





update  lmi 
set 
lmi.OrdRank =lmpp.rownum

FROM LookupMasterItem lmi
inner join (
select lmi.LookupItemId,lm.[Name] as MasterName,li.[Name] as itemName,
lmi.LookupMasterId,lmi.DisplayName,lmi.OrdRank,Convert(DECIMAL(10,2),ROW_NUMBER() OVER(Order by li.Name asc))as  rownum  from LookupMasterItem lmi
inner join LookupMaster lm on lm.Id=lmi.LookupMasterId
inner join LookupItem li on li.Id=lmi.LookupItemId
where lm.[Name] ='PMTCTInfantRegimens'
--order by li.[Name]  asc
)lmpp on lmpp.LookupMasterId=lmi.LookupMasterId 
and lmpp.LookupItemId=lmi.LookupItemId



--





update  lmi 
set 
lmi.OrdRank =lmpp.rownum

FROM LookupMasterItem lmi
inner join (
select lmi.LookupItemId,lm.[Name] as MasterName,li.[Name] as itemName,
lmi.LookupMasterId,lmi.DisplayName,lmi.OrdRank,Convert(DECIMAL(10,2),ROW_NUMBER() OVER(Order by li.Name asc))as  rownum  from LookupMasterItem lmi
inner join LookupMaster lm on lm.Id=lmi.LookupMasterId
inner join LookupItem li on li.Id=lmi.LookupItemId
where lm.[Name] ='PEPRegimens'
--order by li.[Name]  asc
)lmpp on lmpp.LookupMasterId=lmi.LookupMasterId 
and lmpp.LookupItemId=lmi.LookupItemId

--

update  lmi 
set 
lmi.OrdRank =lmpp.rownum

FROM LookupMasterItem lmi
inner join (
select lmi.LookupItemId,lm.[Name] as MasterName,li.[Name] as itemName,
lmi.LookupMasterId,lmi.DisplayName,lmi.OrdRank,Convert(DECIMAL(10,2),ROW_NUMBER() OVER(Order by li.Name asc))as  rownum  from LookupMasterItem lmi
inner join LookupMaster lm on lm.Id=lmi.LookupMasterId
inner join LookupItem li on li.Id=lmi.LookupItemId
where lm.[Name] ='PePRegimen'
--order by li.[Name]  asc
)lmpp on lmpp.LookupMasterId=lmi.LookupMasterId 
and lmpp.LookupItemId=lmi.LookupItemId