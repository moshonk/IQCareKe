IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pr_SCM_GetExistingPharmacyDispense_Futures]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[pr_SCM_GetExistingPharmacyDispense_Futures]
GO

/****** Object:  StoredProcedure [dbo].[pr_SCM_GetExistingPharmacyDispense_Futures]    Script Date: 3/25/2018 3:02:54 PM ******/
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
		And (a.deleteflag Is Null Or a.deleteflag = 0)
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


