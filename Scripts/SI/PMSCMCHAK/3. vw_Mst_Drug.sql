IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[Mst_Drug]'))
BEGIN
EXEC('ALTER VIEW [dbo].[Mst_Drug]
AS
SELECT        D.Item_PK AS Drug_pk, D.ItemCode AS DrugID, D.ItemTypeID, D.ItemName AS DrugName, D.DeleteFlag, D.CreatedBy AS UserID, D.CreateDate, D.UpdateDate, 
                         D.DispensingMargin, D.DispensingUnitPrice, D.FDACode, D.Manufacturer, D.MaxStock, D.MinStock, D.PurchaseUnitPrice, D.QtyPerPurchaseUnit, 
                         ISNULL(CC.ItemSellingPrice, 0) AS SellingUnitPrice, D.DispensingUnit, D.PurchaseUnit, CC.EffectiveDate, 1 AS Sequence, D.ItemInstructions, D.Abbreviation, 
                         D.QtyUnitDisp, D.syrup, D.MorDose, D.MidDose, D.EvenDose, D.NightDose
FROM            dbo.Mst_ItemMaster AS D INNER JOIN
                         dbo.Mst_ItemType AS I ON I.ItemTypeID = D.ItemTypeID LEFT OUTER JOIN
                             (SELECT DISTINCT ItemId, ItemType, PriceStatus, ItemSellingPrice, EffectiveDate
                               FROM            dbo.lnk_ItemCostConfiguration) AS CC ON CC.ItemId = D.Item_PK AND CC.ItemType = D.ItemTypeID AND CC.PriceStatus = 1
WHERE        (I.ItemName = ''Pharmaceuticals'')
')
END



IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[Mst_Drug]'))
BEGIN
EXEC('CREATE VIEW [dbo].[Mst_Drug]
AS
SELECT        D.Item_PK AS Drug_pk, D.ItemCode AS DrugID, D.ItemTypeID, D.ItemName AS DrugName, D.DeleteFlag, D.CreatedBy AS UserID, D.CreateDate, D.UpdateDate, 
                         D.DispensingMargin, D.DispensingUnitPrice, D.FDACode, D.Manufacturer, D.MaxStock, D.MinStock, D.PurchaseUnitPrice, D.QtyPerPurchaseUnit, 
                         ISNULL(CC.ItemSellingPrice, 0) AS SellingUnitPrice, D.DispensingUnit, D.PurchaseUnit, CC.EffectiveDate, 1 AS Sequence, D.ItemInstructions, D.Abbreviation, 
                         D.QtyUnitDisp, D.syrup, D.MorDose, D.MidDose, D.EvenDose, D.NightDose
FROM            dbo.Mst_ItemMaster AS D INNER JOIN
                         dbo.Mst_ItemType AS I ON I.ItemTypeID = D.ItemTypeID LEFT OUTER JOIN
                             (SELECT DISTINCT ItemId, ItemType, PriceStatus, ItemSellingPrice, EffectiveDate
                               FROM            dbo.lnk_ItemCostConfiguration) AS CC ON CC.ItemId = D.Item_PK AND CC.ItemType = D.ItemTypeID AND CC.PriceStatus = 1
WHERE        (I.ItemName = ''Pharmaceuticals'')
')
END



