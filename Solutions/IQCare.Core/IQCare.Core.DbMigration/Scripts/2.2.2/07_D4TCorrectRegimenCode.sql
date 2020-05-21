update  lmi 
set 
lmi.DisplayName='D4T + 3TC + EFV'

FROM LookupMasterItem lmi
inner join (
select lmi.LookupItemId,lm.[Name] as MasterName,li.[Name] as itemName,
lmi.LookupMasterId,lmi.DisplayName,lmi.OrdRank,Convert(DECIMAL(10,2),ROW_NUMBER() OVER(Order by li.Name asc))as  rownum  from LookupMasterItem lmi
inner join LookupMaster lm on lm.Id=lmi.LookupMasterId
inner join LookupItem li on li.Id=lmi.LookupItemId
where li.[Name] ='CF3B'
--order by li.[Name]  asc
)lmpp on lmpp.LookupMasterId=lmi.LookupMasterId 
and lmpp.LookupItemId=lmi.LookupItemId


update LookupItem set DisplayName='D4T + 3TC + EFV'
 where Name='CF3B' 

 --


 update  lmi 
set 
lmi.DisplayName='D4T + 3TC + NVP'

FROM LookupMasterItem lmi
inner join (
select lmi.LookupItemId,lm.[Name] as MasterName,li.[Name] as itemName,
lmi.LookupMasterId,lmi.DisplayName,lmi.OrdRank,Convert(DECIMAL(10,2),ROW_NUMBER() OVER(Order by li.Name asc))as  rownum  from LookupMasterItem lmi
inner join LookupMaster lm on lm.Id=lmi.LookupMasterId
inner join LookupItem li on li.Id=lmi.LookupItemId
where li.[Name] ='CF3A'
--order by li.[Name]  asc
)lmpp on lmpp.LookupMasterId=lmi.LookupMasterId 
and lmpp.LookupItemId=lmi.LookupItemId


update LookupItem set DisplayName='D4T + 3TC + NVP'
 where Name='CF3A' 
 --


 

 update  lmi 
set 
lmi.DisplayName='D4T + 3TC + EFV'

FROM LookupMasterItem lmi
inner join (
select lmi.LookupItemId,lm.[Name] as MasterName,li.[Name] as itemName,
lmi.LookupMasterId,lmi.DisplayName,lmi.OrdRank,Convert(DECIMAL(10,2),ROW_NUMBER() OVER(Order by li.Name asc))as  rownum  from LookupMasterItem lmi
inner join LookupMaster lm on lm.Id=lmi.LookupMasterId
inner join LookupItem li on li.Id=lmi.LookupItemId
where li.[Name] ='AF3B'
--order by li.[Name]  asc
)lmpp on lmpp.LookupMasterId=lmi.LookupMasterId 
and lmpp.LookupItemId=lmi.LookupItemId


update LookupItem set DisplayName='D4T + 3TC + EFV'
 where Name='AF3B' 

 --


 

 

 update  lmi 
set 
lmi.DisplayName='D4T + 3TC + NVP'

FROM LookupMasterItem lmi
inner join (
select lmi.LookupItemId,lm.[Name] as MasterName,li.[Name] as itemName,
lmi.LookupMasterId,lmi.DisplayName,lmi.OrdRank,Convert(DECIMAL(10,2),ROW_NUMBER() OVER(Order by li.Name asc))as  rownum  from LookupMasterItem lmi
inner join LookupMaster lm on lm.Id=lmi.LookupMasterId
inner join LookupItem li on li.Id=lmi.LookupItemId
where li.[Name] ='AF3A'
--order by li.[Name]  asc
)lmpp on lmpp.LookupMasterId=lmi.LookupMasterId 
and lmpp.LookupItemId=lmi.LookupItemId


update LookupItem set DisplayName='D4T + 3TC + NVP'
 where Name='AF3A' 