


update lmi set lmi.LookupItemId= (select Id from LookupItem where Name='DisContinue')
 from  LookupMasterItem lmi 
 inner join LookupItem lt on lt.Id=lmi.LookupItemId
 inner join LookupMaster lm on lm.Id=lmi.LookupMasterId
where lm.Name='PrEP_Status'
and lt.Name='Defer'
