UPDATE [dbo].[dtl_LabTestParameterConfig] SET UnitId = (SELECT ID FROM mst_Decode WHERE Name = 'umol/l') WHERE ParameterId = (SELECT TOP 1 Id FROM [dbo].[Mst_LabTestParameter] WHERE LabTestId = (select TOP 1 Id from [dbo].[mst_LabTestMaster] where ReferenceId = 'CREATININE') AND DeleteFlag = 0);