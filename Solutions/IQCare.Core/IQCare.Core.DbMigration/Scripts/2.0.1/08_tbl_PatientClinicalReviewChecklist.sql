IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('PatientClinicalReviewChecklist'))
	CREATE TABLE [dbo].[PatientClinicalReviewChecklist](
		[id] [int] IDENTITY(1,1) NOT NULL,
		[PatientMasterVisitId] [int] NOT NULL,
		[PatientId] [int] NOT NULL,
		[ReviewDate] [date] NOT NULL,
		[DrtDate] [date] NULL,
		[DrtResult] [tinyint] NULL,
		[HBDone] [tinyint] NULL,
		[HBDate] [date] NULL,
		[HBResult] [int] NULL,
		[CreatinineDone] [tinyint] NULL,
		[CreatinineDate] [date] NULL,
		[CreatinineResult] [int] NULL,
		[AltDone] [tinyint] NULL,
		[AltDate] [date] NULL,
		[AltResult] [int] NULL,
		[HbsagDone] [tinyint] NULL,
		[HbsagDate] [date] NULL,
		[HbsagResult] [tinyint] NULL,
		[VdrlDone] [tinyint] NULL,
		[VdrlDate] [date] NULL,
		[VdrlResult] [tinyint] NULL,
		[CragDone] [tinyint] NULL,
		[CragDate] [date] NULL,
		[CragResult] [tinyint] NULL,
		[TbLamDone] [tinyint] NULL,
		[TbLamDate] [date] NULL,
		[DewormingDone] [tinyint] NULL,
		[DewormingDate] [date] NULL,
		[DepressionScreeningDone] [tinyint] NULL,
		[DepressionScreeningDate] [date] NULL,
		[DepressionScreeningResult] [tinyint] NULL,
		[CacxScreeningDone] [tinyint] NULL,
		[CacxScreeningDate] [date] NULL,
		[CacxScreeningResult] [tinyint] NULL,
		[DentalReviewDone] [tinyint] NULL,
		[DentalReviewDate] [date] NULL,
		[Recommendations] [nvarchar](max) NOT NULL,
		[CreateDate] [date] NOT NULL,
		[CreatedBy] [int] NOT NULL,
	 CONSTRAINT [PK_PatientClinicalReviewChecklist] PRIMARY KEY CLUSTERED 
	(
		[id] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
	GO


