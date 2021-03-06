/****** Object:  StoredProcedure [dbo].[pr_Admin_SaveDrugGeneric_Constella]    Script Date: 11/29/2015 07:26:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[pr_Admin_SaveDrugGeneric_Constella]    
@GenericName Varchar(50),    
@GenericAbbv Varchar (50),    
@DrugTypeId int,    
@UserId int    
    
as    
    
begin

declare @genericId int;

if (@DrugTypeId=37)
  begin
	if exists(select * from mst_Generic where GenericName =@GenericName OR GenericAbbrevation =@GenericAbbv)    
		begin    
			select 0    
		    return    
		end    
    else    
    begin    
		insert into Mst_Generic(GenericName,GenericAbbrevation,DeleteFlag,UserId,CreateDate)  
		Output Inserted.GenericID, Inserted.GenericName,Inserted.GenericAbbrevation  
		values(@GenericName,NullIf(@GenericAbbv,''),0,@UserId,getdate())    
		Select @genericId = scope_identity();
        --select GenericId,GenericName,GenericAbbrevation from Mst_Generic where GenericId = ident_current('Mst_Generic')    
    end    
    
    insert into lnk_DrugTypeGeneric (DrugTypeId, GenericId,DeleteFlag,UserId,CreateDate)  
	Output Inserted.DrugTypeId  
	values ( @DrugTypeId,@genericId,0,@UserId,getdate()) 
    --values ( @DrugTypeId,ident_current('Mst_Generic'),0,@UserId,getdate())    
     
  --  Select DrugTypeId from lnk_DrugTypeGeneric where GenericId =  ident_current('Mst_Generic')  
  end
else
	begin
	   if exists(select * from mst_Generic where GenericName =@GenericName)    
    	   begin    
		     select 0    
			 return    
		   end    
	   else    
           begin    
              insert into Mst_Generic(GenericName,GenericAbbrevation,DeleteFlag,UserId,CreateDate)    
              	Output Inserted.GenericID, Inserted.GenericName,Inserted.GenericAbbrevation  
				values(@GenericName,NullIf(@GenericAbbv,''),0,@UserId,getdate())    
				Select @genericId = scope_identity();
        --select GenericId,GenericName,GenericAbbrevation from Mst_Generic where GenericId = ident_current('Mst_Generic')     
      
              --select GenericId,GenericName,GenericAbbrevation from Mst_Generic where GenericId = ident_current('Mst_Generic')    
           end    
    
       insert into lnk_DrugTypeGeneric (DrugTypeId, GenericId,DeleteFlag,UserId,CreateDate)   
	   Output Inserted.DrugTypeId   
       values ( @DrugTypeId,@genericId,0,@UserId,getdate()) 
    --values ( @DrugTypeId,ident_current('Mst_Generic'),0,@UserId,getdate())    
     
      -- Select DrugTypeId from lnk_DrugTypeGeneric where GenericId =  ident_current('Mst_Generic')  
    
    end    
end    
  
  select * from mst_generic
