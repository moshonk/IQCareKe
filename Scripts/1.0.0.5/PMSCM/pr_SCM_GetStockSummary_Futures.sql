
/****** Object:  StoredProcedure [dbo].[pr_SCM_GetStockSummary_Futures]    Script Date: 10/14/2017 10:23:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[pr_SCM_GetStockSummary_Futures]                                                        
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

Where (ls.StoreID = @StoreId)
Group By	ls.StoreID
		,	md.Drug_pk
		,	md.DrugName
Order By md.Drug_pk
--1                                
Select	Drg.Drug_Pk																																			[ItemId]
	,	Drg.DrugName																																		[ItemName]
	,	Unit.Name																																			[DispensingUnit]
	
	, (select sum(quantity) from dtl_stocktransaction where storeid = @StoreId and itemid = Drg.drug_pk and TransactionDate < @FromDate)					[OpeningStock]
	
	, (select sum(quantity) from dtl_stocktransaction where storeid = @StoreId and itemid = Drg.drug_pk and TransactionDate >= @FromDate and TransactionDate <= @ToDate and POid > 0 and quantity > 0) [QtyRecieved]

	, (select abs(sum(quantity)) from dtl_stocktransaction where storeid = @StoreId and itemid = Drg.drug_pk and TransactionDate >= @FromDate and TransactionDate <= @ToDate and quantity < 0 and poid is null and openingstock is null and AdjustId is null) [QtyDispensed]
	
	, (select abs(sum(quantity)) from dtl_stocktransaction where storeid = @StoreId and itemid = Drg.drug_pk and TransactionDate >= @FromDate and TransactionDate <= @ToDate and POid > 0 and quantity < 0) [InterStoreIssueQty]
	
	, (select sum(quantity) from dtl_stocktransaction where storeid = @StoreId and itemid = Drg.drug_pk and transactiondate <= @ToDate) [ClosingQty]
	,	@StoreId																																			[StoreId]
	,	(	Select Top 1 Name		From Mst_Store		Where Id = @StoreId		)	[StoreName]
	, (select sum(quantity) from dtl_stocktransaction where storeid = @StoreId and itemid = Drg.drug_pk and TransactionDate >= @FromDate and TransactionDate <= @ToDate and AdjustId is not null) AdjustmentQuantity
From Mst_Drug Drg
Left Outer Join Mst_DispensingUnit Unit On Drg.DispensingUnit = Unit.Id

where (select sum(quantity) from dtl_stocktransaction where storeid = @StoreId and itemid = Drg.drug_pk and transactiondate <= @ToDate) is not null
and Drg.Drug_Pk in (select itemid from [dbo].[lnk_StoreItem] where storeid=@StoreId)
Order By Drg.DrugName



End

