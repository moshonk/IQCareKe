Set Nocount On
Go
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_GenNewId]'))
DROP VIEW [dbo].[vw_GenNewId]
GO
create view vw_GenNewId as 
select 	Random_String =
	substring(x,(abs(checksum(newid()))%37)+1,1)+
	substring(x,(abs(checksum(newid()))%37)+1,1)+
	substring(x,(abs(checksum(newid()))%37)+1,1)+
	substring(x,(abs(checksum(newid()))%37)+1,1)+	
	substring(x,(abs(checksum(newid()))%37)+1,1)+
	substring(x,(abs(checksum(newid()))%37)+1,1)+
	substring(x,(abs(checksum(newid()))%37)+1,1)+
	substring(x,(abs(checksum(newid()))%37)+1,1)+
	substring(x,(abs(checksum(newid()))%37)+1,1)+
	substring(x,(abs(checksum(newid()))%37)+1,1)+
	substring(x,(abs(checksum(newid()))%37)+1,1)
from   (select x='49ABCFGHIJKDEL5678MNOPQRSTUVWXYZ0123') a
Go
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetLookupValues]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[GetLookupValues]
GO

/****** Object:  UserDefinedFunction [dbo].[GetLookupValues]    Script Date: 6/27/2016 11:18:23 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[GetLookupValues]
(
	-- Add the parameters for the function here
	@CodeID int,
	@TableName varchar(30),
	@SystemId int = 1
)
RETURNS varchar(max)
AS
BEGIN
	-- Declare the return variable here
	Declare @ResultVar as varchar(max)
	Select @ResultVar =  
	Case @TableName
		When 'mst_DeCode'		Then	Stuff( (  Select ';'+ Name From dbo.mst_DeCode t2 Where t2.CodeID=@CodeID And t2.DeleteFlag= 0 order by  t2.SRNo For XML Path('')  ),1,1,'') 
		When 'Mst_PMTCTDeCode'  Then	Stuff( (  Select ';'+ Name From dbo.Mst_PMTCTDeCode t2 Where t2.CodeID=@CodeID And t2.DeleteFlag= 0 order by  t2.SRNo  For XML Path('')  ),1,1,'') 
		When 'Mst_YesNo'		Then    Stuff( (  Select ';'+  Name From dbo.Mst_YesNo t2 Where t2.DeleteFlag= 0 For XML Path('')  ),1,1,'') 
		When 'Mst_ModDeCode'	Then    Stuff( (  Select ';'+ Name From dbo.Mst_ModDeCode t2 Where t2.CodeID=@CodeID And t2.DeleteFlag= 0 order by t2.SRNo  For XML Path('')  ),1,1,'') 
		When 'Mst_BlueDecode'	Then	Stuff( (  Select ';'+ Name From dbo.Mst_BlueDecode t2 Where t2.CodeID=@CodeID And t2.DeleteFlag= 0 order by  t2.SRNo  For XML Path('')  ),1,1,'') 		
		When 'Mst_Employee'	Then	Stuff( (  Select ';'+ t2.FirstName + ' '+ t2.LastName From dbo.mst_Employee t2 Where t2.DeleteFlag= 0 order by  t2.SRNo  For XML Path('')  ),1,1,'') 
		when 'Mst_ARVSideEffects'Then	Stuff( (  Select ';'+ t2.Name From dbo.Mst_ARVSideEffects t2  Where t2.DeleteFlag= 0 order by  t2.SRNo For XML Path('')  ),1,1,'') 
		when 'mst_LostFollowReason'Then	Stuff( (  Select ';'+ t2.Name From dbo.mst_LostFollowReason t2  Where t2.DeleteFlag= 0 order by  t2.SRNo For XML Path('')  ),1,1,'') 
		when 'Mst_HIVDisease'Then	Stuff( (  Select ';'+ t2.Name From dbo.Mst_HIVDisease t2  Where t2.DeleteFlag= 0 order by  t2.SRNo For XML Path('')  ),1,1,'') 
		when 'Mst_Education'Then	Stuff( (  Select ';'+ t2.Name From dbo.Mst_Education t2  Where t2.DeleteFlag= 0 order by  t2.SRNo For XML Path('')  ),1,1,'') 
		when 'Mst_LPTF'Then	Stuff( (  Select ';'+ t2.Name From dbo.Mst_LPTF t2  Where t2.DeleteFlag= 0 order by  t2.SRNo For XML Path('')  ),1,1,'') 
		when 'mst_Symptom'Then	Stuff( (  Select ';'+ t2.Name From dbo.mst_Symptom t2  Where t2.DeleteFlag= 0 order by  t2.SRNo For XML Path('')  ),1,1,'') 
		when 'mst_Reason'Then	Stuff( (  Select ';'+ t2.Name From dbo.mst_Reason t2  Where t2.DeleteFlag= 0 order by  t2.SRNo For XML Path('')  ),1,1,'') 
	End
	Return @ResultVar

End


GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetLookupName]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[GetLookupName]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

Create FUNCTION [dbo].[GetLookupName]
(
	-- Add the parameters for the function here
	@CodeID int,
	@TableName varchar(30)
)
RETURNS varchar(max)
AS
BEGIN
	-- Declare the return variable here
	Declare @ResultVar as varchar(max)
	Select @ResultVar =  
	Case @TableName
		When 'mst_DeCode'			Then	(Select Top 1 Name From mst_Code Where CodeID = @CodeId)
		When 'Mst_PMTCTDeCode'		Then	(Select Top 1 Name From mst_pmtctCode Where CodeID = @CodeId) 
		When 'Mst_ModDeCode'		Then	(Select Top 1 Name From mst_ModCode Where CodeID = @CodeId) 
		When 'Mst_BlueDecode'		Then	(Select Top 1 Name From mst_BlueCode Where CodeID = @CodeId)  
		 
	End
	Return @ResultVar

End

GO
/****** Object:  View [dbo].[vw_Billing_BillTransaction]    Script Date: 09/03/2015 09:13:32 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_Billing_BillTransaction]'))
DROP VIEW [dbo].[vw_Billing_BillTransaction]
GO
/****** Object:  View [dbo].[vw_Billing_CashTransactions]    Script Date: 09/03/2015 09:13:32 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_Billing_CashTransactions]'))
DROP VIEW [dbo].[vw_Billing_CashTransactions]
GO
/****** Object:  View [dbo].[VW_PatientDetail]    Script Date: 07/21/2015 09:36:40 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_PatientDetail]'))
DROP VIEW [dbo].[VW_PatientDetail]
GO

/****** Object:  View [dbo].[Mst_Consumables]    Script Date: 09/03/2015 09:13:32 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[Mst_Consumables]'))
DROP VIEW [dbo].[Mst_Consumables]
GO

/****** Object:  View [dbo].[Mst_ItemType]    Script Date: 09/03/2015 09:13:32 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[Mst_ItemType]'))
DROP VIEW [dbo].[Mst_ItemType]
GO
/****** Object:  View [dbo].[vw_BillPaymentType]    Script Date: 09/03/2015 09:13:32 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_BillPaymentType]'))
DROP VIEW [dbo].[vw_BillPaymentType]
GO
/****** Object:  View [dbo].[vw_AppointmentReasons]    Script Date: 09/17/2015 10:58:41 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_AppointmentReasons]'))
DROP VIEW [dbo].[vw_AppointmentReasons]
GO
/****** Object:  View [dbo].[vw_WaitingQueue]    Script Date: 09/28/2015 08:41:42 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_WaitingQueue]'))
DROP VIEW [dbo].[vw_WaitingQueue]
GO
/****** Object:  View [dbo].[vw_UserList]    Script Date: 03/16/2016 21:12:42 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_UserList]'))
DROP VIEW [dbo].[vw_UserList]
GO
/****** Object:  View [dbo].[vw_LabTestParameterUnits]    Script Date: 03/16/2016 21:12:42 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_LabTestParameterUnits]'))
DROP VIEW [dbo].[vw_LabTestParameterUnits]
GO
/****** Object:  View [dbo].[Laboratory_ViralLoad]    Script Date: 5/9/2017 10:27:05 AM ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[Laboratory_ViralLoad]'))
DROP VIEW [dbo].[Laboratory_ViralLoad]
GO
/****** Object:  View [dbo].[VW_LabTest]    Script Date: 6/10/2016 11:34:13 AM ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_LabTest]'))
DROP VIEW [dbo].[VW_LabTest]
GO

/****** Object:  View [dbo].[VW_PatientLaboratory]    Script Date: 6/10/2016 11:34:23 AM ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_PatientLaboratory]'))
DROP VIEW [dbo].[VW_PatientLaboratory]
GO

/****** Object:  View [dbo].[ord_PatientLabOrder]    Script Date: 03/16/2016 21:12:42 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[ord_PatientLabOrder]'))
DROP VIEW [dbo].[ord_PatientLabOrder]
GO
/****** Object:  View [dbo].[mst_LabTest]    Script Date: 03/16/2016 21:12:42 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[mst_LabTest]'))
DROP VIEW [dbo].[mst_LabTest]
GO
/****** Object:  View [dbo].[lnk_TestParameter]    Script Date: 03/16/2016 21:12:42 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[lnk_TestParameter]'))
DROP VIEW [dbo].[lnk_TestParameter]
GO
/****** Object:  View [dbo].[lnk_parameterresult]    Script Date: 03/16/2016 21:12:42 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[lnk_parameterresult]'))
DROP VIEW [dbo].[lnk_parameterresult]
GO
/****** Object:  View [dbo].[lnk_LabValue]    Script Date: 03/16/2016 21:12:42 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[lnk_LabValue]'))
DROP VIEW [dbo].[lnk_LabValue]
GO
/****** Object:  View [dbo].[dtl_PatientLabResults]    Script Date: 03/16/2016 21:12:42 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[dtl_PatientLabResults]'))
DROP VIEW [dbo].[dtl_PatientLabResults]
GO

IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_BillingPricePlan]'))
DROP VIEW [dbo].[vw_BillingPricePlan]
GO

IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_BillingPricePlan]'))
DROP VIEW [dbo].[facilityStatisticsView]
GO




SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vw_BillingPricePlan]
AS

Select	D.ID Id,
		D.Name ,
		D.SRNo OrdRank,
		D.Code Code,
		D.CodeID CodeId,
		D.DeleteFlag
From mst_Decode D Inner Join mst_Code C On D.CodeID = C.CodeID And C.Name='Billing Price Plans';


GO

IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[FormView]'))
DROP VIEW [dbo].[FormView]
GO
 Create VIEW [dbo].[FormView]
AS 
Select	F.FeatureID		As FeatureId
	,	F.FeatureName
	,	F.ReportFlag
	,	F.DeleteFlag	As FeatureDeleteFlag
	,	F.AdminFlag
	,	Case When F.FeatureID> 1000 Then  F.Published Else 2 End As Published
	,	F.ModuleId
	,	F.MultiVisit
	,	F.RegistrationFormFlag
	,	F.ReferenceID	As ReferenceId
	,	F.CanLink
	,	V.VisitTypeID	As FormId
	,	V.VisitName		As FormName
	,	V.FormDescription
	,	V.Custom
	,	V.CategoryId 
	,	D.Code CategoryName
	,	V.DeleteFlag	As FormDeleteFlag
	,	(Select Count(Distinct GF.GroupID) From lnk_GroupFeatures GF Where GF.FeatureID = F.FeatureId Group BY GF.FeatureID) PermissionCount
From mst_Feature As F
Inner Join mst_VisitType As V On V.FeatureId = F.FeatureID
Left Outer Join( Select D.ID, D.Name, C.CodeID, D.Code From mst_Decode D Inner Join mst_Code C On C.CodeID=D.CodeID And C.Name='Form Category') D On D.ID= V.CategoryId

Go
/****** Object:  View [dbo].[FieldsView]    Script Date: 7/29/2016 6:25:18 AM ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[FieldsView]'))
DROP VIEW [dbo].[FieldsView]
GO

/****** Object:  View [dbo].[FieldsView]    Script Date: 7/29/2016 6:25:18 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[FieldsView]
AS

Select	F.Id												As FieldId
	,	'8888' + convert(varchar, F.Id)						As PaddedFieldId
	,	F.FieldName
	,	F.FieldDesc
	,	dbo.GetLookupValues(F.CategoryId, F.BindTable, 0)	As FieldValue
	,	0													As Predefined
	,	F.CategoryId										As CodeId
	,	nullif(F.BindTable,
		'')													As BindTable
	,	dbo.GetLookupName(F.CategoryId, F.BindTable)		As BindCategory
	,	0													As ModuleId
	,	isnull(F.DeleteFlag, 0)								As FieldDeleteFlag
	,	F.ControlId
	,	C.Name												As ControlName
	,	C.ReferenceId										As ControlReferenceId
	,   C.DataType											As ControlDataType
	,	F.PatientRegistration
	,	F.CareEnd
	,	F.UserId
	,	F.UpdateDate
	,	(select isnull(count(L.FieldId),0) from lnk_conditionalfields L where L.ConfieldId = F.Id and L.Conpredefine =0)[ConditionalField]
From mst_CustomformField As F
Inner Join mst_control As C On C.ControlID = F.ControlId
Union All 
Select	F.Id												As FieldId
	,	'8888' + convert(varchar, F.Id)						As FieldId
	,	F.PDFName											As Fieldname
	,   F.PDFName											As FieldDesc
	,	dbo.GetLookupValues(F.CategoryId, F.BindTable, 0)	As FieldValue
	,	1													As Predefined
	,	F.CategoryId										As CodeId
	,	isnull(F.BindTable, '')								As BindTable
	,	dbo.GetLookupName(F.CategoryId, F.BindTable)		As BindCategory
	,	0													As ModuleId
	,	0													As FieldDeleteFlag
	,	F.ControlId
	,	C.Name												As ControlName
	,	C.ReferenceId										As ControlReferenceId
	,   C.DataType											As ControlDataType
	,	F.PatientRegistration
	,	Null												As CareEnd
	,	F.UserId
	,	F.UpdateDate
	,	(select isnull(count(L.FieldId),0) from Lnk_Conditionalfields L where L.ConfieldId = F.Id and L.Conpredefine =1)[ConditionalField]
From Mst_PreDefinedFields As F
Inner Join mst_control As C On C.ControlID = F.ControlId



GO



 /****** Object:  View [dbo].[FormBusinessRuleView]    Script Date: 7/29/2016 6:20:13 AM ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[FormBusinessRuleView]'))
DROP VIEW [dbo].[FormBusinessRuleView]
GO

/****** Object:  View [dbo].[FormBusinessRuleView]    Script Date: 7/29/2016 6:20:13 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

  

CREATE VIEW [dbo].[FormBusinessRuleView]
As

Select	FB.Id
	,	FB.BusRuleId
	,	R.Name			As BusRuleName
	,	R.DeleteFlag	As BusRuleDeleteFlag
	,	R.ReferenceId	As BusRuleReferenceId
	,	FB.Value MinValue
	,	FB.Value1 MaxValue
	,	FB.SetType
	,	F.FeatureID		As FeatureId
	,	F.FeatureName	As FeatureName
	,	F.ReferenceID	As FormReferenceId
	,	F.FeatureTypeId
	,	D.Code			As FormTypeReferenceId
	,	T.VisitTypeID FormId
	,	T.VisitName	FormName
	,	F.MultiVisit
	,	T.Custom
From lnk_featureBusinessRule As FB
Inner Join mst_Feature As F On F.FeatureID = FB.FeatureId
Inner Join mst_VisitType T On T.FeatureId = F.FeatureID
Inner Join Mst_BusinessRule As R On R.Id = FB.BusRuleId
Inner Join mst_Decode D On D.ID= F.FeatureTypeId

	 


GO




/****** Object:  View [dbo].[FormFieldsView]    Script Date: 6/27/2016 12:22:43 PM ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[FormFieldsView]'))
DROP VIEW [dbo].[FormFieldsView]
GO

/****** Object:  View [dbo].[FormFieldsView]    Script Date: 7/29/2016 6:18:39 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

	   
CREATE VIEW [dbo].[FormFieldsView]
AS
Select	LF.Id
	,	LF.FeatureId
	,	F.FormId
	,	F.FormDescription
	,	F.FeatureName
	,	F.ReferenceID									FeatureReferenceId
	,	F.MultiVisit
	,	LF.SectionId
	,	S.SectionName
	,	S.SectionInfo
	,	S.IsGridView
	,	S.Seq											SectionOrder
	,	LF.FieldId
	,	Case Predefined
			When 1 Then '9999'
			Else '8888'
		End + convert(varchar, FieldId)					PaddedFieldId
	,	replace(LF.FieldLabel, '''', '')				FieldLabel
	,	LF.UserId
	,	LF.CreateDate
	,	LF.UpdateDate
	,	LF.Predefined
	,	lF.Seq											FieldOrder
	,	F.FeatureDeleteFlag								FeatureDeleteFlag
	,	CF.FieldName
	,	CF.FieldDesc
	,	CF.ControlId
	,	C.Name											ControlName
	,	C.ReferenceId									ControlReferenceId
	,	CF.CategoryId
	,	CF.CareEnd
	,	Case
			When LF.Predefined = 0 And isnull(S.IsGridView, 0) = 0 And CF.ControlId Not In (11, 12, 16) Then 'DTL_CUSTOMFIELD'
			When LF.Predefined = 0 And isnull(S.IsGridView, 0) = 1 And CF.ControlId Not In (11, 12, 16) Then 'DTL_CUSTOMFORM'
			Else Null
		End												PDFTableName
	,	CF.BindTable
	,	dbo.GetLookupName(CF.CategoryId, CF.BindTable)	BindCategory
	,	CF.PatientRegistration
	,	CF.DeleteFlag									FieldDeleteFlag
From Lnk_Forms LF
Inner Join FormView F On F.FeatureID = LF.FeatureId
Inner Join mst_CustomformField CF On CF.Id = LF.FieldId
Inner Join mst_Section S On S.SectionID = LF.SectionId And S.FeatureId = LF.FeatureID
Inner Join Mst_Control C On C.ControlID = CF.ControlId
Where LF.Predefined = 0 
Union All 
Select	LF.Id
	,	LF.FeatureId
	,	F.FormId
	,	F.FormDescription
	,	F.FeatureName
	,	F.ReferenceID										FeatureReferenceId
	,	F.MultiVisit
	,	LF.SectionId
	,	S.SectionName
	,	S.SectionInfo
	,	S.IsGridView
	,	S.Seq												SectionOrder
	,	LF.FieldId
	,	Case Predefined
			When 1 Then '9999'
			Else '8888'
		End + convert(varchar, FieldId)						PaddedFieldId
	,	replace(LF.FieldLabel, '''', '')					FieldLabel
	,	LF.UserId
	,	LF.CreateDate
	,	LF.UpdateDate
	,	LF.Predefined
	,	lF.Seq												FieldOrder
	,	F.FeatureDeleteFlag										FeatureDeleteFlag
	,	PF.BindField										FieldName
	,	Null												FieldDesc
	,	PF.ControlId
	,	C.Name											ControlName
	,	C.ReferenceId									ControlReferenceId
	,	PF.CategoryId
	,	Null												CareEnd
	,	upper(PF.PDFTableName)								PDFTableName
	,	PF.BindTable
	,	dbo.GetLookupName(PF.CategoryId, PF.PDFTableName)	BindCategory
	,	PF.PatientRegistration
	,	0													FieldDeleteFlag
From Lnk_Forms LF
Inner Join FormView F On F.FeatureID = LF.FeatureId
Inner Join Mst_PreDefinedFields PF On PF.Id = LF.FieldId 
Inner Join mst_Section S On  S.SectionID = LF.SectionId And S.FeatureId = LF.FeatureID
Inner Join Mst_Control C On C.ControlID = PF.ControlId
Where LF.Predefined = 1 





GO


IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[FieldsBusinessRuleView]'))
DROP VIEW [dbo].[FieldsBusinessRuleView]
GO

/****** Object:  View [dbo].[FieldsBusinessRuleView]    Script Date: 7/29/2016 6:16:17 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[FieldsBusinessRuleView]
AS
	Select	LBR.Id
		,	LBR.FieldId
		,	F.PaddedFieldId
		,	LBR.BusRuleId
		,	BR.Name					As BusRuleName
		,	BR.ReferenceId			As BusRuleReferenceId
		,	BR.DeleteFlag
		,	nullif(LBR.Value, '')	As Value
		,	nullif(LBR.Value1, '')	As Value1
		,	LBR.Predefined
		,	LBR.UserId
		,	LBR.CreateDate
		,	LBR.UpdateDate
		,	F.ControlName
		,	F.FieldName
		,	F.ControlReferenceId
		,	F.ControlId
	From lnk_fieldsBusinessRule As LBR
	Inner Join Mst_BusinessRule As BR On BR.Id = LBR.BusRuleId
	Inner Join FieldsView As F On F.FieldId = LBR.FieldId
	And F.predefined = LBR.Predefined




GO

IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[FormFieldsBusinessRuleView]'))
	DROP VIEW [dbo].[FormFieldsBusinessRuleView]
GO
/****** Object:  View [dbo].[FormFieldsBusinessRuleView]    Script Date: 6/27/2016 11:18:58 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[FormFieldsBusinessRuleView]
AS

		Select	tbl1.PaddedFieldId
				,tbl1.FieldId
				,tbl1.FieldLabel
				,tbl1.FeatureId
				,tbl1.Predefined
				,tbl2.BindField		As FieldName
				,upper(tbl2.PDFTableName)	As TableName
				,tbl2.ControlId
				,Ctrl.ReferenceId CtrlReferenceId
				,Ctrl.Name CtrlName
				,tbl3.TabID TabId
				,tbl3.SectionID
				,LFBR.BusRuleId
				,LFBR.BusRuleName
				,LFBR.BusRuleReferenceId
				,LFBR.DeleteFlag
				,LFBR.Value
				,LFBR.Value1
		From FormFieldsView As tbl1
		Inner Join Mst_PreDefinedFields As tbl2 On tbl1.FieldId = tbl2.Id
		Inner Join mst_control As Ctrl On Ctrl.ControlID = tbl2.ControlId
		Inner Join lnk_FormTabSection As tbl3 On tbl1.FeatureId = tbl3.FeatureID 
		Inner Join FieldsBusinessRuleView As LFBR On tbl1.PaddedFieldId = LFBR.PaddedFieldId
		Where  (tbl1.Predefined = 1)
			And (tbl1.Predefined = LFBR.Predefined )  
			And (tbl3.SectionID = tbl1.SectionId)                                                                                                                                          
		Union                                                                                                                                                      
		Select	tbl1.PaddedFieldId	
				,tbl1.FieldId
				,tbl1.FieldLabel
				,tbl1.FeatureId
				,tbl1.Predefined
				,tbl2.FieldName
				,'DTL_CUSTOMFORM'	As TableName
				,tbl2.ControlId
				,Ctrl.ReferenceId
				,Ctrl.Name CtrlName
				,tbl3.TabID TabId
				,tbl3.SectionID
				,LFBR.BusRuleId
				,LFBR.BusRuleName
				,LFBR.BusRuleReferenceId
				,LFBR.DeleteFlag
				,LFBR.Value
				,LFBR.Value1
		From FormFieldsView As tbl1
		Inner Join mst_CustomformField As tbl2 On tbl1.FieldId = tbl2.Id
		Inner Join mst_control As Ctrl On Ctrl.ControlID = tbl2.ControlId
		Inner Join lnk_FormTabSection As tbl3 On tbl1.FeatureId = tbl3.FeatureID		
		Inner Join FieldsBusinessRuleView As LFBR On tbl1.PaddedFieldId = LFBR.PaddedFieldId		
		Where (tbl1.Predefined = 0)
			And (tbl1.Predefined = LFBR.Predefined)
			And (tbl3.SectionID = tbl1.SectionId)





GO

IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[PatientVisitView]'))
	DROP VIEW [dbo].[PatientVisitView]
GO

 SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


Create VIEW [dbo].[PatientVisitView]
AS
Select	V.Visit_Id		VisitId
	,	VisitName
	,	V.Ptn_Pk		PatientId
	,	V.LocationID	LocationId
	,	V.VisitDate
	,	Isnull(V.DataQuality,0) DataQuality
	,	Isnull(V.Signature,0) [Signature]
	,	V.CreateDate
	,	V.UserID		UserId
	,	Cast(Isnull(V.DeleteFlag,0) as bit) DeleteFlag
From Ord_visit V
Inner Join mst_VisitType T On T.VisitTypeID = V.VisitType
Where V.Ptn_Pk > 0

GO

/****** Object:  View [dbo].[PatientView]    Script Date: 6/9/2016 9:28:17 PM ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[PatientView]'))
	DROP VIEW [dbo].[PatientView]
GO


/****** Object:  View [dbo].[PatientView]    Script Date: 6/9/2016 9:28:17 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[PatientView]
AS
Select	Ptn_Pk
	,	cast(decryptbykey(FirstName) As varchar(50))	As FirstName
	,	cast(decryptbykey(LastName) As varchar(50))		As LastName
	,	cast(decryptbykey(MiddleName) As varchar(50))	As MiddleName
	,	cast(decryptbykey(FirstName) As varchar(50)) + ' '+Isnull(cast(decryptbykey(MiddleName) As varchar(50)) ,'') + cast(decryptbykey(LastName) As varchar(50))		As PatientName
	,	LocationId
	,	IQNumber
	,	RegistrationDate
	,	DOB
	,	Case Sex
			When 16 Then 'Male'
			Else 'Female'
		End												As Sex
	,	DobPrecision
	,	DateOfDeath
	,	MaritalStatus
	,	Sex												As SexId
	,	Nullif(Convert(varchar(100), Decryptbykey([Address])),'') As [Address]
	,	Nullif(Convert(varchar(100), Decryptbykey(Phone)),'') As Phone
	,	PatientFacilityId
	,	UserId
	,	CreateDate
	,	UpdateDate
	,	DeleteFlag
	,	Status
	,	PatientEnrollmentID
From mst_Patient
Where (DeleteFlag = 0 Or DeleteFlag Is Null)
GO


/****** Object:  View [dbo].[vw_BillPaymentType]    Script Date: 09/03/2015 09:13:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_BillPaymentType]'))
EXEC dbo.sp_executesql @statement = N'

CREATE VIEW [dbo].[vw_BillPaymentType]
AS
--Select	D.ID,
--		C.CodeID,
--		D.Name As PaymentName,
--		~Convert(bit, Isnull(D.DeleteFlag, 0)) Active
--From dbo.mst_Decode D
--Inner Join
--	dbo.mst_Code C On D.CodeID = C.CodeID
--Where (C.DeleteFlag = 0)
--And (C.Name = ''PaymentType'');

Select	TypeID ID,
		212 CodeID,
		TypeName PaymentName,
		Active
From Mst_BillPaymentType;
'
GO
/****** Object:  View [dbo].[Mst_ItemType]    Script Date: 09/03/2015 09:13:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[Mst_ItemType]'))
EXEC dbo.sp_executesql @statement = N'/*
 Created By Joseph Njung''e
 Return items types from the mst decode table

*/
CREATE VIEW [dbo].[Mst_ItemType]
AS

Select	ID As ItemTypeID,
		Name As ItemName,
		CreateDate,
		SRNo,
		DeleteFlag
From dbo.mst_Decode
Where CodeID = 202  ;
'
GO
/****** Object:  View [dbo].[vw_Master_ItemList]    Script Date: 09/03/2015 09:13:32 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_Master_ItemList]'))
DROP VIEW [dbo].[vw_Master_ItemList]
GO
/****** Object:  View [dbo].[vw_Master_ItemList]    Script Date: 09/03/2015 09:13:32 ******/
/****** Object:  View [dbo].[vw_Master_ItemList]    Script Date: 03/16/2016 21:12:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



/*
 Created By Joseph Njung'e
 Return ItemList with the latest price and the price date.
*/
CREATE VIEW [dbo].[vw_Master_ItemList]
AS

With Items (ItemID, ItemName,ItemTypeID,ItemTypeName,DeleteFlag)As (
Select	Item_PK [ItemID],
		M.ItemName,
		M.ItemTypeID,
		I.ItemName ItemTypeName,
		M.DeleteFlag
From dbo.Mst_ItemMaster M
Inner Join
	Mst_ItemType I On I.ItemTypeID = M.ItemTypeID
Where I.DeleteFlag = 0
And M.DeleteFlag = 0 
Union All
Select	L.Id ItemID,
		L.Name ItemName,
		I.ItemTypeID,
		I.ItemName ItemTypeName,
		L.DeleteFlag
From mst_LabTestMaster L
Inner Join
	Mst_ItemType I On I.ItemName = 'Lab Tests'
Where I.DeleteFlag = 0
And L.DeleteFlag = 0 
Union All
Select	L.Id ItemID,
		L.Name ItemName,
		I.ItemTypeID,
		I.ItemName ItemTypeName,
		L.DeleteFlag
From Mst_ClinicalService L
Inner Join
	Mst_ItemType I On I.ItemName = 'Clinical Services'
Where I.DeleteFlag = 0
And L.DeleteFlag = 0 
Union All
Select	V.VisitTypeID ItemID,
		V.VisitName ItemName,
		I.ItemTypeID,
		I.ItemName ItemTypeName,
		V.DeleteFlag
From mst_VisitType V
Left Outer Join mst_Feature F On F.FeatureID = V.FeatureId And F.DeleteFlag = 0
Inner Join 
	Mst_ItemType I On I.ItemName = 'VisitType'
Where V.DeleteFlag = 0 
And I.DeleteFlag = 0
Union All
Select	W.WardID ItemID,
		W.WardName ItemName,
		I.ItemTypeID,
		I.ItemName ItemTypeName,
		W.DeleteFlag
From Mst_PatientWard W
Inner Join
	Mst_ItemType I On I.ItemName = 'Ward Admission'
Where I.DeleteFlag = 0
And W.DeleteFlag = 0
)
Select	I.ItemId,
		I.ItemName,
		I.ItemTypeId,
		I.ItemTypeName,
		CC.ItemSellingPrice UnitSellingPrice,
		CC.PriceDate,
		Isnull(CC.PharmacyPriceType,0)PharmacyPriceType, 
		CC.VersionStamp,
		Convert(bit,Isnull(DeleteFlag,0)) DeleteFlag
From Items I
Left Outer Join (
	Select	ItemSellingPrice,
			Max(EffectiveDate) PriceDate,
			ItemType,
			ItemId,
			PriceStatus,
			Max(Convert(bigint,VersionStamp))VersionStamp,
			Isnull(PharmacyPriceType,0) PharmacyPriceType
	From dbo.lnk_ItemCostConfiguration
	Where DeleteFlag = 0
	Group By	ItemSellingPrice,
				ItemType,
				ItemId,
				PriceStatus,
				PharmacyPriceType
	) CC On CC.ItemId = I.ItemID
And CC.ItemType = I.ItemTypeID
And CC.PriceStatus = 1 ;



GO

/****** Object:  View [dbo].[Mst_Consumables]    Script Date: 09/03/2015 09:13:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[Mst_Consumables]'))
EXEC dbo.sp_executesql @statement = N'

/*
 Created By Joseph Njung''e
 Return DrugList from mst_itemmaster
 ItemTypeID 300	 = Pharmaceuticals
*/
CREATE VIEW [dbo].[Mst_Consumables]
AS
Select	D.Item_PK ,
		0 DrugID,
		D.ItemTypeID,
		D.ItemName ,
		D.DeleteFlag,
		D.CreatedBy UserID,
		D.CreateDate CreateDate,
		D.UpdateDate,		
		D.FDACode,
		D.Manufacturer,
		D.MaxStock,
		D.MinStock,
		D.PurchaseUnitPrice,
		D.QtyPerPurchaseUnit,		
		Isnull(CC.ItemSellingPrice,0)SellingUnitPrice,
		D.DispensingUnit,
		D.PurchaseUnit,
		CC.EffectiveDate,
		1 As Sequence
From dbo.Mst_ItemMaster D
Inner Join
	Mst_ItemType I On I.ItemTypeID= D.ItemTypeID
Inner Join  lnk_DrugGeneric DG On d.Item_PK=DG.Drug_pk
Inner Join lnk_DrugTypeGeneric DTG On DTG.GenericId = DG.GenericID
Inner join mst_DrugType DT On DT.DrugTypeID = DTG.DrugTypeId
Left Outer Join
	dbo.lnk_ItemCostConfiguration CC On CC.ItemId = D.Item_PK And CC.ItemType=D.ItemTypeID And CC.PriceStatus = 1
Where I.ItemName=''Pharmaceuticals''  And DT.DrugTypeName In(''Medical supplies'');



'
GO
/****** Object:  View [dbo].[Mst_Drug]    Script Date: 09/03/2015 09:13:32 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[Mst_Drug]'))
DROP VIEW [dbo].[Mst_Drug]
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
 Created By Joseph Njung'e
 Return DrugList from mst_itemmaster
 ItemTypeID 300	 = Drugs
*/
CREATE VIEW [dbo].[Mst_Drug]
AS
Select	D.Item_PK Drug_pk,
		D.ItemCode DrugID,
		D.ItemTypeID,
		D.ItemName DrugName,
		D.DeleteFlag,
		D.CreatedBy UserID,
		D.CreateDate CreateDate,
		D.UpdateDate,
		D.DispensingMargin,
		D.DispensingUnitPrice,
		D.FDACode,
		D.Manufacturer,
		D.MaxStock,
		D.MinStock,
		D.PurchaseUnitPrice,
		D.QtyPerPurchaseUnit,		
		Isnull(CC.ItemSellingPrice,0)SellingUnitPrice,
		D.DispensingUnit,
		D.PurchaseUnit,
		CC.EffectiveDate,
		1 As [Sequence] ,
		D.ItemInstructions,
		D.Abbreviation
From dbo.Mst_ItemMaster D
Inner Join
	Mst_ItemType I On I.ItemTypeID= D.ItemTypeID
Left Outer Join
	(Select Distinct ItemId, ItemType,PriceStatus, ItemSellingPrice,EffectiveDate From dbo.lnk_ItemCostConfiguration) CC On CC.ItemId = D.Item_PK And CC.ItemType=D.ItemTypeID And CC.PriceStatus = 1
Where I.ItemName='Pharmaceuticals';


GO
/****** Object:  View [dbo].[VW_PatientDetail]    Script Date: 07/21/2015 09:36:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_PatientDetail]'))
EXEC dbo.sp_executesql @statement = N'

CREATE VIEW [dbo].[VW_PatientDetail]
AS
SELECT     dbo.mst_Patient.Ptn_Pk, dbo.mst_Patient.LocationID, dbo.mst_Facility.FacilityName AS [Patient Location], dbo.mst_Patient.PatientEnrollmentID, 
                      dbo.mst_Patient.PatientClinicID, dbo.mst_Patient.DOB, dbo.mst_LPTF.Name AS [Transfered From Facility], dbo.mst_Patient.TransferIn AS Transfered, 
                      dbo.mst_Decode.Name AS Gender, DATEDIFF(dd, dbo.mst_Patient.DOB, GETDATE()) / 365 AS Age, dbo.mst_LPTF.ARFunded AS [PEPFAR Funded Site], 
                      dbo.mst_Facility.PepFarStartDate, dbo.Lnk_PatientProgramStart.StartDate AS [Registration Date], dbo.mst_Patient.ARTStartDate, dbo.mst_Patient.Sex, 
                      dbo.mst_Patient.FirstName, dbo.mst_Patient.MiddleName, dbo.mst_Patient.LastName, dbo.mst_Patient.Address, dbo.mst_Patient.Phone, 
                      dbo.mst_Patient.ANCNumber, dbo.mst_Patient.PMTCTNumber, dbo.mst_Patient.AdmissionNumber, dbo.mst_Patient.OutpatientNumber, 
                      dbo.Lnk_PatientProgramStart.ModuleId, dbo.mst_Patient.CountryId, dbo.mst_Patient.PosId, dbo.mst_Patient.SatelliteId, 
                      mst_Facility_1.FacilityID AS [CTC TransferIn FacilityID], mst_Facility_1.FacilityName AS [CTC TransferIn FacilityName], 
                      mst_Facility_1.PepFarStartDate AS [CTC TransferIn FacilityPEPFar Funding], dbo.fn_GetPatientStatus(dbo.mst_Patient.Ptn_Pk, dbo.Lnk_PatientProgramStart.ModuleId) 
                      AS [Patient Status], dbo.mst_Province.Name AS Province, dbo.mst_District.Name AS District, dbo.mst_Division.Name AS Division, dbo.mst_Ward.Name AS Ward, 
                      dbo.mst_Village.Name AS Village, dbo.dtl_PatientHivPrevCareIE.CurrentART AS [Previous ART Regimen], 
                      dbo.dtl_PatientHivPrevCareIE.CurrentARTStartDate AS [Previous ART StartDate], ISNULL(dbo.dtl_PatientHivPrevCareIE.CurrentARTStartDate, 
                      dbo.mst_Patient.ARTStartDate) AS [Track1-ARTStartDate], dbo.fn_GetPatientARTStatus_Futures(dbo.mst_Patient.Ptn_Pk) AS ARTStatus, dbo.mst_Patient.IQNumber, 
                      dbo.mst_Patient.NearestHealthCentre, dbo.mst_Patient.Landmark
FROM         dbo.mst_Patient INNER JOIN
                      dbo.mst_Facility ON dbo.mst_Patient.LocationID = dbo.mst_Facility.FacilityID INNER JOIN
                      dbo.mst_Decode ON dbo.mst_Patient.Sex = dbo.mst_Decode.ID INNER JOIN
                      dbo.Lnk_PatientProgramStart ON dbo.mst_Patient.Ptn_Pk = dbo.Lnk_PatientProgramStart.Ptn_pk LEFT OUTER JOIN
                      dbo.dtl_PatientHivPrevCareIE ON dbo.mst_Patient.Ptn_Pk = dbo.dtl_PatientHivPrevCareIE.Ptn_pk LEFT OUTER JOIN
                      dbo.mst_Ward ON dbo.mst_Patient.Ward = dbo.mst_Ward.Id LEFT OUTER JOIN
                      dbo.mst_Division ON dbo.mst_Patient.Division = dbo.mst_Division.Id LEFT OUTER JOIN
                      dbo.mst_Province ON dbo.mst_Patient.Province = dbo.mst_Province.ID LEFT OUTER JOIN
                      dbo.mst_District ON dbo.mst_Patient.DistrictName = dbo.mst_District.ID LEFT OUTER JOIN
                      dbo.mst_Village ON dbo.mst_Patient.VillageName = dbo.mst_Village.ID LEFT OUTER JOIN
                      dbo.mst_Facility AS mst_Facility_1 ON dbo.mst_Patient.SatelliteId = mst_Facility_1.SatelliteID AND dbo.mst_Patient.PosId = mst_Facility_1.PosID AND 
                      dbo.mst_Patient.CountryId = mst_Facility_1.CountryID LEFT OUTER JOIN
                      dbo.mst_LPTF ON dbo.mst_Patient.LPTFTransferId = dbo.mst_LPTF.ID
WHERE     (dbo.mst_Patient.DeleteFlag = 0) OR
                      (dbo.mst_Patient.DeleteFlag IS NULL)


'
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/*
 Created By Joseph Njung'e
 Return Complete Cash Movement 
*/
CREATE VIEW [dbo].[vw_Billing_CashTransactions]
AS
Select		
		O.TransactionDate,
		O.AmountPayable Amount,
		O.Ptn_PK,
		O.userID CashierUserID,
		O.ReceiptNumber,
		'Cash Payment' As TransactionDescription
From dbo.ord_bill O
Inner Join
			dbo.vw_BillPaymentType PT On PT.ID = O.TransactionType
Where PT.PaymentName = 'Cash' And O.Ptn_PK > 0
Union All
Select B.RefundDate TransactionDate,
		 O.AmountPayable Amount,
		O.Ptn_PK,
		B.RefundBy CashierUserID,
		B.ReversalReference ReceiptNumber,
		'Cash Refund' As TransactionDescription
From dbo.ord_Bill_Reversals B 
Inner Join 
	dbo.ord_bill O On O.TransactionID = B.TransactionID 
And B.Refunded = 1 And B.RefundType='Cash' And O.Ptn_PK > 0
Union All
Select D.TransactionDate,
	Case D.TransactionType When 'Debit' Then  D.Amount Else D.Amount End Amount,
	D.Ptn_PK,
	D.UserID CashierUserID,
	D.ReferenceNumber,
	Case D.TransactionDescription When 'Deposit' Then 'Cash Deposit' Else 'Deposit Refund' End TransactionDescription
From dbo.dtl_BillDepositTransaction D 
Where D.TransactionDescription In ('Deposit','Refund') And D.DepositType='Cash' And D.Ptn_PK > 0;

GO

/****** Object:  View [dbo].[vw_Billing_BillTransaction]    Script Date: 09/03/2015 09:13:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_Billing_BillTransaction]'))
EXEC dbo.sp_executesql @statement = N'



/*
 Created By Joseph Njung''e
 Return Complete bill transaction 
*/
CREATE VIEW [dbo].[vw_Billing_BillTransaction]
AS
Select	T.TransactionID,
		T.Ptn_PK,
		T.BillID,	
		B.LocationID,	
		B.BillNumber,
		B.BillAmount,
		B.BillDate,
		T.TransactionDate,
		T.TransactionType,
		PT.PaymentName,
		T.RefNumber,
		T.Amount,
		T.AmountPayable,
		T.TenderedAmount,
		T.userID TransactedBy,
		T.ReceiptNumber,
		T.TransactionStatus,
		T.Reversed,
		Convert(bit,Case 
			When T.Reversed = 1 Or R.TransactionReversalID Is Not Null Then 0 
			Else
				 Case  When PT.PaymentName In(''Cash'',''Deposit'') Then 1  Else 0 End
			End)		Reversible,
		R.TransactionReversalID,
		R.RequestDate,
		R.UserID As RequestedBy,
		R.ReversalReason,
		R.ApprovalNotes,
		R.ApprovalDate,
		R.ApprovalStatus,
		R.ApprovedBy,
		R.ReversalReference,
		Convert(bit,Case 
			When R.Refunded = 1  Then 0 
			Else
				 Case  When PT.PaymentName In(''Cash'',''Deposit'') And T.Reversed = 1 Then 1  Else 0 End
			End)		Refundable,
		Isnull(R.Refunded,0) Refunded,
		R.RefundDate,
		R.RefundBy,
		R.RefundType
From dbo.ord_bill As T
Inner Join
	dbo.mst_Bill B On B.BillID=T.BillID
Inner Join
			dbo.vw_BillPaymentType PT On PT.ID = T.TransactionType
Left Outer Join
	dbo.ord_Bill_Reversals As R On R.TransactionID = T.TransactionID
Where  T.Ptn_PK > 0;



'
GO


/****** Object:  View [dbo].[vw_AppointmentReasons]    Script Date: 03/16/2016 21:12:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
 Created By Joseph Njung'e
 Return items types from the mst decode table

*/
CREATE VIEW [dbo].[vw_AppointmentReasons]
AS

SELECT        Name, ID, DeleteFlag
FROM            mst_Decode
WHERE        (CodeID = 26) AND (DeleteFlag = 0)
--Union
--SELECT        Name AS name, ID AS id, DeleteFlag AS DeleteFlag
--FROM            mst_ModDeCode
--WHERE        (CodeID = 321) AND (DeleteFlag = 0)
--Union 
--SELECT        ModuleName AS name, ModuleID AS id, DeleteFlag AS DeleteFlag
--FROM            mst_module
--WHERE        (DeleteFlag = 0) AND (ModuleID NOT IN (2, 3, 201, 202, 203, 19));


GO

/****** Object:  View [dbo].[vw_UserList]    Script Date: 03/16/2016 21:12:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_UserList]
AS
SELECT        U.UserID AS UserId, U.UserName AS SystemUserName, U.UserFirstName + ' ' + U.UserLastName AS Name, E.FirstName + ' ' + E.LastName AS EmployeeName, ISNULL(U.DeleteFlag, 0) AS UserDeleteFlag, 
                         E.EmployeeID AS EmployeeId, E.DesignationID AS DesignationId,
                             (SELECT        TOP (1) Name
                               FROM            dbo.mst_Designation AS D
                               WHERE        (Id = E.DesignationID)) AS Designation, ISNULL(E.DeleteFlag, 0) AS EmployeeDeleteFlag
FROM            dbo.mst_User AS U LEFT OUTER JOIN
                         dbo.mst_Employee AS E ON U.EmployeeId = E.EmployeeID

GO
/****** Object:  View [dbo].[vw_WaitingQueue]    Script Date: 03/16/2016 21:12:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[vw_WaitingQueue]
AS
Select	D.ID QueueId,
		C.CodeID,
		D.Name As QueueName
From dbo.mst_Decode D
Inner Join
	dbo.mst_Code C On D.CodeID = C.CodeID
Where (C.DeleteFlag = 0)
And (C.Name = 'Waiting List');


GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[vw_LabTestParameterUnits]
AS
SELECT        ID UnitId, Name UnitName, DeleteFlag
FROM            dbo.mst_Decode
WHERE        (CodeID = 30)



GO

IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_ModuleIdentifiers]'))
DROP VIEW [dbo].[VW_ModuleIdentifiers]
GO
CREATE VIEW [dbo].[VW_ModuleIdentifiers]
AS
SELECT     mm.ModuleID, mm.ModuleName,mm.DisplayName, mm.CanEnroll, mpi.ID AS FieldId, mpi.FieldName, mpi.FieldType, mpi.Label AS FieldLabel, mpi.AutoPopulateNumber
FROM         dbo.mst_module AS mm INNER JOIN
                      dbo.lnk_PatientModuleIdentifier AS mi ON mm.ModuleID = mi.ModuleID INNER JOIN
                      dbo.mst_PatientIdentifier AS mpi ON mpi.ID = mi.FieldID
WHERE     (mm.DeleteFlag = 0) OR
                      (mm.DeleteFlag IS NULL)



GO
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_PatientPharmacy]'))
DROP VIEW [dbo].[VW_PatientPharmacy]
Go
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_PatientPharmacy]
AS
SELECT        dbo.ord_PatientPharmacyOrder.Ptn_pk, dbo.ord_PatientPharmacyOrder.VisitID, dbo.ord_PatientPharmacyOrder.LocationID, 
                         dbo.ord_PatientPharmacyOrder.OrderedBy, dbo.ord_PatientPharmacyOrder.OrderedByDate, dbo.ord_PatientPharmacyOrder.DispensedBy, 
                         dbo.ord_PatientPharmacyOrder.DispensedByDate, dbo.ord_PatientPharmacyOrder.ProgID, dbo.ord_PatientPharmacyOrder.OrderType, 
                         dbo.ord_PatientPharmacyOrder.Height, dbo.ord_PatientPharmacyOrder.Weight, dbo.ord_PatientPharmacyOrder.ProviderID, 
                         dbo.ord_PatientPharmacyOrder.PharmacyPeriodTaken, dbo.VW_Drug.Drug_pk, dbo.VW_Drug.DrugName, dbo.dtl_RegimenMap.RegimenType, 
                         dbo.dtl_RegimenMap.RegimenId, dbo.dtl_PatientPharmacyOrder.Duration, dbo.dtl_PatientPharmacyOrder.OrderedQuantity, 
                         dbo.dtl_PatientPharmacyOrder.DispensedQuantity, dbo.dtl_PatientPharmacyOrder.Prophylaxis, dbo.ord_Visit.VisitDate, dbo.ord_Visit.VisitType, 
                         dbo.ord_PatientPharmacyOrder.ptn_pharmacy_pk, dbo.VW_Drug.DrugTypeId, dbo.VW_Drug.DrugTypeName AS DrugType, Stock.Quantity AS ActualQtyDispensed, 
                         Stock.ExpiryDate, dbo.Mst_Store.Id AS StoreId, dbo.Mst_Store.Name AS StoreName, dbo.Mst_Batch.ID AS BatchId, dbo.Mst_Batch.Name AS BatchNo, 
                         ISNULL(Bill.SellingPrice, 0) AS SellingPrice, ISNULL(Bill.CostPrice, 0) AS CostPrice, Bill.Margin, Bill.BillAmount, dbo.VW_Drug.[Item Code], dbo.VW_Drug.[FDA Code], 
                         dbo.VW_Drug.[Dispensing Unit], dbo.VW_Drug.[Dispensing Unit Id], dbo.VW_Drug.MaxStock, dbo.VW_Drug.MinStock, dbo.VW_Drug.PurchaseUnitId, 
                         dbo.VW_Drug.[Purchase Unit], dbo.dtl_PatientPharmacyOrder.FrequencyID, dbo.dtl_PatientPharmacyOrder.TreatmentPhase, 
                         dbo.dtl_PatientPharmacyOrder.WhyPartial, dbo.dtl_PatientPharmacyOrder.Month, dbo.ord_PatientPharmacyOrder.HoldMedicine, 
                         dbo.ord_PatientPharmacyOrder.RegimenLine, dbo.ord_PatientPharmacyOrder.PharmacyNotes, dbo.dtl_PatientPharmacyOrder.StrengthID, 
                         dbo.ord_PatientPharmacyOrder.CreateDate, dbo.ord_PatientPharmacyOrder.EmployeeID, dbo.ord_PatientPharmacyOrder.Signature, dbo.mst_Strength.StrengthName,
                          dbo.mst_Frequency.Name AS FrequencyName, dbo.VW_Drug.[Selling Price] AS UnitSellingPrice, dbo.VW_Drug.GenericID, dbo.VW_Drug.GenericName, 
                         dbo.dtl_PatientPharmacyOrder.SingleDose, dbo.dtl_PatientPharmacyOrder.Financed, dbo.dtl_PatientPharmacyOrder.PrintPrescriptionStatus, 
                         dbo.dtl_PatientPharmacyOrder.PatientInstructions, dbo.ord_PatientPharmacyOrder.ReportingID, dbo.dtl_PatientPharmacyOrder.pillCount, 
                         dbo.mst_Frequency.multiplier AS FreqMultiplier
FROM            dbo.dtl_RegimenMap RIGHT OUTER JOIN
                         dbo.mst_Strength RIGHT OUTER JOIN
                         dbo.mst_Frequency RIGHT OUTER JOIN
                         dbo.ord_PatientPharmacyOrder INNER JOIN
                         dbo.ord_Visit ON dbo.ord_PatientPharmacyOrder.VisitID = dbo.ord_Visit.Visit_Id INNER JOIN
                         dbo.dtl_PatientPharmacyOrder ON dbo.ord_PatientPharmacyOrder.ptn_pharmacy_pk = dbo.dtl_PatientPharmacyOrder.ptn_pharmacy_pk ON 
                         dbo.mst_Frequency.ID = dbo.dtl_PatientPharmacyOrder.FrequencyID ON dbo.mst_Strength.StrengthId = dbo.dtl_PatientPharmacyOrder.StrengthID LEFT OUTER JOIN
                         dbo.VW_Drug ON dbo.dtl_PatientPharmacyOrder.Drug_Pk = dbo.VW_Drug.Drug_pk ON 
                         dbo.dtl_RegimenMap.OrderID = dbo.ord_PatientPharmacyOrder.ptn_pharmacy_pk LEFT OUTER JOIN
                             (SELECT        Ptn_Pharmacy_Pk, ItemId, BatchId, ExpiryDate, StoreId, SUM(Quantity) AS Quantity
                               FROM            dbo.Dtl_StockTransaction
                               WHERE        (Ptn_Pharmacy_Pk IS NOT NULL)
                               GROUP BY Ptn_Pharmacy_Pk, ItemId, BatchId, ExpiryDate, StoreId) AS Stock ON dbo.dtl_PatientPharmacyOrder.ptn_pharmacy_pk = Stock.Ptn_Pharmacy_Pk AND 
                         dbo.dtl_PatientPharmacyOrder.Drug_Pk = Stock.ItemId AND dbo.dtl_PatientPharmacyOrder.BatchNo = Stock.BatchId AND 
                         dbo.dtl_PatientPharmacyOrder.ExpiryDate = Stock.ExpiryDate LEFT OUTER JOIN
                         dbo.Mst_Store ON dbo.Mst_Store.Id = Stock.StoreId LEFT OUTER JOIN
                         dbo.Mst_Batch ON dbo.Mst_Batch.ID = Stock.BatchId LEFT OUTER JOIN
                             (SELECT        PharmacyId, ItemId, BatchId, VisitId, SUM(SellingPrice) AS SellingPrice, CostPrice, Margin, SUM(BillAmount) AS BillAmount
                               FROM            dbo.Dtl_PatientBillTransaction
                               GROUP BY PharmacyId, ItemId, BatchId, VisitId, CostPrice, Margin) AS Bill ON dbo.dtl_PatientPharmacyOrder.ptn_pharmacy_pk = Bill.PharmacyId AND 
                         dbo.dtl_PatientPharmacyOrder.Drug_Pk = Bill.ItemId AND dbo.dtl_PatientPharmacyOrder.BatchNo = Bill.BatchId AND 
                         dbo.ord_PatientPharmacyOrder.VisitID = Bill.VisitId
WHERE        (dbo.ord_Visit.DeleteFlag = 0) OR
                         (dbo.ord_Visit.DeleteFlag IS NULL)

GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[dtl_PatientLabResults]
AS
Select	lr.LabOrderId As 'LabID',
		lo.LocationId,
		lr.LabTestId,
		lr.ParameterId,
		lr.ResultValue As 'TestResults',
		lr.ResultText As 'TestResults1',
		lr.ResultOptionId As 'TestResultId',
		1 As 'Financed',
		lr.ResultUnitId As 'Units',
		lr.UserId,
		lr.CreateDate,
		lo.UpdateDate,
		Null As 'TabId',
		d.TestNotes As 'RequestNotes',
		D.ResultNotes,
		D.ResultBy,
		D.ResultDate
From dbo.dtl_LabOrderTestResult As lr
Inner Join dbo.ord_LabOrder As lo On lr.LabOrderId = lo.Id
Inner Join dbo.dtl_LabOrderTest As d On lr.LabOrderTestId = d.Id


GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[lnk_LabValue]
AS
Select	Id
		,ParameterId	As 'SubTestID'
		,MinBoundary	As 'MinBoundaryValue'
		,MaxBoundary	As 'MaxBoundaryValue'
		,MinNormalRange
		,MaxNormalRange
		,Null			As 'TextNormalRange'
		,1				As 'UserID'
		,Null			
		As 'CreateDate'
		,Null			As 'UpdateDate'
		,DefaultUnit
		,UnitId
		,DeleteFlag
From dbo.dtl_LabTestParameterConfig



GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[lnk_parameterresult]
AS
Select	Id As 'ResultID',
		ParameterId,
		Value As 'Result',
		1 As 'UserID',
		Null As 'CreateDate',
		Null As 'UpdateDate',
		DeleteFlag
From dbo.dtl_LabTestParameterResultOption


GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[lnk_TestParameter]
AS
Select	Id As 'SubTestID',
		ParameterName As 'SubTestName',
		LabTestId As 'TestID',
		0 As 'ControlID',
		0 As 'SerialNumber',
		DeleteFlag,
		UserId,
		CreateDate,
		UpdateDate,
		Null As 'LoincCode',
		Null
		As 'Sequence'
From dbo.Mst_LabTestParameter


GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[mst_LabTest]
AS
Select	Id As LabTestID,
		Name As LabName,
		DepartmentId As LabDepartmentID,
		1 As LabTypeID,
		1 As Sequence,
		ltm.DeleteFlag,
		ltm.Active,
		1 As UserID,
		ltm.CreateDate,
		null UpdateDate,
		ltm.IsGroup,
		'Text' DataType
From dbo.mst_LabTestMaster ltm



GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[ord_PatientLabOrder]
AS
Select	Id As LabID,
		Null As OldLabID,
		Ptn_Pk,
		LocationId,
		OrderedBy As OrderedbyName,
		OrderDate As OrderedbyDate,
		(
			Select Top (1)
				ResultBy
			From dbo.dtl_LabOrderTest
			Where (LabOrderId = lo.Id) And ResultBy Is Not Null
		)
		As ReportedbyName,
		(
			Select Top (1)
				ResultDate
			From dbo.dtl_LabOrderTest As R
			Where (LabOrderId = lo.Id) And R.ResultDate Is Not Null
		)
		As ReportedbyDate,
		Null As CheckedbyName,
		Null As CheckedbyDate,
		PreClinicLabDate,
		DeleteFlag,
		UserId,
		CreateDate,
		UpdateDate,
		VisitId,
		Null As LabPeriod,
		OrderNumber As LabNumber
From dbo.ord_LabOrder As lo

GO
CREATE VIEW [dbo].[Laboratory_ViralLoad]
AS
SELECT        labTrac.Id, labTrac.patientId, PatientLabTracker_1.ResultValues, PatientLabTracker_1.FacilityId
FROM            (SELECT        MAX(Id) AS Id, patientId
                          FROM            dbo.PatientLabTracker
                          GROUP BY patientId, LabTestId
                          HAVING         (LabTestId = 3)) AS labTrac INNER JOIN
                         dbo.PatientLabTracker AS PatientLabTracker_1 ON labTrac.Id = PatientLabTracker_1.Id
                        WHERE        (PatientLabTracker_1.Results = 'Complete')
GO

/****** Object:  View [dbo].[VW_LabTest]    Script Date: 6/10/2016 11:34:13 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[VW_LabTest]
AS
	--SELECT     dbo.lnk_TestParameter.SubTestID AS TestID, dbo.lnk_TestParameter.SubTestName AS TestName, dbo.mst_LabTest.LabTestID AS [Test GroupId], 
	--                      dbo.mst_LabTest.LabName AS [Test GroupName], dbo.mst_LabDepartment.LabDepartmentID, dbo.mst_LabDepartment.LabDepartmentName, 
	--                      dbo.mst_LabType.LabTypeID, dbo.mst_LabType.LabTypeName
	--FROM         dbo.mst_LabTest INNER JOIN
	--                      dbo.lnk_TestParameter ON dbo.mst_LabTest.LabTestID = dbo.lnk_TestParameter.TestID LEFT OUTER JOIN
	--                      dbo.mst_LabType ON dbo.mst_LabTest.LabTypeID = dbo.mst_LabType.LabTypeID LEFT OUTER JOIN
	--                      dbo.mst_LabDepartment ON dbo.mst_LabTest.LabDepartmentID = dbo.mst_LabDepartment.LabDepartmentID

	Select	P.Id	ParameterId
			,P.ParameterName
			,P.ReferenceId ParameterReferenceId
			,T.Id	LabTestId
			,T.Name	LabTestName
			,T.ReferenceId TestReferenceId
			,T.IsGroup
			,T.DepartmentId
			,D.LabDepartmentName
			, T.DeleteFlag TestDeleteFlag
			,T.Active TestActive
			,P.DeleteFlag ParameterDeleteFlag
	From mst_LabTestMaster T
	Inner Join Mst_LabTestParameter P On T.Id = P.LabTestId
	Left Outer Join mst_LabDepartment D On T.DepartmentId = D.LabDepartmentID


GO

/****** Object:  View [dbo].[VW_PatientLaboratory]    Script Date: 6/10/2016 11:34:23 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[VW_PatientLaboratory]
AS
--SELECT     dbo.ord_PatientLabOrder.LabID, dbo.ord_PatientLabOrder.Ptn_pk, dbo.ord_PatientLabOrder.LocationID, dbo.ord_PatientLabOrder.OrderedbyName, 
--                      dbo.ord_PatientLabOrder.OrderedbyDate, dbo.ord_PatientLabOrder.ReportedbyName, dbo.ord_PatientLabOrder.ReportedbyDate, 
--                      dbo.ord_PatientLabOrder.CheckedbyName, dbo.ord_PatientLabOrder.CheckedbyDate, dbo.ord_PatientLabOrder.PreClinicLabDate, dbo.VW_LabTest.TestName, 
--                      dbo.VW_LabTest.TestID, dbo.VW_LabTest.[Test GroupId], dbo.VW_LabTest.[Test GroupName], dbo.VW_LabTest.LabDepartmentID, 
--                      dbo.VW_LabTest.LabDepartmentName, dbo.VW_LabTest.LabTypeID, dbo.VW_LabTest.LabTypeName, dbo.dtl_PatientLabResults.TestResults, 
--                      dbo.dtl_PatientLabResults.TestResults1, dbo.dtl_PatientLabResults.TestResultId, dbo.lnk_parameterresult.Result AS [Parameter Result], dbo.ord_Visit.VisitDate, 
--                      dbo.ord_PatientLabOrder.LabPeriod
--FROM         dbo.ord_PatientLabOrder INNER JOIN
--                      dbo.dtl_PatientLabResults ON dbo.ord_PatientLabOrder.LabID = dbo.dtl_PatientLabResults.LabID INNER JOIN
--                      dbo.VW_LabTest ON dbo.dtl_PatientLabResults.ParameterID = dbo.VW_LabTest.TestID INNER JOIN
--                      dbo.ord_Visit ON dbo.ord_PatientLabOrder.VisitId = dbo.ord_Visit.Visit_Id LEFT OUTER JOIN
--                      dbo.lnk_parameterresult ON dbo.dtl_PatientLabResults.TestResultId = dbo.lnk_parameterresult.ResultID
--WHERE     (dbo.ord_Visit.DeleteFlag = 0) OR
--                      (dbo.ord_Visit.DeleteFlag IS NULL)

	Select	O.Id				LabId
		,o.Ptn_Pk
		,O.LocationId
		,O.OrderedBy		OrderedByName
		,O.OrderNumber
		,o.OrderDate		OrderedByDate
		,Ot.ResultBy		ReportedByName
		,OT.ResultDate		ReportedByDate
		,O.OrderedBy		CheckedbyName
		,o.OrderDate		CheckedbyDate
		,O.PreClinicLabDate
		,LT.ParameterName	TestName
		,LT.ParameterId		TestId
		,LT.LabTestId		[Test GroupId]
		,lt.LabTestName		[Test GroupName]
		,LT.DepartmentId	LabDepartmentId
		,LT.LabDepartmentName
		,0					LabTypeId
		,'Additional Lab'	LabTypeName
		,R.ResultValue		TestResults
		,R.ResultText		TestResults1
		,R.ResultOptionId	 TestResultId
		,R.ResultOption		[Parameter Result]
		,R.Undetectable
		,R.DetectionLimit
		,R.ResultUnit
		,R.HasResult
		,V.VisitDate
		,Null				LabPeriod
		,LT.TestReferenceId
		,LT.ParameterReferenceId		
	From dbo.ord_LabOrder O
	Inner Join dtl_LabOrderTest OT On OT.LabOrderId = O.Id
	Inner Join dtl_LabOrderTestResult R On R.LabOrderTestId = OT.Id
	Inner Join VW_LabTest LT On LT.ParameterId = R.ParameterId
	Inner Join ord_Visit V On v.Visit_Id = O.VisitId
	Where (V.DeleteFlag = 0)	Or (V.DeleteFlag IS NULL)


GO


/****** Object:  View [dbo].[ServiceAreaBusinessRuleView]    Script Date: 7/29/2016 6:21:45 AM ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[ServiceAreaBusinessRuleView]'))
DROP VIEW [dbo].[ServiceAreaBusinessRuleView]
GO

/****** Object:  View [dbo].[ServiceAreaBusinessRuleView]    Script Date: 7/29/2016 6:21:45 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[ServiceAreaBusinessRuleView]
AS
Select	SR.Id
	,	SR.BusRuleId
	,	R.Name			As BusRuleName
	,	R.DeleteFlag	As BusRuleDeleteFlag
	,	R.ReferenceId	As BusRuleReferenceId
	,	SR.Value
	,	SR.Value1
	,	SR.SetType
	,	M.ModuleId		As ModuleId
	,	M.ModuleName	
	,	M.DisplayName	
	,	M.CanEnroll	
From lnk_ServiceBusinessRule As SR
Inner Join mst_module As M On M.ModuleId = SR.ModuleId
Inner Join Mst_BusinessRule As R On R.Id = SR.BusRuleId


GO

/****** Object:  View [dbo].[LookupView]    Script Date: 7/29/2016 6:23:27 AM ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[LookupView]'))
DROP VIEW [dbo].[LookupView]
GO

/****** Object:  View [dbo].[LookupView]    Script Date: 7/29/2016 6:23:27 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[LookupView]
AS
	Select	Id
		,	D.Name
		,	D.CodeID					LookupId
		,	C.Name						LookupName
		,	convert(bit, D.DeleteFlag)	Deleted
		,	'MST_DECODE'				Category
		,	D.SRNo						OrdRank
	From mst_Decode D
	Inner Join Mst_Code C On C.CodeID = D.CodeID
	Where D.SystemId In (0 , 1)
	Union All
	Select	Id
		,	D.Name
		,	D.CodeID					LookupId
		,	C.Name						LookupName
		,	convert(bit, D.DeleteFlag)	Deleted
		,	'MST_MODDECODE'				Category
		,	D.SRNo						OrdRank
	From mst_ModDecode D
	Inner Join Mst_ModCode C On C.CodeID = D.CodeID
	Where D.SystemId In (0 , 1)
	Union All
	Select	Id
		,	D.Name
		,	D.CodeID					LookupId
		,	C.Name						LookupName
		,	convert(bit, D.DeleteFlag)	Deleted
		,	'MST_BLUEDECODE'			Category
		,	D.SRNo						OrdRank
	From mst_BlueDecode D
	Inner Join Mst_BlueCode C On C.CodeID = D.CodeID
	Where D.SystemId In (0 , 1)
	Union All
	Select	Id
		,	D.Name
		,	D.CodeID					LookupId
		,	C.Name						LookupName
		,	convert(bit, D.DeleteFlag)	Deleted
		,	'PMTCTDECODE'				Category
		,	D.SRNo						OrdRank
	From mst_pmtctDeCode D
	Inner Join mst_pmtctCode C On C.CodeID = D.CodeID
	Where D.SystemId In (0 , 1)


GO
/****** Object:  View [dbo].[VW_FieldConditionalField]    Script Date: 7/29/2016 6:29:51 AM ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_FieldConditionalField]'))
DROP VIEW [dbo].[VW_FieldConditionalField]
GO

/****** Object:  View [dbo].[VW_FieldConditionalField]    Script Date: 7/29/2016 6:29:51 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[VW_FieldConditionalField]
AS
SELECT     Lnk_Forms.FieldId, Lnk_Forms.FieldLabel, dbo.Lnk_Conditionalfields.FieldId AS ConditionalFieldId, dbo.Lnk_Conditionalfields.FieldLabel AS ConditionalFieldLabel, 
                      CASE Lnk_Forms.Predefined WHEN 1 THEN Mst_PredefinedFields_1.PdfName WHEN 0 THEN Mst_CustomFormField_1.FieldName END AS FieldName, 
                      CASE Lnk_Forms.Predefined WHEN 1 THEN Mst_PredefinedFields_1.PdfTableName WHEN 0 THEN 'dt_CustomField' END AS FieldSavingTable, 
                      CASE dbo.Lnk_ConditionalFields.Predefined WHEN 1 THEN dbo.Mst_PredefinedFields.PdfName WHEN 0 THEN dbo.Mst_CustomFormField.FieldName END AS ConditionalFieldName,
                      CASE dbo.Lnk_ConditionalFields.Predefined WHEN 1 THEN dbo.Mst_PredefinedFields.PdfTableName WHEN 0 THEN 'dtl_CustomField' END AS ConditionalFieldSavingTable,
                      CASE Lnk_Forms.Predefined WHEN 1 THEN Mst_PredefinedFields_1.ControlId WHEN 0 THEN Mst_CustomFormField_1.ControlId END AS FieldControlId, 
                      CASE Lnk_Forms.Predefined WHEN 1 THEN Mst_PredefinedFields_1.BindTable WHEN 0 THEN 'Mst_ModDecode' END AS FieldBindTable, 
                      CASE Lnk_Forms.Predefined WHEN 1 THEN Mst_PredefinedFields_1.ModuleId WHEN 0 THEN 0 END AS FieldModuleId, 
                      CASE Lnk_Forms.Predefined WHEN 1 THEN Mst_PredefinedFields_1.CategoryId WHEN 0 THEN 0 END AS FieldCategoryId, 
                      CASE Lnk_Forms.Predefined WHEN 1 THEN Mst_PredefinedFields_1.BindField WHEN 0 THEN '' END AS FieldBindField, 
                      CASE dbo.Lnk_ConditionalFields.Predefined WHEN 1 THEN dbo.Mst_PredefinedFields.ControlId WHEN 0 THEN dbo.Mst_CustomFormField.ControlId END AS ConditionalFieldControlId,
                      CASE dbo.Lnk_ConditionalFields.Predefined WHEN 1 THEN dbo.Mst_PredefinedFields.BindTable WHEN 0 THEN dbo.Mst_CustomFormField.BindTable END AS ConditionalFieldBindTable,
                      CASE dbo.Lnk_ConditionalFields.Predefined WHEN 1 THEN dbo.Mst_PredefinedFields.ModuleId  WHEN 0 THEN 0 END AS ConditionalFieldModuleId, 
                      CASE dbo.Lnk_ConditionalFields.Predefined WHEN 1 THEN dbo.Mst_PredefinedFields.CategoryId WHEN 0 THEN dbo.Mst_CustomFormField.CategoryId END AS ConditionalFieldCategoryId,
                      CASE dbo.Lnk_ConditionalFields.Predefined WHEN 1 THEN dbo.Mst_PredefinedFields.BindField WHEN 0 THEN '' END AS ConditionalFieldBindField, 
                      Lnk_Forms.FeatureId, dbo.mst_Section.SectionID AS FieldSectionId, dbo.mst_Section.SectionName AS FieldSectionName, 
                      dbo.Lnk_Conditionalfields.SectionId AS ConditionalFieldSectionId, Lnk_Forms.Predefined AS FieldPredefined, 
                      dbo.Lnk_Conditionalfields.Predefined AS ConditionalFieldPredefined, dbo.mst_Section.Seq AS FieldSectionSequence, 
                      dbo.Lnk_Conditionalfields.Seq AS ConditionalFieldSequence, Lnk_Forms.TabId AS TabId, Lnk_Forms.TabName AS TabName
					  FROM dbo.Mst_PreDefinedFields AS Mst_PreDefinedFields_1 RIGHT OUTER JOIN
                      dbo.mst_CustomformField AS mst_CustomformField_1 RIGHT OUTER JOIN
                      dbo.Lnk_Conditionalfields RIGHT OUTER JOIN
                          (SELECT z.FeatureId, z.SectionId, z.FieldId, z.FieldLabel, z.UserId, z.CreateDate, z.Predefined, z.Seq, lnkTab.TabId, mstTab.TabName
                            FROM dbo.Lnk_Forms AS z 
							 INNER JOIN dbo.lnk_FormTabSection lnkTab on z.FeatureId=lnkTab.FeatureId and z.SectionId=lnkTab.SectionId          
							 INNER JOIN dbo.Mst_FormBuilderTab mstTab on lnkTab.TabId=mstTab.TabId
                            UNION
                            SELECT a.FeatureId, a.SectionId, b.FieldId, b.FieldLabel, b.UserId, b.CreateDate, b.Predefined, b.Seq,lnkTab.TabId, mstTab.TabName
                            FROM dbo.Lnk_Forms AS a INNER JOIN
                            dbo.Lnk_Conditionalfields AS b ON a.FieldId = b.ConfieldId 
							INNER JOIN dbo.lnk_FormTabSection lnkTab on a.FeatureId=lnkTab.FeatureId and a.SectionId=lnkTab.SectionId          
							INNER JOIN dbo.Mst_FormBuilderTab mstTab on lnkTab.TabId=mstTab.TabId) AS Lnk_Forms LEFT OUTER JOIN
                      dbo.mst_Section ON Lnk_Forms.SectionId = dbo.mst_Section.SectionID ON dbo.Lnk_Conditionalfields.Conpredefine = Lnk_Forms.Predefined AND 
                      dbo.Lnk_Conditionalfields.ConfieldId = Lnk_Forms.FieldId LEFT OUTER JOIN
                      dbo.mst_CustomformField ON dbo.Lnk_Conditionalfields.FieldId = dbo.mst_CustomformField.Id LEFT OUTER JOIN
                      dbo.Mst_PreDefinedFields ON dbo.Lnk_Conditionalfields.FieldId = dbo.Mst_PreDefinedFields.Id ON mst_CustomformField_1.Id = Lnk_Forms.FieldId ON 
                      Mst_PreDefinedFields_1.Id = Lnk_Forms.FieldId
UNION
					  SELECT     dbo.Lnk_CareEndForm.FieldId, dbo.Lnk_CareEndForm.FieldLabel, dbo.lnk_CareEndConditionalFields.FieldId AS ConditionalFieldId, 
                      dbo.lnk_CareEndConditionalFields.FieldLabel AS ConditionalFieldLabel, 
                      CASE dbo.Lnk_CareEndForm.Predefined WHEN 1 THEN Mst_PredefinedFields_1.PdfName WHEN 0 THEN Mst_CustomFormField_1.FieldName END AS FieldName, 
                      CASE dbo.Lnk_CareEndForm.Predefined WHEN 1 THEN Mst_PredefinedFields_1.PdfTableName WHEN 0 THEN 'dt_CustomField' END AS FieldSavingTable, 
                      CASE dbo.lnk_CareEndConditionalFields.Predefined WHEN 1 THEN dbo.Mst_PredefinedFields.PdfName WHEN 0 THEN dbo.Mst_CustomFormField.FieldName END AS ConditionalFieldName,
                       CASE dbo.lnk_CareEndConditionalFields.Predefined WHEN 1 THEN dbo.Mst_PredefinedFields.PdfTableName WHEN 0 THEN 'dtl_CustomField' END AS ConditionalFieldSavingTable,
                       CASE dbo.Lnk_CareEndForm.Predefined WHEN 1 THEN Mst_PredefinedFields_1.ControlId WHEN 0 THEN Mst_CustomFormField_1.ControlId END AS FieldControlId, 
                      CASE dbo.Lnk_CareEndForm.Predefined WHEN 1 THEN Mst_PredefinedFields_1.BindTable WHEN 0 THEN 'Mst_ModDecode' END AS FieldBindTable, 
                      CASE dbo.Lnk_CareEndForm.Predefined WHEN 1 THEN Mst_PredefinedFields_1.ModuleId WHEN 0 THEN 0 END AS FieldModuleId, 
                      CASE dbo.Lnk_CareEndForm.Predefined WHEN 1 THEN Mst_PredefinedFields_1.CategoryId WHEN 0 THEN 0 END AS FieldCategoryId, 
                      CASE dbo.Lnk_CareEndForm.Predefined WHEN 1 THEN Mst_PredefinedFields_1.BindField WHEN 0 THEN '' END AS FieldBindField, 
                      CASE dbo.lnk_CareEndConditionalFields.Predefined WHEN 1 THEN dbo.Mst_PredefinedFields.ControlId WHEN 0 THEN dbo.Mst_CustomFormField.ControlId END AS ConditionalFieldControlId,
                       CASE dbo.lnk_CareEndConditionalFields.Predefined WHEN 1 THEN dbo.Mst_PredefinedFields.BindTable WHEN 0 THEN dbo.Mst_CustomFormField.BindTable END AS
                       ConditionalFieldBindTable, 
                      CASE dbo.lnk_CareEndConditionalFields.Predefined WHEN 1 THEN dbo.Mst_PredefinedFields.ModuleId WHEN 0 THEN 0 END AS ConditionalFieldModuleId, 
                      CASE dbo.lnk_CareEndConditionalFields.Predefined WHEN 1 THEN dbo.Mst_PredefinedFields.CategoryId WHEN 0 THEN dbo.Mst_CustomFormField.CategoryId END AS
                       ConditionalFieldCategoryId, 
                      CASE dbo.lnk_CareEndConditionalFields.Predefined WHEN 1 THEN dbo.Mst_PredefinedFields.BindField WHEN 0 THEN '' END AS ConditionalFieldBindField, 
                      dbo.Lnk_CareEndForm.FeatureId, dbo.mst_Section.SectionID AS FieldSectionId, dbo.mst_Section.SectionName AS FieldSectionName, 
                      dbo.lnk_CareEndConditionalFields.SectionId AS ConditionalFieldSectionId, dbo.Lnk_CareEndForm.Predefined AS FieldPredefined, 
                      dbo.lnk_CareEndConditionalFields.Predefined AS ConditionalFieldPredefined, dbo.mst_Section.Seq AS FieldSectionSequence, 
                      dbo.lnk_CareEndConditionalFields.Seq AS ConditionalFieldSequence, '' AS TabId, '' AS TabName
					  FROM  dbo.Mst_PreDefinedFields AS Mst_PreDefinedFields_1 RIGHT OUTER JOIN
                      dbo.mst_CustomformField AS mst_CustomformField_1 RIGHT OUTER JOIN
                      dbo.lnk_CareEndConditionalFields RIGHT OUTER JOIN
                      dbo.Lnk_CareEndForm LEFT OUTER JOIN
                      dbo.mst_Section ON dbo.Lnk_CareEndForm.SectionId = dbo.mst_Section.SectionID ON 
                      dbo.lnk_CareEndConditionalFields.Conpredefine = dbo.Lnk_CareEndForm.Predefined AND 
                      dbo.lnk_CareEndConditionalFields.ConfieldId = dbo.Lnk_CareEndForm.FieldId LEFT OUTER JOIN
                      dbo.mst_CustomformField ON dbo.lnk_CareEndConditionalFields.FieldId = dbo.mst_CustomformField.Id LEFT OUTER JOIN
                      dbo.Mst_PreDefinedFields ON dbo.lnk_CareEndConditionalFields.FieldId = dbo.Mst_PreDefinedFields.Id ON 
                      mst_CustomformField_1.Id = dbo.Lnk_CareEndForm.FieldId ON Mst_PreDefinedFields_1.Id = dbo.Lnk_CareEndForm.FieldId

GO

 /****** Object:  View [dbo].[ServiceAreaFormView]    Script Date: 7/29/2016 6:31:49 AM ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[ServiceAreaFormView]'))
DROP VIEW [dbo].[ServiceAreaFormView]
GO

/****** Object:  View [dbo].[ServiceAreaFormView]    Script Date: 7/29/2016 6:31:49 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[ServiceAreaFormView]
AS
Select Distinct	F.FeatureID		As FeatureId
	,	F.FeatureName
	,	F.ReportFlag
	,	F.FeatureDeleteFlag	As FeatureDeleteFlag
	,	F.AdminFlag
	,	F.Published
	,	F.ModuleId
	,	F.MultiVisit
	,	F.RegistrationFormFlag
	,	F.ReferenceID	As ReferenceId
	,	F.CanLink
	,	F.FormId
	,	F.FormName
	,	F.FormDescription
	,	F.Custom
	,	F.CategoryId
	,	F.CategoryName Code
	,	F.FormDeleteFlag
	,	PermissionCount PermCount
From FormView As F
--Inner Join mst_VisitType As V On V.FeatureId = F.FeatureID
--Left Outer Join( Select D.ID, D.Name, C.CodeID, D.Code From mst_Decode D Inner Join mst_Code C On C.CodeID=D.CodeID And C.Name='Form Category') D On D.ID= V.CategoryId
Where (F.FeatureDeleteFlag = 0)
	And (F.AdminFlag = 0)
	And (F.FormDeleteFlag = 0)
	Or (F.FeatureDeleteFlag Is Null)
	And (F.AdminFlag Is Null)
	And (F.FormDeleteFlag Is Null)
Union
Select	Distinct F.FeatureID		As FeatureId
	,	F.FeatureName
	,	F.ReportFlag
	,	F.FeatureDeleteFlag
	,	F.AdminFlag
	,	F. Published
	,	L.ModuleId
	,	F.MultiVisit
	,	F.RegistrationFormFlag
	,	F.ReferenceId
	,	F.CanLink
	,	F.FormId
	,	F.FormName
	,	F.FormDescription
	,	F.Custom
	,	F.CategoryId
	,	F.CategoryName Code
	,	F.FormDeleteFlag
	,	PermissionCount PermCount
From FormView As F
--Inner Join mst_VisitType As V On V.FeatureId = F.FeatureID
Inner Join lnk_SplFormModule L On L.FeatureId = F.FeatureID
--Left Outer Join( Select D.ID, D.Name, C.CodeID, D.Code From mst_Decode D Inner Join mst_Code C On C.CodeID=D.CodeID And C.Name='Form Category') D On D.ID= V.CategoryId
Where (F.FeatureDeleteFlag = 0)
	And (F.AdminFlag = 0)
	And (F.FormDeleteFlag = 0)
	Or (F.FeatureDeleteFlag Is Null)
	And (F.AdminFlag Is Null)
	And (F.FormDeleteFlag Is Null)




GO
