/****** Object:  StoredProcedure [dbo].[Pr_SCM_SaveStockOrdAdjust_Futures]    Script Date: 11/29/2015 08:11:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[Pr_SCM_SaveStockOrdAdjust_Futures]                                                  
@Updatestock int=NULL,  
@AdjustmentId int=NULL,                      
@AdjustReasonId int=NULL,                      
@LocationId int = NULL,                      
@StoreId int = NULL,                      
@AdjustmentPreparedBy int = NULL,                      
@AdjustmentAuthorisedBy int = NULL,                      
@ItemId int = NULL,                         
@BatchId int = NULL,                  
@ExpiryDate datetime = NULL,               
@PurchaseUnit int = NULL,                      
@AdjustmentQuantity int = NULL,                    
@AdjustmentDate varchar(30) = NULL,                      
@UserId int = NULL                     
as                                                   
BEGIN
                      
                    
if Not Exists (Select AdjustId	From Ord_AdjustStock	Where StoreId = @StoreId	And AdjustmentDate = @AdjustmentDate) 
Begin
	Insert Into Ord_AdjustStock (
		LocationId,
		StoreId,
		AdjustmentDate,
		AdjustmentPreparedBy,
		AdjustmentAuthorisedBy,
		Updatestock)
	Values (
		@LocationId,
		@StoreId,
		Convert(varchar, Getdate(), 106),
		@AdjustmentPreparedBy,
		@AdjustmentAuthorisedBy,
		@Updatestock )
	Select scope_identity() [AdjustId]
End 
Else Begin
	Select AdjustId From Ord_AdjustStock Where StoreId = @StoreId And AdjustmentDate = @AdjustmentDate
End
Update Ord_AdjustStock Set
	LocationId = @LocationId,
	StoreId = @StoreId,
	AdjustmentPreparedBy = @AdjustmentPreparedBy,
	AdjustmentAuthorisedBy = @AdjustmentAuthorisedBy,
	Updatestock = @Updatestock,
	AdjustmentDate = @AdjustmentDate
Where AdjustId = @AdjustmentId;
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
	@Updatestock )

End