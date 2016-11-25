IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pr_SCM_SaveUpdateHivTreatementPharmacyField_Futures]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[pr_SCM_SaveUpdateHivTreatementPharmacyField_Futures]
GO
CREATE procedure [dbo].[pr_SCM_SaveUpdateHivTreatementPharmacyField_Futures] (   
	@OrderId int,    
	@weight VarChar(50),    
	@height VarChar(50),            
	@Programe int,    
	@Periodtaken int,    
	@Provider int,    
	@RegimenLine int,    
	@NxtAppDate datetime,    
	@Reason int    )
As Begin

	declare @VisitGetId int  , @rowCount int, @PtnGetPk int , @LocationId int  , @EmpId int, @deleteflag int, @UserId int; 
           
	Update ord_PatientPharmacyOrder Set
			Weight = @weight
		,	Height = @height
		,	ProgID = @Programe
		,	PharmacyPeriodTaken = @Periodtaken
		,	ProviderID = @Provider
		,	RegimenLine = @RegimenLine
	Where (ptn_pharmacy_pk = @OrderID)   

	Select	@VisitGetID = visitid
		,	@PtnGetPk = Ptn_pk
		,	@LocationId = LocationID
		,	@EmpId = EmployeeID
		,	@deleteflag = DeleteFlag
		,	@UserId = UserID
	From ord_PatientPharmacyOrder
	Where ptn_pharmacy_pk = @OrderId
 
  

	Update dtl_PatientAppointment Set
			AppDate = @NxtAppDate
		,	AppReason = @Reason
	Where (Visit_pk = @VisitGetID);

	Select @rowCount = @@rowcount;

	If(@rowCount = 0) Begin
		Insert Into dtl_PatientAppointment (
				Ptn_pk
			,	LocationID
			,	Visit_pk
			,	AppDate
			,	AppReason
			,	AppStatus
			,	EmployeeID
			,	DeleteFlag
			,	UserID
			,	CreateDate)
		Values (
				@PtnGetPk
			,	@LocationId
			,	@VisitGetId
			,	@NxtAppDate
			,	@Reason
			,	0
			,	@EmpId
			,	@deleteflag
			,	@UserId
			,	getdate())  
	End
 
	Select	a.Weight
		,	a.Height
		,	a.ProgID
		,	a.PharmacyPeriodTaken
		,	a.ProviderID
		,	a.RegimenLine
		,	b.AppDate
		,	isnull(b.AppReason, 0)	As AppReason
	From ord_PatientPharmacyOrder As a
	Left Outer Join dtl_PatientAppointment As b On a.VisitID = b.Visit_pk
	Where (a.ptn_pharmacy_pk = @OrderId)            
    
End

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pr_SCM_GetPharmacyOrderDetail_Futures]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[pr_SCM_GetPharmacyOrderDetail_Futures]
GO
/****** Object:  StoredProcedure [dbo].[pr_SCM_SavePharmacyDispenseOrderDetail_Futures]    Script Date: 5/12/2016 5:15:04 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pr_SCM_SavePharmacyDispenseOrderDetail_Futures]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[pr_SCM_SavePharmacyDispenseOrderDetail_Futures]
GO
/****** Object:  StoredProcedure [dbo].[Pr_SCM_GetPurchaseDetailsForGRN_Futures]    Script Date: 04/02/2015 09:17:30 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Pr_SCM_GetPurchaseDetailsForGRN_Futures]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Pr_SCM_GetPurchaseDetailsForGRN_Futures]
GO
/****** Object:  StoredProcedure [dbo].[pr_SCM_SaveGRNItems_Futures]    Script Date: 04/02/2015 13:54:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pr_SCM_SaveGRNItems_Futures]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[pr_SCM_SaveGRNItems_Futures]
GO

 IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SCM_GetItemsByStoreId]') AND type in (N'P', N'PC'))
 DROP PROCEDURE [dbo].[SCM_GetItemsByStoreId]
GO

/****** Object:  StoredProcedure [dbo].[SCM_GetItemsByStoreId]    Script Date: 9/15/2016 3:13:42 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		J
-- Create date: 2016 08 01
-- Description:	Get Items linked to a store
-- =============================================
CREATE PROCEDURE [dbo].[SCM_GetItemsByStoreId] 
	-- Add the parameters for the stored procedure here
	@StoreId int 
AS
BEGIN
	Select Distinct	L.StoreID	As StoreId
				,	D.Drug_pk ItemId
				,	D.DrugName ItemName
				,	D.ItemTypeID
	From lnk_StoreItem As L
	Inner Join Mst_Drug As D On L.ItemId = D.Drug_pk
	And L.ItemTypeID = D.ItemTypeID
	Where (L.StoreID = 002)
	Group By	L.StoreID
			,	D.Drug_pk
			,	D.DrugName
			,	D.ItemTypeID
	Order By D.DrugName
END

GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pr_SCM_GetOpeningStock_Futures]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[pr_SCM_GetOpeningStock_Futures]
GO

/****** Object:  StoredProcedure [dbo].[pr_SCM_GetOpeningStock_Futures]    Script Date: 9/6/2016 6:28:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[pr_SCM_GetOpeningStock_Futures]        
AS            
BEGIN         
--0           
	Select	a.Drug_pk
		,	a.DrugName
		,	b.StoreID
		,	c.Name	As DispensingUnit
		,	c.Id
	From Mst_Drug As a
	Inner Join lnk_StoreItem As b On a.Drug_pk = b.ItemId
	Left Outer Join Mst_DispensingUnit As c On a.DispensingUnit = c.Id
	Where (a.DeleteFlag = 0	Or a.DeleteFlag Is Null) And A.ItemTypeID=b.ItemTypeID   Order By a.DrugName
	 
--1        
	Select	Id
		,	Name
		,	DeleteFlag
	From [dbo].[mst_batch]
	Where DeleteFlag = 0            
        
--2          
Select Distinct	a.Drug_pk													As ItemId
			,	a.DrugName													As ItemName
			,	b.StoreId
			,	f.Name														As StoreName
			,	b.Quantity
			,	b.BatchId
			,	c.Name														As BatchNo
			,	d.Name														As DispensingUnit
			,	replace(convert(varchar, b.ExpiryDate, 106), ' ', '-')		
				As ExpiryDate
			,	b.OpeningStock
			,	replace(convert(varchar, b.TransactionDate, 106), ' ', '-')	As TransacDate
From Mst_Drug As a
Inner Join Dtl_StockTransaction As b On a.Drug_pk = b.ItemId
Inner Join Mst_Batch As c On b.BatchId = c.ID
Left Outer Join Mst_DispensingUnit As d On a.DispensingUnit = d.Id
Inner Join Mst_Store As f On b.StoreId = f.Id
Where (b.OpeningStock = 1)   Order By a.DrugName         
              
END

GO
/****** Object:  StoredProcedure [dbo].[pr_SCM_GetStoreDetails_Futures]    Script Date: 5/12/2016 5:29:45 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pr_SCM_GetStoreDetails_Futures]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[pr_SCM_GetStoreDetails_Futures]
GO

/****** Object:  StoredProcedure [dbo].[pr_SCM_GetStoreDetails_Futures]    Script Date: 5/13/2016 10:09:15 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[pr_SCM_GetStoreDetails_Futures]            
            
as            
            
begin            
--0            
Select Id, Name, StoreID, CentralStore, DeleteFlag, SRNO, UserId from mst_store where deleteflag=0       
--1      
Select a.SourceStore, b.Name[SourceStoreName], a.DestinationStore, c.Name[DestStoreName],      
a.UserID from dbo.Lnk_StoreSourceDestination a inner join mst_store b      
on a.SourceStore = b.Id  inner join mst_store c on a.DestinationStore = c.Id   
where b.deleteflag=0   order by SourceStoreName, DestStoreName  

--Source Store Table--2    
select distinct a.Id,a.Name,a.StoreId from mst_store a join Lnk_StoreSourceDestination b on a.id=b.SourceStore
where deleteflag=0 
UNION 
Select Id, Name, StoreID from mst_store where deleteflag=0 and CentralStore=1 
    
end

GO
/****** Object:  StoredProcedure [dbo].[pr_SCM_GetItemListing_Futures]    Script Date: 5/12/2016 5:29:45 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pr_SCM_GetItemListing_Futures]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[pr_SCM_GetItemListing_Futures]
GO
/****** Object:  StoredProcedure [dbo].[pr_SCM_GetItemListing_Futures]    Script Date: 5/12/2016 5:29:45 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[pr_SCM_GetItemListing_Futures]      
      
as      
      
begin      
      
Select 	a.ID	As ItemType
	,	a.Name	As ItemTypeName
	,	s.DrugTypeID
	,	s.DrugTypeName
	,	b.GenericID
	,	b.GenericName
	,	c.Drug_pk
	,	c.DrugName
	,	a.Name + '-' + s.DrugTypeName + '-' + convert(varchar, c.Drug_pk)
		As ListId
From mst_Decode As a
Inner Join Lnk_ItemDrugType As p On a.ID = p.ItemTypeId
Inner Join mst_DrugType As s On p.DrugTypeId = s.DrugTypeID
Inner Join lnk_DrugTypeGeneric As q On q.DrugTypeId = p.DrugTypeId
Inner Join mst_Generic As b On b.GenericID = q.GenericId
Left Outer Join lnk_DrugGeneric As r On r.GenericID = b.GenericID
Left Outer Join Mst_Drug As c On c.Drug_pk = r.Drug_pk
Where (c.DeleteFlag = 0) 
Order By ItemTypeName, s.DrugTypeName, b.GenericName, c.DrugName    
      
end

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Pr_SCM_GetPurchaseDetails_Futures]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Pr_SCM_GetPurchaseDetails_Futures]
GO

/****** Object:  StoredProcedure [dbo].[Pr_SCM_GetPurchaseDetails_Futures]    Script Date: 9/9/2016 8:13:56 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[Pr_SCM_GetPurchaseDetails_Futures]  (                     
@UserID int,        
@DestinStoreID int,    
@LocationID  int        
)                  
As Begin                          
                 
Select	PO.POId
	,	PO.OrderNo
	,	PO.SupplierID
	,	isnull(SP.SupplierName, '')					As SupplierName
	,	convert(varchar(100), PO.OrderDate, 106)	As OrderDate
	,	Case PO.[Status]
			When 1 Then 'New'
			When 2 Then 'Approved'
			When 3 Then 'Received'
			When 4 Then 'Partial Received'
			When 5 Then 'Rejected'
		End											As Status
	,	PO.SourceStoreID
	,	PO.DestinStoreID
	,	isnull(DS.Name, '')							As DestStore
	,	PO.UserID
	,	isnull(SS.Name, '')							As SourceName
From ord_PurchaseOrder As PO
Left Outer Join Mst_Supplier As SP On PO.SupplierID = SP.Id
Left Outer Join Mst_Store As DS On PO.DestinStoreID = DS.Id
Left Outer Join Mst_Store As SS On PO.SourceStoreID = SS.Id
Where (PO.DestinStoreID = @DestinStoreID)
	And (PO.LocationID = @LocationID) 
                  
End

GO

/****** Object:  StoredProcedure [dbo].[pr_SCM_GetItemListStoreFiltered_Futures]    Script Date: 5/12/2016 5:27:35 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pr_SCM_GetItemListStoreFiltered_Futures]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[pr_SCM_GetItemListStoreFiltered_Futures]
GO

/****** Object:  StoredProcedure [dbo].[pr_SCM_GetItemListStoreFiltered_Futures]    Script Date: 5/12/2016 5:27:35 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[pr_SCM_GetItemListStoreFiltered_Futures]  
@StoreId int,   
@ItemTypeId int ,                                      
@SubitemId int =0                                                                                                   
as                                                                      
Begin  
declare @CatName varchar(200)      
 select @CatName = Name from Mst_Decode where Id = @ItemTypeId     
     
                    
  if @CatName <> 'Lab Tests'      
  begin                    
   if(@SubitemId =0)                         
  begin               
  select a.Drug_pk [ItemID],a.DrugName [ItemName],e.ItemTypeId [ItemTypeID]  from mst_drug a inner join lnk_StoreItem e          
   on  (a.Drug_pk =e.ItemId ) where e.ItemTypeID =@ItemTypeId and  e.StoreID=@StoreId and a.DeleteFlag=0 group by a.Drug_pk  ,a.DrugName ,e.ItemTypeID  order by a.DrugName            
         
  
  
 select a.Drug_pk [ItemID],a.DrugName [ItemName]  from mst_drug a left outer join  lnk_StoreItem e          
 on  (a.Drug_pk =e.ItemId )  where dbo.fn_GetDrugTypeId_futures(a.Drug_Pk) in (      
            select drugtypeid from lnk_itemdrugtype where itemtypeid = @ItemTypeId)    
			and a.DeleteFlag=0
 group by a.Drug_pk  ,a.DrugName  order by a.DrugName            
  --,e.ItemTypeId          
  end                
 else                        
  begin                        
      
 select a.Drug_pk [ItemID],a.DrugName [ItemName],e.ItemTypeId [ItemTypeID]  from mst_drug a inner join lnk_StoreItem e          
on  (a.Drug_pk =e.ItemId ) where e.ItemTypeId =@ItemTypeId and e.StoreID=@StoreId and  dbo.fn_GetDrugTypeId_futures (a.drug_pk) =@SubitemId     
and a.DeleteFlag=0     
group by a.Drug_pk  ,a.DrugName ,e.ItemTypeId  order by a.DrugName            
              
              
  select a.Drug_pk [ItemID],a.DrugName [ItemName],e.ItemTypeId [ItemTypeID]  from mst_drug a left outer join lnk_StoreItem e          
on  (a.Drug_pk =e.ItemId and e.ItemTypeId =@ItemTypeId) where   dbo.fn_GetDrugTypeId_futures (a.drug_pk) =@SubitemId    
and a.DeleteFlag=0      
group by a.Drug_pk  ,a.DrugName ,e.ItemTypeId  order by a.DrugName               
                         
  end                   
  end      
  else      
  begin              
           
select a.SubTestID [ItemID] ,a.SubTestName [ItemName] ,b.ItemTypeId [ItemTypeID]  from lnk_testParameter a               
inner join lnk_StoreItem b on a.SubTestID =b.ItemId and b.StoreID=@StoreId     
where b.ItemTypeId =@ItemTypeId group by a.SubTestID  ,a.SubTestName,b.ItemTypeId   order by a.SubTestName            
              
select a.SubTestID [ItemID] ,a.SubTestName [ItemName] ,b.ItemTypeId [ItemTypeID]  from lnk_testParameter a               
left outer join lnk_StoreItem b on a.SubTestID =b.ItemId and    
b.ItemTypeId=@ItemTypeId  group by a.SubTestID  ,a.SubTestName,b.ItemTypeId  order by a.SubTestName              
              
end                        
 end
 
GO

/****** Object:  StoredProcedure [dbo].[Pr_SCM_GetPharmacyDispenseMasters_Futures]    Script Date: 12/11/2014 16:16:40 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Pr_SCM_GetPharmacyDispenseMasters_Futures]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Pr_SCM_GetPharmacyDispenseMasters_Futures]
GO
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
					Select Top 1 P.AppDate
					From dtl_PatientAppointment P
					Where P.Ptn_pk = @Ptn_Pk
					And P.AppReason = (
						Select top 1 Id
						From mst_decode
						Where name = 'Pharmacy Refill'
					)
					Order By P.AppDate Desc
				)
				NextRefillDate
				,(
					Select Top 1 PV.Height

					From dtl_patientvitals PV
					Inner Join ord_visit OV On PV.Visit_pk = OV.Visit_Id
					Where PV.ptn_pk = @Ptn_Pk
					And PV.Height Is Not Null
					Order By OV.VisitDate Desc
				)
				RecentHeight
				,(
					Select Top 1 PV.Height

					From dtl_patientvitals PV
					Inner Join ord_visit OV On PV.Visit_pk = OV.Visit_Id
					Where PV.ptn_pk = @Ptn_Pk
					And PV.Weight Is Not Null
					And OV.VisitDate Between dateadd(Day, -7, @currdate) And @currdate
					Order By OV.VisitDate Desc
				)
				RecentWeight
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
	Order By 1
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


End

GO


/****** Object:  StoredProcedure [dbo].[Pr_SCM_GetPurchaseDetailsForGRN_Futures]    Script Date: 04/02/2015 09:17:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Pr_SCM_GetPurchaseDetailsForGRN_Futures]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE Procedure [dbo].[Pr_SCM_GetPurchaseDetailsForGRN_Futures]                         
@UserID int,          
@StoreID int,      
@LocationID  int  ,
@IsSourceStore bit= 0                        
as                                              
begin
Select 
	PO.POId,
	PO.OrderNo,
	PO.SupplierID,
	Isnull(SP.SupplierName,'''') SupplierName,
	Convert(varchar(100), PO.OrderDate, 106) [OrderDate],
	[Status] =
			Case PO.[Status]
				When 2 Then ''New''
				When 3 Then ''Received''
				When 4 Then ''Partial Received''
				When 5 Then ''Rejected'' End,
	Isnull(SR.Name,'''')[SourceName],
	PO.SourceStoreID,
	Po.DestinStoreID,
	Isnull(DS.Name,'''') DestStore,
	PO.UserID
From  ord_PurchaseOrder PO
Left Outer Join
	Mst_Supplier SP On PO.SupplierID = SP.Id
Left Outer Join
	mst_store DS On PO.DestinStoreID = DS.Id
Left Outer Join
	mst_store SR On PO.SourceStoreID = SR.Id	
Where Case 
		When @IsSourceStore= 1 And PO.SourceStoreID=@StoreID  And SR.StoreId Is Not Null Then 1
		When @IsSourceStore= 0 And PO.DestinStoreID=@StoreID And DS.StoreId Is Not Null Then 1
		Else 0 End = 1
And PO.LocationID = @LocationID
And PO.[Status] Not In (1, 5)
Order By PO.POId Desc;        
End' 
END
GO
/****** Object:  StoredProcedure [dbo].[pr_SCM_SaveGRNItems_Futures]    Script Date: 04/02/2015 13:54:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pr_SCM_SaveGRNItems_Futures]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE Procedure [dbo].[pr_SCM_SaveGRNItems_Futures]                               
@GRNId int ,                              
@POId  int,                                  
@ItemId int ,                               
--@BatchID  int ,                            
@Margin  decimal(9,2)=0,                              
@batchName varchar(500),                               
@RecievedQuantity int,                              
@FreeRecievedQuantity int=0,                              
@PurchasePrice decimal(9,2)=0,                                 
@SellingPrice  decimal(9,2)=0,                              
@SellingPricePerDispense decimal(9,2)=0,                               
@ExpiryDate datetime,                                
@UserId int ,                            
@destinationStoreID int=0 ,                            
@SourceStoreID int=0,                          
@TotPurchasePrice decimal(9,2)=0,                          
@IsPOorIST int  -- 1 for Purchase order and 2 for Inter store transfer   
                          
As                                  
Begin
                                   
                                
	declare @tempBatchId int, 
			@tempbatchname varchar(100), 
			@tempExpiryDate datetime, 
			@Indexofdelimeter int,
			@maxbatchSrno int;
                         
	Select @tempBatchId = ID	From Mst_Batch	Where Name = @batchName	And ItemID = @ItemId   ;
	
	If(@tempBatchId Is Null) Begin
		Select @maxbatchSrno = Max(SRNO)	From Mst_Batch;
		Insert Into Mst_Batch (
			name,
			UserId,
			CreateDate,
			SRNO,
			ItemID,
			ExpiryDate)
		Values (
			@batchName, 
			@UserId, 
			Getdate(), 
			(@maxbatchSrno + 1), 
			@ItemId, 
			@ExpiryDate);
		Select @tempBatchId = SCOPE_IDENTITY();
	End
                           
                         

	Insert Into Dtl_GRNote (
		GRNId,
		ItemId,
		BatchID,
		RecievedQuantity,
		FreeRecievedQuantity,
		PurchasePrice,
		TotPurchasePrice,
		SellingPrice,
		SellingPricePerDispense,
		ExpiryDate,
		UserId,
		CreateDate)
	Values (
		@GRNId, 
		@ItemId, 
		@tempBatchId, 
		@RecievedQuantity, 
		@FreeRecievedQuantity, 
		@PurchasePrice, 
		@TotPurchasePrice, 
		@SellingPrice, 
		@SellingPricePerDispense, 
		@ExpiryDate, 
		@UserId, 
		Getdate()
	);


	Declare @tempPurchasePrice decimal(9, 2),
			@tempQtyPerPurchaseUnit int,
			@tempTotalRecievedQuantity int,
			@itemMasterPurchasePrice decimal(9, 2);
			
	Select @tempPurchasePrice = Max(PurchasePrice)	From Dtl_GRNote	Where GRNId = @GRNId And ItemId = @ItemId;

	Select	@itemMasterPurchasePrice = PurchaseUnitPrice,
			@tempQtyPerPurchaseUnit = QtyPerPurchaseUnit
	From Mst_Drug
	Where Drug_pk = @ItemId;
	If (@itemMasterPurchasePrice < @tempPurchasePrice) Begin
		Update mst_drug Set
			PurchaseUnitPrice = @tempPurchasePrice,
			DispensingUnitPrice = (@tempPurchasePrice / QtyPerPurchaseUnit)
		Where Drug_pk = @ItemId;
		--Njung''e - Commented out. Selling Price managed via billing
		--Update mst_drug Set
		--	SellingUnitPrice = (DispensingUnitPrice + (DispensingMargin / 100) * DispensingUnitPrice),
		--	EffectiveDate = Getdate()
		--Where Drug_pk = @ItemId
	End 
	                     
         
	Select @tempTotalRecievedQuantity =  Case 
			When @IsPOorIST = 2 Then @RecievedQuantity 
			Else  @RecievedQuantity * @tempQtyPerPurchaseUnit End;                                
	Insert Into dtl_stocktransaction (
		ItemId,
		BatchId,
		POId,
		GRNId,
		StoreId,
		TransactionDate,
		Quantity,
		ExpiryDate,
		PurchasePrice,
		SellingPrice,
		Margin,
		UserId,
		CreateDate)
	Values (
		@ItemId, 
		@tempBatchId, 
		@POId, 
		@GRNId, 
		@destinationStoreID, 
		Getdate(), 
		@tempTotalRecievedQuantity, 
		@ExpiryDate, 
		@PurchasePrice, 
		@SellingPrice, 
		@Margin, 
		@UserId, 
		Getdate());

	If (@IsPOorIST = 2) Begin
		Insert Into Dtl_StockTransaction (
			ItemId,
			BatchId,
			POId,
			GRNId,
			StoreId,
			TransactionDate,
			Quantity,
			ExpiryDate,
			PurchasePrice,
			SellingPrice,
			Margin,
			UserId,
			CreateDate)
		Values (
			@ItemId, 
			@tempBatchId, 
			@POId, 
			@GRNId, 
			@SourceStoreID, 
			Getdate(), 
			-@tempTotalRecievedQuantity, 
			@ExpiryDate, 
			@PurchasePrice, 
			@SellingPrice, 
			@Margin, 
			@UserId, 
			Getdate());
	End

	declare @TotalRecievedQuantity int,
			 @TotalQuantity int,
			 @POstatus int;

	Select @TotalRecievedQuantity = Sum(e.RecievedQuantity)
	From Dtl_PurchaseItem a
	Left Outer Join
		Mst_Drug b On a.ItemId = b.Drug_pk
	Left Outer Join
		Ord_GRNote d On d.POId = a.POId
	Left Outer Join
		Dtl_GRNote e On (e.GRNId = d.GRNId	And e.ItemId = a.ItemId)
	Left Outer Join
		Mst_Batch f On f.ID = e.BatchID
	Inner Join
		ord_PurchaseOrder g On g.Poid = a.POId
	Where a.POId = @POId
	Group By a.POID;

	Select @TotalQuantity = Sum(Quantity)	From dtl_PurchaseItem	Where POId = @POId	Group By POId;

	Update ord_PurchaseOrder Set
		Status = Case 
						When (@TotalRecievedQuantity = @TotalQuantity) Then 3 
						When (@TotalRecievedQuantity < @TotalQuantity) Then 4
						Else [Status] End --@POstatus
	Where POId = @POId;


End' 
END
GO
/****** Object:  StoredProcedure [dbo].[pr_SCM_SavePharmacyDispenseOrder_Futures]    Script Date: 04/01/2015 11:33:11 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pr_SCM_SavePharmacyDispenseOrder_Futures]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[pr_SCM_SavePharmacyDispenseOrder_Futures]
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[pr_SCM_SavePharmacyDispenseOrder_Futures]                
	@Ptn_Pk int,                
	@LocationId int,                
	@DispensedBy int,                
	@DispensedByDate datetime,                
	@OrderType int,                
	@ProgramId int,                
	@StoreId int,            
	@Regimen varchar(50),                
	@UserId int,        
	@OrderId int = 0   ,
	@ModuleId int = null,
	@PharmacyRefillAppDate datetime   = Null,
	@PeriodTaken int = null,
	@RegimenLine int = null,
	@ProviderId int =null,
	@Height numeric(8,2)= null,
	@Weight numeric(8,2)= null
As             
Begin
	Declare @VisitId int,@ARTStartDate datetime;
	Select @Regimen = Nullif(Ltrim(Rtrim(@Regimen)), '');
	If (@OrderId > 0) Begin
		
		Select @VisitId = VisitId
		From dbo.Ord_PatientPharmacyOrder
		Where Ptn_Pharmacy_Pk = @OrderId;

		Update dbo.Ord_Visit Set
			VisitDate = @DispensedByDate,
			DataQuality = 1,
			UserId = @UserId
		Where Ptn_Pk = @VisitId;

		Update dbo.Ord_PatientPharmacyOrder Set
			DispensedBy = @DispensedBy,
			DispensedByDate = @DispensedByDate,
			StoreId = @StoreId,
			UserId = @UserId,
			UpdateDate = Getdate()
		Where Ptn_Pharmacy_Pk = @OrderId;
		
		If (@Regimen Is Not Null) Begin
			Update dbo.Dtl_RegimenMap Set
				RegimenType = @Regimen
			Where ptn_pk = @Ptn_pk
			And Visit_Pk = @VisitId
			And OrderId = @OrderId;			
		End
	
		--exec pr_SCM_SetPharmacyRefillAppointment @Ptn_Pk,@LocationId,@VisitId,@PharmacyRefillAppDate,@UserId,@UserId   
		--  Delete from Dtl_PatientPharmacyOrder where Ptn_Pharmacy_Pk = @OrderId            
		Select	@VisitId [VisitId],
				@OrderId [Ptn_Pharmacy_Pk];
	End 
	Else Begin

		Select @ModuleId = Isnull(@ModuleId,ModuleId) From mst_module Where ModuleName='Pharmacy';
		
		Insert Into dbo.Ord_Visit (
			Ptn_Pk,
			LocationId,
			VisitDate,
			VisitType,
			DataQuality,
			DeleteFlag,
			UserId,
			ModuleID,
			CreateDate)
		Values (
			@Ptn_Pk, 
			@LocationId, 
			@DispensedByDate, 
			4, 
			0, 
			0, 
			@UserId,
			@ModuleId, 
			Getdate());
		Select @VisitId = SCOPE_IDENTITY();	

		If(@Height Is Not Null OR @Weight Is Not Null) Begin
			Insert Into dtl_PatientVitals (
				Ptn_pk
				,LocationID
				,Visit_pk
				,Height
				,Weight)
			Values (
				@Ptn_Pk
				,@LocationId
				,@VisitId
				,@Height
				,@Weight);
		End
		Insert Into dbo.Ord_PatientPharmacyOrder (
			Ptn_Pk,
			VisitId,
			LocationId,
			OrderedBy,
			OrderedByDate,
			DispensedBy,
			DispensedByDate,
			OrderType,
			ProgId,
			StoreId,
			DeleteFlag,			
			UserId,
			CreateDate,
			PharmacyPeriodTaken,
			ProviderID,
			RegimenLine,
			Signature,
			Height,
			Weight
			)
		Values (
			@Ptn_Pk, 
			@VisitId, 
			@LocationId, 
			0, 
			Null, 
			@DispensedBy, 
			@DispensedByDate, 
			@OrderType, 
			@ProgramId, 
			@StoreId, 
			0, 
			@UserId, 
			Getdate(),
			@PeriodTaken,
			@ProviderId,
			@RegimenLine,
			@UserId,
			@Height,
			@Weight);

		Select @OrderId = SCOPE_IDENTITY();
		Update ord_PatientPharmacyOrder Set
			ReportingID = (Select Right('000000' + Convert(varchar, @OrderId), 6))
		Where ptn_pharmacy_pk = @OrderId;


		If (@Regimen Is Not Null) Begin
			Insert Into dbo.Dtl_RegimenMap (
				Ptn_Pk,
				LocationId,
				Visit_Pk,
				RegimenType,
				OrderId,
				DeleteFlag,
				UserId,
				CreateDate)
			Values (
				@Ptn_Pk, 
				@LocationId, 
				@VisitId, 
				@Regimen, 
				@OrderId, 
				0, 
				@UserId, 
				Getdate());
		End
		--exec pr_SCM_SetPharmacyRefillAppointment @Ptn_Pk,@LocationId,@VisitId,@PharmacyRefillAppDate,@UserId,@UserId   
		Select	@VisitId [VisitId],
				@OrderId [Ptn_Pharmacy_Pk];
	End
	Select @ARTStartDate = dbo.fn_GetPatientARTStartDate_constella(@Ptn_pk);
	Update mst_Patient Set
		ARTStartDate = @ARTStartDate
	Where ptn_pk = @Ptn_pk;
End

GO

/****** Object:  StoredProcedure [dbo].[Pr_SCM_SaveStockOrdAdjust_Futures]    Script Date: 05/29/2015 07:26:35 ******/
/****** Object:  StoredProcedure [dbo].[Pr_SCM_SaveStockOrdAdjust_Futures]    Script Date: 01/14/2016 14:17:22 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Pr_SCM_SaveStockOrdAdjust_Futures]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Pr_SCM_SaveStockOrdAdjust_Futures]
GO

/****** Object:  StoredProcedure [dbo].[Pr_SCM_SaveStockOrdAdjust_Futures]    Script Date: 01/14/2016 14:17:22 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[Pr_SCM_SaveStockOrdAdjust_Futures]     
@LocationId int ,                      
@StoreId int ,                      
@AdjustmentPreparedBy int,                      
@AdjustmentAuthorisedBy int ,  
@AdjustmentDate datetime ,                      
@UserId int    ,
@Updatestock int=1                  
as                                                   
BEGIN
                      

	Insert Into Ord_AdjustStock (
		LocationId,
		StoreId,
		AdjustmentDate,
		AdjustmentPreparedBy,
		AdjustmentAuthorisedBy,
		Updatestock,
		CreateDate,
		UserId)
	Values (
		@LocationId,
		@StoreId,
		@AdjustmentDate,
		@AdjustmentPreparedBy,
		@AdjustmentAuthorisedBy,
		@Updatestock,
		getdate() ,
		@UserId)
	Select SCOPE_IDENTITY() [AdjustId]

End

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pr_SCM_SaveUpdateItemMasterList_Futures]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[pr_SCM_SaveUpdateItemMasterList_Futures]
GO

/****** Object:  StoredProcedure [dbo].[pr_SCM_SaveUpdateItemMasterList_Futures]    Script Date: 01/14/2016 14:20:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[pr_SCM_SaveUpdateItemMasterList_Futures]                               
 -- Add the parameters for the stored procedure here                              
@Id int=NULL,              
@StoreId varchar(100)=NULL, 
@LocationId int = null,                     
@Name varchar(100)=NULL,      
@StoreCategory varchar(100)=NULL,                     
@DeleteFlag varchar(10)=NULL,                      
@SRNo varchar(10)=NULL,                      
@CategoryID varchar(10)=NULL,                      
@TableName varchar(100)=NULL,               
@CentralStore varchar(10)=NULL ,      
@DispensingStore varchar(10)=Null,                
@UserId int=NULL,           
@Str varchar(Max)=NULL                
                      
AS                 
Declare @SQLStr varchar(MAX)                               
BEGIN   
declare @Active bit;                
Set @DeleteFlag = Case When @DeleteFlag='Active' then 0              
      When @DeleteFlag='InActive' then 1 End   
	               
Set @CentralStore = Case When @CentralStore='No' then 0                
      When @CentralStore='Yes' then 1 End             
Set @DispensingStore = Case When @DispensingStore='No' then 0                
      When @DispensingStore='Yes' then 1 End           
              
if @TableName = 'Mst_DispensingUnit'                
 Begin                
  if not exists(select Id from Mst_DispensingUnit where Id = @Id)                  
     begin                   
       insert into Mst_DispensingUnit(Name,DeleteFlag,SRNo, UserId,CreateDate)                               
       values(@Name,@DeleteFlag, @SRNo, @UserId, getdate())                              
     end                  
    else                  
     begin                  
  update Mst_DispensingUnit set Name = @Name, DeleteFlag = @DeleteFlag, SRNo=@SRNo,                
  UserId = @UserId, UpdateDate = getdate() where id = @Id                  
     end                  
 End                
else if @TableName = 'Mst_Manufacturer'                
 Begin                
  if not exists(select Id from Mst_Manufacturer where Id = @Id)                  
     begin                   
       insert into Mst_Manufacturer(Name, DeleteFlag, SRNo, UserId,CreateDate)                               
       values(@Name, @DeleteFlag, @SRNo, @UserId, getdate())                              
     end                  
    else                  
     begin                  
  update Mst_Manufacturer set Name = @Name, DeleteFlag = @DeleteFlag, SRNo=@SRNo,                
  UserId = @UserId, UpdateDate = getdate() where id = @Id                  
     end                  
 End      
else if @TableName = 'Mst_Batch'                
 Begin                
  if not exists(select Id from Mst_Batch where Id = @Id)                  
     begin                   
       insert into Mst_Batch(Name, DeleteFlag, SRNo, UserId,CreateDate)                               
       values(@Name, @DeleteFlag, @SRNo, @UserId, getdate())                              
     end                  
    else                  
     begin                  
  update Mst_Batch set Name = @Name, DeleteFlag = @DeleteFlag, SRNo=@SRNo,                
  UserId = @UserId, UpdateDate = getdate() where id = @Id                  
     end                  
 End                
                
else if @TableName = 'mst_Drugtype'                
 Begin                
  if not exists(select DrugTypeID from mst_Drugtype where DrugTypeID = @Id)                  
     begin                   
       insert into mst_Drugtype(DrugTypeName, DeleteFlag, UserId,CreateDate)                               
       values(@Name, @DeleteFlag, @UserId, getdate())                              
     end                  
    else                  
     begin                  
  update mst_Drugtype set DrugTypeName = @Name, DeleteFlag = @DeleteFlag,                
  UserId = @UserId, UpdateDate = getdate() where DrugTypeID = @Id                  
     end                  
 End               
              
else if @TableName = 'Mst_Decode' Begin                
  if not exists(select Id from mst_decode where Id = @Id)                  
     begin                   
       insert into mst_decode(Name,CodeId,SRNo,UpdateFlag, DeleteFlag, UserId,CreateDate)                               
       values(@Name,@CategoryID,@SRNo,null, @DeleteFlag,@UserId, getdate())                              
     end                  
 else                  
     begin                  
  update mst_decode set Name = @Name, DeleteFlag = @DeleteFlag, SRNo=@SRNo,                
  UserId = @UserId, UpdateDate = getdate() where id = @Id                  
     end                
 End             
          
else if @TableName = 'Lnk_StoreSourceDestination'                
 Begin          
  Exec(@Str);          
 End          
               
END				

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SCM_ManageItemStore]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SCM_ManageItemStore]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Joseph Njung'e
-- Create date: 
-- Description:	Insert - update Item store
-- =============================================
CREATE PROCEDURE [dbo].[SCM_ManageItemStore] 
	-- Add the parameters for the stored procedure here
	@Id int=NULL,              
	@StoreId varchar(100)=NULL, 
	@LocationId int ,                     
	@Name varchar(100)=NULL,      
	@StoreCategory varchar(100)=NULL,                     
	@DeleteFlag bit,   
	@Active bit,                   
	@SRNo varchar(10)=NULL,                   
	@CentralStore varchar(10)=NULL ,      
	@DispensingStore varchar(10)=Null,                
	@UserId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	Set @CentralStore = Case When @CentralStore='No' then 0                
		When @CentralStore='Yes' then 1 End             
	Set @DispensingStore = Case When @DispensingStore='No' then 0                
		When @DispensingStore='Yes' then 1 End           
              
    -- Insert statements for procedure here
	If (@Id Is Null ) Or Not Exists(Select Id From Mst_Store Where Id = @Id)  Begin                   
		Insert Into Mst_Store (
				Name
			,	LocationId
			,	StoreId
			,	CentralStore
			,	DispensingStore
			,	DeleteFlag
			,	Active
			,	SRNo
			,	UserId
			,	CreateDate
			,	StoreCategory)
		Values (
				@Name
			,	@LocationId
			,	@StoreId
			,	@CentralStore
			,	@DispensingStore
			,	@DeleteFlag
			,	@Active
			,	@SRNo
			,	@UserId
			,	getdate()
			,	@StoreCategory)                         
     End                  
	Else  Begin                  
		Update Mst_Store Set
				Name = @Name
			,	StoreId = @StoreId
			,	CentralStore = @CentralStore
			,	DispensingStore = @DispensingStore
			,	StoreCategory = @StoreCategory
			,	DeleteFlag = @DeleteFlag
			,	Active = @Active
			,	SRNo = @SRNo
			,	UserId = @UserId
			,	UpdateDate = getdate()
		Where (Id = @Id)               
     End                
END

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Pr_SCM_GetStoreNameByUserID_Futures]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Pr_SCM_GetStoreNameByUserID_Futures]
GO

/****** Object:  StoredProcedure [dbo].[Pr_SCM_GetStoreNameByUserID_Futures]    Script Date: 01/14/2016 14:22:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[Pr_SCM_GetStoreNameByUserID_Futures]      
@UserID int      
as       
begin
Select Distinct	a.ID [StoreId],
				a.Name [StoreName],
				CentralStore,
				DispensingStore,
				a.StoreCategory
From mst_store a
Inner Join
	lnk_storeuser b On a.Id = b.StoreID
Where b.UserID = @UserID
And a.DeleteFlag = 0
End

GO

/****** Object:  StoredProcedure [dbo].[pr_SCM_GetExistingPharmacyDispense_Futures]    Script Date: 12/02/2015 07:56:47 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pr_SCM_GetExistingPharmacyDispense_Futures]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[pr_SCM_GetExistingPharmacyDispense_Futures]
GO

/****** Object:  StoredProcedure [dbo].[pr_SCM_GetExistingPharmacyDispense_Futures]    Script Date: 12/02/2015 07:56:47 ******/
/****** Object:  StoredProcedure [dbo].[pr_SCM_GetExistingPharmacyDispense_Futures]    Script Date: 5/12/2016 5:14:18 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[pr_SCM_GetExistingPharmacyDispense_Futures]          
	@Ptn_Pk int,        
	@StoreId int 
As          
Begin          
          
	Select	convert(varchar(11), isnull(a.DispensedByDate, a.OrderedByDate), 113) [TransactionDate],
			Case
				When a.OrderStatus = 1 Then 'New Order'
				When a.OrderStatus = 3 Then 'Partial Dispense'
				Else 'Already Dispensed Order'
			End [Status],
			a.Ptn_Pharmacy_Pk
	From dbo.ord_PatientPharmacyOrder a
		Inner Join dbo.ord_visit b On a.visitid = b.visit_id
	Where a.Ptn_Pk = @Ptn_Pk
		And (StoreId = @StoreId Or a.StoreId Is Null)
		And (b.deleteflag Is Null Or b.deleteflag = 0)
		And (a.DispensedByDate Is Not Null Or a.OrderedByDate Is Not Null) 
	Order By isnull(a.DispensedByDate, a.OrderedByDate)     desc 
 /*     
union      
      
select convert(varchar(11), isnull(a.DispensedByDate,a.OrderedByDate),113) [TransactionDate],          
Case when a.OrderStatus=1 then 'New Order' when a.OrderStatus = 3 then 'Partial Dispense' else 'Already Dispensed Order' end [Status],          
a.Ptn_Pharmacy_Pk           
from dbo.ord_PatientPharmacyOrder a inner join dbo.ord_visit b on a.visitid = b.visit_id           
 where a.Ptn_Pk = @Ptn_Pk and StoreId is null and (b.deleteflag is null or b.deleteflag = 0) 
 and convert(varchar(11), isnull(a.DispensedByDate,a.OrderedByDate),113) IS NOT NULL   order by 3
  
  */
--select convert(varchar(11), isnull(a.DispensedByDate,a.OrderedByDate),113) [TransactionDate],        
--Case when a.DispensedByDate is null then 'New Order' else 'Already Dispensed Order' end [Status],        
--a.Ptn_Pharmacy_Pk         
--from dbo.ord_PatientPharmacyOrder a inner join dbo.ord_visit b on a.visitid = b.visit_id         
-- where a.Ptn_Pk = @Ptn_Pk and StoreId = @StoreId and (b.deleteflag is null or b.deleteflag = 0)         
--    
--union    
--    
--select convert(varchar(11), isnull(a.DispensedByDate,a.OrderedByDate),113) [TransactionDate],        
--Case when a.DispensedByDate is null then 'New Order' else 'Already Dispensed Order' end [Status],        
--a.Ptn_Pharmacy_Pk         
--from dbo.ord_PatientPharmacyOrder a inner join dbo.ord_visit b on a.visitid = b.visit_id         
-- where a.Ptn_Pk = @Ptn_Pk and StoreId is null and (b.deleteflag is null or b.deleteflag = 0)     
   
            
End


GO


/****** Object:  StoredProcedure [dbo].[Pr_SCM_GetPurcaseOrderItem]    Script Date: 12/02/2015 11:28:56 ******/
Set Ansi_nulls On
Go

Set Quoted_identifier On
Go
ALTER Procedure [dbo].[Pr_SCM_GetPurcaseOrderItem]                                         
@isPO int =0,                            
@UserID int,                        
@StoreID int =0                                        
as                                          
                                          
begin
                                          
--0                                  
if(@isPO =1) begin
Select	a.Drug_Pk [ItemID],
		a.DrugName [ItemName],
		b.SupplierId
From Mst_Drug a
	Inner Join lnk_supplierItem b On a.Drug_pk = b.ItemId
		And a.DeleteFlag = 0
Group By	a.Drug_Pk,
			a.DrugName,
			b.SupplierId
Order By a.DrugName Asc
End Else If (@isPO = 2) Begin
Select	convert(varchar(100), a.Drug_Pk) + '-' + convert(varchar(100), Stock.BatchId) + '-' + convert(varchar, Stock.ExpiryDate, 101) [ItemID],
		a.DrugName + ' - ' + Stock.BatchName + ' - ' + convert(varchar, Stock.ExpiryDate, 106) + ' - ' + Convert(varchar,Stock.AvailableQTY) ItemName,
		--convert(varchar, dbo.fn_GetItemStock_Futures(a.Drug_Pk,Stock.BatchId, Stock.ExpiryDate, c.Id)) [ItemName],
		f.Name [DispensingUnit],
		f.Id [UnitId],
		isnull(Stock.BatchName, '') [Batch],
		 [BatchId],
		Stock.StoreID,
		a.Drug_Pk [StockItemID],
		--(
		--	Select
		--		sum(m.Quantity) [AvailableQTY]
		--	From dbo.Mst_Drug x
		--		Inner Join lnk_storeitem b On x.Drug_Pk = b.ItemId
		--		Inner Join mst_Store c On b.StoreId = c.Id
		--		Left Outer Join dtl_StockTransaction m On c.Id = m.StoreId
		--			And x.Drug_Pk = m.ItemId
		--	Where m.StoreId = @StoreID
		--		And x.Drug_Pk = a.Drug_Pk
		--		And m.BatchId = e.Id
		--		And m.ExpiryDate = e.ExpiryDate
		--)
		Stock.[AvailableQTY],
		replace(convert(varchar, Stock.ExpiryDate, 106), ' ', '-') [ExpiryDate]
From dbo.Mst_Drug a
	--Inner Join lnk_storeitem b On a.Drug_Pk = b.ItemId
	Inner Join
		(
			Select
				sum(T.Quantity) As AvailableQTY,
				SI.StoreID,
				T. ItemId Drug_pk,
				T.BatchId,
				T.ExpiryDate,
				Store.Name StoreName,
				Mst_Batch.Name BatchName
			From Dtl_StockTransaction As T
			Inner Join lnk_StoreItem As SI On T.ItemId = SI.ItemId
			Inner Join Mst_Store As Store On SI.StoreID = Store.Id
--Inner Join Dtl_StockTransaction As T On Store.Id = T.StoreId	And x.Drug_pk = T.ItemId
			Inner Join Mst_Batch On Mst_Batch.ID = T.BatchId
			Where T.StoreId = @StoreId
			Group By	SI.StoreID,
						T.ItemId,
						T.BatchId,
						T.ExpiryDate,
						Store.Name,
						Mst_Batch.Name
			Having (sum(T.Quantity) > 0)
		) Stock On  Stock.Drug_pk = a.Drug_pk
	--Inner Join mst_Store c On b.StoreId = c.Id
	--Left Outer Join dtl_StockTransaction d On c.Id = d.StoreId	And a.Drug_Pk = d.ItemId
	--Left Outer Join Mst_Batch e On d.BatchId = e.Id		And a.Drug_Pk = e.itemid
	Left Outer Join Mst_DispensingUnit f On a.DispensingUnit = f.Id

Where Stock.StoreId = @StoreID
	--And e.itemid Is Not Null
	--And (a.DrugName + ' - ' + Stock.BatchName + ' - ' + convert(varchar, ExpiryDate, 106) + ' - ' + convert(varchar, dbo.fn_GetItemStock_Futures(a.Drug_Pk, e.Id, e.ExpiryDate, c.Id))) Is Not Null
--Group By Stock.StoreID,
			--a.Drug_Pk,
			--a.DrugName,
			--f.Name,
			--f.ID,
			--Stock.BatchName,
			--BatchId ,
			--ExpiryDate,
			--e.itemid
Order By [ItemName]
End
--1                                    

Select	c.Drug_Pk,
		DrugId,
		c.DrugName [ItemName],
		dbo.fn_GetDrugGenericCommaSeprated(c.Drug_Pk) [GenericName],
		dbo.fn_Drug_Abbrev_Constella(c.Drug_Pk) [GenAbbr],
		c.FDACode,
		c.DispensingUnit,
		(
			Select
				name
			From Mst_DispensingUnit
			Where id = c.DispensingUnit
		)
		[DispensingunitName],
		c.MinStock,
		c.MaxStock,
		c.PurchaseUnit,
		(
			Select
				name
			From Mst_DispensingUnit
			Where id = c.PurchaseUnit
		)
		[PurchaseUnitName],
		c.QtyPerPurchaseUnit,
		isnull(c.PurchaseUnitPrice, 0) [PurchaseUnitPrice],
		c.Manufacturer,
		c.DispensingUnitPrice,
		c.DispensingMargin,
		isnull(c.SellingUnitPrice, 0) [SellingUnitPrice],
		c.EffectiveDate,
		c.DeleteFlag
From Mst_Drug c

---2           
If (@isPO = 1) Begin
Select	'' [ItemCode],
		'' [Units],
		'' [UnitQuantity],
		'' [OrderQuantity],
		'' [Price],
		'' [TotPrice],
		'' [Isfunded]
End Else If (@isPO = 2) Begin
Select	'' [ItemCode],
		'' [Units],
		'' [OrderQuantity],
		'' [Price],
		'' [TotPrice],
		'' [Isfunded],
		'' BatchID,
		'' BatchName,
		'' AvailableQTY,
		'' [ExpiryDate]
End
--3                            
If (@UserID = 1) Begin
Select	a.EmployeeID,
		rtrim(ltrim(a.FirstName)) + ' ' + rtrim(ltrim(a.LastName)) [EmpName]
From mst_employee a
--inner join mst_user b on a.EmployeeID =b.UserID                             
End Else Begin
Select	a.EmployeeID,
		rtrim(ltrim(a.FirstName)) + ' ' + rtrim(ltrim(a.LastName)) [EmpName]
From mst_employee a
	Inner Join mst_user b
		--on a.EmployeeID =b.UserID where b.userID=@UserID 
		On a.EmployeeID = b.EmployeeID
Where b.userID = @UserID;
End


--- 4                       
Select Distinct	c.Drug_Pk,
				c.DrugName [ItemName],
				Case
					When f.donorid > 0 Then 1
					Else 0
				End [Isfunded]
From Mst_Drug c
	Inner Join Lnk_ProgramItem e On e.ItemId = c.Drug_Pk
	Inner Join Lnk_DonorProgram f On f.ProgramId = e.ProgramId
		And convert(datetime, convert(varchar, getdate(), 106)) >= convert(datetime, convert(varchar, fundingstartdate, 106))
		And convert(datetime, convert(varchar, getdate(), 106)) <= convert(datetime, convert(varchar, FundingEndDate, 106))
Group By	c.Drug_Pk,
			c.DrugName,
			f.donorid

End

Go



SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[pr_SCM_DeleteStoreUserlnk_Futures]                        
@StoreId int                
AS                        
BEGIN   
                                      
delete  from lnk_storeuser   where StoreID In (@StoreId ,0)                                                                                   
 
END

Go
/****** Object:  StoredProcedure [dbo].[pr_SCM_SaveStoreUserlnk_Futures]    Script Date: 01/14/2016 14:16:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pr_SCM_SaveStoreUserlnk_Futures]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[pr_SCM_SaveStoreUserlnk_Futures]
GO

/****** Object:  StoredProcedure [dbo].[pr_SCM_SaveStoreUserlnk_Futures]    Script Date: 01/14/2016 14:16:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[pr_SCM_SaveStoreUserlnk_Futures]                         
(                       
	@StoreId int,                
	@UserList Xml= null 
)                                   
                                
AS                        
BEGIN   
	Delete From Lnk_StoreUser Where StoreID = @StoreId   ;
		
	Insert Into Lnk_StoreUser(UserId, StoreID,CreateDate)
	Select	ul.r.value('id[1]', 'int') UserId,	
			@StoreId,
			getdate()
	From @UserList.nodes('/root/user') As ul (r) ;                                                              
                           
                                     
END


GO


/****** Object:  StoredProcedure [dbo].[pr_SCM_GetStoreUserLinking_Futures]    Script Date: 12/07/2015 17:57:53 ******/
/****** Object:  StoredProcedure [dbo].[pr_SCM_GetStoreUserLinking_Futures]    Script Date: 01/14/2016 14:14:07 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pr_SCM_GetStoreUserLinking_Futures]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[pr_SCM_GetStoreUserLinking_Futures]
GO

/****** Object:  StoredProcedure [dbo].[pr_SCM_GetStoreUserLinking_Futures]    Script Date: 01/14/2016 14:14:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[pr_SCM_GetStoreUserLinking_Futures]  (                                     
  @StoreId int =0        
 )                                
As                                          
Begin

	Select	Id,
			Name
	From Mst_Store
	Where DeleteFlag = 0;
	Select	U.UserID,
			UserName,
			(UserFirstName+'  '+ UserLastName) Name,
			Case When SU.UserID Is Null Then 100 Else 1 End SortIndex
	From mst_User U
	Left Outer Join Lnk_StoreUser SU On U.UserID =  SU.UserID And SU.StoreID = @StoreId
	Where DeleteFlag = 0;
	Select	UserID,
			StoreID
	From lnk_storeuser
	Where StoreID = @StoreId;

End

GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pr_SCM_GetCommonItemList_Futures]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[pr_SCM_GetCommonItemList_Futures]
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[pr_SCM_GetCommonItemList_Futures]                                                                                            
(                
@CategoryId varchar(10)=NULL,            
@TableName varchar(50)=NULL    ,
@LocationId int = null        
)            
as                                           
Declare @SQLStr varchar(MAX)
                 
Begin
                                                      
	If @TableName = 'Mst_DispensingUnit' Begin
		Select	Id
			,	Name
			,	DeleteFlag
			,	SRNo
			,	UserId
			,	CreateDate
			,	UpdateDate
			,	UpdateFlag
			,	Case
					When DeleteFlag = 0 Then 'Active'
					When DeleteFlag = 1 Then 'InActive'
				End	As Status
			, DeleteFlag
		From Mst_DispensingUnit
		Order By SRNo
	End 
	Else If @TableName = 'Mst_Manufacturer' Begin
		Select	Id
			,	Name
			,	DeleteFlag
			,	SRNo
			,	UserId
			,	CreateDate
			,	UpdateDate
			,	UpdateFlag
			,	Case
					When DeleteFlag = 0 Then 'Active'
					When DeleteFlag = 1 Then 'InActive'
				End	As Status
			, DeleteFlag
		From Mst_Manufacturer
		Order By SRNo
	End 
	Else If @TableName = 'Mst_Batch' Begin
		Select	ID
			,	Name
			,	DeleteFlag
			,	SRNO
			,	UpdateFlag
			,	UserId
			,	CreateDate
			,	UpdateDate
			,	ItemID
			,	ExpiryDate
			,	Case
					When DeleteFlag = 0 Then 'Active'
					When DeleteFlag = 1 Then 'InActive'
				End	As Status
			,DeleteFlag
		From Mst_Batch
		Order By SRNO
	End 
	Else If @TableName = 'mst_Drugtype' Begin
		Select	DrugTypeID		As Id
			,	DrugTypeName	As Name
			,	DeleteFlag
			,	UpdateFlag
			,	UserID
			,	CreateDate
			,	UpdateDate
			,	SRNo
			,	Case
					When DeleteFlag = 0 Then 'Active'
					When DeleteFlag = 1 Then 'InActive'
				End				As Status
			,DeleteFlag
		From mst_DrugType Order By SRNo, DrugTypeName
	End 
	Else If @TableName = 'Mst_Store' Begin
		Select	Id
			,	Name
			,	StoreId
			,	LocationId
			,	SRNo
			,	UserId
			,	CreateDate
			,	UpdateDate
			,	StoreCategory
			,	Case
					When Active = 0 Then 'InActive'
					Else 'Active'
				End	As [Status]
			,DeleteFlag
			,	Case CentralStore
					When 0 Then 'No'
					When 1 Then 'Yes'
				End	As CentralStore
			,	Case isnull(DispensingStore, 0)
					When 0 Then 'No'
					When 1 Then 'Yes'
				End	As DispensingStore
			,	Id	As IdTemp
		From Mst_Store
		Where (LocationId = @LocationId)
			And (DeleteFlag = 0)
		Order By Name
	End 
	Else Begin
		Select	ID
			,	Name
			,	CodeID
			,	SRNo
			,	UpdateFlag
			,	DeleteFlag
			,	UserID
			,	CreateDate
			,	UpdateDate
			,	SystemId
			,	Code
			,	ModuleId
			,	Case
					When DeleteFlag = 0 Then 'Active'
					When DeleteFlag = 1 Then 'InActive'
				End	As Status
			,DeleteFlag
		From mst_Decode
		Where (CodeID = @CategoryId)
		Order By SRNo
	End


End
GO

/****** Object:  StoredProcedure [dbo].[Pr_SCM_GetStockforAdjustment_Futures]    Script Date: 01/14/2016 14:08:40 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Pr_SCM_GetStockforAdjustment_Futures]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Pr_SCM_GetStockforAdjustment_Futures]
GO

/****** Object:  StoredProcedure [dbo].[Pr_SCM_GetStockforAdjustment_Futures]    Script Date: 01/14/2016 14:08:40 ******/
/****** Object:  StoredProcedure [dbo].[Pr_SCM_GetStockforAdjustment_Futures]    Script Date: 01/20/2016 11:29:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[Pr_SCM_GetStockforAdjustment_Futures]                                                                
@StoreID int = NULL,                                  
@AdjustmentDate datetime = NULL      
                                      
as                                                                 
BEGIN
Select	ST.StoreId,
		d.Drug_pk ItemId,
		D.DrugName,
		DU.Name [DispensingUnit],
		DU.Id UnitId,
		B.Name Batch,
		ST.BatchId,
		0 AdjustReasonId,
		isnull(sum(ST.Quantity), 0) AvailableQTY,
		0 AdjQty,
		B.ExpiryDate		
From Mst_Drug D
	Inner Join Dtl_StockTransaction ST On ST.ItemId = D.Drug_pk
	Inner Join Mst_Batch B On B.ID = ST.BatchId
		And B.ItemID = D.Drug_pk
	Left Outer Join Mst_DispensingUnit DU On D.DispensingUnit = DU.Id
Where D.DeleteFlag = 0
	And ST.StoreId = @StoreId
Group By	D.Drug_pk,
			D.DrugName,
			ST.BatchId,
			ST.StoreId,
			B.Name,
			B.ExpiryDate,
			Du.Id,
			DU.Name
Order By D.DrugName, B.ExpiryDate;

Select *
From Ord_AdjustStock
Where StoreId = @StoreID
	And AdjustmentDate = @AdjustmentDate;

End

GO

/****** Object:  StoredProcedure [dbo].[Pr_SCM_SaveStockTransAdjust_Futures]    Script Date: 01/14/2016 14:25:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Pr_SCM_SaveStockTransAdjust_Futures]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Pr_SCM_SaveStockTransAdjust_Futures]
GO

/****** Object:  StoredProcedure [dbo].[Pr_SCM_SaveStockTransAdjust_Futures]    Script Date: 01/14/2016 14:25:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[Pr_SCM_SaveStockTransAdjust_Futures]                                                  
	@StoreId int ,                      
	@Updatestock int = 1,
	@AdjustmentId int,                      
	@ItemId int ,                         
	@BatchId int ,                  
	@ExpiryDate datetime ,               
	@AdjustmentQuantity int ,                 
	@PurchaseUnit int = NULL,     
	@AdjustReasonId int,                  
	@UserId int                     
as                                                   
BEGIN
                      
    declare @TransactionId int;         
 --if (@Updatestock = 1) Begin
	 Insert Into Dtl_AdjustStock (
		AdjustId,
		ItemId,
		StoreId,
		BatchId,
		ExpiryDate,
		PurchaseUnit,
		AdjustReasonId,
		AdjustmentQuantity,
		UpdateStock)
	Values (
		@AdjustmentId,
		@ItemId,
		@StoreId,
		@BatchId,
		@ExpiryDate,
		@PurchaseUnit,
		@AdjustReasonId,
		@AdjustmentQuantity,
		@Updatestock );
	Select @TransactionId = scope_identity();
	Insert Into dtl_StockTransaction (
		AdjustId,
		ItemId,
		BatchId,
		ExpiryDate,
		StoreId,
		TransactionDate,
		Quantity,
		UserId,
		CreateDate,
		UpdateDate)
	Values (
		@TransactionId,
		@ItemId,
		@BatchId,
		@ExpiryDate,
		@StoreId,
		getdate(),
		@AdjustmentQuantity,
		@UserId,
		getdate(),
		getdate() )

End

GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pr_SCM_GetPharmacyPrescription_Futures]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[pr_SCM_GetPharmacyPrescription_Futures]
GO
/****** Object:  StoredProcedure [dbo].[pr_SCM_GetPharmacyPrescription_Futures]    Script Date: 03/17/2016 07:34:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[pr_SCM_GetPharmacyPrescription_Futures]     (                                           
	@Ptn_Pharmacy_Pk int,                        
	@PatientId int,                        
	@password varchar(50) = null,  
	@IQCareFlag int   )                                                            
                                                
As Begin 
                                                
If(@IQCareFlag=1)  Begin                                                
	Select Distinct	Drug_pk							As ItemId
				,	DrugName						As ItemName
				,	[Item Code]
				,	[Dispensing Unit Id]			As DispensingUnitId
				,	[Dispensing Unit]				As DispensingUnitName
				,	StrengthID
				,	FrequencyID
				,	FrequencyName
				,	isnull(DispensedQuantity, 0)	As QtyDisp
				,	OrderedByDate
				,	isnull(CostPrice, 0)			As CostPrice
				,	isnull(Margin, 0)				As Margin
				,	isnull(SellingPrice, 0)			As SellingPrice
				,	isnull(BillAmount, 0)			As BillAmount
				,	isnull(UnitSellingPrice, 0)		As UnitSellingPrice
				,	VisitID
				,	isnull(OrderedQuantity, 0)		As OrderedQuantity
				,	isnull(SingleDose, 0)			As 'Dose'
				,	Duration
	From VW_PatientPharmacy As a
	Where (ptn_pharmacy_pk = @Ptn_Pharmacy_Pk)
		And (PrintPrescriptionStatus = 1)
	Group By	Drug_pk
			,	DrugName
			,	[Item Code]
			,	[Dispensing Unit Id]
			,	[Dispensing Unit]
			,	StrengthID
			,	FrequencyID
			,	FrequencyName
			,	DispensedQuantity
			,	OrderedByDate
			,	CostPrice
			,	Margin
			,	SellingPrice
			,	BillAmount
			,	UnitSellingPrice
			,	VisitID
			,	OrderedQuantity
			,	SingleDose
			,	Duration                                              
End                                                
Select Top 1	DispensedByDate
			,	isnull(ProgId, 0)	[ProgId]
			,	isnull(ReportingID, (
				Select right('000000' + convert(varchar, @Ptn_Pharmacy_Pk), 6)
				)
				)					[ReportingID]
			,	Height
			,	Weight
			,	PharmacyNotes
			,	VisitId
From vw_patientpharmacy
Where ptn_Pharmacy_Pk = @Ptn_Pharmacy_Pk                         
                        
--Declare @SymKey varchar(400)                                      
--Set @SymKey = 'Open symmetric key Key_CTC decryption by password='+ @password + ''                                          
--exec(@SymKey)                                       
                          
Select	convert(varchar(50), decryptbykey(P.FirstName))		As FirstName
	,	convert(varchar(50), decryptbykey(P.MiddleName))	As middlename
	,	convert(varchar(50), decryptbykey(P.LastName))		As lastname
	,	Case
			When nullif(PatientEnrollmentId, '') Is Not Null Then P.CountryId + '-' + P.PosId + '-' + P.SatelliteId + '-' + P.PatientEnrollmentId
			Else PatientFacilityID
		End													As PatientEnrollmentId
	,	P.Ptn_Pk
	,	D.Name												As Gender
	,	datediff(dd, P.DOB, getdate()) / 365.25				As Age
	,	P.DOB
	,	convert(varchar(50), decryptbykey(P.Phone))			As phone
From mst_Patient As P
Inner Join mst_Decode As D On P.Sex = D.ID
Where (P.Ptn_Pk = @PatientId)
                                     
--Close symmetric key Key_CTC                         
                      
Select Top (1)	a.FacilityLogo,
				a.FacilityAddress,
				a.FacilityTel,
				a.FacilityCell,
				a.FacilityFax,
				a.FacilityEmail,
				a.FacilityURL,
				a.FacilityFooter,
				isnull(a.FacilityTemplate, 0) As FacilityTemplate
From mst_Facility As a
Inner Join ord_PatientPharmacyOrder As b On a.FacilityID = b.LocationID
Where (b.Ptn_Pk = @PatientId And B.ptn_pharmacy_pk = @Ptn_Pharmacy_Pk)       

Select	U.Name As PrescriberName,
		U.Designation
From vw_UserList As U
Inner Join ord_PatientPharmacyOrder As O On O.OrderedBy = U.UserId
Where (O.ptn_pharmacy_pk = @Ptn_Pharmacy_Pk);

--select b.FirstName+' '+b.LastName[PrescriberName],c.Name[Designation] from ord_patientpharmacyorder a                 
--Left outer join mst_employee b on a.Orderedby=b.EmployeeId            
--Left Outer Join mst_Designation c on b.DesignationId=c.Id                
--where a.ptn_Pharmacy_Pk = @Ptn_Pharmacy_Pk                
                                       
Select Top (1) Case a.AllergyID
		When 83 Then convert(varchar(100), 'Other: ' + a.AllergyNameOther)
		Else b.Name
	End As Allergy
From dtl_PatientAllergy As a
Inner Join mst_Decode As b On a.AllergyID = b.ID
Where (a.Ptn_Pk = @PatientId)
Order By a.PtnAllergyID Desc;

Select	U.Name As DispenserName,
		U.Designation
From vw_UserList As U
Inner Join ord_PatientPharmacyOrder As O On O.DispensedBy = U.UserId
Where (O.ptn_pharmacy_pk = @Ptn_Pharmacy_Pk);
            
--select b.FirstName+' '+b.LastName[DispenserName],c.Name[Designation] from ord_patientpharmacyorder a                 
--Left outer join mst_employee b on a.Dispensedby=b.EmployeeId            
--Left Outer Join mst_Designation c on b.DesignationId=c.Id                
--where a.ptn_Pharmacy_Pk = @Ptn_Pharmacy_Pk                                     
End

GO

/****** Object:  StoredProcedure [dbo].[pr_SCM_SavePharmacyDispenseOrderDetail_Futures]    Script Date: 5/12/2016 5:15:04 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[pr_SCM_SavePharmacyDispenseOrderDetail_Futures]                        
	@Ptn_Pk int,                        
	@StoreId int,                        
	@VisitId int,                        
	@Ptn_Pharmacy_Pk int,                        
	@Drug_Pk int,                        
	@StrengthId int,                        
	@FrequencyId int,                        
	@DispensedQuantity int,                        
	@Prophylaxis int,                        
	@BatchId int,                        
	@CostPrice decimal(18,2),                        
	@Margin decimal(18,2),                        
	@SellingPrice decimal(18,2),                        
	@BillAmount decimal(18,2),                        
	@ExpiryDate datetime,                        
	@DispensingUnit int,                        
	@DispensedByDate datetime,                        
	@LocationId int,                        
	@UserId int,          
	@DataStatus int ,  
	@Dose decimal(18,2),  
	@Duration decimal(18,2),  
	@PrescribeOrderedQuantity decimal(18,2),  
	@PrintPrescriptionStatus int,  
	@PatientInstructions varchar(500),
	@WhyPartial varchar(255) =null,
	@BatchNo varchar(50)  
As Begin                        
          
	declare @EntryStatus int;
	Select @BatchId = id	From mst_batch Where name = @BatchNo And itemid = @Drug_Pk

	Set @EntryStatus = 0

	If Exists (Select Drug_Pk From dbo.Dtl_PatientPharmacyOrder	Where Drug_Pk = @Drug_Pk And DispensedQuantity = 0	And Ptn_Pharmacy_Pk = @Ptn_Pharmacy_Pk) Begin
		Set @EntryStatus = 1

		Update dbo.Dtl_PatientPharmacyOrder Set
			DispensedQuantity = @DispensedQuantity
			, BatchNo = @BatchId
			, ExpiryDate = @ExpiryDate
			, UserId = @UserId
			, UpdateDate = GETDATE()
			, SingleDose = @Dose
			, Duration = @Duration
			, OrderedQuantity = @PrescribeOrderedQuantity
			, PrintPrescriptionStatus = @PrintPrescriptionStatus
			, PatientInstructions = @PatientInstructions
			,WhyPartial = nullif(@WhyPartial,'')
		Where Ptn_Pharmacy_pk = @Ptn_Pharmacy_Pk
		And Drug_Pk = @Drug_Pk;

		Insert Into dbo.Dtl_PatientBillTransaction (
			Ptn_Pk
			,VisitId
			,LocationId
			,TransactionDate
			,LabId
			,PharmacyId
			,ItemId
			,BatchId
			,DispensingUnit
			,Quantity
			,SellingPrice
			,CostPrice
			,Margin
			,ConsultancyFee
			,AdminFee
			,BillAmount
			,DoctorId
			,UserId
			,CreateDate)
		Values (
			@Ptn_Pk
			,@VisitId
			,@LocationId
			,@DispensedByDate
			,0
			,@Ptn_Pharmacy_pk
			,@Drug_Pk
			,@BatchId
			,@DispensingUnit
			,@DispensedQuantity
			,@SellingPrice
			,@CostPrice
			,@Margin
			,0
			,0
			,@BillAmount
			,0
			,@UserId
			,GETDATE())

		Insert Into dbo.Dtl_StockTransaction (
			ItemId
			,BatchId
			,Ptn_Pharmacy_Pk
			,PtnPk
			,StoreId
			,TransactionDate
			,Quantity
			,ExpiryDate
			,PurchasePrice
			,SellingPrice
			,Margin
			,UserId
			,CreateDate)
		Values (
			@Drug_Pk
			,@BatchId
			,@Ptn_Pharmacy_Pk
			,@Ptn_Pk
			,@StoreId
			,@DispensedByDate
			,'-' + CONVERT(varchar, @DispensedQuantity)
			,@ExpiryDate
			,@CostPrice
			,@SellingPrice
			,@Margin
			,@UserId
			,GETDATE())
	End


	If Not Exists (Select	Drug_Pk	From dbo.Dtl_PatientPharmacyOrder Where Drug_Pk = @Drug_Pk	And BatchNo = @BatchId	And ExpiryDate = @ExpiryDate And Ptn_Pharmacy_Pk = @Ptn_Pharmacy_Pk) Begin
		Set @EntryStatus = 1
	
		Insert Into dbo.Dtl_PatientPharmacyOrder (
			Ptn_Pharmacy_Pk
			,Drug_Pk
			,GenericId
			,StrengthId
			,FrequencyId
			,DispensedQuantity
			,UserId
			,CreateDate
			,Prophylaxis
			,BatchNo
			,ExpiryDate
			,SingleDose
			,Duration
			,OrderedQuantity
			,PrintPrescriptionStatus
			,WhyPartial
			,PatientInstructions)
		Values (
			@Ptn_Pharmacy_Pk
			,@Drug_Pk
			,0
			,@StrengthId
			,@FrequencyId
			,@DispensedQuantity
			,@UserId
			,GETDATE()
			,@Prophylaxis
			,@BatchId
			,@ExpiryDate
			,@Dose
			,@Duration
			,@PrescribeOrderedQuantity
			,@PrintPrescriptionStatus
			,nullif(@WhyPartial,'')
			,@PatientInstructions)

		Insert Into dbo.Dtl_PatientBillTransaction (
			Ptn_Pk
			,VisitId
			,LocationId
			,TransactionDate
			,LabId
			,PharmacyId
			,ItemId
			,BatchId
			,DispensingUnit
			,Quantity
			,SellingPrice
			,CostPrice
			,Margin
			,ConsultancyFee
			,AdminFee
			,BillAmount
			,DoctorId
			,UserId
			,CreateDate)
		Values (
			@Ptn_Pk
			,@VisitId
			,@LocationId
			,@DispensedByDate
			,0
			,@Ptn_Pharmacy_pk
			,@Drug_Pk
			,@BatchId
			,@DispensingUnit
			,@DispensedQuantity
			,@SellingPrice
			,@CostPrice
			,@Margin
			,0
			,0
			,@BillAmount
			,0
			,@UserId
			,GETDATE())
		Insert Into dbo.Dtl_StockTransaction (
			ItemId
			,BatchId
			,Ptn_Pharmacy_Pk
			,PtnPk
			,StoreId
			,TransactionDate
			,Quantity
			,ExpiryDate
			,PurchasePrice
			,SellingPrice
			,Margin
			,UserId
			,CreateDate)
		Values (
			@Drug_Pk
			,@BatchId
			,@Ptn_Pharmacy_Pk
			,@Ptn_Pk
			,@StoreId
			,@DispensedByDate
			,'-' + CONVERT(varchar, @DispensedQuantity)
			,@ExpiryDate
			,@CostPrice
			,@SellingPrice
			,@Margin
			,@UserId
			,GETDATE())
	End

	If (@EntryStatus = 0 And @DataStatus = 1) Begin
		Insert Into dbo.Dtl_PatientPharmacyOrder (
			Ptn_Pharmacy_Pk
			,Drug_Pk
			,GenericId
			,StrengthId
			,FrequencyId
			,DispensedQuantity
			,UserId
			,CreateDate
			,Prophylaxis
			,BatchNo
			,ExpiryDate
			,SingleDose
			,Duration
			,OrderedQuantity
			,PrintPrescriptionStatus
			,WhyPartial
			,PatientInstructions)
		Values (
			@Ptn_Pharmacy_Pk
			,@Drug_Pk
			,0
			,@StrengthId
			,@FrequencyId
			,@DispensedQuantity
			,@UserId
			,GETDATE()
			,@Prophylaxis
			,@BatchId
			,@ExpiryDate
			,@Dose
			,@Duration
			,@PrescribeOrderedQuantity
			,@PrintPrescriptionStatus
			,nullif(@WhyPartial,'')
			,@PatientInstructions);

		Declare @duraction1 decimal(18, 2), @Qty1 decimal(18, 2);

		Select Top 1	@duraction1 = Duration
						,@Qty1 = OrderedQuantity
		From dbo.Dtl_PatientPharmacyOrder
		Where Ptn_Pharmacy_Pk = @Ptn_Pharmacy_Pk
		And Drug_Pk = @Drug_Pk
		And Duration Is Not Null
		And OrderedQuantity Is Not Null;

		Update dbo.Dtl_PatientPharmacyOrder Set
			Duration = @duraction1
			, OrderedQuantity = @Qty1
		Where Ptn_Pharmacy_Pk = @Ptn_Pharmacy_Pk
		And Drug_Pk = @Drug_Pk
		And Duration Is Null
		And OrderedQuantity Is Null;

		Insert Into dbo.Dtl_PatientBillTransaction (
			Ptn_Pk
			,VisitId
			,LocationId
			,TransactionDate
			,LabId
			,PharmacyId
			,ItemId
			,BatchId
			,DispensingUnit
			,Quantity
			,SellingPrice
			,CostPrice
			,Margin
			,ConsultancyFee
			,AdminFee
			,BillAmount
			,DoctorId
			,UserId
			,CreateDate)
		Values (
			@Ptn_Pk
			,@VisitId
			,@LocationId
			,@DispensedByDate
			,0
			,@Ptn_Pharmacy_pk
			,@Drug_Pk
			,@BatchId
			,@DispensingUnit
			,@DispensedQuantity
			,@SellingPrice
			,@CostPrice
			,@Margin
			,0
			,0
			,@BillAmount
			,0
			,@UserId
			,GETDATE())

		Insert Into dbo.Dtl_StockTransaction (
			ItemId
			,BatchId
			,Ptn_Pharmacy_Pk
			,PtnPk
			,StoreId
			,TransactionDate
			,Quantity
			,ExpiryDate
			,PurchasePrice
			,SellingPrice
			,Margin
			,UserId
			,CreateDate)
		Values (
			@Drug_Pk
			,@BatchId
			,@Ptn_Pharmacy_Pk
			,@Ptn_Pk
			,@StoreId
			,@DispensedByDate
			,'-' + CONVERT(varchar, @DispensedQuantity)
			,@ExpiryDate
			,@CostPrice
			,@SellingPrice
			,@Margin
			,@UserId
			,GETDATE())
	End
	
	Declare @OrderedQuantity decimal(18, 2), @TotalDispensedQuantity decimal(18, 2);

	Select @OrderedQuantity = orderedquantity	
	From dtl_patientpharmacyorder	Where ptn_pharmacy_pk = @ptn_Pharmacy_Pk	And Drug_Pk = @Drug_Pk;


	Select @TotalDispensedQuantity = SUM(DispensedQuantity)
	From dtl_patientpharmacyorder
	Where ptn_pharmacy_pk = @ptn_Pharmacy_Pk
	And Drug_Pk = @Drug_Pk;

	Declare @OrderedQuantity1 decimal(18, 2),@TotalDispensedQuantity1 decimal(18, 2);

	Select @OrderedQuantity1 = SUM(z.OrderedQuantity)
	From (
		Select	Drug_Pk		,ISNULL(OrderedQuantity, 0) 'OrderedQuantity'
		From dtl_patientpharmacyorder
		Where ptn_pharmacy_pk = @ptn_Pharmacy_Pk
		Group By	Drug_Pk,OrderedQuantity
	) z
	Select @TotalDispensedQuantity1 = SUM(DispensedQuantity)
	From dtl_patientpharmacyorder
	Where ptn_pharmacy_pk = @ptn_Pharmacy_Pk;

	Select @OrderedQuantity1
	Select @TotalDispensedQuantity1

	If (@OrderedQuantity1 <= @TotalDispensedQuantity1) Begin
		Update ord_PatientPharmacyOrder		Set 
			OrderStatus = 2
		Where DispensedByDate Is Not Null
		And ptn_pharmacy_pk = @ptn_pharmacy_pk
	End
	
	Update ord_PatientPharmacyOrder	Set 
		OrderStatus = 3
	Where DispensedByDate Is Not Null
	And ptn_pharmacy_pk = @ptn_pharmacy_pk
	And @OrderedQuantity > @TotalDispensedQuantity

End
GO

/****** Object:  StoredProcedure [dbo].[pr_SCM_GetPharmacyOrderDetail_Futures]    Script Date: 5/12/2016 5:17:58 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[pr_SCM_GetPharmacyOrderDetail_Futures]                      
@Ptn_Pharmacy_Pk int
as                      
                      
begin

Select Distinct	a.Drug_Pk [ItemId]
				,a.DrugName [ItemName]
				,a.[Dispensing Unit Id] [DispensingUnitId]
				,a.[Dispensing Unit] [DispensingUnitName]
				,a.OrderedByDate
				,a.BatchId
				,a.BatchNo
				,a.StrengthId
				,a.FrequencyId
				,a.FrequencyName
				,CONVERT(varchar(11), a.ExpiryDate, 113) [ExpiryDate]
				,a.DispensedQuantity [QtyDisp]
				,a.WhyPartial
				,a.CostPrice
				,a.Margin
				,a.SellingPrice
				,a.BillAmount
				,a.Prophylaxis
				,a.DrugTypeId [ItemType]
				,a.RegimenType [GenericAbb]
				,0 [ReturnQty]
				,Null [ReturnReason]
				,a.UnitSellingPrice
				,a.visitId
				,a.OrderedQuantity
				,'0' DataStatus
				,a.SingleDose 'Dose'
				,a.Duration
				,a.PrintPrescriptionStatus
				,a.PatientInstructions,
				a.DispensedByDate,
				Isnull(ProgId,0) ProgId
From vw_patientpharmacy a
Where a.ptn_Pharmacy_Pk = @Ptn_Pharmacy_Pk;

--Select Top 1	DispensedByDate
--				,ISNULL(ProgId, 0) [ProgId]
--From vw_patientpharmacy
--Where ptn_Pharmacy_Pk = @Ptn_Pharmacy_Pk




End
GO
  /****** Object:  StoredProcedure [dbo].[pr_SCM_GetItemListSupplier_Futures]    Script Date: 5/12/2016 5:25:41 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pr_SCM_GetItemListSupplier_Futures]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[pr_SCM_GetItemListSupplier_Futures]
GO
/****** Object:  StoredProcedure [dbo].[pr_SCM_GetItemListSupplier_Futures]    Script Date: 5/12/2016 5:25:41 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[pr_SCM_GetItemListSupplier_Futures]                           
@ItemTypeId int ,             
@SupplierId int ,                       
@SubitemId int =0                                                                                                      
as                                                                      
begin                           
    
 declare @CatName varchar(200)    
 select @CatName = Name from Mst_Decode where Id = @ItemTypeId   
                     
  if @CatName <> 'Lab Tests'    
  begin                  
   if(@SubitemId =0)                       
  begin             
  select a.Drug_pk [ItemID],a.DrugName [ItemName],e.ItemTypeId [ItemTypeID]  from mst_drug a inner join Lnk_SupplierItem e        
   on  (a.Drug_pk =e.ItemId ) where e.ItemTypeId =@ItemTypeId and  e.SupplierId=@SupplierId 
   and a.DeleteFlag = 0 group by a.Drug_pk  ,a.DrugName ,e.ItemTypeId  order by a.DrugName          
       
 select a.Drug_pk [ItemID],a.DrugName [ItemName]  from mst_drug a left outer join  Lnk_SupplierItem e        
 on  (a.Drug_pk =e.ItemId )  where dbo.fn_GetDrugTypeId_futures(a.Drug_Pk) in (    
            select drugtypeid from lnk_itemdrugtype where itemtypeid = @ItemTypeId) 
			and a.DeleteFlag = 0  
 group by a.Drug_pk  ,a.DrugName  order by a.DrugName          
  --,e.ItemTypeId        
  end              
 else                      
  begin                      
    
 select a.Drug_pk [ItemID],a.DrugName [ItemName],e.ItemTypeId [ItemTypeID]  from mst_drug a inner join Lnk_SupplierItem e        
on  (a.Drug_pk =e.ItemId ) where e.ItemTypeId =@ItemTypeId and e.SupplierId=@SupplierId and  dbo.fn_GetDrugTypeId_futures (a.drug_pk) =@SubitemId 
and a.DeleteFlag = 0        
group by a.Drug_pk  ,a.DrugName ,e.ItemTypeId  order by a.DrugName          
            
            
  select a.Drug_pk [ItemID],a.DrugName [ItemName],e.ItemTypeId [ItemTypeID]  from mst_drug a left outer join Lnk_SupplierItem e        
on  (a.Drug_pk =e.ItemId and e.ItemTypeId =@ItemTypeId) where   dbo.fn_GetDrugTypeId_futures (a.drug_pk) =@SubitemId 
and a.DeleteFlag = 0        
group by a.Drug_pk  ,a.DrugName ,e.ItemTypeId  order by a.DrugName             
                       
  end                 
  end    
  else    
  begin            
         
select a.SubTestID [ItemID] ,a.SubTestName [ItemName] ,b.ItemTypeId [ItemTypeID]  from lnk_testParameter a             
inner join Lnk_SupplierItem b on a.SubTestID =b.ItemId and b.SupplierId=@SupplierId   
where b.ItemTypeId =@ItemTypeId group by a.SubTestID  ,a.SubTestName,b.ItemTypeId   order by a.SubTestName          
            
select a.SubTestID [ItemID] ,a.SubTestName [ItemName] ,b.ItemTypeId [ItemTypeID]  from lnk_testParameter a             
left outer join Lnk_SupplierItem b on a.SubTestID =b.ItemId and  
b.ItemTypeId=@ItemTypeId  group by a.SubTestID  ,a.SubTestName,b.ItemTypeId  order by a.SubTestName            
            
end                      
 end

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pr_SCM_GetStockSummary_Futures]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[pr_SCM_GetStockSummary_Futures]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[pr_SCM_GetStockSummary_Futures]                                                        
@StoreId int=NULL,                                                    
@ItemId int=NULL,                                                    
@FromDate datetime=NULL,                                                    
@ToDate datetime=NULL                                                    
                                                        
AS                                                                  
BEGIN
--0                                                    
Set @Todate = dateadd(dd, 1, @Todate)
Set @ItemId = Case When @ItemId = 0 Then Null Else @ItemId End

Select Distinct	ls.StoreID	As StoreId
			,	md.Drug_pk
			,	md.DrugName
From lnk_StoreItem As ls
Inner Join Mst_Drug As md On ls.ItemId = md.Drug_pk
--Inner Join Dtl_StockTransaction As dt On md.Drug_pk = dt.ItemId
Where (ls.StoreID = @StoreId)
Group By	ls.StoreID
		,	md.Drug_pk
		,	md.DrugName
Order By md.Drug_pk
--1                                
Select	Drg.Drug_Pk																																			[ItemId]
	,	Drg.DrugName																																		[ItemName]
	,	Unit.Name																																			[DispensingUnit]
	,	P.OpeningQuantity																																	[OpeningStock]
	,	Recq.RecQty																																			[QtyRecieved]
	,	r.IssQty																																			[QtyDispensed]
	,	s.InterStoreIssueQty
	,	(isnull(P.OpeningQuantity, 0) + isnull(Recq.RecQty, 0) + isnull(t.AdjustmentQuantity, 0)) - (isnull(s.InterstoreIssueQty, 0) + isnull(R.IssQty, 0))	[ClosingQty]
	,	@StoreId																																			[StoreId]
	,	(	Select Top 1 Name		From Mst_Store		Where Id = @StoreId		)	[StoreName]
	,	t.AdjustmentQuantity
From Mst_Drug Drg
Left Outer Join Mst_DispensingUnit Unit On Drg.DispensingUnit = Unit.Id
Left Outer Join (
Select	tmp.drug_pk
	,	tmp.drugname
	,	tmp.dispensingunit
	,	sum(openingquantity)	[OpeningQuantity]
From (
Select	a.Drug_Pk
	,	a.DrugName
	,	c.Name			[DispensingUnit]
	,	sum(b.Quantity)	[OpeningQuantity]
From mst_drug a
Left Outer Join dtl_stocktransaction b On a.Drug_Pk = b.ItemId
Left Outer Join Mst_DispensingUnit c On a.DispensingUnit = c.Id
Where b.storeid = @StoreId 
	And b.ExpiryDate >= @FromDate 
	And transactiondate >= @FromDate 
	And transactiondate < @ToDate 
	And openingstock = 1 
	And (a.Drug_pk = @ItemId Or @ItemId Is Null)
Group By	a.drug_pk
		,	a.drugname
		,	c.name
Union
Select	a.Drug_Pk
	,	a.DrugName
	,	c.Name																	[DispensingUnit]
	,	nullif(dbo.fn_GetItemOpeningStock(a.Drug_pk, @StoreId, @FromDate), 0)	[OpeningQuanitity]
From mst_drug a
Left Outer Join Mst_DispensingUnit c On a.DispensingUnit = c.Id
Group By	a.drug_pk
		,	a.drugname
		,	c.name
) tmp
Group By	tmp.drug_pk
		,	tmp.drugname
		,	tmp.dispensingunit
) p On Drg.Drug_Pk = p.Drug_pk
Left Outer Join (
Select	q.drug_pk
	,	q.drugname
	,	q.dispensingunit
	,	sum(q.RecQty)	[RecQty]
From       
(
Select	a.Drug_Pk
	,	a.DrugName
	,	c.Name			[DispensingUnit]
	,	sum(Quantity)	[RecQty]
From mst_drug a
Inner Join dtl_stocktransaction b On a.Drug_Pk = b.ItemId
Left Outer Join Mst_DispensingUnit c On a.DispensingUnit = c.Id
Where b.Openingstock Is Null 
	And b.AdjustId Is Null 
	And b.storeid = @StoreId And (b.GrnId Is Not Null Or b.GrnId > 0) 
	And b.Quantity > 0 
	And b.ExpiryDate >= @FromDate
	 And b.transactiondate >= @FromDate And b.transactiondate < @ToDate
Group By	a.drug_pk
		,	a.drugname
		,	c.name
Having sum(Quantity) >= 0
) q
Group By	q.drug_pk
		,	q.drugname
		,	q.dispensingunit
) Recq On Drg.Drug_Pk = Recq.Drug_Pk
Left Outer Join (
	Select	a.Drug_Pk
		,	a.DrugName
		,	c.Name				[DispensingUnit]
		,	abs(sum(Quantity))	[IssQty]
	From mst_drug a
	Inner Join dtl_stocktransaction b On a.Drug_Pk = b.ItemId
	Left Outer Join Mst_DispensingUnit c On a.DispensingUnit = c.Id
	Where b.storeid = @StoreId 
		And b.Ptn_Pharmacy_pk > 0 
		And b.ExpiryDate >= @FromDate 
		And b.transactiondate >= @FromDate 
		And b.transactiondate < @ToDate
	Group By	b.StoreId
			,	a.drug_pk
			,	a.drugname
			,	c.name
) r On Drg.Drug_Pk = r.Drug_Pk
Left Outer Join (
	Select	a.Drug_Pk
		,	a.DrugName
		,	c.Name				[DispensingUnit]
		,	sum(abs(Quantity))	[InterStoreIssueQty]
	From mst_drug a
	Inner Join dtl_stocktransaction b On a.Drug_Pk = b.ItemId
	Left Outer Join Mst_DispensingUnit c On a.DispensingUnit = c.Id
	Where b.storeid = @StoreId 
		And (b.GrnId Is Not Null Or b.GrnId > 0) 
		And b.Quantity < 0 And b.ExpiryDate >= @FromDate 
		And b.transactiondate >= @FromDate
		And b.transactiondate < @ToDate
		And (a.Drug_pk = @ItemId Or @ItemId Is Null)
	Group By	a.drug_pk
			,	a.drugname
			,	c.name
) s On Drg.Drug_Pk = s.Drug_Pk
Left Outer Join (
	Select	a.Drug_Pk
		,	a.DrugName
		,	c.Name			[DispensingUnit]
		,	sum(b.Quantity)	[AdjustmentQuantity]
	From mst_drug a
	Inner Join dtl_stocktransaction b On a.Drug_Pk = b.ItemId
	Left Outer Join Mst_DispensingUnit c On a.DispensingUnit = c.Id
	Where b.storeid = @StoreId 
		And b.ExpiryDate >= @FromDate 
		And b.AdjustId Is Not Null 
		And b.transactiondate >= @FromDate 
		And b.transactiondate < @ToDate
		And (a.Drug_pk = @ItemId Or @ItemId Is Null)
	Group By	a.drug_pk
			,	a.drugname
			,	c.name
) t On Drg.Drug_Pk = t.Drug_Pk

Where (p.OpeningQuantity Is Not Null Or Recq.RecQty Is Not Null Or r.IssQty Is Not Null Or s.InterStoreIssueQty Is Not Null)
	And (Drg.Drug_pk = @ItemId Or @ItemId Is Null)
Order By Drg.DrugName

--2 
/*
                                                 
select Drg.Drug_Pk[ItemId],Drg.DrugName[ItemName],Unit.Name [DispensingUnit],P.OpeningQuantity[OpeningStock],                          
Recq.RecQty[QtyRecieved], r.IssQty[QtyDispensed],s.InterStoreIssueQty,                          
(isnull(P.OpeningQuantity,0)+isnull(Recq.RecQty,0)+isnull(t.AdjustmentQuantity,0))-isnull(R.IssQty,0) [ClosingQty],                          
(Select Id from Mst_Store where Id = @StoreId)[StoreId],                          
(Select Name from Mst_Store where Id = @StoreId)[StoreName],t.AdjustmentQuantity                          
from Mst_Drug Drg Left Outer join Mst_DispensingUnit Unit on Drg.DispensingUnit = Unit.Id                           
Left Outer Join                           
(select tmp.drug_pk,tmp.drugname,tmp.dispensingunit,sum(openingquantity)[OpeningQuantity] from                         
(select a.Drug_Pk,a.DrugName,c.Name [DispensingUnit], sum(b.Quantity)[OpeningQuantity]                          
from mst_drug a Left Outer join dtl_stocktransaction b on a.Drug_Pk = b.ItemId                          
Left Outer join Mst_DispensingUnit c on a.DispensingUnit = c.Id                          
where b.storeid = @StoreId and b.ItemId=@ItemId and b.ExpiryDate>=@FromDate and                         
transactiondate>=@FromDate and transactiondate<@ToDate  and openingstock = 1                          
group by a.drug_pk,a.drugname,c.name                        
union                        
select a.Drug_Pk,a.DrugName,c.Name [DispensingUnit], nullif(dbo.fn_GetItemOpeningStock(a.Drug_pk,@StoreId,@FromDate),0)[OpeningQuanitity]                        
from mst_drug a Left Outer join Mst_DispensingUnit c on a.DispensingUnit = c.Id                      
and a.Drug_Pk=@ItemId                      
union                      
select a.Drug_Pk,a.DrugName,c.Name [DispensingUnit], sum(b.Quantity)[OpeningQuantity]                          
from mst_drug a Left Outer join dtl_stocktransaction b on a.Drug_Pk = b.ItemId                          
Left Outer join Mst_DispensingUnit c on a.DispensingUnit = c.Id                          
where b.storeid = @StoreId and b.ItemId=@ItemId and b.ExpiryDate>=@FromDate and                         
transactiondate>=@FromDate and transactiondate<@ToDate  and POID IS NULL and                      
GRNId IS NULL and DisposeId IS NULL and Ptn_Pharmacy_Pk IS NULL and PtnPk IS NULL                       
and OpeningStock IS NULL                           
group by a.drug_pk,a.drugname,c.name                        
)tmp group by tmp.drug_pk,tmp.drugname,tmp.dispensingunit) p on Drg.Drug_Pk = P.Drug_pk                          
Left Outer Join                          
(select q.drug_pk,q.drugname,q.dispensingunit,sum(q.RecQty)[RecQty] from                
--(select a.Drug_Pk,a.DrugName,c.Name [DispensingUnit], sum(Quantity)[RecQty]                        
-- from mst_drug a Left Outer join dtl_stocktransaction b on a.Drug_Pk = b.ItemId                        
-- Left Outer join Mst_DispensingUnit c on a.DispensingUnit = c.Id                        
-- where  b.Openingstock IS NULL and  b.AdjustId IS NULL  and b.storeid = @StoreId and b.ExpiryDate>=@FromDate and                       
-- transactiondate>=@FromDate and transactiondate<@ToDate                         
-- group by a.drug_pk,a.drugname,c.name  having sum(Quantity) >= 0       
-- union        
 (select a.Drug_Pk,a.DrugName,c.Name [DispensingUnit], sum(Quantity)[RecQty]                         
 from mst_drug a Inner join dtl_stocktransaction b on a.Drug_Pk = b.ItemId                        
 Left Outer join Mst_DispensingUnit c on a.DispensingUnit = c.Id                        
 where b.Openingstock IS NULL and  b.AdjustId IS NULL and b.storeid = @StoreId and (b.GrnId is not null or b.GrnId > 0)                         
 and b.Quantity>0 and b.ExpiryDate>=@FromDate and                   
 b.transactiondate >=@FromDate and b.transactiondate<@ToDate                        
 group by a.drug_pk,a.drugname,c.name having sum(Quantity) >= 0 )q         
 group by q.drug_pk, q.drugname, q.dispensingunit) Recq on Drg.Drug_Pk = Recq.Drug_Pk         
Left Outer Join                          
(select a.Drug_Pk,a.DrugName,c.Name [DispensingUnit], abs(sum(Quantity)) [IssQty]                         
from mst_drug a inner join dtl_stocktransaction b on a.Drug_Pk = b.ItemId                        
Left Outer join Mst_DispensingUnit c on a.DispensingUnit = c.Id and b.ItemId=@ItemId                     
where b.storeid = @StoreId  and b.Ptn_Pharmacy_pk > 0                         
and b.ExpiryDate>=@FromDate and b.transactiondate >=@FromDate and b.transactiondate<@ToDate                        
group by b.StoreId, a.drug_pk,a.drugname,c.name
--select a.Drug_Pk,a.DrugName,c.Name [DispensingUnit], sum(Quantity) [IssQty]                           
--from mst_drug a inner join dtl_stocktransaction b on a.Drug_Pk = b.ItemId                          
--Left Outer join Mst_DispensingUnit c on a.DispensingUnit = c.Id                          
--where b.storeid = @StoreId and b.ItemId=@ItemId and (b.Ptn_Pharmacy_pk is not null or b.Ptn_Pharmacy_pk > 0)                           
--and b.ExpiryDate>=@FromDate and b.transactiondate >=@FromDate and b.transactiondate<=@ToDate                          
--group by b.StoreId, a.drug_pk,a.drugname,c.name
)r on Drg.Drug_Pk = r.Drug_Pk 
                     
Left Outer Join                    
(select a.Drug_Pk,a.DrugName,c.Name [DispensingUnit], sum(abs(Quantity)) [InterStoreIssueQty]                           
from mst_drug a inner join dtl_stocktransaction b on a.Drug_Pk = b.ItemId                          
Left Outer join Mst_DispensingUnit c on a.DispensingUnit = c.Id                          
where b.storeid = @StoreId and b.ItemId=@ItemId and (b.GrnId is not null or b.GrnId > 0)                           
and b.Quantity<0 and b.ExpiryDate>=@FromDate and b.transactiondate >=@FromDate and b.transactiondate<=@ToDate                          
group by a.drug_pk,a.drugname,c.name)s on Drg.Drug_Pk = s.Drug_Pk                  
Left Outer Join                    
(
select a.Drug_Pk,a.DrugName,c.Name[DispensingUnit], sum(b.Quantity)[AdjustmentQuantity]                         
from mst_drug a Inner join dtl_stocktransaction b on a.Drug_Pk = b.ItemId                        
Left Outer join Mst_DispensingUnit c on a.DispensingUnit = c.Id and b.ItemId=@ItemId                      
where b.storeid = @StoreId and                           
b.ExpiryDate>=@FromDate and b.AdjustId IS NOT NULL and                   
b.transactiondate >=@FromDate and b.transactiondate<@ToDate                        
group by a.drug_pk,a.drugname,c.name
--select a.Drug_Pk,a.DrugName,'' [DispensingUnit], '' [InterStoreIssueQty],sum(b.AdjustmentQuantity)[AdjustmentQuantity]                          
--from mst_drug a Inner join Dtl_AdjustStock b on a.Drug_Pk = b.ItemId                          
--Inner Join Ord_AdjustStock c on b.AdjustId = c.AdjustId                          
--where b.storeid = @StoreId                            
--and b.ExpiryDate>=@FromDate and                    
--c.Adjustmentdate >=@FromDate and c.Adjustmentdate<=@ToDate                          
--group by a.drug_pk,a.drugname,b.AdjustmentQuantity
)t on Drg.Drug_Pk = t.Drug_Pk                       
where (p.OpeningQuantity is not null or Recq.RecQty is not null or r.IssQty is not null                    
or s.InterStoreIssueQty is not null)  
ORDER BY Drg.DrugName     
*/

End
GO


