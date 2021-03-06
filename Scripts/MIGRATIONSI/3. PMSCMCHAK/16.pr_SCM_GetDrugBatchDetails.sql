IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pr_SCM_GetDrugBatchDetails]') AND type in (N'P', N'PC'))
BEGIN

EXEC ('ALTER proc [dbo].[pr_SCM_GetDrugBatchDetails]
  @Drug_id int
, @StoreID int
as
select a.ID as BatchID, a.ItemID
, a.Name + '' ('' + convert(varchar, dbo.fn_GetItemStock_Futures(a.ItemID, a.Id, a.ExpiryDate, @StoreID)) + '')'' as VarBatchQty
, convert(varchar, a.ExpiryDate, 106) as ExpiryDate,
convert(varchar, dbo.fn_GetItemStock_Futures(a.ItemID, a.Id, a.ExpiryDate, @StoreID)) as BatchQty
,convert(varchar, dbo.fn_GetItemStock_Futures(a.ItemID, a.Id, a.ExpiryDate, @StoreID)) as Quantity
from mst_batch a
where a.ItemID = @Drug_id and dbo.fn_GetItemStock_Futures(a.ItemID, a.Id, a.ExpiryDate, @StoreId) > 0')
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pr_SCM_GetDrugBatchDetails]') AND type in (N'P', N'PC'))
BEGIN

EXEC ('Create proc [dbo].[pr_SCM_GetDrugBatchDetails]
  @Drug_id int
, @StoreID int
as
select a.ID as BatchID, a.ItemID
, a.Name + '' ('' + convert(varchar, dbo.fn_GetItemStock_Futures(a.ItemID, a.Id, a.ExpiryDate, @StoreID)) + '')'' as VarBatchQty
, convert(varchar, a.ExpiryDate, 106) as ExpiryDate,
convert(varchar, dbo.fn_GetItemStock_Futures(a.ItemID, a.Id, a.ExpiryDate, @StoreID)) as BatchQty
,convert(varchar, dbo.fn_GetItemStock_Futures(a.ItemID, a.Id, a.ExpiryDate, @StoreID)) as Quantity
from mst_batch a
where a.ItemID = @Drug_id and dbo.fn_GetItemStock_Futures(a.ItemID, a.Id, a.ExpiryDate, @StoreId) > 0')
END