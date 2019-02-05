/****** Object:  Table [dbo].[PatientCervicalCancerScreening]    Script Date: 2/4/2019 6:10:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PatientCervicalCancerScreening]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[PatientCervicalCancerScreening](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[PatientId] [int] NULL,
	[PatientMasterVisitId] [int] NULL,
	[VisitDate] [datetime] NULL,
	[AppointmentDate] [datetime] NULL,
	[ReferredTo] [nvarchar](50) NULL,
	[DeleteFlag] [bit] NOT NULL,
	[Active] [bit] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[AuditData] [xml] NULL,
 CONSTRAINT [PK_PatientCervicalCancerScreening] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_PatientCervicalCancerScreening_PatientMasterVisit]') AND parent_object_id = OBJECT_ID(N'[dbo].[PatientCervicalCancerScreening]'))
ALTER TABLE [dbo].[PatientCervicalCancerScreening]  WITH CHECK ADD  CONSTRAINT [FK_PatientCervicalCancerScreening_PatientMasterVisit] FOREIGN KEY([PatientId])
REFERENCES [dbo].[Patient] ([Id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_PatientCervicalCancerScreening_PatientMasterVisit]') AND parent_object_id = OBJECT_ID(N'[dbo].[PatientCervicalCancerScreening]'))
ALTER TABLE [dbo].[PatientCervicalCancerScreening] CHECK CONSTRAINT [FK_PatientCervicalCancerScreening_PatientMasterVisit]
GO
