/****** Object:  Table [dbo].[PatientPregnancyIntentionAssessment]    Script Date: 5/24/2018 6:05:35 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PatientPregnancyIntentionAssessment]')
		  AND type IN(N'U'))
	CREATE TABLE [dbo].[PatientPregnancyIntentionAssessment](
		[Id] [int] IDENTITY(1,1) NOT NULL,
		[PatientId] [int] NOT NULL,
		[PatientMasterVisitId] [int] NOT NULL,
		[VisitDate] [datetime] NULL,
		[PartnerHivStatus] [int] NULL,
		[ClientEligibleForFP] [nvarchar](1) NULL,
		[ServiceForEligibleClient] [int] NULL,
		[ReasonForFPIneligibility] [int] NULL,
		[PlanningToConceive3M] [nvarchar](1) NULL,
		[RegularMenses] [nvarchar](1) NULL,
		[InitiatedOnART] [nvarchar](1) NULL,
		[Active] [bit] NULL,
		[DeleteFlag] [bit] NOT NULL,
		[CreateDate] [datetime] NOT NULL,
		[CreatedBy] [int] NOT NULL,
		[AuditData] [xml] NULL,
	 CONSTRAINT [PK_PatientPregnancyIntentionForm] PRIMARY KEY CLUSTERED 
	(
		[Id] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	)
	GO

/****** Object:  Table [dbo].[PatientPIAPregnancySymptom]    Script Date: 5/24/2018 6:05:06 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PatientPIAPregnancySymptom]')
		  AND type IN(N'U'))
	CREATE TABLE [dbo].[PatientPIAPregnancySymptom](
		[Id] [int] IDENTITY(1,1) NOT NULL,
		[PatientId] [int] NOT NULL,
		[PatientPIAId] [int] NOT NULL,
		[PregnancySymptomId] [int] NULL,
		[DeleteFlag] [bit] NOT NULL,
		[CreateDate] [datetime] NULL,
		[CreatedBy] [int] NULL,
		[AuditData] [xml] NULL,
	 CONSTRAINT [PK_PatientPIAPregnancySymptom] PRIMARY KEY CLUSTERED 
	(
		[Id] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	)
	GO
