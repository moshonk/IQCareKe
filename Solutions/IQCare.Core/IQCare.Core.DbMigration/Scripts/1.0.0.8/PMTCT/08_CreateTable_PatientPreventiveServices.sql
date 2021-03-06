﻿IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PatientPreventiveServices]') AND type in (N'U')) 
BEGIN
CREATE TABLE [dbo].[PatientPreventiveServices](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PatientId] [int] NOT NULL,
	[PatientMasterVisitId] [INT] NOT NULL,
	[PreventiveServiceId] [INT] NOT NULL,
	[PreventiveServiceDate] [datetime] NULL,
	[Description] [varchar](max) NULL,
	[DeleteFlag] [bit] NULL,
	[CreatedBy] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL DEFAULT GETDATE(),
	[AuditData] [varchar](max) NULL,
 CONSTRAINT [PK_PatientPreventiveServices] PRIMARY KEY CLUSTERED ([Id] ASC ),
 CONSTRAINT [FK_PatientPreventiveServices_Patient] FOREIGN KEY([PatientId]) REFERENCES [dbo].[Patient] ([Id]),
 CONSTRAINT [FK_PatientPreventiveServices_PatientMasterVisit] FOREIGN KEY([PatientMasterVisitId]) REFERENCES [dbo].[PatientMasterVisit] ([Id])
)
END