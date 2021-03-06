IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_getPatientEncounterHistory]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_getPatientEncounterHistory]
GO


CREATE PROCEDURE [dbo].[sp_getPatientEncounterHistory]
	-- Add the parameters for the stored procedure here
	@PatientID int = null

AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
Set Nocount On;

select * from (
select distinct a.patientmastervisitid VisitID,b.displayname VisitName,a.patientid,
(case b.displayname 
	when 'Pharmacy' then convert(varchar(50),isnull((select top 1 DATEADD(d,DATEDIFF(d,0,ISNULL(orderedbydate,dispensedbydate)),0) from ord_patientpharmacyorder where patientmastervisitid = a.patientmastervisitid),'0'))
	when 'Lab' then convert(varchar(50),isnull((select top 1 DATEADD(d,DATEDIFF(d,0,OrderDate),0) from ord_laborder where patientmastervisitid = a.patientmastervisitid),'0'))
	when 'CCC' then convert(varchar(50),isnull((select top 1 DATEADD(d,DATEDIFF(d,0,visitdate),0) from PatientMasterVisit where id = a.patientmastervisitid),'0'))
	when 'Triage' then convert(varchar(50),isnull((select top 1 DATEADD(d,DATEDIFF(d,0,visitdate),0) from PatientVitals where patientmastervisitid = a.patientmastervisitid),'0'))
	else DATEADD(d,DATEDIFF(d,0,a.encounterstarttime),0)
	end) VisitDate, 

c.username, a.deleteflag,
(case b.displayname 
	when 'Pharmacy' then convert(varchar(50),isnull((select top 1 orderstatus from ord_patientpharmacyorder where patientmastervisitid = a.patientmastervisitid),'0'))
	when 'Lab' then convert(varchar(50),isnull((select top 1 orderstatus from ord_laborder where patientmastervisitid = a.patientmastervisitid),'0'))
	else '0'
	end) [status]
from patientencounter a inner join lookupitem b on a.encountertypeid = b.id
inner join mst_user c on a.createdby = c.userid
inner join PatientMasterVisit d on a.patientmastervisitid = d.id
where a.patientid =@PatientID  and d.visitdate is not null

union all
select pmv.Id as VisitID,'CCC' as VisitName,pmv.PatientId as patientid,pmv.VisitDate as VisitDate,c.UserName as username ,pmv.DeleteFlag as deleteflag,'0'  [status] 
 from PatientMasterVisit pmv 
 inner join mst_User c on c.UserID=pmv.CreatedBy
 inner join(
select * from LookupItemView where ItemName ='TS'
)ltv on ltv.ItemId=pmv.VisitBy 
where pmv.VisitBy is not null  and  pmv.PatientId=@PatientID

) ph
order by convert(date,ph.VisitDate) desc


End
GO
