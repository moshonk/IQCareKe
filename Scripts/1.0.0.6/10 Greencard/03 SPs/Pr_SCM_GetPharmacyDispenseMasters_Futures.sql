IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Pr_SCM_GetPharmacyDispenseMasters_Futures]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Pr_SCM_GetPharmacyDispenseMasters_Futures]
GO
/****** Object:  StoredProcedure [dbo].[Pr_SCM_GetPharmacyDispenseMasters_Futures]    Script Date: 4/16/2018 11:08:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE Procedure [dbo].[Pr_SCM_GetPharmacyDispenseMasters_Futures]                  
@Ptn_Pk int,                  
@StoreId int                  
as                  
begin
                  
 Declare @druglen int,  @currdate datetime;

select @currdate = getdate();
/*
Select @druglen = Max(Len(a.DrugName))
From dbo.Mst_Drug a
Left Outer Join dbo.Dtl_StockTransaction b
	On a.Drug_Pk = b.ItemId
Inner Join dbo.Lnk_DrugStrength s
	On s.DrugId = a.Drug_Pk
Inner Join dbo.Mst_Strength t
	On t.StrengthId = s.StrengthId
Left Outer Join dbo.Mst_Batch c
	On b.BatchId = c.Id
Left Outer Join dbo.Mst_DispensingUnit d
	On a.DispensingUnit = d.Id
Left Outer Join (Select Distinct e.ItemId
	From dbo.Lnk_ProgramItem e
	Inner Join dbo.Lnk_DonorProgram f
		On f.ProgramId = e.ProgramId And
		Getdate() >= fundingstartdate And Getdate() <= fundingenddate) z
	On z.ItemId = a.Drug_Pk
Where b.StoreId = @StoreId And b.expirydate >= Getdate()
  
If(@druglen IS NULL or @druglen=0)  
Begin
Set @druglen = 80  
End
*/

Select @druglen = 130;

--Select Top (1)	b.RegimenType As LastRegimen,
--				a.DispensedByDate As LastDispense,
--				(Select Top 1 M.RegimenType From dtl_RegimenMap M Where M.Ptn_Pk=@Ptn_Pk And 
--				(M.DeleteFlag Is Not Null Or M.DeleteFlag=0) 
--				And RegimenType Is Not Null Order By 1
--				) CurrentRegimen
--From ord_PatientPharmacyOrder As a
--Left Outer Join dtl_RegimenMap As b On a.Ptn_pk = b.Ptn_Pk
--And a.ptn_pharmacy_pk = b.OrderID
--Inner Join dtl_PatientPharmacyOrder As c On a.ptn_pharmacy_pk = c.ptn_pharmacy_pk
--Where (a.DeleteFlag = 0 Or a.DeleteFlag Is Null)
--And (a.Ptn_pk = @Ptn_Pk)
--And (a.DispensedByDate Is Not Null)
--Order By LastDispense Desc;
Select Top (1)	b.RegimenType As LastRegimen
				,a.DispensedByDate As LastDispense
				,CR.RegimenType CurrentRegimen
				,CR.OrderedByDate CurrentRegimenPrescriptionDate
				,CR.DispensedByDate CurrentRegimenDispenseDate
				,CR.CurrentRegimenLine
				,(
					select top 1 * from (
					Select Top 1 P.AppDate
					From dtl_PatientAppointment P
					Where P.Ptn_pk = @Ptn_Pk
					--And P.AppReason = (
					--	Select top 1 Id
					--	From mst_decode
					--	Where name = 'Pharmacy Refill'
					--)
					Order By P.AppDate Desc
					union
					select top 1 AppointmentDate AppDate from patientappointment pa inner join Patient p
					on pa.patientid = p.id
					where p.ptn_pk = @Ptn_Pk
					order by pa.AppointmentDate desc
					) nxtAppointmentDate order by AppDate desc
				)
				NextRefillDate
				,(
					select top 1 * from (
					Select Top 1 PV.Height
					From dtl_patientvitals PV
					Inner Join ord_visit OV On PV.Visit_pk = OV.Visit_Id
					Where PV.ptn_pk = @Ptn_Pk
					And PV.Height Is Not Null
					Order By OV.VisitDate Desc
					union
					select top 1 Height from patientvitals pv 
					inner join patientMasterVisit pmv on pv.patientmastervisitid = pmv.id
					inner join patient p on pv.patientid = p.id
					where p.ptn_pk = @Ptn_Pk and pv.height is not null
					order by pv.visitdate desc
					) LatestHeight

				)
				RecentHeight
				,(
					select top 1 * from (
					Select Top 1 PV.[Weight]
					From dtl_patientvitals PV
					Inner Join ord_visit OV On PV.Visit_pk = OV.Visit_Id
					Where PV.ptn_pk = @Ptn_Pk
					And PV.Weight Is Not Null
					And OV.VisitDate Between dateadd(Day, -7, @currdate) And @currdate
					Order By OV.VisitDate Desc
					union
					select top 1 [Weight] from patientvitals pv 
					inner join patientMasterVisit pmv on pv.patientmastervisitid = pmv.id
					inner join patient p on pv.patientid = p.id
					where p.ptn_pk = @Ptn_Pk and pv.[Weight] is not null
					order by pv.visitdate desc
					) latestWeight
				)
				RecentWeight,
				(
				select top 1 lui.DisplayName AppReason
				from patientappointment pa inner join Patient p on pa.patientid = p.id
				inner join lookupitem lui on lui.id = pa.ReasonId
				where p.ptn_pk = @Ptn_Pk
				order by pa.AppointmentDate desc)
				AppointmentReason
From ord_PatientPharmacyOrder As a
Left Outer Join dtl_RegimenMap As b On a.Ptn_pk = b.Ptn_Pk
And a.ptn_pharmacy_pk = b.OrderID
Inner Join dtl_PatientPharmacyOrder As c On a.ptn_pharmacy_pk = c.ptn_pharmacy_pk
Left Outer Join (
	Select Top 1	M.RegimenType
					,O.DispensedByDate
					,O.OrderedByDate
					,M.Ptn_Pk
					,(
						Select Top 1 R.RegimenName
						From mst_Regimen R
						Where R.RegimenID = O.RegimenLine
					)
					CurrentRegimenLine
	From dtl_RegimenMap M
	Inner Join ord_PatientPharmacyOrder O On O.VisitID = M.Visit_Pk
		And O.Ptn_pk = @Ptn_Pk
	Where M.Ptn_Pk = @Ptn_Pk
	And (M.DeleteFlag Is Not Null Or M.DeleteFlag = 0)
	And RegimenType Is Not Null
	And O.DispensedByDate Is Not Null
	--Order By 1
	order by O.DispensedByDate desc
) CR On CR.Ptn_Pk = A.Ptn_pk
Where (a.DeleteFlag = 0 Or a.DeleteFlag Is Null)
And (a.Ptn_pk = @Ptn_Pk)
And (a.DispensedByDate Is Not Null)
Order By LastDispense Desc;

With CTE
As (
	Select	a.Drug_Pk
			,a.ItemTypeID
			,a.DrugName
			,isnull(c.Name, '')																											[BatchNo]
			,c.Id																														[BatchId]
			,isnull(d.Name, '')																											[DispensingUnit]
			,isnull(d.Id, 0)																											[DispensingId]
			,
			--Isnull(dbo.fn_GetSellingPrice_Futures(a.Drug_Pk, c.Id, b.ExpiryDate, @StoreId), 0.00) 
			a.SellingUnitPrice																											[SellingPrice]
			,a.SellingUnitPrice																											[ConfigSellingPrice]
			,isnull(b.ExpiryDate, '')																									[ExpiryDate]
			,dbo.fn_GetItemStock_Futures(a.Drug_Pk, c.Id, b.ExpiryDate, @StoreId)														[AvailQty]
			,isnull(a.DispensingUnitPrice, 0)																							[CostPrice]
			,Case
				When z.ItemId > 0 Then 1
				Else 0
			End																															[Funded]
			,isnull(a.DispensingMargin, 0)																								[DispensingMargin]
			,t.StrengthId
			,a.DrugName + ' Batch: ' + isnull(c.Name, '') + ' Exp: ' + convert(varchar(11), isnull(b.ExpiryDate, ''), 113) + ' Qty: ' +
			convert(varchar(20), dbo.fn_GetItemStock_Futures(a.Drug_Pk, c.Id, b.ExpiryDate, @StoreId))									[DisplayItem]
			,(convert(varchar, a.Drug_Pk) + '-' + convert(varchar, c.Id) + '-' + convert(varchar(11), isnull(b.ExpiryDate, ''), 113))	[DisplayItemId]
			,dbo.fn_GetDrugTypeId_futures(a.Drug_Pk)																					[DrugTypeId]
			,isnull(dbo.fn_Drug_Abbrev_Constella(a.Drug_Pk), '')																		[GenericAbb]
			,isnull(c.Name, '') + '(' + convert(varchar(20), dbo.fn_GetItemStock_Futures(a.Drug_Pk, c.Id, b.ExpiryDate, @StoreId)) + ')' + '~' + isnull(convert(varchar(20), b.ExpiryDate, 106), '') [BatchQty]
	From dbo.Mst_Drug a
	Left Outer Join dbo.Dtl_StockTransaction b On a.Drug_Pk = b.ItemId
	Inner Join dbo.Lnk_DrugStrength s On s.DrugId = a.Drug_Pk
	Inner Join dbo.Mst_Strength t On t.StrengthId = s.StrengthId
	Left Outer Join dbo.Mst_Batch c On b.BatchId = c.Id
	Left Outer Join dbo.Mst_DispensingUnit d On a.DispensingUnit = d.Id
	Left Outer Join (
		Select Distinct e.ItemId
		From dbo.Lnk_ProgramItem e
	Inner Join dbo.Lnk_DonorProgram f On f.ProgramId = e.ProgramId	And @currdate >= fundingstartdate	And @currdate <= fundingenddate
	) z On z.ItemId = a.Drug_Pk
	Left Outer Join dbo.fn_Billing_PriceList(Null, Null, @currdate) Price On Price.ItemID = a.Drug_pk
		And Price.ItemTypeID = a.ItemTypeID
	Where b.StoreId = @StoreId
	And b.expirydate >= @currdate
	And  (a.DeleteFlag Is Null OR a.DeleteFlag = 0 )
	Group By a.Drug_Pk, a.DrugName, c.Name, c.Id, d.Name, d.Id, a.SellingUnitPrice, a.ItemTypeID, b.ExpiryDate, z.ItemId, t.StrengthId, a.dispensingunitprice, a.Dispensingmargin
)
Select *
From CTE
Where AvailQty > 0
order by ExpiryDate asc


End


