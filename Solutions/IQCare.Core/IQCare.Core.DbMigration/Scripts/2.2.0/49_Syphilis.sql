UPDATE [dbo].[Mst_LabTestParameter] SET DataType = 'SELECTLIST' where LabTestId = (select top 1 Id from [dbo].[mst_LabTestMaster] where Name = 'Syphilis (RPR)');

IF EXISTS(SELECT * FROM [dbo].[Mst_LabTestParameter] where LabTestId = (select top 1 Id from [dbo].[mst_LabTestMaster] where Name = 'Syphilis (RPR)') AND ParameterName = 'Syphilis (RPR)' AND DeleteFlag = 0)
BEGIN

IF NOT EXISTS(select * from dtl_LabTestParameterResultOption  dlp
inner join (
select top 1 mlp.LabTestId,mlp.ParameterName  from Mst_LabTestParameter mlp
inner join mst_LabTestMaster mlm  on mlm.Id=mlp.LabTestId
where  mlm.Name='Syphilis (RPR)' and mlp.ParameterName='Syphilis (RPR)'
and mlp.DeleteFlag=0
)ml on ml.LabTestId=dlp.ParameterId
and dlp.Value='Positive')
BEGIN
INSERT INTO [dbo].[dtl_LabTestParameterResultOption] (ParameterId, Value, DeleteFlag)
	VALUES((SELECT top 1 Id FROM [dbo].[Mst_LabTestParameter] where LabTestId = (select top 1 Id from [dbo].[mst_LabTestMaster] where Name = 'Syphilis (RPR)') AND ParameterName = 'Syphilis (RPR)' AND DeleteFlag = 0), 'Positive', 0);

END



IF NOT EXISTS(select * from dtl_LabTestParameterResultOption  dlp
inner join (
select top 1 mlp.LabTestId,mlp.ParameterName  from Mst_LabTestParameter mlp
inner join mst_LabTestMaster mlm  on mlm.Id=mlp.LabTestId
where  mlm.Name='Syphilis (RPR)' and mlp.ParameterName='Syphilis (RPR)'
and mlp.DeleteFlag=0
)ml on ml.LabTestId=dlp.ParameterId
and dlp.Value='Negative')
BEGIN
INSERT INTO [dbo].[dtl_LabTestParameterResultOption] (ParameterId, Value, DeleteFlag)
	VALUES((SELECT top 1 Id FROM [dbo].[Mst_LabTestParameter] where LabTestId = (select top 1 Id from [dbo].[mst_LabTestMaster] where Name = 'Syphilis (RPR)') AND ParameterName = 'Syphilis (RPR)' AND DeleteFlag = 0), 'Negative', 0);

END

	/*INSERT INTO [dbo].[dtl_LabTestParameterResultOption] (ParameterId, Value, DeleteFlag)
	VALUES((SELECT top 1 Id FROM [dbo].[Mst_LabTestParameter] where LabTestId = (select top 1 Id from [dbo].[mst_LabTestMaster] where Name = 'Syphilis (RPR)') AND ParameterName = 'Syphilis (RPR)' AND DeleteFlag = 0), 'Positive', 0);

	INSERT INTO [dbo].[dtl_LabTestParameterResultOption] (ParameterId, Value, DeleteFlag)
	VALUES((SELECT top 1 Id FROM [dbo].[Mst_LabTestParameter] where LabTestId = (select top 1 Id from [dbo].[mst_LabTestMaster] where Name = 'Syphilis (RPR)') AND ParameterName = 'Syphilis (RPR)' AND DeleteFlag = 0), 'Negative', 0); */
END