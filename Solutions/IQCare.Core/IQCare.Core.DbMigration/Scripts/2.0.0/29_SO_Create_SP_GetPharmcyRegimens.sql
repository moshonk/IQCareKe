IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_getPharmacyRegimens]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_getPharmacyRegimens]
GO

/****** Object:  StoredProcedure [dbo].[sp_getPharmacyRegimens]    Script Date: 1/22/2019 5:10:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		John Macharia
-- Create date: 8th Mar 2017
-- Description:	get pharmacy drug switch, substitution reasons
-- =============================================
CREATE PROCEDURE [dbo].[sp_getPharmacyRegimens]
	-- Add the parameters for the stored procedure here
	@regimenLine varchar(50) = null

AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
Set Nocount On

if(@regimenLine='BaselineART')
BEGIN
  
  
  select v.ItemId as LookupItemId, v.ItemName + '(' + v.displayname + ')' DisplayName 
	from LookupItemView v  WHERE v.MasterName IN ('PaedsThirdlineRegimen','PaedsSecondlineRegimen','PaedsFirstLineRegimen','AdultThirdlineRegimen','AdultSecondlineRegimen','AdultFirstLineRegimen')
	order by OrdRank
END
ELSE
	select LookupItemId, b.name + '(' + b.displayname + ')' DisplayName 
	from LookupMasterItem a inner join lookupitem b on a.lookupitemid = b.id
	where a.LookupMasterId = (select id from lookupmaster where name = @regimenLine)
	order by OrdRank
End





