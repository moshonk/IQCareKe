USE [IQCareDefault]
GO


ALTER TABLE mst_itemMaster ADD abbreviation nvarchar(50) NULL;
ALTER TABLE ord_patientPharmacyOrder ADD masterVisitId int NULL

ALTER TABLE ord_labOrder ADD LabTestId int NULL
ALTER TABLE ord_labOrder ADD patientMasterVisitId int NULL
ALTER TABLE mst_Patient ADD DateOfDeath datetime NULL

/****** Object:  View [dbo].[Mst_Drug]    Script Date: 3/23/2017 3:11:04 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
 Created By Joseph Njung'e
 Return DrugList from mst_itemmaster
 ItemTypeID 300	 = Drugs
*/
ALTER VIEW [dbo].[Mst_Drug]
AS
SELECT        D.Item_PK AS Drug_pk, D.ItemCode AS DrugID, D.ItemTypeID, D.ItemName AS DrugName, D.DeleteFlag, D.CreatedBy AS UserID, D.CreateDate, D.UpdateDate, D.DispensingMargin, D.DispensingUnitPrice, 
                         D.FDACode, D.Manufacturer, D.MaxStock, D.MinStock, D.PurchaseUnitPrice, D.QtyPerPurchaseUnit, ISNULL(CC.ItemSellingPrice, 0) AS SellingUnitPrice, D.DispensingUnit, D.PurchaseUnit, CC.EffectiveDate, 
                         1 AS Sequence, D.ItemInstructions, D.abbreviation
FROM            dbo.Mst_ItemMaster AS D INNER JOIN
                         dbo.Mst_ItemType AS I ON I.ItemTypeID = D.ItemTypeID LEFT OUTER JOIN
                             (SELECT DISTINCT ItemId, ItemType, PriceStatus, ItemSellingPrice, EffectiveDate
                               FROM            dbo.lnk_ItemCostConfiguration) AS CC ON CC.ItemId = D.Item_PK AND CC.ItemType = D.ItemTypeID AND CC.PriceStatus = 1
WHERE        (I.ItemName = 'Pharmaceuticals')

GO


/****** Object:  Table [dbo].[AdherenceOutcome]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AdherenceOutcome](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PatientId] [int] NOT NULL,
	[PatientMasterVisitId] [int] NOT NULL,
	[AdherenceType] [int] NOT NULL,
	[Score] [int] NOT NULL,
	[ScoreDescription] [varchar](150) NULL,
	[DeleteFlag] [bit] NOT NULL,
	[CreateBy] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[AuditData] [xml] NULL,
 CONSTRAINT [PK_AdherenceOutcome] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AdultChildVaccination]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AdultChildVaccination](
	[Id] [int] NOT NULL,
	[PatientId] [int] NOT NULL,
	[PatientMasterVisitId] [int] NOT NULL,
	[Person] [varchar](5) NOT NULL,
	[Vaccine] [int] NOT NULL,
	[VaccineStage] [varchar](50) NOT NULL,
	[Void] [bit] NOT NULL,
	[VoidBy] [int] NULL,
	[VoidDate] [date] NULL,
	[CreateBy] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_AdultChildVaccination] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AdverseEvent]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AdverseEvent](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PatientId] [int] NOT NULL,
	[PatientMasterVisitId] [int] NOT NULL,
	[EventName] [varchar](250) NOT NULL,
	[EventCause] [varchar](250) NULL,
	[Severity] [varchar](250) NULL,
	[Action] [varchar](250) NULL,
	[DeleteFlag] [bit] NOT NULL,
	[CreateBy] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[AuditData] [xml] NULL,
 CONSTRAINT [PK_AdverseEvent] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ARTPataient]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ARTPataient](
	[Ptn_Pk] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varbinary](max) NOT NULL,
	[LastName] [varbinary](max) NOT NULL,
	[LocationID] [int] NULL,
	[PatientEnrollmentID] [varchar](50) NULL,
	[PatientClinicID] [varchar](50) NULL,
	[ReferredFrom] [int] NULL,
	[RegistrationDate] [datetime] NULL,
	[Sex] [int] NOT NULL,
	[DOB] [datetime] NOT NULL,
	[DobPrecision] [int] NULL,
	[LocalCouncil] [varchar](60) NULL,
	[VillageName] [int] NULL,
	[DistrictName] [int] NULL,
	[Province] [int] NULL,
	[Address] [varbinary](max) NULL,
	[Phone] [varbinary](max) NULL,
	[MaritalStatus] [int] NULL,
	[EducationLevel] [int] NULL,
	[EducationOther] [varchar](50) NULL,
	[Literacy] [int] NULL,
	[EmployeeID] [int] NULL,
	[Status] [int] NULL,
	[StatusChangedDate] [datetime] NULL,
	[ProgramID] [int] NULL,
	[Notes] [varchar](max) NULL,
	[DeleteFlag] [int] NULL,
	[UserID] [int] NULL,
	[CreateDate] [datetime] NULL,
	[UpdateDate] [datetime] NULL,
	[ARTStartDate] [datetime] NULL,
	[CountryId] [varchar](10) NULL,
	[PosId] [varchar](10) NULL,
	[SatelliteId] [varchar](10) NULL,
	[MiddleName] [varbinary](max) NULL,
	[Division] [int] NULL,
	[Ward] [int] NULL,
	[ReferredFromSpecify] [varchar](200) NULL,
	[TransferIn] [int] NULL,
	[LPTFTransferId] [int] NULL,
	[ANCNumber] [varchar](50) NULL,
	[PMTCTNumber] [varchar](50) NULL,
	[AdmissionNumber] [varchar](50) NULL,
	[OutpatientNumber] [varchar](50) NULL,
	[HealthUnit] [int] NULL,
	[SubCountry] [int] NULL,
	[whose] [int] NULL,
	[DateTransferredin] [datetime] NULL,
	[NearestSchool] [varchar](300) NULL,
	[NearestHealthCentre] [varchar](300) NULL,
	[IQNumber] [varchar](100) NULL,
	[Home_based_care] [varchar](50) NULL,
	[PatientTelephonenumber] [varchar](50) NULL,
	[Landmark] [varchar](50) NULL,
	[Sublocation] [varchar](50) NULL,
	[Parish] [int] NULL,
	[ClinicalTeamLeader] [int] NULL,
	[ID/PassportNo] [varchar](100) NULL,
	[Nationality] [int] NULL,
	[PlaceofBirth] [varchar](100) NULL,
	[Religion] [int] NULL,
	[ReligionOther] [varchar](100) NULL,
	[Code] [varchar](100) NULL,
	[Town] [int] NULL,
	[Outpatienttoattend] [int] NULL,
	[AttendanceTime] [varchar](15) NULL,
	[Wardadmitted] [int] NULL,
	[MaternityNumber] [varchar](50) NULL,
	[HEIIDNumber] [varchar](50) NULL,
	[HTCNumber] [varchar](50) NULL,
	[DistrictRegistrationNr] [varchar](50) NULL,
	[PEPNumber] [varchar](50) NULL,
	[IPTRegNo] [varchar](50) NULL,
	[PatientFacilityId] [varchar](50) NULL,
	[DateOfDeath] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ARVTreatmentTracker]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ARVTreatmentTracker](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PatientId] [int] NOT NULL,
	[ServiceAreaId] [int] NOT NULL,
	[PatientMasterVisitId] [int] NOT NULL,
	[RegimenStartDate] [int] NOT NULL,
	[RegimenId] [int] NOT NULL,
	[Regimen] [varchar](50) NOT NULL,
	[RegimenLineId] [int] NOT NULL,
	[RegimenLine] [varchar](50) NOT NULL,
	[DrugId] [int] NOT NULL,
	[RegimenStatusDate] [datetime] NOT NULL,
	[TreatmentStatusId] [int] NOT NULL,
	[ParentId] [int] NOT NULL,
	[DeleteFlag] [bit] NOT NULL,
	[CreateBy] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[AuditData] [xml] NULL,
 CONSTRAINT [PK_ARVTreatmentTracker] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ComplaintsHistory]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ComplaintsHistory](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PatientId] [int] NOT NULL,
	[PatientMasterVisitId] [int] NOT NULL,
	[PresentingComplaint] [varchar](1000) NOT NULL,
	[ComplaintHistory] [varchar](1000) NULL,
	[DeleteFlag] [bit] NOT NULL,
	[CreateBy] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL CONSTRAINT [DF_ComplaintsHistory_CreateDate]  DEFAULT (getdate()),
	[AuditData] [xml] NULL,
 CONSTRAINT [PK_ComplaintsHistory] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[County]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[County](
	[Id] [int] NOT NULL,
	[CountyId] [int] NULL,
	[CountyName] [nvarchar](255) NULL,
	[SubcountyId] [int] NULL,
	[Subcountyname] [nvarchar](255) NULL,
	[WardId] [int] NULL,
	[WardName] [nvarchar](255) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Disclosure]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Disclosure](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PatientId] [int] NOT NULL,
	[PatientMasterVisitId] [int] NOT NULL,
	[Category] [varchar](15) NOT NULL,
	[DisclosureStage] [varchar](10) NOT NULL,
	[DisclosureDate] [date] NULL,
	[DeleteFlag] [bit] NOT NULL CONSTRAINT [DF_Disclosure_Void]  DEFAULT ((0)),
	[CreatedBy] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL CONSTRAINT [DF_Disclosure_CreateDate]  DEFAULT (getdate()),
	[Active] [bit] NOT NULL CONSTRAINT [DF_Disclosure_Active]  DEFAULT ((0)),
	[AuditData] [xml] NULL,
 CONSTRAINT [PK_Disclosure_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[HIVEnrollmentBaseline]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[HIVEnrollmentBaseline](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PatientId] [int] NOT NULL,
	[PatientMasterVisitId] [int] NOT NULL,
	[HIVDiagnosisDate] [date] NOT NULL,
	[EnrollmentDate] [date] NOT NULL,
	[EnrollmentWHOStage] [int] NOT NULL,
	[ARTInitiationDate] [date] NOT NULL,
	[ARTHistoryUse] [bit] NOT NULL,
	[HIVRetest] [bit] NOT NULL,
	[HIVRetestTypeId] [int] NULL,
	[ReasonForNoRetest] [varchar](250) NULL,
	[DeleteFlag] [bit] NOT NULL,
	[CreateBy] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_HIVEnrollmentBaseline] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[HIVTesting]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[HIVTesting](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PersonId] [int] NOT NULL,
	[BaselineResult] [int] NOT NULL,
	[BaselineDate] [datetime] NULL,
	[TestingDate] [datetime] NULL,
	[TestingResult] [int] NOT NULL,
	[ReferredToCare] [bit] NOT NULL,
	[CCCNumber] [varchar](20) NULL,
	[EnrollmentId] [int] NULL,
	[DeleteFlag] [bit] NOT NULL CONSTRAINT [DF_HIVTesting_DeleteFlag]  DEFAULT ((0)),
	[CreatedBy] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL CONSTRAINT [DF_HIVTesting_CreateDate]  DEFAULT (getdate()),
	[AuditData] [xml] NULL,
	[PatientMasterVisitId] [int] NOT NULL,
 CONSTRAINT [PK_HIVTesting] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[INHProphylaxis]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[INHProphylaxis](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PatientId] [int] NOT NULL,
	[PatientMasterVisitId] [int] NOT NULL,
	[StartDate] [date] NULL,
	[Complete] [bit] NOT NULL,
	[CompletionDate] [date] NULL,
	[DeleteFlag] [bit] NOT NULL CONSTRAINT [DF_INHProphylaxis_Void]  DEFAULT ((0)),
	[CreatedBy] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL CONSTRAINT [DF_INHProphylaxis_CreateDate]  DEFAULT (getdate()),
	[Active] [bit] NOT NULL CONSTRAINT [DF_INHProphylaxis_Active]  DEFAULT ((0)),
 CONSTRAINT [PK_INHProphylaxis] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LookupItem]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LookupItem](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[DisplayName] [varchar](150) NOT NULL,
	[DeleteFlag] [bit] NOT NULL CONSTRAINT [DF_LookupMaster_DeleteFlag]  DEFAULT ((0)),
 CONSTRAINT [PK_LookupMaster] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LookupMaster]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LookupMaster](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[DisplayName] [varchar](150) NULL,
	[DeleteFlag] [bit] NOT NULL CONSTRAINT [DF_LookupItem_DeleteFlag]  DEFAULT ((0)),
 CONSTRAINT [PK_LookupItem] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LookupMasterItem]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LookupMasterItem](
	[LookupMasterId] [int] NOT NULL,
	[LookupItemId] [int] NOT NULL,
	[DisplayName] [varchar](50) NULL,
	[OrdRank] [decimal](5, 2) NULL CONSTRAINT [DF_LookupMasterItem_OrdRank]  DEFAULT ((0.00)),
 CONSTRAINT [PK_LookupMasterItem] PRIMARY KEY CLUSTERED 
(
	[LookupMasterId] ASC,
	[LookupItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ModuleMaster]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ModuleMaster](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[ReferenceId] [varchar](15) NOT NULL,
	[DisplayName] [varchar](150) NOT NULL,
	[Version] [varchar](50) NOT NULL,
	[ReleaseDate] [date] NOT NULL,
	[ReleaseVersion] [varchar](8) NOT NULL,
	[DeleteFlag] [bit] NOT NULL,
	[CreateBy] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[AuditData] [xml] NULL,
 CONSTRAINT [PK_ModuleMaster] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

/****** Object:  Table [dbo].[Patient]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Patient](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ptn_pk] [int] NOT NULL,
	[PersonId] [int] NOT NULL,
	[PatientIndex] [varchar](50) NULL,
	[PatientType] [int] NOT NULL,
	[FacilityId] [int] NOT NULL,
	[Active] [bit] NOT NULL CONSTRAINT [DF_Patient_Active]  DEFAULT ((1)),
	[DateOfBirth] [datetime] NOT NULL,
	[DobPrecision] [bit] NULL CONSTRAINT [DF_Patient_DobPrecision]  DEFAULT ((0)),
	[NationalId] [varbinary](400) NOT NULL,
	[DeleteFlag] [bit] NOT NULL CONSTRAINT [DF_Patient_DeleteFlag]  DEFAULT ((0)),
	[CreatedBy] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[AuditData] [xml] NULL,
 CONSTRAINT [PK_person_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PatientAllergies]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PatientAllergies](
	[id] [int] NOT NULL,
	[PatientId] [int] NOT NULL,
	[PatientMasterVisitId] [int] NOT NULL,
	[AllergyType] [int] NOT NULL,
	[Allagen] [varchar](150) NOT NULL,
	[Description] [varchar](150) NOT NULL,
	[OnsetDate] [date] NULL,
	[Void] [int] NOT NULL,
	[VoidBy] [int] NULL,
	[VoidDate] [date] NULL,
	[CreateBy] [int] NOT NULL,
	[CreateDate] [date] NOT NULL,
 CONSTRAINT [PK_PatientAllergies] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PatientAllergy]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PatientAllergy](
	[Id] [int] NOT NULL,
	[PatientId] [int] NOT NULL,
	[PatientMasterVisitId] [int] NULL,
	[Allergen] [varchar](250) NOT NULL,
	[AllergyResponse] [varchar](250) NOT NULL,
	[DeleteFlag] [bit] NOT NULL,
	[CreateBy] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[AuditData] [xml] NULL,
 CONSTRAINT [PK_PatientAllergy] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PatientAppointment]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PatientAppointment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PatientMasterVisitId] [int] NOT NULL,
	[ServiceAreaId] [int] NOT NULL,
	[PatientId] [int] NOT NULL,
	[AppointmentDate] [datetime] NOT NULL,
	[ReasonId] [int] NOT NULL,
	[Description] [varchar](250) NULL,
	[StatusId] [int] NOT NULL CONSTRAINT [DF_PatientAppointment_Status]  DEFAULT ((0)),
	[StatusDate] [datetime] NULL,
	[DifferentiatedCareId] [int] NOT NULL,
	[DeleteFlag] [bit] NOT NULL CONSTRAINT [DF_PatientAppointment_Void]  DEFAULT ((0)),
	[CreatedBy] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL CONSTRAINT [DF_PatientAppointment_CreateDate]  DEFAULT (getdate()),
	[AuditData] [xml] NULL,
 CONSTRAINT [PK_PatientAppointment] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PatientARVHistory]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PatientARVHistory](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PatientId] [int] NOT NULL,
	[PatientMasterVisitId] [int] NOT NULL,
	[TreatmentType] [varchar](50) NOT NULL,
	[Purpose] [varchar](150) NOT NULL,
	[Regimen] [varchar](150) NOT NULL,
	[DateLastUsed] [datetime] NOT NULL,
	[DeleteFlag] [bit] NOT NULL CONSTRAINT [DF_ARTUseHistory_Void]  DEFAULT ((0)),
	[CreatedBy] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL CONSTRAINT [DF_ARTUseHistory_CreateDate]  DEFAULT (getdate()),
	[AuditData] [xml] NULL,
 CONSTRAINT [PK_ARTUseHistory] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PatientBaselineAssessment]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PatientBaselineAssessment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PatientId] [int] NOT NULL,
	[PatientMasterVisitId] [int] NOT NULL,
	[HBVInfected] [bit] NOT NULL,
	[Pregnant] [bit] NULL,
	[TBinfected] [bit] NOT NULL,
	[WHOStage] [int] NOT NULL,
	[BreastFeeding] [bit] NULL,
	[CD4Count] [decimal](18, 0) NULL,
	[MUAC] [decimal](8, 2) NULL,
	[Weight] [decimal](8, 2) NOT NULL,
	[Height] [decimal](8, 2) NOT NULL,
	[BMI]  AS ([Weight]/(([Height]/(100))*([Height]/(100)))) PERSISTED,
	[DeleteFlag] [bit] NULL CONSTRAINT [DF_PatientARTInitiationBaseline_void]  DEFAULT ((0)),
	[CreatedBy] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL CONSTRAINT [DF_ARTInitiationBaseline_CreateDate]  DEFAULT (getdate()),
	[AuditData] [xml] NULL,
 CONSTRAINT [PK_PatientARTInitiationBaseline] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PatientCareending]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PatientCareending](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PatientId] [int] NOT NULL,
	[PatientMasterVisitId] [int] NOT NULL,
	[PatientEnrollmentId] [int] NOT NULL,
	[ExitReason] [int] NOT NULL,
	[ExitDate] [datetime] NOT NULL,
	[TransferOutfacility] [varchar](250) NULL,
	[DateOfDeath] [datetime] NULL,
	[CareEndingNotes] [text] NULL,
	[Active] [bit] NOT NULL,
	[DeleteFlag] [bit] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[AuditData] [xml] NULL,
 CONSTRAINT [PK_PatientCareending_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PatientChronicIllness]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PatientChronicIllness](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PatientId] [int] NOT NULL,
	[PatientMasterVisitId] [int] NOT NULL,
	[ChronicIllness] [int] NOT NULL,
	[Treatment] [varchar](150) NOT NULL,
	[Dose] [int] NULL,
	[Duration] [int] NULL,
	[DeleteFlag] [bit] NOT NULL,
	[CreateBy] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[AuditData] [xml] NULL,
 CONSTRAINT [PK_PatientChronicIllness] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PatientClinicalDiagnosis]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PatientClinicalDiagnosis](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PatientId] [int] NOT NULL,
	[PatientMasterVisitId] [int] NOT NULL,
	[Diagnosis] [varchar](250) NOT NULL,
	[Treatment] [varchar](250) NOT NULL,
	[DeleteFlag] [bit] NOT NULL,
	[CreateBy] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[AuditData] [xml] NULL,
 CONSTRAINT [PK_PatientClinicalDiagnosis] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PatientClinicalNotes]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PatientClinicalNotes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PatientId] [int] NOT NULL,
	[FacilityId] [int] NOT NULL,
	[PatientMasterVisitId] [int] NOT NULL,
	[ServiceAreaId] [int] NOT NULL,
	[ClinicalNotes] [varchar](8000) NOT NULL,
	[DeleteFlag] [bit] NOT NULL,
	[CreateBy] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[ModifyFlag] [bit] NOT NULL,
	[VersionStamp] [timestamp] NOT NULL,
	[AuditData] [xml] NULL,
 CONSTRAINT [PK_PatientClinicalNotes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PatientConsent]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PatientConsent](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[PatientId] [int] NOT NULL,
	[PatientMasterVisitId] [int] NOT NULL,
	[ServiceAreaId] [int] NOT NULL,
	[ConsentType] [int] NOT NULL,
	[ConsentDate] [datetime] NOT NULL,
	[DeclineReason] [datetime] NULL,
	[Active] [bit] NOT NULL,
	[DeleteFlag] [bit] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[AuditData] [xml] NULL,
 CONSTRAINT [PK_patient_Consent] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PatientContact]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PatientContact](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[PersonId] [int] NOT NULL,
	[PhysicalAddress] [varbinary](max) NOT NULL,
	[mobileNo] [varbinary](max) NOT NULL,
	[Active] [bit] NOT NULL,
	[DeleteFlag] [int] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreateDate] [date] NOT NULL,
 CONSTRAINT [PK_patient_contact] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PatientDiagnosis]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PatientDiagnosis](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PatientId] [int] NOT NULL,
	[PatientMasterVisitId] [int] NOT NULL,
	[Diagnosis] [varchar](400) NOT NULL,
	[ManagementPlan] [varchar](400) NULL,
	[DeleteFlag] [bit] NOT NULL,
	[CreateBy] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[AuditData] [xml] NULL,
 CONSTRAINT [PK_PatientDiagnosis] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PatientEncounter]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PatientEncounter](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PatientId] [int] NOT NULL,
	[EncounterTypeId] [int] NOT NULL,
	[PatientMasterVisitId] [int] NOT NULL,
	[EncounterStartTime] [datetime] NOT NULL,
	[EncounterEndTime] [datetime] NOT NULL,
	[ServiceAreaId] [int] NOT NULL,
	[DeleteFlag] [bit] NOT NULL,
	[CreateBy] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[AuditData] [xml] NULL,
 CONSTRAINT [PK_PatientEncounter] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PatientEnrollment]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PatientEnrollment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PatientId] [int] NOT NULL,
	[ServiceAreaId] [int] NOT NULL,
	[EnrollmentDate] [datetime] NOT NULL,
	[EnrollmentStatusId] [int] NOT NULL,
	[TransferIn] [bit] NOT NULL CONSTRAINT [DF_PatientEnrollment_TransferIn]  DEFAULT ((0)),
	[CareEnded] [bit] NOT NULL CONSTRAINT [DF_PatientEnrollment_Active]  DEFAULT ((0)),
	[DeleteFlag] [bit] NOT NULL CONSTRAINT [DF_patient_enrollment_void]  DEFAULT ((0)),
	[CreatedBy] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL CONSTRAINT [DF_PatientEnrollment_CreateDate]  DEFAULT (getdate()),
	[AuditData] [xml] NULL,
 CONSTRAINT [PK_PatientEnrollment] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO


/****** Object:  Table [dbo].[dtl_patientPharmacyDispensed]    Script Date: 3/23/2017 3:19:13 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[dtl_patientPharmacyDispensed](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ptn_pharmacy_pk] [int] NULL,
	[drug_pk] [int] NULL,
	[batchId] [int] NULL,
	[frequencyID] [int] NULL,
	[dose] [int] NULL,
	[duration] [decimal](18, 2) NULL,
	[dispensedQuantity] [decimal](18, 2) NULL,
	[dispensedDate] [datetime] NULL,
	[dispensedBy] [int] NULL,
	[deleteFlag] [int] NULL,
 CONSTRAINT [PK_dtl_patientPharmacyDispensed] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


/****** Object:  Table [dbo].[PatientFamilyPlanning]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PatientFamilyPlanning](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PatientId] [int] NOT NULL,
	[PatientMasterVisitId] [int] NOT NULL,
	[FPStatusId] [int] NOT NULL,
	[ReasonNotOnFPId] [int] NULL,
	[DeleteFlag] [bit] NOT NULL,
	[CreateBy] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[AuditData] [xml] NULL,
 CONSTRAINT [PK_PatientFamilyPlanning] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PatientFamilyPlanningMethod]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PatientFamilyPlanningMethod](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PatientId] [int] NOT NULL,
	[PatientFPId] [int] NOT NULL,
	[FPMethodId] [int] NOT NULL,
	[DeleteFlag] [bit] NOT NULL,
 CONSTRAINT [PK_PatientFamilyPlanningMethod] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PatientHivDiagnosis]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PatientHivDiagnosis](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PatientMasterVisitId] [int] NULL,
	[PatientId] [int] NOT NULL,
	[HIVDiagnosisDate] [datetime] NOT NULL,
	[EnrollmentDate] [datetime] NOT NULL,
	[EnrollmentWHOStage] [int] NOT NULL,
	[ARTInitiationDate] [datetime] NOT NULL,
	[DeleteFlag] [bit] NOT NULL CONSTRAINT [DF_DiagnosisARVHistory_Void]  DEFAULT ((0)),
	[CreatedBy] [int] NULL,
	[CreateDate] [datetime] NOT NULL,
	[AuditData] [xml] NULL,
 CONSTRAINT [PK_diagnosis_arv_history] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PatientIdentifier]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PatientIdentifier](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PatientId] [int] NOT NULL,
	[PatientEnrollmentId] [int] NOT NULL,
	[IdentifierTypeId] [int] NOT NULL,
	[IdentifierValue] [varchar](50) NOT NULL,
	[DeleteFlag] [bit] NOT NULL CONSTRAINT [DF_patient_identifier_void]  DEFAULT ((0)),
	[CreatedBy] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL CONSTRAINT [DF_PatientIdentifier_CreateDate]  DEFAULT (getdate()),
	[Active] [bit] NOT NULL CONSTRAINT [DF_PatientIdentifier_Active]  DEFAULT ((0)),
	[AuditData] [xml] NULL,
 CONSTRAINT [PK_PatientIdentifier] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PatientLabTracker]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PatientLabTracker](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[patientId] [int] NOT NULL,
	[PatientMasterVisitId] [int] NOT NULL,
	[LabName] [varchar](50) NOT NULL,
	[SampleDate] [datetime] NOT NULL,
	[Reasons] [varchar](50) NULL,
	[Results] [varchar](50) NULL,
	[CreatedBy] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[AuditData] [xml] NULL,
	[DeleteFlag] [bit] NULL,
 CONSTRAINT [PK_PatientLabTracker] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PatientLocation]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PatientLocation](
	[id] [int] NOT NULL,
	[PatientId] [int] NOT NULL,
	[County] [int] NOT NULL,
	[SubCounty] [int] NULL,
	[Ward] [int] NULL,
	[LocalCouncil] [varchar](250) NULL,
	[Location] [varchar](250) NULL,
	[SubLocation] [varchar](250) NULL,
	[LandMark] [varchar](250) NULL,
	[NearestHealthCentre] [varchar](250) NULL,
	[is_active] [bit] NOT NULL,
	[sketch_map] [binary](50) NOT NULL,
	[Void] [bit] NOT NULL,
	[VoidBy] [int] NULL,
	[VoidDate] [datetime] NULL,
	[createBy] [int] NOT NULL,
	[createDate] [datetime] NOT NULL,
 CONSTRAINT [PK_person_location] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PatientMaritalStatus]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PatientMaritalStatus](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PersonId] [int] NOT NULL,
	[MaritalStatusId] [int] NOT NULL,
	[Active] [bit] NOT NULL CONSTRAINT [DF_PatientMaritalStatus_Active]  DEFAULT ((1)),
	[DeleteFlag] [bit] NOT NULL CONSTRAINT [DF_patient_maritalstatus_void]  DEFAULT ((0)),
	[CreatedBy] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL CONSTRAINT [DF_patient_maritalstatus_create_date]  DEFAULT (getdate()),
	[AuditData] [xml] NULL,
 CONSTRAINT [PK_PatientMaritalStatus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PatientMasterVisit]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PatientMasterVisit](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PatientId] [int] NOT NULL,
	[ServiceId] [int] NOT NULL,
	[Start] [datetime] NOT NULL CONSTRAINT [DF_PatientMasterVisit_start]  DEFAULT (getdate()),
	[End] [datetime] NULL,
	[Active] [bit] NOT NULL CONSTRAINT [DF_PatientMasterVisit_Active]  DEFAULT ((0)),
	[VisitDate] [datetime] NULL,
	[VisitScheduled] [int] NULL,
	[VisitBy] [int] NULL,
	[VisitType] [int] NULL,
	[Status] [int] NULL CONSTRAINT [DF_PatientMasterVisit_Status]  DEFAULT ((0)),
	[CreateDate] [datetime] NOT NULL CONSTRAINT [DF_PatientMasterVisit_createDate]  DEFAULT (getdate()),
	[DeleteFlag] [bit] NOT NULL CONSTRAINT [DF_PatientMasterVisit_DeleteFlag]  DEFAULT ((0)),
	[CreatedBy] [int] NOT NULL,
	[AuditData] [xml] NULL,
 CONSTRAINT [PK_PatientMasterVisit] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PatientOVCStatus]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PatientOVCStatus](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PersonId] [int] NOT NULL,
	[GuardianId] [int] NOT NULL,
	[Orphan] [bit] NOT NULL,
	[InSchool] [bit] NOT NULL,
	[Active] [bit] NOT NULL,
	[DeleteFlag] [bit] NOT NULL CONSTRAINT [DF_patient_ovcstatus_void]  DEFAULT ((0)),
	[CreatedBy] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[AuditData] [xml] NULL,
 CONSTRAINT [PK_PatientOVCStatus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PatientPHDP]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PatientPHDP](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PatientId] [int] NOT NULL,
	[PatientMasterVisitId] [int] NOT NULL,
	[Phdp] [int] NOT NULL,
	[DeleteFlag] [bit] NOT NULL,
	[CreateBy] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[AuditData] [xml] NULL,
 CONSTRAINT [PK_PatientPHDP] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PatientPhysicalExamination]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PatientPhysicalExamination](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[PatientId] [int] NOT NULL,
	[PhysicalExaminationId] [int] NULL,
	[PatientMasterVisitId] [int] NOT NULL,
	[FemaleLMP] [date] NULL,
	[PregnancyStatus] [int] NULL,
	[ExpectedDateOfChild] [date] NULL,
	[ANCPNCProfile] [varchar](50) NULL,
	[OnFamilyPlanning] [int] NULL,
	[FPMethod] [int] NULL,
	[CaCxScreen] [int] NULL,
	[STIScreen] [int] NULL,
	[STIPartnerNotification] [int] NULL,
	[Void] [bit] NULL,
	[VoidBy] [int] NULL,
	[VoidDate] [date] NULL,
	[CreateBy] [int] NOT NULL,
	[CreateDate] [date] NOT NULL,
 CONSTRAINT [PK_PatientPhysicalExamination] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PatientPopulation]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PatientPopulation](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PersonId] [int] NOT NULL,
	[PopulationType] [varchar](250) NOT NULL,
	[PopulationCategory] [int] NOT NULL,
	[Active] [bit] NOT NULL CONSTRAINT [DF_PatientPopulation_Active]  DEFAULT ((0)),
	[DeleteFlag] [bit] NOT NULL CONSTRAINT [DF_patient_population_void]  DEFAULT ((0)),
	[CreatedBy] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL CONSTRAINT [DF_patient_population_create_date]  DEFAULT (getdate()),
	[AuditData] [xml] NULL,
	[PopulationTypeId] [int] NULL,
 CONSTRAINT [PK_PatientPopulation] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PatientProphylaxis]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PatientProphylaxis](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProphylaxisTypeId] [int] NOT NULL,
	[PatientId] [int] NOT NULL,
	[PatientMasterVisitId] [int] NOT NULL,
	[StartDate] [date] NOT NULL,
	[Complete] [bit] NOT NULL,
	[CompletionDate] [date] NULL,
	[DeleteFlag] [bit] NOT NULL,
	[CreateBy] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_PatientProphylaxis] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PatientReferral]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PatientReferral](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PatientId] [int] NOT NULL,
	[PatientMasterVisitId] [int] NOT NULL,
	[ReferredFrom] [int] NOT NULL,
	[ReferredTo] [varchar](250) NULL,
	[ReferralReason] [varchar](250) NOT NULL,
	[ReferralDate] [datetime] NOT NULL,
	[ReferredBy] [varchar](50) NOT NULL,
	[DeleteFlag] [bit] NOT NULL,
	[CreateBy] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[AuditData] [xml] NULL,
 CONSTRAINT [PK_PatientReferral] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PatientScreening]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PatientScreening](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PatientId] [int] NOT NULL,
	[PatientMasterVisitId] [int] NOT NULL,
	[ScreeningTypeId] [int] NOT NULL,
	[ScreeningDone] [bit] NOT NULL,
	[ScreeningDate] [date] NULL,
	[ScreeningCategoryId] [int] NULL,
	[ScreeningValueId] [int] NULL,
	[Comment] [varchar](250) NULL,
	[DeleteFlag] [bit] NOT NULL,
	[CreateBy] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[AuditData] [xml] NULL,
 CONSTRAINT [PK_PatientScreening] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PatientTransferIn]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PatientTransferIn](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PatientId] [int] NOT NULL,
	[PatientMasterVisitId] [int] NOT NULL,
	[ServiceAreaId] [int] NOT NULL,
	[TransferInDate] [datetime] NOT NULL,
	[TreatmentStartDate] [datetime] NOT NULL,
	[CurrentTreatment] [varchar](50) NOT NULL,
	[FacilityFrom] [varchar](150) NOT NULL,
	[MFLCode] [int] NOT NULL,
	[CountyFrom] [varchar](150) NOT NULL,
	[TransferInNotes] [varchar](250) NOT NULL,
	[DeleteFlag] [bit] NOT NULL CONSTRAINT [DF_transfer_in_void]  DEFAULT ((0)),
	[CreatedBy] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL CONSTRAINT [DF_PatientTransferIn_CreateDate]  DEFAULT (getdate()),
	[AuditData] [xml] NULL,
 CONSTRAINT [PK_PatientTransferIn] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PatientTreatementDiagnosis]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PatientTreatementDiagnosis](
	[id] [int] NOT NULL,
	[PatientId] [int] NOT NULL,
	[PatientMasterVisitId] [int] NOT NULL,
	[Diagnosis] [varchar](250) NOT NULL,
	[Treatment] [varchar](250) NOT NULL,
	[Dose] [int] NOT NULL,
	[Duration] [int] NOT NULL,
	[NextAppointment] [date] NOT NULL,
	[ReferredFor] [varchar](250) NOT NULL,
	[Void] [bit] NOT NULL,
	[VoidBy] [int] NULL,
	[VoidDate] [date] NULL,
	[CreateBy] [int] NULL,
	[CreateDate] [date] NULL,
 CONSTRAINT [PK_PatientTreatementDiagnosis] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PatientTreatmentInitiation]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PatientTreatmentInitiation](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PatientMasterVisitId] [int] NOT NULL,
	[PatientId] [int] NOT NULL,
	[DateStartedOnFirstLine] [datetime] NOT NULL,
	[Cohort] [varchar](20) NOT NULL,
	[Regimen] [int] NULL,
	[BaselineViralload] [decimal](18, 0) NULL,
	[BaselineViralloadDate] [datetime] NULL,
	[DeleteFlag] [bit] NOT NULL CONSTRAINT [DF_PatientTreatmentInitiation_DeleteFlag]  DEFAULT ((0)),
	[CreatedBy] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[AuditData] [xml] NULL,
 CONSTRAINT [PK_PatientTreatmentInitiation] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PatientTreatmentSupporter]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PatientTreatmentSupporter](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PersonId] [int] NOT NULL,
	[SupporterId] [int] NOT NULL,
	[MobileContact] [varchar](50) NULL,
	[DeleteFlag] [bit] NOT NULL CONSTRAINT [DF_PatientTreatmentSupporter_Void]  DEFAULT ((0)),
	[CreatedBy] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[AuditData] [xml] NULL,
 CONSTRAINT [PK_PatientTreatmentSupporter] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PatientVitals]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PatientVitals](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PatientId] [int] NOT NULL,
	[PatientMasterVisitId] [int] NOT NULL,
	[Temperature] [decimal](5, 2) NULL,
	[RespiratoryRate] [decimal](5, 2) NULL,
	[HeartRate] [decimal](5, 2) NULL,
	[BPDiastolic] [int] NULL,
	[BPSystolic] [int] NULL,
	[Height] [decimal](8, 2) NULL,
	[Weight] [decimal](8, 2) NULL,
	[Muac] [decimal](8, 2) NULL,
	[SpO2] [decimal](5, 2) NULL,
	[BMI] [decimal](8, 2) NULL,
	[HeadCircumference] [decimal](8, 2) NULL,
	[Active] [bit] NULL CONSTRAINT [DF_PatientVitals_Active]  DEFAULT ((0)),
	[DeleteFlag] [bit] NOT NULL CONSTRAINT [DF_PatientVitals_Void]  DEFAULT ((0)),
	[CreatedBy] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL CONSTRAINT [DF_PatientVitals_CreateDate]  DEFAULT (getdate()),
	[AuditData] [xml] NULL,
 CONSTRAINT [PK_PatientVitals_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Person]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Person](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varbinary](800) NOT NULL,
	[MidName] [varbinary](800) NULL,
	[LastName] [varbinary](800) NOT NULL,
	[Sex] [int] NOT NULL,
	[Active] [bit] NOT NULL CONSTRAINT [DF_Person_Active]  DEFAULT ((1)),
	[DeleteFlag] [bit] NOT NULL CONSTRAINT [DF_Person_DeleteFlag]  DEFAULT ((0)),
	[CreateDate] [datetime2](7) NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[AuditData] [xml] NULL,
 CONSTRAINT [PK_Person] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PersonContact]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PersonContact](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PersonId] [int] NOT NULL,
	[PhysicalAddress] [varbinary](max) NOT NULL,
	[MobileNumber] [varbinary](max) NOT NULL,
	[AlternativeNumber] [varbinary](max) NULL,
	[EmailAddress] [varbinary](max) NULL,
	[Active] [bit] NOT NULL CONSTRAINT [DF_PersonContact_IsActive]  DEFAULT ((1)),
	[DeleteFlag] [int] NOT NULL CONSTRAINT [DF_person_contact_void]  DEFAULT ((0)),
	[CreatedBy] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL CONSTRAINT [DF_PersonContact_CreateDate]  DEFAULT (getdate()),
	[AuditData] [xml] NULL,
 CONSTRAINT [PK_person_contact] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PersonLocation]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PersonLocation](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PersonId] [int] NOT NULL,
	[County] [int] NOT NULL,
	[SubCounty] [int] NOT NULL,
	[Ward] [int] NOT NULL,
	[Village] [varchar](250) NOT NULL CONSTRAINT [DF_PatientLocation_Village]  DEFAULT (NULL),
	[Location] [varchar](250) NOT NULL,
	[SubLocation] [varchar](250) NOT NULL,
	[LandMark] [varchar](250) NOT NULL CONSTRAINT [DF_PatientLocation_LandMark]  DEFAULT (NULL),
	[NearestHealthCentre] [varchar](250) NOT NULL CONSTRAINT [DF_PatientLocation_NearestHealthCentre]  DEFAULT (NULL),
	[Active] [bit] NOT NULL CONSTRAINT [DF_PersonLocation_Active]  DEFAULT ((0)),
	[SketchMap] [varbinary](1000) NULL,
	[DeleteFlag] [bit] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[AuditData] [xml] NULL,
 CONSTRAINT [PK_PersonLocation] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PersonRelationship]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PersonRelationship](
	[PersonId] [int] NOT NULL,
	[RelatedTo] [int] NOT NULL,
	[RelationshipTypeId] [int] NOT NULL,
	[DeleteFlag] [bit] NOT NULL CONSTRAINT [DF_PersonRelationship_Void]  DEFAULT ((0)),
	[CreatedBy] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL CONSTRAINT [DF_PersonRelationship_CreateDate]  DEFAULT (getdate()),
	[AuditData] [xml] NULL,
	[ID] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_PersonRelationship] PRIMARY KEY CLUSTERED 
(
	[PersonId] ASC,
	[RelatedTo] ASC,
	[RelationshipTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PhysicalExamination]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PhysicalExamination](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PatientId] [int] NOT NULL,
	[PatientMasterVisitId] [int] NOT NULL,
	[ExaminationTypeId] [int] NOT NULL,
	[ExamId] [int] NOT NULL,
	[Finding] [varchar](400) NOT NULL,
	[DeleteFlag] [bit] NOT NULL,
	[CreateBy] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_PhysicalExamination_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Pregnancy]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Pregnancy](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PatientId] [int] NULL,
	[PatientMasterVisitId] [int] NULL,
	[LMP] [date] NOT NULL,
	[EDD] [date] NOT NULL,
	[Gravidae] [varchar](50) NULL,
	[Parity] [varchar](50) NULL,
	[Outcome] [int] NULL,
	[DateOfOutcome] [date] NULL,
	[DeleteFlag] [bit] NOT NULL,
	[CreateBy] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[AuditData] [xml] NULL,
 CONSTRAINT [PK_Pregnancy] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PregnancyIndicator]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PregnancyIndicator](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PatientId] [int] NOT NULL,
	[PatientMasterVisitId] [int] NOT NULL,
	[LMP] [date] NOT NULL,
	[EDD] [date] NULL,
	[PregnacyStatusId] [int] NULL,
	[ANCProfile] [bit] NOT NULL,
	[ANCProfileDate] [date] NULL,
	[DeleteFlag] [bit] NOT NULL,
	[CreateBy] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[AuditData] [xml] NULL,
 CONSTRAINT [PK_PregnancyIndicator] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PregnancyLog]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PregnancyLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PatientId] [int] NULL,
	[PatientMasterVisitId] [int] NULL,
	[LMP] [date] NOT NULL,
	[EDD] [date] NOT NULL,
	[Outcome] [int] NULL,
	[DateOfOutcome] [date] NULL,
	[Void] [bit] NULL,
	[VoidBy] [int] NULL,
	[VoidDate] [datetime] NULL,
	[CreateBy] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_PregnancyLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[gcPatientView]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/****** Object:  Table [dbo].[ServiceEntryPoint]    Script Date: 3/22/2017 5:42:06 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

USE [IQCareDefault]
GO

/****** Object:  Table [dbo].[Vaccination]    Script Date: 3/22/2017 6:13:55 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[Vaccination](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PatientId] [int] NOT NULL,
	[PatientMasterVisitId] [int] NOT NULL,
	[Vaccine] [int] NOT NULL,
	[VaccineStage] [varchar](50) NOT NULL,
	[DeleteFlag] [bit] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL CONSTRAINT [DF_AdultChildVaccination_CreateDate]  DEFAULT (getdate()),
	[AuditData] [xml] NULL,
	[VaccineDate] [datetime] NULL,
	[Active] [bit] NOT NULL CONSTRAINT [DF_Vaccination_Active]  DEFAULT ((0)),
 CONSTRAINT [PK_Vaccination] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[Vaccination]  WITH CHECK ADD  CONSTRAINT [FK_Vaccination_Patient] FOREIGN KEY([PatientId])
REFERENCES [dbo].[Patient] ([Id])
GO

ALTER TABLE [dbo].[Vaccination] CHECK CONSTRAINT [FK_Vaccination_Patient]
GO

ALTER TABLE [dbo].[Vaccination]  WITH CHECK ADD  CONSTRAINT [FK_Vaccination_PatientMasterVisit] FOREIGN KEY([PatientMasterVisitId])
REFERENCES [dbo].[PatientMasterVisit] ([Id])
GO

ALTER TABLE [dbo].[Vaccination] CHECK CONSTRAINT [FK_Vaccination_PatientMasterVisit]
GO


/****** Object:  Table [dbo].[ServiceArea]    Script Date: 3/23/2017 3:02:30 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[ServiceArea](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](150) NULL,
	[Code] [varchar](10) NULL,
	[DisplayName] [varchar](150) NULL,
	[Void] [bit] NULL CONSTRAINT [DF_ServiceArea_Void]  DEFAULT ((0)),
	[VoidDate] [datetime] NULL CONSTRAINT [DF_ServiceArea_VoidDate]  DEFAULT (getdate()),
	[CreateBy] [int] NOT NULL CONSTRAINT [DF_ServiceArea_CreateBy]  DEFAULT ((0)),
	[CreateDate] [datetime] NOT NULL CONSTRAINT [DF_ServiceArea_CreateDate]  DEFAULT (getdate()),
	[VoidBy] [int] NOT NULL CONSTRAINT [DF_ServiceArea_VoidBy]  DEFAULT ((0)),
 CONSTRAINT [PK_ServiceArea] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


CREATE TABLE [dbo].[ServiceEntryPoint](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PatientId] [int] NOT NULL,
	[ServiceAreaId] [int] NOT NULL,
	[EntryPointId] [int] NOT NULL,
	[DeleteFlag] [bit] NOT NULL CONSTRAINT [DF_ServiceEntryPoint_void]  DEFAULT ((0)),
	[CreatedBy] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL CONSTRAINT [DF_ServiceEntryPoint_CreateDate]  DEFAULT (getdate()),
	[Active] [bit] NOT NULL CONSTRAINT [DF_ServiceEntryPoint_Active]  DEFAULT ((0)),
	[AuditData] [xml] NULL,
 CONSTRAINT [PK_ServiceEntryPoint] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

ALTER TABLE [dbo].[ServiceEntryPoint]  WITH CHECK ADD  CONSTRAINT [FK_ServiceEntryPoint_Patient] FOREIGN KEY([PatientId])
REFERENCES [dbo].[Patient] ([Id])
GO

ALTER TABLE [dbo].[ServiceEntryPoint] CHECK CONSTRAINT [FK_ServiceEntryPoint_Patient]
GO




CREATE VIEW [dbo].[gcPatientView]
AS
SELECT DISTINCT
	          pt.Id AS Id,
		      pt.PersonId AS PersonId,
			  pt.ptn_pk AS ptn_pk,
			  pni.IdentifierValue AS EnrollmentNumber,
			  pt.PatientIndex,
			  CAST(DECRYPTBYKEY(pn.FirstName) AS VARCHAR(50)) AS FirstName,
			  CAST(DECRYPTBYKEY(pn.MidName) AS VARCHAR(50)) AS MiddleName,
			  CAST(DECRYPTBYKEY(pn.LastName) AS VARCHAR(50)) AS LastName,
			  pn.Sex, 
             pn.Active,
			  pt.CreateDate AS RegistrationDate,
			  pe.EnrollmentDate AS [EnrollmentDate ],
			  --(pe.CareEnded ) AS PatientStatus,
			 CAST(			  ( 
			    case pe.CareEnded
				 when 0 then 'Active'
				 when 1 then
				 'In-Active'
				  --(SELECT * FROM lookupItem WHERE Id IN(SELECT c.ExitReason FROM PatientCareending c
					 --  INNER JOIN patient p
					 --  on
					 --  p.Id= c.PatientId))
				end
			    ) as varchar(50)) PatientStatus ,
			  pt.DateOfBirth 'DateOfBirth', 
              CAST(DECRYPTBYKEY(pt.NationalId) AS VARCHAR(50)) AS NationalId,
			  pt.FacilityId,
			  pt.PatientType,
			  pe.TransferIn
FROM            dbo.Patient pt INNER JOIN
                         dbo.Person pn ON pn.Id = pt.PersonId INNER JOIN
                         dbo.PatientEnrollment pe ON pt.Id = pe.PatientId INNER JOIN
                         dbo.PatientIdentifier pni ON pni.PatientId =pt.Id 

WHERE
			pni.IdentifierTypeId IN(SELECT Id FROM dbo.LookupItem WHERE Name='CCCNumber')



GO
/****** Object:  View [dbo].[LookupItemView]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[LookupItemView]
AS
SELECT        MasterId, ItemId, MasterName, ItemName, DisplayName, ItemDisplayName, OrdRank, ISNULL(ROW_NUMBER() OVER(ORDER BY ItemId DESC), -1) AS RowID
FROM            (SELECT        M.Id AS MasterId, I.Id AS ItemId, M.Name AS MasterName, I.Name AS ItemName, L.DisplayName, L.DisplayName AS ItemDisplayName, L.OrdRank
                          FROM            dbo.LookupMaster AS M INNER JOIN
                                                    dbo.LookupMasterItem AS L ON M.Id = L.LookupMasterId INNER JOIN
                                                    dbo.LookupItem AS I ON L.LookupItemId = I.Id) AS X


GO
/****** Object:  View [dbo].[PatientBaselineView]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[PatientBaselineView]
AS
SELECT        dbo.PatientHivDiagnosis.PatientId, dbo.PatientHivDiagnosis.Id, dbo.PatientHivDiagnosis.PatientMasterVisitId, dbo.PatientTransferIn.ServiceAreaId, dbo.PatientTransferIn.TransferInDate, 
                         dbo.PatientTransferIn.TreatmentStartDate, dbo.PatientTransferIn.CurrentTreatment,
                             (SELECT        Name + ' (' + DisplayName + ')' AS Expr1
                               FROM            dbo.LookupItem
                               WHERE        (Id = dbo.PatientTransferIn.CurrentTreatment)) AS CurrentTreatmentName, dbo.PatientTransferIn.FacilityFrom, dbo.PatientTransferIn.MFLCode, dbo.PatientTransferIn.CountyFrom, 
                         dbo.PatientTransferIn.TransferInNotes, dbo.PatientHivDiagnosis.HIVDiagnosisDate, dbo.PatientHivDiagnosis.EnrollmentDate, dbo.PatientHivDiagnosis.EnrollmentWHOStage,
                             (SELECT        Name
                               FROM            dbo.LookupItem
                               WHERE        (Id = dbo.PatientHivDiagnosis.EnrollmentWHOStage)) AS EnrollmentWHOStageName, dbo.PatientHivDiagnosis.ARTInitiationDate, dbo.PatientTreatmentInitiation.DateStartedOnFirstLine, 
                         dbo.PatientTreatmentInitiation.Cohort, dbo.PatientTreatmentInitiation.Regimen,
                             (SELECT        Name + ' (' + DisplayName + ')' AS Expr1
                               FROM            dbo.LookupItem
                               WHERE        (Id = dbo.PatientTreatmentInitiation.Regimen)) AS RegimenName, dbo.PatientTreatmentInitiation.BaselineViralload, dbo.PatientTreatmentInitiation.BaselineViralloadDate, 
                         dbo.PatientBaselineAssessment.HBVInfected, dbo.PatientBaselineAssessment.Pregnant, dbo.PatientBaselineAssessment.TBinfected, dbo.PatientBaselineAssessment.WHOStage,
                             (SELECT        Name
                               FROM            dbo.LookupItem
                               WHERE        (Id = dbo.PatientBaselineAssessment.WHOStage)) AS WhoStageName, dbo.PatientBaselineAssessment.BreastFeeding, dbo.PatientBaselineAssessment.CD4Count, 
                         dbo.PatientBaselineAssessment.MUAC, dbo.PatientBaselineAssessment.Weight, dbo.PatientBaselineAssessment.Height, dbo.PatientBaselineAssessment.BMI
FROM           dbo.PatientHivDiagnosis LEFT OUTER JOIN
                          dbo.PatientTransferIn ON dbo.PatientHivDiagnosis.PatientId = dbo.PatientTransferIn.PatientId LEFT OUTER JOIN
                         dbo.PatientTreatmentInitiation ON dbo.PatientHivDiagnosis.PatientId = dbo.PatientTreatmentInitiation.PatientId LEFT OUTER JOIN
                         dbo.PatientBaselineAssessment ON dbo.PatientHivDiagnosis.PatientId = dbo.PatientBaselineAssessment.PatientId


GO
/****** Object:  View [dbo].[PatientView]    Script Date: 3/22/2017 12:06:58 PM ******/
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
From mst_Patient
Where (DeleteFlag = 0 Or DeleteFlag Is Null)

GO
/****** Object:  View [dbo].[PatientVisitView]    Script Date: 3/22/2017 12:06:58 PM ******/
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
/****** Object:  View [dbo].[PersonContactView]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[PersonContactView]
AS
SELECT        Id, PersonId, CAST(DECRYPTBYKEY(PhysicalAddress) AS VARCHAR(50)) AS PhysicalAddress, CAST(DECRYPTBYKEY(MobileNumber) AS VARCHAR(50)) AS MobileNumber, 
                         CAST(DECRYPTBYKEY(AlternativeNumber) AS VARCHAR(50)) AS AlternativeNumber, CAST(DECRYPTBYKEY(EmailAddress) AS VARCHAR(50)) AS EmailAddress, Active, DeleteFlag, CreatedBy, CreateDate
FROM            dbo.PersonContact


GO
/****** Object:  View [dbo].[PersonView]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[PersonView]
AS
SELECT        Id, CAST(DECRYPTBYKEY(FirstName) AS VARCHAR(50)) AS FirstName, CAST(DECRYPTBYKEY(MidName) AS VARCHAR(50)) AS MiddleName, CAST(DECRYPTBYKEY(LastName) AS VARCHAR(50)) AS LastName, 
                         Sex, Active, DeleteFlag, CreateDate, CreatedBy, AuditData
FROM            dbo.Person


GO
/****** Object:  View [dbo].[view_patientVisit]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_patientVisit]
AS
SELECT        TOP (100) PERCENT dbo.PatientMasterVisit.id AS visitID, 'Green Card' AS VisitName, dbo.PatientMasterVisit.patientId, dbo.PatientMasterVisit.visitDate, 
                         dbo.mst_User.UserName, dbo.PatientMasterVisit.DeleteFlag
FROM            dbo.PatientMasterVisit INNER JOIN
                         dbo.mst_User ON dbo.PatientMasterVisit.createdBy = dbo.mst_User.UserID
WHERE        (dbo.PatientMasterVisit.visitDate IS NOT NULL) AND (dbo.PatientMasterVisit.DeleteFlag IS NULL OR
                         dbo.PatientMasterVisit.DeleteFlag = 0)


GO


ALTER VIEW [dbo].[PatientBaselineView]
AS
SELECT        dbo.PatientHivDiagnosis.PatientId, dbo.PatientHivDiagnosis.Id, dbo.PatientHivDiagnosis.PatientMasterVisitId, dbo.PatientTransferIn.ServiceAreaId, dbo.PatientTransferIn.TransferInDate, 
                         dbo.PatientTransferIn.TreatmentStartDate, ISNULL(dbo.PatientTransferIn.CurrentTreatment,0) 'CurrentTreatment',
                             (SELECT        Name + ' (' + DisplayName + ')' AS Expr1
                               FROM            dbo.LookupItem
                               WHERE        (Id = dbo.PatientTransferIn.CurrentTreatment)) AS CurrentTreatmentName, ISNULL(dbo.PatientTransferIn.FacilityFrom,'N/A') 'FacilityFrom', dbo.PatientTransferIn.MFLCode, dbo.PatientTransferIn.CountyFrom, 
                         dbo.PatientTransferIn.TransferInNotes, dbo.PatientHivDiagnosis.HIVDiagnosisDate, dbo.PatientHivDiagnosis.EnrollmentDate, ISNULL(dbo.PatientHivDiagnosis.EnrollmentWHOStage,0) 'EnrollmentWHOStage',
                             (SELECT        Name
                               FROM            dbo.LookupItem
                               WHERE        (Id = dbo.PatientHivDiagnosis.EnrollmentWHOStage)) AS EnrollmentWHOStageName, dbo.PatientHivDiagnosis.ARTInitiationDate, dbo.PatientTreatmentInitiation.DateStartedOnFirstLine, 
                         dbo.PatientTreatmentInitiation.Cohort, ISNULL(dbo.PatientTreatmentInitiation.Regimen,0) 'Regimen',
                            ISNULL((SELECT        Name + ' (' + DisplayName + ')' AS Expr1
                               FROM            dbo.LookupItem
                               WHERE        (Id = dbo.PatientTreatmentInitiation.Regimen)),'N/A') AS RegimenName, dbo.PatientTreatmentInitiation.BaselineViralload, dbo.PatientTreatmentInitiation.BaselineViralloadDate, 
                         dbo.PatientBaselineAssessment.HBVInfected, dbo.PatientBaselineAssessment.Pregnant, dbo.PatientBaselineAssessment.TBinfected,ISNULL(dbo.PatientBaselineAssessment.WHOStage,0) 'WHOStage',
                             (SELECT        Name
                               FROM            dbo.LookupItem
                               WHERE        (Id = dbo.PatientBaselineAssessment.WHOStage)) AS WhoStageName, dbo.PatientBaselineAssessment.BreastFeeding, dbo.PatientBaselineAssessment.CD4Count, 
                         dbo.PatientBaselineAssessment.MUAC, dbo.PatientBaselineAssessment.Weight, dbo.PatientBaselineAssessment.Height, dbo.PatientBaselineAssessment.BMI
FROM           dbo.PatientHivDiagnosis LEFT OUTER JOIN
                          dbo.PatientTransferIn ON dbo.PatientHivDiagnosis.PatientId = dbo.PatientTransferIn.PatientId LEFT OUTER JOIN
                         dbo.PatientTreatmentInitiation ON dbo.PatientHivDiagnosis.PatientId = dbo.PatientTreatmentInitiation.PatientId LEFT OUTER JOIN
                         dbo.PatientBaselineAssessment ON dbo.PatientHivDiagnosis.PatientId = dbo.PatientBaselineAssessment.PatientId



GO



ALTER TABLE [dbo].[AdherenceOutcome] ADD  CONSTRAINT [DF_PatientAdheranceAssessment_Void]  DEFAULT ((0)) FOR [DeleteFlag]
GO
ALTER TABLE [dbo].[AdultChildVaccination] ADD  CONSTRAINT [DF_AdultChildVaccination_Void]  DEFAULT ((0)) FOR [Void]
GO
ALTER TABLE [dbo].[AdverseEvent] ADD  CONSTRAINT [DF_AdverseEvent_DeleteFlag]  DEFAULT ((0)) FOR [DeleteFlag]
GO
ALTER TABLE [dbo].[AdverseEvent] ADD  CONSTRAINT [DF_AdverseEvent_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[ARTPataient] ADD  CONSTRAINT [DF_ARTPataient_DeleteFlag]  DEFAULT ((0)) FOR [DeleteFlag]
GO
ALTER TABLE [dbo].[ARVTreatmentTracker] ADD  CONSTRAINT [DF_ARVTreatmentTracker_RegimenLineId]  DEFAULT ((0)) FOR [RegimenLineId]
GO
ALTER TABLE [dbo].[ARVTreatmentTracker] ADD  CONSTRAINT [DF_ARVTreatmentTracker_DrugId]  DEFAULT ((0)) FOR [DrugId]
GO
ALTER TABLE [dbo].[ARVTreatmentTracker] ADD  CONSTRAINT [DF_ARVTreatmentTracker_ParentId]  DEFAULT ((0)) FOR [ParentId]
GO
ALTER TABLE [dbo].[ARVTreatmentTracker] ADD  CONSTRAINT [DF_ARVTreatmentTracker_DeleteFlag]  DEFAULT ((0)) FOR [DeleteFlag]
GO
ALTER TABLE [dbo].[ARVTreatmentTracker] ADD  CONSTRAINT [DF_ARVTreatmentTracker_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[HIVEnrollmentBaseline] ADD  CONSTRAINT [DF_DiagnosisARVHistory_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[Marital_Status] ADD  CONSTRAINT [DF_Marital_Status_DeleteFlag]  DEFAULT ((0)) FOR [DeleteFlag]
GO
ALTER TABLE [dbo].[ModuleMaster] ADD  CONSTRAINT [DF_ModuleMaster_DeleteFlag]  DEFAULT ((0)) FOR [DeleteFlag]
GO
ALTER TABLE [dbo].[ModuleMaster] ADD  CONSTRAINT [DF_ModuleMaster_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[PatientAllergies] ADD  CONSTRAINT [DF_PatientAllergies_void]  DEFAULT ((0)) FOR [Void]
GO
ALTER TABLE [dbo].[PatientAllergy] ADD  CONSTRAINT [DF_PatientAllergy_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[PatientCareending] ADD  CONSTRAINT [DF_PatientCareending_Active]  DEFAULT ((0)) FOR [Active]
GO
ALTER TABLE [dbo].[PatientCareending] ADD  CONSTRAINT [DF_PatientCareending_void]  DEFAULT ((0)) FOR [DeleteFlag]
GO
ALTER TABLE [dbo].[PatientChronicIllness] ADD  CONSTRAINT [DF_ChronicIllness_void]  DEFAULT ((0)) FOR [DeleteFlag]
GO
ALTER TABLE [dbo].[PatientChronicIllness] ADD  CONSTRAINT [DF_PatientChronicIllness_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[PatientClinicalDiagnosis] ADD  CONSTRAINT [DF_PatientTreatementDiagnosis_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[PatientClinicalNotes] ADD  CONSTRAINT [DF_PatientClinicalNotes_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[PatientConsent] ADD  CONSTRAINT [DF_PatientConsent_IsActive]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[PatientConsent] ADD  CONSTRAINT [DF_PatientConsent_Void]  DEFAULT ((0)) FOR [DeleteFlag]
GO
ALTER TABLE [dbo].[PatientConsent] ADD  CONSTRAINT [DF_PatientConsent_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[PatientContact] ADD  CONSTRAINT [DF_PatientContact_IsActive]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[PatientContact] ADD  CONSTRAINT [DF_patient_contact_void]  DEFAULT ((0)) FOR [DeleteFlag]
GO
ALTER TABLE [dbo].[PatientDiagnosis] ADD  CONSTRAINT [DF_PatientDiagnosis_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[PatientEncounter] ADD  CONSTRAINT [DF_patient_encounter_void]  DEFAULT ((0)) FOR [DeleteFlag]
GO
ALTER TABLE [dbo].[PatientEncounter] ADD  CONSTRAINT [DF_PatientEncounter_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[PatientFamilyPlanning] ADD  CONSTRAINT [DF_PatientFamilyPlanning_DeleteFlag]  DEFAULT ((0)) FOR [DeleteFlag]
GO
ALTER TABLE [dbo].[PatientFamilyPlanning] ADD  CONSTRAINT [DF_PatientFamilyPlanning_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[PatientFamilyPlanningMethod] ADD  CONSTRAINT [DF_PatientFamilyPlanningMethod_DeleteFlag]  DEFAULT ((0)) FOR [DeleteFlag]
GO
ALTER TABLE [dbo].[PatientLocation] ADD  CONSTRAINT [DF_person_location_is_active]  DEFAULT ((0)) FOR [is_active]
GO
ALTER TABLE [dbo].[PatientLocation] ADD  CONSTRAINT [DF_person_location_void]  DEFAULT ((0)) FOR [Void]
GO
ALTER TABLE [dbo].[PatientLocation] ADD  CONSTRAINT [DF_person_location_create_by]  DEFAULT ((0)) FOR [createBy]
GO
ALTER TABLE [dbo].[PatientPHDP] ADD  CONSTRAINT [DF_PatientPHDP_Void]  DEFAULT ((0)) FOR [DeleteFlag]
GO
ALTER TABLE [dbo].[PatientPHDP] ADD  CONSTRAINT [DF_PatientPHDP_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[PatientPhysicalExamination] ADD  CONSTRAINT [DF_PatientPhysicalExamination_Void]  DEFAULT ((0)) FOR [Void]
GO
ALTER TABLE [dbo].[PatientReferral] ADD  CONSTRAINT [DF_PatientReferral_DeleteFlag]  DEFAULT ((0)) FOR [DeleteFlag]
GO
ALTER TABLE [dbo].[PatientReferral] ADD  CONSTRAINT [DF_PatientReferral_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[PatientScreening] ADD  CONSTRAINT [DF_PatientScreening_Void]  DEFAULT ((0)) FOR [DeleteFlag]
GO
ALTER TABLE [dbo].[PatientScreening] ADD  CONSTRAINT [DF_PatientScreening_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[PatientTreatementDiagnosis] ADD  CONSTRAINT [DF_PatientTreatementDiagnosis_Void]  DEFAULT ((0)) FOR [Void]
GO
ALTER TABLE [dbo].[PatientTreatementDiagnosis] ADD  CONSTRAINT [DF_PatientTreatementDiagnosis_VoidBy]  DEFAULT ((0)) FOR [VoidBy]
GO
ALTER TABLE [dbo].[PhysicalExamination] ADD  CONSTRAINT [DF_PhysicalExamination_Void]  DEFAULT ((0)) FOR [DeleteFlag]
GO
ALTER TABLE [dbo].[PhysicalExamination] ADD  CONSTRAINT [DF_PhysicalExamination_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[Pregnancy] ADD  CONSTRAINT [DF_Pregnancy_Void]  DEFAULT ((0)) FOR [DeleteFlag]
GO
ALTER TABLE [dbo].[Pregnancy] ADD  CONSTRAINT [DF_Pregnancy_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[PregnancyIndicator] ADD  CONSTRAINT [DF_PregnancyIndicator_ANCProfile]  DEFAULT ((0)) FOR [ANCProfile]
GO
ALTER TABLE [dbo].[PregnancyIndicator] ADD  CONSTRAINT [DF_PregnancyIndicator_DeleteFlag]  DEFAULT ((0)) FOR [DeleteFlag]
GO
ALTER TABLE [dbo].[PregnancyIndicator] ADD  CONSTRAINT [DF_PregnancyIndicator_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[AdherenceOutcome]  WITH CHECK ADD  CONSTRAINT [FK_AdherenceOutcome_Patient] FOREIGN KEY([PatientId])
REFERENCES [dbo].[Patient] ([Id])
GO
ALTER TABLE [dbo].[AdherenceOutcome] CHECK CONSTRAINT [FK_AdherenceOutcome_Patient]
GO
ALTER TABLE [dbo].[AdherenceOutcome]  WITH CHECK ADD  CONSTRAINT [FK_PatientAdheranceAssessment_PatientMasterVisit] FOREIGN KEY([PatientMasterVisitId])
REFERENCES [dbo].[PatientMasterVisit] ([Id])
GO
ALTER TABLE [dbo].[AdherenceOutcome] CHECK CONSTRAINT [FK_PatientAdheranceAssessment_PatientMasterVisit]
GO
ALTER TABLE [dbo].[AdultChildVaccination]  WITH CHECK ADD  CONSTRAINT [FK_AdultChildVaccination_Patient] FOREIGN KEY([PatientId])
REFERENCES [dbo].[Patient] ([Id])
GO
ALTER TABLE [dbo].[AdultChildVaccination] CHECK CONSTRAINT [FK_AdultChildVaccination_Patient]
GO
ALTER TABLE [dbo].[AdultChildVaccination]  WITH CHECK ADD  CONSTRAINT [FK_AdultChildVaccination_PatientMasterVisit] FOREIGN KEY([PatientMasterVisitId])
REFERENCES [dbo].[PatientMasterVisit] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AdultChildVaccination] CHECK CONSTRAINT [FK_AdultChildVaccination_PatientMasterVisit]
GO
ALTER TABLE [dbo].[AdverseEvent]  WITH CHECK ADD  CONSTRAINT [FK_AdverseEvent_Patient] FOREIGN KEY([PatientId])
REFERENCES [dbo].[Patient] ([Id])
GO
ALTER TABLE [dbo].[AdverseEvent] CHECK CONSTRAINT [FK_AdverseEvent_Patient]
GO
ALTER TABLE [dbo].[AdverseEvent]  WITH CHECK ADD  CONSTRAINT [FK_AdverseEvent_PatientMasterVisit] FOREIGN KEY([PatientMasterVisitId])
REFERENCES [dbo].[PatientMasterVisit] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AdverseEvent] CHECK CONSTRAINT [FK_AdverseEvent_PatientMasterVisit]
GO
ALTER TABLE [dbo].[ARVTreatmentTracker]  WITH CHECK ADD  CONSTRAINT [FK_ARVTreatmentTracker_Patient] FOREIGN KEY([PatientId])
REFERENCES [dbo].[Patient] ([Id])
GO
ALTER TABLE [dbo].[ARVTreatmentTracker] CHECK CONSTRAINT [FK_ARVTreatmentTracker_Patient]
GO
ALTER TABLE [dbo].[ARVTreatmentTracker]  WITH CHECK ADD  CONSTRAINT [FK_ARVTreatmentTracker_PatientMasterVisit] FOREIGN KEY([PatientMasterVisitId])
REFERENCES [dbo].[PatientMasterVisit] ([Id])
GO
ALTER TABLE [dbo].[ARVTreatmentTracker] CHECK CONSTRAINT [FK_ARVTreatmentTracker_PatientMasterVisit]
GO
ALTER TABLE [dbo].[ComplaintsHistory]  WITH CHECK ADD  CONSTRAINT [FK_ComplaintsHistory_PatientMasterVisit] FOREIGN KEY([PatientMasterVisitId])
REFERENCES [dbo].[PatientMasterVisit] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ComplaintsHistory] CHECK CONSTRAINT [FK_ComplaintsHistory_PatientMasterVisit]
GO
ALTER TABLE [dbo].[Disclosure]  WITH CHECK ADD  CONSTRAINT [FK_Disclosure_PatientMasterVisit] FOREIGN KEY([PatientMasterVisitId])
REFERENCES [dbo].[PatientMasterVisit] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Disclosure] CHECK CONSTRAINT [FK_Disclosure_PatientMasterVisit]
GO
ALTER TABLE [dbo].[HIVEnrollmentBaseline]  WITH CHECK ADD  CONSTRAINT [FK_HIVEnrollmentBaseline_Patient] FOREIGN KEY([PatientId])
REFERENCES [dbo].[Patient] ([Id])
GO
ALTER TABLE [dbo].[HIVEnrollmentBaseline] CHECK CONSTRAINT [FK_HIVEnrollmentBaseline_Patient]
GO
ALTER TABLE [dbo].[HIVEnrollmentBaseline]  WITH CHECK ADD  CONSTRAINT [FK_HIVEnrollmentBaseline_PatientMasterVisit] FOREIGN KEY([PatientMasterVisitId])
REFERENCES [dbo].[PatientMasterVisit] ([Id])
GO
ALTER TABLE [dbo].[HIVEnrollmentBaseline] CHECK CONSTRAINT [FK_HIVEnrollmentBaseline_PatientMasterVisit]
GO
ALTER TABLE [dbo].[INHProphylaxis]  WITH CHECK ADD  CONSTRAINT [FK_INHProphylaxis_PatientMasterVisit] FOREIGN KEY([PatientMasterVisitId])
REFERENCES [dbo].[PatientMasterVisit] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[INHProphylaxis] CHECK CONSTRAINT [FK_INHProphylaxis_PatientMasterVisit]
GO
ALTER TABLE [dbo].[Patient]  WITH CHECK ADD  CONSTRAINT [FK_Patient_Patient] FOREIGN KEY([Id])
REFERENCES [dbo].[Patient] ([Id])
GO
ALTER TABLE [dbo].[Patient] CHECK CONSTRAINT [FK_Patient_Patient]
GO
ALTER TABLE [dbo].[Patient]  WITH CHECK ADD  CONSTRAINT [FK_Patient_Person] FOREIGN KEY([PersonId])
REFERENCES [dbo].[Person] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Patient] CHECK CONSTRAINT [FK_Patient_Person]
GO
ALTER TABLE [dbo].[PatientAllergies]  WITH CHECK ADD  CONSTRAINT [FK_PatientAllergies_PatientMasterVisit] FOREIGN KEY([PatientMasterVisitId])
REFERENCES [dbo].[PatientMasterVisit] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PatientAllergies] CHECK CONSTRAINT [FK_PatientAllergies_PatientMasterVisit]
GO
ALTER TABLE [dbo].[PatientAppointment]  WITH CHECK ADD  CONSTRAINT [FK_PatientAppointment_PatientMasterVisit] FOREIGN KEY([PatientMasterVisitId])
REFERENCES [dbo].[PatientMasterVisit] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PatientAppointment] CHECK CONSTRAINT [FK_PatientAppointment_PatientMasterVisit]
GO
ALTER TABLE [dbo].[PatientARVHistory]  WITH CHECK ADD  CONSTRAINT [FK_ARTUseHistory_Patient] FOREIGN KEY([PatientId])
REFERENCES [dbo].[Patient] ([Id])
GO
ALTER TABLE [dbo].[PatientARVHistory] CHECK CONSTRAINT [FK_ARTUseHistory_Patient]
GO
ALTER TABLE [dbo].[PatientARVHistory]  WITH CHECK ADD  CONSTRAINT [FK_ARTUseHistory_PatientMasterVisit] FOREIGN KEY([PatientMasterVisitId])
REFERENCES [dbo].[PatientMasterVisit] ([Id])
GO
ALTER TABLE [dbo].[PatientARVHistory] CHECK CONSTRAINT [FK_ARTUseHistory_PatientMasterVisit]
GO
ALTER TABLE [dbo].[PatientBaselineAssessment]  WITH CHECK ADD  CONSTRAINT [FK_ARTInitiationBaseline_Patient] FOREIGN KEY([PatientId])
REFERENCES [dbo].[Patient] ([Id])
GO
ALTER TABLE [dbo].[PatientBaselineAssessment] CHECK CONSTRAINT [FK_ARTInitiationBaseline_Patient]
GO
ALTER TABLE [dbo].[PatientBaselineAssessment]  WITH CHECK ADD  CONSTRAINT [FK_ARTInitiationBaseline_PatientMasterVisit] FOREIGN KEY([PatientMasterVisitId])
REFERENCES [dbo].[PatientMasterVisit] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PatientBaselineAssessment] CHECK CONSTRAINT [FK_ARTInitiationBaseline_PatientMasterVisit]
GO
ALTER TABLE [dbo].[PatientCareending]  WITH CHECK ADD  CONSTRAINT [FK_PatientCareending_PatientMasterVisit] FOREIGN KEY([PatientMasterVisitId])
REFERENCES [dbo].[PatientMasterVisit] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PatientCareending] CHECK CONSTRAINT [FK_PatientCareending_PatientMasterVisit]
GO
ALTER TABLE [dbo].[PatientChronicIllness]  WITH CHECK ADD  CONSTRAINT [FK_PatientChronicIllness_PatientMasterVisit] FOREIGN KEY([PatientMasterVisitId])
REFERENCES [dbo].[PatientMasterVisit] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PatientChronicIllness] CHECK CONSTRAINT [FK_PatientChronicIllness_PatientMasterVisit]
GO
ALTER TABLE [dbo].[PatientClinicalNotes]  WITH CHECK ADD  CONSTRAINT [FK_PatientClinicalNotes_Patient] FOREIGN KEY([PatientId])
REFERENCES [dbo].[Patient] ([Id])
GO
ALTER TABLE [dbo].[PatientClinicalNotes] CHECK CONSTRAINT [FK_PatientClinicalNotes_Patient]
GO
ALTER TABLE [dbo].[PatientClinicalNotes]  WITH CHECK ADD  CONSTRAINT [FK_PatientClinicalNotes_PatientMasterVisit] FOREIGN KEY([PatientMasterVisitId])
REFERENCES [dbo].[PatientMasterVisit] ([Id])
GO
ALTER TABLE [dbo].[PatientClinicalNotes] CHECK CONSTRAINT [FK_PatientClinicalNotes_PatientMasterVisit]
GO
ALTER TABLE [dbo].[PatientContact]  WITH CHECK ADD  CONSTRAINT [FK_PatientContact_Person] FOREIGN KEY([PersonId])
REFERENCES [dbo].[Person] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PatientContact] CHECK CONSTRAINT [FK_PatientContact_Person]
GO
ALTER TABLE [dbo].[PatientDiagnosis]  WITH CHECK ADD  CONSTRAINT [FK_PatientDiagnosis_PatientMasterVisit] FOREIGN KEY([PatientMasterVisitId])
REFERENCES [dbo].[PatientMasterVisit] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PatientDiagnosis] CHECK CONSTRAINT [FK_PatientDiagnosis_PatientMasterVisit]
GO
ALTER TABLE [dbo].[PatientEncounter]  WITH CHECK ADD  CONSTRAINT [FK_PatientEncounter_Patient] FOREIGN KEY([PatientId])
REFERENCES [dbo].[Patient] ([Id])
GO
ALTER TABLE [dbo].[PatientEncounter] CHECK CONSTRAINT [FK_PatientEncounter_Patient]
GO
ALTER TABLE [dbo].[PatientEncounter]  WITH CHECK ADD  CONSTRAINT [FK_PatientEncounter_PatientMasterVisit] FOREIGN KEY([PatientMasterVisitId])
REFERENCES [dbo].[PatientMasterVisit] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PatientEncounter] CHECK CONSTRAINT [FK_PatientEncounter_PatientMasterVisit]
GO
ALTER TABLE [dbo].[PatientFamilyPlanning]  WITH CHECK ADD  CONSTRAINT [FK_PatientFamilyPlanning_Patient] FOREIGN KEY([PatientId])
REFERENCES [dbo].[Patient] ([Id])
GO
ALTER TABLE [dbo].[PatientFamilyPlanning] CHECK CONSTRAINT [FK_PatientFamilyPlanning_Patient]
GO
ALTER TABLE [dbo].[PatientFamilyPlanning]  WITH CHECK ADD  CONSTRAINT [FK_PatientFamilyPlanning_PatientMasterVisit] FOREIGN KEY([PatientMasterVisitId])
REFERENCES [dbo].[PatientMasterVisit] ([Id])
GO
ALTER TABLE [dbo].[PatientFamilyPlanning] CHECK CONSTRAINT [FK_PatientFamilyPlanning_PatientMasterVisit]
GO
ALTER TABLE [dbo].[PatientFamilyPlanningMethod]  WITH CHECK ADD  CONSTRAINT [FK_PatientFamilyPlanningMethod_PatientFamilyPlanning] FOREIGN KEY([PatientFPId])
REFERENCES [dbo].[PatientFamilyPlanning] ([Id])
GO
ALTER TABLE [dbo].[PatientFamilyPlanningMethod] CHECK CONSTRAINT [FK_PatientFamilyPlanningMethod_PatientFamilyPlanning]
GO
ALTER TABLE [dbo].[PatientHivDiagnosis]  WITH CHECK ADD  CONSTRAINT [FK_DiagnosisARVHistory_Patient] FOREIGN KEY([PatientId])
REFERENCES [dbo].[Patient] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PatientHivDiagnosis] CHECK CONSTRAINT [FK_DiagnosisARVHistory_Patient]
GO
ALTER TABLE [dbo].[PatientIdentifier]  WITH CHECK ADD  CONSTRAINT [FK_PatientIdentifier_Patient] FOREIGN KEY([PatientId])
REFERENCES [dbo].[Patient] ([Id])
GO
ALTER TABLE [dbo].[PatientIdentifier] CHECK CONSTRAINT [FK_PatientIdentifier_Patient]
GO
ALTER TABLE [dbo].[PatientIdentifier]  WITH CHECK ADD  CONSTRAINT [FK_PatientIdentifier_PatientEnrollment] FOREIGN KEY([PatientEnrollmentId])
REFERENCES [dbo].[PatientEnrollment] ([Id])
GO
ALTER TABLE [dbo].[PatientIdentifier] CHECK CONSTRAINT [FK_PatientIdentifier_PatientEnrollment]
GO
ALTER TABLE [dbo].[PatientLabTracker]  WITH CHECK ADD  CONSTRAINT [FK_PatientLabTracker_PatientMasterVisit] FOREIGN KEY([PatientMasterVisitId])
REFERENCES [dbo].[PatientMasterVisit] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PatientLabTracker] CHECK CONSTRAINT [FK_PatientLabTracker_PatientMasterVisit]
GO
ALTER TABLE [dbo].[PatientLocation]  WITH CHECK ADD  CONSTRAINT [FK_PatientLocation_Patient] FOREIGN KEY([PatientId])
REFERENCES [dbo].[Patient] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PatientLocation] CHECK CONSTRAINT [FK_PatientLocation_Patient]
GO
ALTER TABLE [dbo].[PatientMaritalStatus]  WITH CHECK ADD  CONSTRAINT [FK_PatientMaritalStatus_Person] FOREIGN KEY([PersonId])
REFERENCES [dbo].[Person] ([Id])
GO
ALTER TABLE [dbo].[PatientMaritalStatus] CHECK CONSTRAINT [FK_PatientMaritalStatus_Person]
GO
ALTER TABLE [dbo].[PatientOVCStatus]  WITH CHECK ADD  CONSTRAINT [FK_PatientOVCStatus_Person] FOREIGN KEY([PersonId])
REFERENCES [dbo].[Person] ([Id])
GO
ALTER TABLE [dbo].[PatientOVCStatus] CHECK CONSTRAINT [FK_PatientOVCStatus_Person]
GO
ALTER TABLE [dbo].[PatientOVCStatus]  WITH CHECK ADD  CONSTRAINT [FK_PatientOVCStatus_Person1] FOREIGN KEY([GuardianId])
REFERENCES [dbo].[Person] ([Id])
GO
ALTER TABLE [dbo].[PatientOVCStatus] CHECK CONSTRAINT [FK_PatientOVCStatus_Person1]
GO
ALTER TABLE [dbo].[PatientPHDP]  WITH CHECK ADD  CONSTRAINT [FK_PatientPHDP_PatientMasterVisit] FOREIGN KEY([PatientMasterVisitId])
REFERENCES [dbo].[PatientMasterVisit] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PatientPHDP] CHECK CONSTRAINT [FK_PatientPHDP_PatientMasterVisit]
GO
ALTER TABLE [dbo].[PatientPhysicalExamination]  WITH CHECK ADD  CONSTRAINT [FK_PatientPhysicalExamination_PatientMasterVisit] FOREIGN KEY([PatientMasterVisitId])
REFERENCES [dbo].[PatientMasterVisit] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PatientPhysicalExamination] CHECK CONSTRAINT [FK_PatientPhysicalExamination_PatientMasterVisit]
GO
ALTER TABLE [dbo].[PatientPopulation]  WITH CHECK ADD  CONSTRAINT [FK_PatientPopulation_Person] FOREIGN KEY([PersonId])
REFERENCES [dbo].[Person] ([Id])
GO
ALTER TABLE [dbo].[PatientPopulation] CHECK CONSTRAINT [FK_PatientPopulation_Person]
GO
ALTER TABLE [dbo].[PatientProphylaxis]  WITH CHECK ADD  CONSTRAINT [FK_PatientProphylaxis_Patient] FOREIGN KEY([PatientId])
REFERENCES [dbo].[Patient] ([Id])
GO
ALTER TABLE [dbo].[PatientProphylaxis] CHECK CONSTRAINT [FK_PatientProphylaxis_Patient]
GO
ALTER TABLE [dbo].[PatientProphylaxis]  WITH CHECK ADD  CONSTRAINT [FK_PatientProphylaxis_PatientMasterVisit] FOREIGN KEY([PatientMasterVisitId])
REFERENCES [dbo].[PatientMasterVisit] ([Id])
GO
ALTER TABLE [dbo].[PatientProphylaxis] CHECK CONSTRAINT [FK_PatientProphylaxis_PatientMasterVisit]
GO
ALTER TABLE [dbo].[PatientReferral]  WITH CHECK ADD  CONSTRAINT [FK_PatientReferral_PatientMasterVisit] FOREIGN KEY([PatientMasterVisitId])
REFERENCES [dbo].[PatientMasterVisit] ([Id])
GO
ALTER TABLE [dbo].[PatientReferral] CHECK CONSTRAINT [FK_PatientReferral_PatientMasterVisit]
GO
ALTER TABLE [dbo].[PatientScreening]  WITH CHECK ADD  CONSTRAINT [FK_PatientScreening_Patient] FOREIGN KEY([PatientId])
REFERENCES [dbo].[Patient] ([Id])
GO
ALTER TABLE [dbo].[PatientScreening] CHECK CONSTRAINT [FK_PatientScreening_Patient]
GO
ALTER TABLE [dbo].[PatientScreening]  WITH CHECK ADD  CONSTRAINT [FK_PatientScreening_PatientMasterVisit] FOREIGN KEY([PatientMasterVisitId])
REFERENCES [dbo].[PatientMasterVisit] ([Id])
GO
ALTER TABLE [dbo].[PatientScreening] CHECK CONSTRAINT [FK_PatientScreening_PatientMasterVisit]
GO
ALTER TABLE [dbo].[PatientTransferIn]  WITH CHECK ADD  CONSTRAINT [FK_PatientTransferIn_Patient] FOREIGN KEY([PatientId])
REFERENCES [dbo].[Patient] ([Id])
GO
ALTER TABLE [dbo].[PatientTransferIn] CHECK CONSTRAINT [FK_PatientTransferIn_Patient]
GO
ALTER TABLE [dbo].[PatientTreatementDiagnosis]  WITH CHECK ADD  CONSTRAINT [FK_PatientTreatementDiagnosis_PatientMasterVisit] FOREIGN KEY([PatientId])
REFERENCES [dbo].[PatientMasterVisit] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PatientTreatementDiagnosis] CHECK CONSTRAINT [FK_PatientTreatementDiagnosis_PatientMasterVisit]
GO
ALTER TABLE [dbo].[PatientTreatmentInitiation]  WITH CHECK ADD  CONSTRAINT [FK_PatientTreatmentInitiation_Patient] FOREIGN KEY([PatientId])
REFERENCES [dbo].[Patient] ([Id])
GO
ALTER TABLE [dbo].[PatientTreatmentInitiation] CHECK CONSTRAINT [FK_PatientTreatmentInitiation_Patient]
GO
ALTER TABLE [dbo].[PatientTreatmentSupporter]  WITH CHECK ADD  CONSTRAINT [FK_PatientTreatmentSupporter_Person] FOREIGN KEY([PersonId])
REFERENCES [dbo].[Person] ([Id])
GO
ALTER TABLE [dbo].[PatientTreatmentSupporter] CHECK CONSTRAINT [FK_PatientTreatmentSupporter_Person]
GO
ALTER TABLE [dbo].[PatientVitals]  WITH CHECK ADD  CONSTRAINT [FK_PatientVitals_PatientMasterVisit] FOREIGN KEY([PatientMasterVisitId])
REFERENCES [dbo].[PatientMasterVisit] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PatientVitals] CHECK CONSTRAINT [FK_PatientVitals_PatientMasterVisit]
GO
ALTER TABLE [dbo].[PersonContact]  WITH CHECK ADD  CONSTRAINT [FK_PersonContact_Person] FOREIGN KEY([PersonId])
REFERENCES [dbo].[Person] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PersonContact] CHECK CONSTRAINT [FK_PersonContact_Person]
GO
ALTER TABLE [dbo].[PersonLocation]  WITH CHECK ADD  CONSTRAINT [FK_PersonLocation_Person] FOREIGN KEY([PersonId])
REFERENCES [dbo].[Person] ([Id])
GO
ALTER TABLE [dbo].[PersonLocation] CHECK CONSTRAINT [FK_PersonLocation_Person]
GO
ALTER TABLE [dbo].[PersonRelationship]  WITH CHECK ADD  CONSTRAINT [FK_PersonRelationship_Person] FOREIGN KEY([PersonId])
REFERENCES [dbo].[Person] ([Id])
GO
ALTER TABLE [dbo].[PersonRelationship] CHECK CONSTRAINT [FK_PersonRelationship_Person]
GO
ALTER TABLE [dbo].[PhysicalExamination]  WITH CHECK ADD  CONSTRAINT [FK_PhysicalExamination_PatientMasterVisit] FOREIGN KEY([PatientMasterVisitId])
REFERENCES [dbo].[PatientMasterVisit] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PhysicalExamination] CHECK CONSTRAINT [FK_PhysicalExamination_PatientMasterVisit]
GO
ALTER TABLE [dbo].[Pregnancy]  WITH CHECK ADD  CONSTRAINT [FK_Pregnancy_Patient] FOREIGN KEY([PatientId])
REFERENCES [dbo].[Patient] ([Id])
GO
ALTER TABLE [dbo].[Pregnancy] CHECK CONSTRAINT [FK_Pregnancy_Patient]
GO
ALTER TABLE [dbo].[Pregnancy]  WITH CHECK ADD  CONSTRAINT [FK_Pregnancy_PatientMasterVisit] FOREIGN KEY([PatientMasterVisitId])
REFERENCES [dbo].[PatientMasterVisit] ([Id])
GO
ALTER TABLE [dbo].[Pregnancy] CHECK CONSTRAINT [FK_Pregnancy_PatientMasterVisit]
GO
ALTER TABLE [dbo].[PregnancyIndicator]  WITH CHECK ADD  CONSTRAINT [FK_PregnancyIndicator_Patient] FOREIGN KEY([PatientId])
REFERENCES [dbo].[Patient] ([Id])
GO
ALTER TABLE [dbo].[PregnancyIndicator] CHECK CONSTRAINT [FK_PregnancyIndicator_Patient]
GO
ALTER TABLE [dbo].[PregnancyIndicator]  WITH CHECK ADD  CONSTRAINT [FK_PregnancyIndicator_PatientMasterVisit] FOREIGN KEY([PatientMasterVisitId])
REFERENCES [dbo].[PatientMasterVisit] ([Id])
GO
ALTER TABLE [dbo].[PregnancyIndicator] CHECK CONSTRAINT [FK_PregnancyIndicator_PatientMasterVisit]
GO
/****** Object:  StoredProcedure [dbo].[Patient_Insert]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Patient_Insert] 
 -- Add the parameters for the stored procedure here
 @PersonId int,
 @ptn_pk int = null,
 @PatientIndex varchar(50),
 @DateOfBirth datetime,
 @NationalId varchar(100),
 @FacilityId int,
 @UserId int,
 @Active bit,
 @PatientType int,
 @DobPrecision bit
AS
BEGIN
 -- SET NOCOUNT ON added to prevent extra result sets from
 -- interfering with SELECT statements.
 SET NOCOUNT ON;

    -- Insert statements for procedure here
 Insert Into  Patient(ptn_pk,PersonId,PatientIndex,PatientType,FacilityId,Active,DateOfBirth,NationalId,DeleteFlag,CreatedBy,CreateDate,AuditData,DobPrecision)
 Values(
  @ptn_pk,
  @PersonId,
  @PatientIndex,
  @PatientType,
  @FacilityId,
  @Active,
  @DateOfBirth,
  ENCRYPTBYKEY(KEY_GUID('Key_CTC'),@NationalId),
  0,
  @UserId,
  GETDATE(),
  NULL,
  @DobPrecision
 );
SELECT SCOPE_IDENTITY() Id;
END

GO
/****** Object:  StoredProcedure [dbo].[Patient_Update]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: Felix Kithinji
-- Create date: 15-Mar-2017
-- Description: update
-- =============================================
CREATE PROCEDURE [dbo].[Patient_Update] 
 -- Add the parameters for the stored procedure here
 @ptn_pk int = null,
 @DateOfBirth datetime,
 @NationalId varchar(100),
 @FacilityId int,
 @Id int
AS
BEGIN
 -- SET NOCOUNT ON added to prevent extra result sets from
 -- interfering with SELECT statements.
 SET NOCOUNT ON;

    -- Insert statements for procedure here
 UPDATE Patient
 SET
  ptn_pk = @ptn_pk,
  DateOfBirth = @DateOfBirth,
  NationalId=ENCRYPTBYKEY(KEY_GUID('Key_CTC'),@NationalId),
  FacilityId=@FacilityId
 WHERE
  Id=@Id
END


GO
/****** Object:  StoredProcedure [dbo].[Person_Insert]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:  Steve Osewe
-- Create date: 20-Jan-2017
-- Description: Insert
-- =============================================
CREATE PROCEDURE [dbo].[Person_Insert]
 -- Add the parameters for the stored procedure here
 @FirstName varchar(100),
 @MidName varchar(100)= Null,
 @LastName varchar(100),
 @Sex int,
 --@DateOfBirth date,
 --@NationalId varchar(100) = null,
 @UserId int
AS
BEGIN
 -- SET NOCOUNT ON added to prevent extra result sets from
 -- interfering with SELECT statements.
 SET NOCOUNT ON;

 --if(@DateOfBirth is null)BEGIN SET @DateOfBirth='1989-06-15' END
    -- Insert statements for procedure here
 Insert Into Person(FirstName, MidName,LastName,Sex,Active,DeleteFlag,CreateDate,CreatedBy)
 Values(
  ENCRYPTBYKEY(KEY_GUID('Key_CTC'),@FirstName),
  ENCRYPTBYKEY(KEY_GUID('Key_CTC'),@MidName),
  ENCRYPTBYKEY(KEY_GUID('Key_CTC'),@LastName),
  @Sex,
  --@DateOfBirth,
  --ENCRYPTBYKEY(KEY_GUID('Key_CTC'),@NationalId),
  1,
  0,
  GETDATE(),
  @UserId
 );
 SELECT SCOPE_IDENTITY() PersonId;
END
GO
/****** Object:  StoredProcedure [dbo].[Person_Update]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Person_Update]
 -- Add the parameters for the stored procedure here
 @FirstName varchar(100),
 @MidName varchar(100)= Null,
 @LastName varchar(100),
 @Sex int,
 --@DateOfBirth date,
 --@NationalId varchar(100) = null,
 @Id int
AS
BEGIN
 -- SET NOCOUNT ON added to prevent extra result sets from
 -- interfering with SELECT statements.
 SET NOCOUNT ON;

    -- Insert statements for procedure here
 UPDATE Person
 SET
  FirstName=ENCRYPTBYKEY(KEY_GUID('Key_CTC'),@FirstName),
  MidName=ENCRYPTBYKEY(KEY_GUID('Key_CTC'),@MidName),
  LastName=ENCRYPTBYKEY(KEY_GUID('Key_CTC'),@LastName),
  Sex=@Sex
  --DateOfBirth=@DateOfBirth,
  --NationalId=ENCRYPTBYKEY(KEY_GUID('Key_CTC'),@NationalId)
 WHERE
   Id=@Id;
END
GO
/****** Object:  StoredProcedure [dbo].[PersonContact_Insert]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Steve Osewe
-- Create date: 20-Jan-2017
-- Description:	Insert
-- =============================================
CREATE PROCEDURE [dbo].[PersonContact_Insert]
	-- Add the parameters for the stored procedure here
	@PersonId int=Null,
	@PhysicalAddress varbinary(max)= Null,
	@MobileNumber varbinary(max)=Null,
	@AlternativeNumber varbinary(max)=Null,
	@EmailAddress varbinary(max)=Null,
	@UserId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Declare @Id int;

	if( @AlternativeNumber IS NULL)
		BEGIN
		  SET @AlternativeNumber = NULL;
		END
	else
	BEGIN
	  SET @AlternativeNumber=ENCRYPTBYKEY(KEY_GUID('Key_CTC'),@AlternativeNumber)
	END

	if(@EmailAddress is null)
	begin
		SET @EmailAddress= NULL;
	end
	else
		begin
		  SET @EmailAddress=ENCRYPTBYKEY(KEY_GUID('Key_CTC'),@EmailAddress);
		end

	Insert Into PersonContact(PersonId,PhysicalAddress,MobileNumber,AlternativeNumber,EmailAddress,Active,DeleteFlag,CreateDate,CreatedBy)
	Values(
		@PersonId,
		ENCRYPTBYKEY(KEY_GUID('Key_CTC'),@PhysicalAddress),
		ENCRYPTBYKEY(KEY_GUID('Key_CTC'),@MobileNumber),
		@AlternativeNumber,
		@EmailAddress,
		1,
		0,
		GETDATE(),
		@UserId
	);
	SET @Id =(Select SCOPE_IDENTITY() Id);
	
	-- Set Previous Contacts to Zero
	if(@Id>0)
	BEGIN
		UPDATE PersonContact SET Active=0 WHERE PersonId=@PersonId AND Id NOT IN(Id);
	END
END

GO
/****** Object:  StoredProcedure [dbo].[PersonContact_Update]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PersonContact_Update]
 -- Add the parameters for the stored procedure here
 @PersonId int=Null,
 @PhysicalAddress varbinary(max)= Null,
 @MobileNumber varbinary(max)=Null,
 @AlternativeNumber varbinary(max)=Null,
 @EmailAddress varbinary(max)=Null,
 @Id int
AS
BEGIN
 -- SET NOCOUNT ON added to prevent extra result sets from
 -- interfering with SELECT statements.
 SET NOCOUNT ON;

 if( @AlternativeNumber IS NULL)
  BEGIN
    SET @AlternativeNumber = NULL;
  END
 else
 BEGIN
   SET @AlternativeNumber=ENCRYPTBYKEY(KEY_GUID('Key_CTC'),@AlternativeNumber)
 END

 if(@EmailAddress is null)
 begin
  SET @EmailAddress= NULL;
 end
 else
  begin
    SET @EmailAddress=ENCRYPTBYKEY(KEY_GUID('Key_CTC'),@EmailAddress);
  end

    -- Insert statements for procedure here
    UPDATE PersonContact
 SET
  PhysicalAddress=ENCRYPTBYKEY(KEY_GUID('Key_CTC'),@PhysicalAddress),
  MobileNumber=ENCRYPTBYKEY(KEY_GUID('Key_CTC'),@MobileNumber),
  AlternativeNumber=@AlternativeNumber,
  EmailAddress=@EmailAddress
 WHERE 
  PersonId=@PersonId 
  AND
  Id=@Id 
END
GO
/****** Object:  StoredProcedure [dbo].[sp_deletePatientEncounterAdverseEvents]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		John Macharia
-- Create date: 29th Jan 2017
-- Description:	save patient encounter - Adverse Events
-- =============================================
CREATE PROCEDURE [dbo].[sp_deletePatientEncounterAdverseEvents]
	-- Add the parameters for the stored procedure here
	@PatientMasterVisitID int = null,
	@PatientID int = null

AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
Set Nocount On;
-- Insert statements for procedure here
	update AdverseEvent set DeleteFlag = 1 where PatientMasterVisitId = @PatientMasterVisitID and PatientId = @PatientID
	
End


/****** Object:  StoredProcedure [dbo].[sp_getPharmacyDrugList]    Script Date: 3/22/2017 6:17:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		John Macharia
-- Create date: 14th Feb 2017
-- Description:	get pharmacy drug list
-- =============================================
ALTER PROCEDURE [dbo].[sp_getPharmacyDrugList]
	-- Add the parameters for the stored procedure here
	@regimenLine int = null

AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
Set Nocount On;

	--select Drug_pk, CONCAT(Drug_pk, ' - ', DrugName)DrugName from mst_drug
	select Drug_pk, DrugName,CONCAT(Drug_pk, '~',abbreviation, '~', DrugName)val from mst_drug
End






GO
/****** Object:  StoredProcedure [dbo].[sp_deletePatientEncounterAllergies]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		John Macharia
-- Create date: 19th Mar 2017
-- Description:	save patient encounter - delete allergies
-- =============================================
CREATE PROCEDURE [dbo].[sp_deletePatientEncounterAllergies]
	-- Add the parameters for the stored procedure here
	@PatientMasterVisitID int = null,
	@PatientID int = null

AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
Set Nocount On;
-- Insert statements for procedure here
	update patientallergy set DeleteFlag = 1 where PatientId = @PatientID
End



GO
/****** Object:  StoredProcedure [dbo].[sp_deletePatientEncounterChronicIllness]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		John Macharia
-- Create date: 29th Jan 2017
-- Description:	save patient encounter - Adverse Events
-- =============================================
CREATE PROCEDURE [dbo].[sp_deletePatientEncounterChronicIllness]
	-- Add the parameters for the stored procedure here
	@PatientMasterVisitID int = null,
	@PatientID int = null

AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
Set Nocount On;
-- Insert statements for procedure here
	update PatientChronicIllness set DeleteFlag = 1 where PatientId = @PatientID
End



GO
/****** Object:  StoredProcedure [dbo].[sp_deletePatientEncounterDiagnosis]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		John Macharia
-- Create date: 29th Jan 2017
-- Description:	save patient encounter - Adverse Events
-- =============================================
CREATE PROCEDURE [dbo].[sp_deletePatientEncounterDiagnosis]
	-- Add the parameters for the stored procedure here
	@PatientMasterVisitID int = null,
	@PatientID int = null

AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
Set Nocount On;
-- Insert statements for procedure here
	update PatientDiagnosis set DeleteFlag = 1 where PatientMasterVisitId = @PatientMasterVisitID and PatientId = @PatientID
End


GO
/****** Object:  StoredProcedure [dbo].[sp_deletePatientEncounterPHDP]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		John Macharia
-- Create date: 29th Jan 2017
-- Description:	save patient encounter - Chronic Illness
-- =============================================
CREATE PROCEDURE [dbo].[sp_deletePatientEncounterPHDP]
	-- Add the parameters for the stored procedure here
	@PatientMasterVisitID int = null,
	@PatientID int = null

AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
Set Nocount On;
-- Insert statements for procedure here
		UPDATE PatientPHDP SET DeleteFlag = 1
		where PatientMasterVisitId = @PatientMasterVisitID and PatientId = @PatientID
		
End


GO
/****** Object:  StoredProcedure [dbo].[sp_deletePatientEncounterPhysicalExam]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

USE [IQCareDefault]
GO
/****** Object:  StoredProcedure [dbo].[mstPatient_Insert]    Script Date: 3/22/2017 5:49:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: Felix Kithinji
-- Create date: 15-Mar-2017
-- Description: Insert
-- =============================================
ALTER PROCEDURE [dbo].[mstPatient_Insert] 
 -- Add the parameters for the stored procedure here
 @FirstName varchar(MAX),
 @LastName varchar(MAX),
 @MiddleName varchar(MAX),
 @LocationID int,
 @PatientEnrollmentID varchar(50),
 @ReferredFrom int,
 @RegistrationDate datetime,
 @Sex int,
 @DOB datetime,
 @DobPrecision int,
 @MaritalStatus int,
 @Address varchar(MAX),
 @Phone varchar(MAX),
 @UserID int,
 @PosId varchar(10),
 @ModuleId int,
 @StartDate datetime,
 @CreateDate datetime
AS
BEGIN
 -- SET NOCOUNT ON added to prevent extra result sets from
 -- interfering with SELECT statements.
 SET NOCOUNT ON;

 DECLARE @Ptn_Pk int

    -- Insert statements for procedure here
 Insert Into mst_Patient(FirstName, LastName, MiddleName, LocationID, PatientEnrollmentID, ReferredFrom, RegistrationDate, Sex, DOB, DobPrecision, MaritalStatus, Address, Phone, UserID, PosId, Status, DeleteFlag, CreateDate)
 Values(
  ENCRYPTBYKEY(KEY_GUID('Key_CTC'),@FirstName),
  ENCRYPTBYKEY(KEY_GUID('Key_CTC'),@LastName),
  ENCRYPTBYKEY(KEY_GUID('Key_CTC'),@MiddleName),
  @LocationID,
  @PatientEnrollmentID,
  @ReferredFrom,
  @RegistrationDate,
  @Sex,
  @DOB,
  @DobPrecision,
  @MaritalStatus,
  ENCRYPTBYKEY(KEY_GUID('Key_CTC'),@Address),
  ENCRYPTBYKEY(KEY_GUID('Key_CTC'),@Phone),
  @UserID,
  @PosId,
  0,
  0,
  @CreateDate
 );
 SELECT @Ptn_Pk=@@IDENTITY;
 SELECT SCOPE_IDENTITY() Ptn_Pk;

 Insert Into Lnk_PatientProgramStart(Ptn_pk, ModuleId, StartDate, UserID, CreateDate)
 Values(
  @Ptn_Pk,
  @ModuleId,
  @StartDate,
  @UserID,
  @CreateDate
 );
END



-- =============================================
-- Author:		John Macharia
-- Create date: 29th Jan 2017
-- Description:	save patient encounter - Adverse Events
-- =============================================
CREATE PROCEDURE [dbo].[sp_deletePatientEncounterPhysicalExam]
	-- Add the parameters for the stored procedure here
	@PatientMasterVisitID int = null,
	@PatientID int = null

AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
Set Nocount On;
-- Insert statements for procedure here
	update PhysicalExamination set DeleteFlag = 1 where PatientMasterVisitId = @PatientMasterVisitID and PatientId = @PatientID
End


GO
/****** Object:  StoredProcedure [dbo].[sp_deletePatientEncounterVaccines]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		John Macharia
-- Create date: 29th Jan 2017
-- Description:	save patient encounter - Adverse Events
-- =============================================
create PROCEDURE [dbo].[sp_deletePatientEncounterVaccines]
	-- Add the parameters for the stored procedure here
	@PatientMasterVisitID int = null,
	@PatientID int = null

AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
Set Nocount On;
-- Insert statements for procedure here
	update Vaccination set DeleteFlag = 1 where PatientId = @PatientID
End



GO
/****** Object:  StoredProcedure [dbo].[sp_deletePatientFamilyPlanningMethod]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		John Macharia
-- Create date: 29th Jan 2017
-- Description:	delete family planning method
-- =============================================
CREATE PROCEDURE [dbo].[sp_deletePatientFamilyPlanningMethod]
	-- Add the parameters for the stored procedure here
	@PatientID varchar(50) = null,
	@FPId varchar(50) = null

AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
Set Nocount On;
-- Insert statements for procedure here
	update PatientFamilyPlanningMethod set DeleteFlag = 1 where PatientId = @PatientID and PatientFPId = @FPId
End



GO
/****** Object:  StoredProcedure [dbo].[sp_getPatientEncounter]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		John Macharia
-- Create date: 10th Feb 2017
-- Description:	get patient encounter
-- =============================================
CREATE PROCEDURE [dbo].[sp_getPatientEncounter]
	-- Add the parameters for the stored procedure here
	@PatientMasterVisitID int = null,
	@PatientID int = null

AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
Set Nocount On;
	declare @PatientFPId int = (select Id from PatientFamilyPlanning where PatientMasterVisitId = @PatientMasterVisitID and patientId = @PatientID)
	declare @TBScreeningTypeID int = (Select Id from LookupMaster where name = 'TBStatus')
	declare @NutritionScreeningTypeID int = (Select Id from LookupMaster where name = 'NutritionStatus')
	declare @CaCxScreeningTypeID int = (Select Id from LookupMaster where name = 'CaCxScreening')
	declare @STIScreeningTypeID int = (Select Id from LookupMaster where name = 'STIScreening')
	declare @ARVAdherenceType int = (Select Id from LookupMaster where name = 'ARVAdherence')
	declare @CTXAdherenceType int = (Select Id from LookupMaster where name = 'CTXAdherence')

	--0
	select * from PatientMasterVisit where id = @PatientMasterVisitID and patientId = @PatientID
	
	--1
	select * from ComplaintsHistory where PatientMasterVisitId = @PatientMasterVisitID and patientId = @PatientID
	
	--2
	select * from PatientPhysicalExamination where PatientMasterVisitId = @PatientMasterVisitID and patientId = @PatientID
	
	--TB Screening 3
	select ScreeningValueId from PatientScreening 
	where PatientMasterVisitId = @PatientMasterVisitID and patientId = @PatientID and ScreeningTypeId = @TBScreeningTypeID
	
	--Nutrition Screening 4
	select ScreeningValueId from PatientScreening 
	where PatientMasterVisitId = @PatientMasterVisitID and patientId = @PatientID and ScreeningTypeId = @NutritionScreeningTypeID
	
	--CaCX 5
	select ScreeningValueId from PatientScreening 
	where PatientMasterVisitId = @PatientMasterVisitID and patientId = @PatientID and ScreeningTypeId = @CaCxScreeningTypeID
	
	--STI 6
	select ScreeningValueId from PatientScreening 
	where PatientMasterVisitId = @PatientMasterVisitID and patientId = @PatientID and ScreeningTypeId = @STIScreeningTypeID
	
	--7
	select * from PatientFamilyPlanning where PatientMasterVisitId = @PatientMasterVisitID and patientId = @PatientID
	
	--8
	select * from PatientFamilyPlanningMethod where PatientFPId = @PatientFPId and DeleteFlag <> 1

	--9
	select * from PatientAppointment where PatientMasterVisitId = @PatientMasterVisitID and patientId = @PatientID

	--10
	select * from PatientPHDP where PatientMasterVisitId = @PatientMasterVisitID and patientId = @PatientID 
	and (DeleteFlag is null OR DeleteFlag = 0)

	--11 ARV Adherence
	select Score from AdherenceOutcome 
	where PatientMasterVisitId = @PatientMasterVisitID and patientId = @PatientID and AdherenceType = @ARVAdherenceType

	--12 CTX Adherence
	select Score from AdherenceOutcome 
	where PatientMasterVisitId = @PatientMasterVisitID and patientId = @PatientID and AdherenceType = @CTXAdherenceType

End



GO
/****** Object:  StoredProcedure [dbo].[sp_getPatientEncounterAdverseEvents]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		John Macharia
-- Create date: 14th Feb 2017
-- Description:	get patient encounter Adverse Events
-- =============================================
CREATE PROCEDURE [dbo].[sp_getPatientEncounterAdverseEvents]
	-- Add the parameters for the stored procedure here
	@PatientMasterVisitID int = null,
	@PatientID int = null

AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
Set Nocount On;

	select Severity SeverityID,EventName,EventCause,b.DisplayName Severity,[Action] 
	from AdverseEvent a left join LookupItem b on a.Severity = b.Id
	where PatientMasterVisitId = @PatientMasterVisitID and patientId = @PatientID and (a.DeleteFlag is null or a.DeleteFlag = 0)
	
End



GO
/****** Object:  StoredProcedure [dbo].[sp_getPatientEncounterAllergies]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		John Macharia
-- Create date: 19th Mar 2017
-- Description:	get patient encounter Allergies
-- =============================================
create PROCEDURE [dbo].[sp_getPatientEncounterAllergies]
	-- Add the parameters for the stored procedure here
	@PatientMasterVisitID int = null,
	@PatientID int = null

AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
Set Nocount On;

	select Allergen, AllergyResponse 
	from patientallergy
	where patientId = @PatientID and (DeleteFlag is null or DeleteFlag = 0)
	
End



GO
/****** Object:  StoredProcedure [dbo].[sp_getPatientEncounterChronicIllness]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		John Macharia
-- Create date: 14th Feb 2017
-- Description:	get patient encounter Chronic Illness
-- =============================================
CREATE PROCEDURE [dbo].[sp_getPatientEncounterChronicIllness]
	-- Add the parameters for the stored procedure here
	@PatientMasterVisitID int = null,
	@PatientID int = null

AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
Set Nocount On;

	select chronicIllness chronicIllnessID, b.DisplayName chronicIllnessName, Treatment,dose,Duration 
	from PatientChronicIllness a inner join LookupItem b on a.ChronicIllness = b.Id
	where patientId = @PatientID and (a.DeleteFlag is null or a.DeleteFlag = 0)
	
End



GO
/****** Object:  StoredProcedure [dbo].[sp_getPatientEncounterDiagnosis]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		John Macharia
-- Create date: 14th Feb 2017
-- Description:	get patient encounter Diagnosis
-- =============================================
CREATE PROCEDURE [dbo].[sp_getPatientEncounterDiagnosis]
	-- Add the parameters for the stored procedure here
	@PatientMasterVisitID int = null,
	@PatientID int = null

AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
Set Nocount On;

	select Diagnosis, ManagementPlan
	from PatientDiagnosis
	where PatientMasterVisitId = @PatientMasterVisitID and patientId = @PatientID and (DeleteFlag is null or DeleteFlag = 0)
	
End



GO
/****** Object:  StoredProcedure [dbo].[sp_getPatientEncounterExam]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		John Macharia
-- Create date: 14th Feb 2017
-- Description:	get patient encounter Physical Exam
-- =============================================
CREATE PROCEDURE [dbo].[sp_getPatientEncounterExam]
	-- Add the parameters for the stored procedure here
	@PatientMasterVisitID int = null,
	@PatientID int = null

AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
Set Nocount On;

	select ExaminationTypeId examTypeID, ExamId examID, b.DisplayName examType, c.DisplayName exam, Finding findings
	from PhysicalExamination a 
	inner join LookupItem b on a.ExaminationTypeId = b.Id
	left join LookupItem c on a.ExamId = c.Id
	where PatientMasterVisitId = @PatientMasterVisitID and patientId = @PatientID and (a.DeleteFlag is null or a.DeleteFlag = 0)
	
End



GO
/****** Object:  StoredProcedure [dbo].[sp_getPatientEncounterHistory]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		John Macharia
-- Create date: 10th Feb 2017
-- Description:	get patient encounter History
-- =============================================
CREATE PROCEDURE [dbo].[sp_getPatientEncounterHistory]
	-- Add the parameters for the stored procedure here
	@PatientID int = null

AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
Set Nocount On;
	select * from view_patientvisit where patientid = @PatientID
	order by visitdate desc
End



GO
/****** Object:  StoredProcedure [dbo].[sp_getPatientEncounterVaccines]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		John Macharia
-- Create date: 14th Feb 2017
-- Description:	get patient encounter Vaccines
-- =============================================
CREATE PROCEDURE [dbo].[sp_getPatientEncounterVaccines]
	-- Add the parameters for the stored procedure here
	@PatientMasterVisitID int = null,
	@PatientID int = null

AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
Set Nocount On;

	select vaccine vaccineID, VaccineStage VaccineStageID, b.DisplayName VaccineName, c.DisplayName VaccineStageName, Convert(varchar(12),VaccineDate,106)VaccineDate
	from Vaccination a 
	inner join LookupItem b on a.Vaccine = b.Id
	left join LookupItem c on a.VaccineStage = c.Id
	where patientId = @PatientID and (a.DeleteFlag is null or a.DeleteFlag = 0)
	
End



GO
/****** Object:  StoredProcedure [dbo].[sp_getPatientPharmacyPrescription]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		John Macharia
-- Create date: 13th Mar 2017
-- Description:	get patient pharmacy prescription
-- =============================================
CREATE PROCEDURE [dbo].[sp_getPatientPharmacyPrescription]
	-- Add the parameters for the stored procedure here
	@PatientMasterVisitID int = null

AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
Set Nocount On;
	declare @pharmacy_pk int
	set @pharmacy_pk = (select ptn_pharmacy_pk from ord_PatientPharmacyOrder 
						where masterVisitID = @PatientMasterVisitID and DeleteFlag <> 1)

	select a.Drug_Pk,
	(select batchId from dtl_patientPharmacyDispensed where ptn_pharmacy_pk = a.ptn_pharmacy_pk and drug_pk = a.Drug_Pk) batchId,
	a.FrequencyID,b.abbreviation abbr,b.DrugName,c.Name batchName,a.SingleDose dose, 
	d.Name freq,a.duration,a.OrderedQuantity,
	(select dispensedQuantity from dtl_patientPharmacyDispensed where ptn_pharmacy_pk = a.ptn_pharmacy_pk and drug_pk = a.Drug_Pk)DispensedQuantity
	from dtl_PatientPharmacyOrder a inner join mst_drug b on a.Drug_Pk = b.Drug_pk
	left join Mst_Batch c on a.BatchNo = c.ID
	left join mst_Frequency d on a.FrequencyID = d.ID
	--left join dtl_patientPharmacyDispensed e on a.ptn_pharmacy_pk = e.ptn_pharmacy_pk
	where a.ptn_pharmacy_pk = @pharmacy_pk
	
End



GO
/****** Object:  StoredProcedure [dbo].[sp_getPendingPrescriptions]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		John Macharia
-- Create date: 16th Mar 2017
-- Description:	get patient encounter Chronic Illness
-- =============================================
CREATE PROCEDURE [dbo].[sp_getPendingPrescriptions]
	-- Add the parameters for the stored procedure here
	@PatientMasterVisitID int = null,
	@PatientID int = null

AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
Set Nocount On;

	select a.masterVisitID, a.Ptn_pk, e.identifiervalue, c.FirstName, c.MidName, c.LastName, d.UserLastName + d.UserFirstName as prescribedBy 
	from ord_PatientPharmacyOrder a inner join patient b on a.ptn_pk = b.Id
	inner join person c on b.PersonId = c.Id
	inner join mst_User d on a.OrderedBy = d.UserID
	inner join PatientIdentifier e on e.PatientId = a.Ptn_pk
	where (a.DeleteFlag is null or a.DeleteFlag = 0) and (a.orderstatus = 1 or a.orderstatus = 3)
	
End



GO
/****** Object:  StoredProcedure [dbo].[sp_getPharmacyBatch]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		John Macharia
-- Create date: 14th Feb 2017
-- Description:	get pharmacy drug batches
-- =============================================
CREATE PROCEDURE [dbo].[sp_getPharmacyBatch]
	-- Add the parameters for the stored procedure here
	@DrugPk int = null

AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
Set Nocount On;

	select id, Name from Mst_Batch where ItemID = @DrugPk and DeleteFlag <> 1
End



GO
/****** Object:  StoredProcedure [dbo].[sp_getPharmacyDrugFrequency]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		John Macharia
-- Create date: 3rd June 2017
-- Description:	get pharmacy drug frequency
-- =============================================
CREATE PROCEDURE [dbo].[sp_getPharmacyDrugFrequency]
	-- Add the parameters for the stored procedure here

AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
Set Nocount On;

	select id,name,multiplier from mst_Frequency where DeleteFlag <> 1
End



GO
/****** Object:  StoredProcedure [dbo].[sp_getPharmacyDrugList]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		John Macharia
-- Create date: 14th Feb 2017
-- Description:	get pharmacy drug list
-- =============================================
CREATE PROCEDURE [dbo].[sp_getPharmacyDrugList]
	-- Add the parameters for the stored procedure here
	@regimenLine int = null

AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
Set Nocount On;

	--select Drug_pk, CONCAT(Drug_pk, ' - ', DrugName)DrugName from mst_drug
	select Drug_pk, DrugName,CONCAT(Drug_pk, '~',abbreviation, '~', DrugName)val from mst_drug
End



GO
/****** Object:  StoredProcedure [dbo].[sp_getPharmacyDrugSwitchSubReasons]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		John Macharia
-- Create date: 8th Mar 2017
-- Description:	get pharmacy drug switch, substitution reasons
-- =============================================
CREATE PROCEDURE [dbo].[sp_getPharmacyDrugSwitchSubReasons]
	-- Add the parameters for the stored procedure here
	@TreatmentPlan int = null

AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
Set Nocount On;

	select LookupItemId, DisplayName from LookupMasterItem where LookupMasterId = @TreatmentPlan
	order by OrdRank
End



GO
/****** Object:  StoredProcedure [dbo].[SP_mst_PatientToGreencardRegistration]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<felix/stephen>
-- Create date: <03-22-2017>
-- Description:	<Patient registration migration from bluecard to greencard>
-- =============================================
CREATE PROCEDURE [dbo].[SP_mst_PatientToGreencardRegistration]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

DECLARE @ptn_pk int, @FirstName varbinary(max), @MiddleName varbinary(max), @LastName varbinary(max), @Sex int, @Status bit , @DeleteFlag bit, @CreateDate datetime, @UserID int,  @message varchar(80), @Id int, @PatientFacilityId varchar(50), @PatientType int, @FacilityId varchar(10), @DateOfBirth datetime, @DobPrecision int, @NationalId varbinary(max), @PatientId int,  @ARTStartDate date,@transferIn int,@CCCNumber varchar(20);
  
PRINT '-------- Patients Report --------';  
  
DECLARE mstPatient_cursor CURSOR FOR   
SELECT Ptn_Pk, FirstName, MiddleName ,LastName,Sex, [Status], DeleteFlag, CreateDate, UserID, PatientFacilityId, PosId, DOB, DobPrecision, [ID/PassportNo],PatientClinicID
FROM mst_Patient   
ORDER BY Ptn_Pk;  
  
OPEN mstPatient_cursor  
  
FETCH NEXT FROM mstPatient_cursor   
INTO @ptn_pk, @FirstName, @MiddleName, @LastName, @Sex, @Status, @DeleteFlag, @CreateDate, @UserID, @PatientFacilityId, @FacilityId, @DateOfBirth, @DobPrecision, @NationalId,@CCCNumber
  
WHILE @@FETCH_STATUS = 0  
BEGIN  
    PRINT ' '  
    SELECT @message = '----- patients From mst_patient: ' + CAST(@ptn_pk as varchar(50))
  
    PRINT @message  

	--set null dates
	IF @CreateDate is null
		SELECT @CreateDate = getdate()
	--Due to the logic of green card
	IF @Status = 1
		SELECT @Status = 0
	ELSE
		SELECT @Status = 1

	--Default all persons to new
	SET @ARTStartDate=( SELECT ARTTransferInDate FROM dtl_PatientHivPrevCareIE WHERE Ptn_pk=@ptn_pk);
	if(@ARTStartDate Is NULL) BEGIN SET @PatientType=(SELECT Id FROM LookupItem WHERE Name='New');SET @transferIn=0; END ELSE BEGIN SET @PatientType=(SELECT Id FROM LookupItem WHERE Name='TransferIn');SET @transferIn=1; END
	-- SELECT @PatientType = 1285

	--encrypt nationalid
	SELECT @NationalId=ENCRYPTBYKEY(KEY_GUID('Key_CTC'),@NationalId)

	Insert into Person(FirstName, MidName, LastName, Sex, Active, DeleteFlag, CreateDate, CreatedBy)
	Values(@FirstName, @MiddleName, @LastName, @Sex, @Status, @DeleteFlag, @CreateDate, @UserID);

	SELECT @Id=@@IDENTITY;
	SELECT @message = 'Created Person Id: ' + CAST(@Id as varchar(50));
	PRINT @message;

	Insert into Patient(ptn_pk, PersonId, PatientIndex, PatientType, FacilityId, Active, DateOfBirth, DobPrecision, NationalId, DeleteFlag, CreatedBy, CreateDate)
	Values(@ptn_pk, @Id, @PatientFacilityId, @PatientType, @FacilityId, @Status, @DateOfBirth, @DobPrecision, @NationalId, @DeleteFlag, @UserID, @CreateDate);

	SELECT @PatientId=@@IDENTITY;
	SELECT @message = 'Created Patient Id: ' + CAST(@PatientId as varchar);
	PRINT @message;

	-- Insert to PatientEnrollment
		INSERT INTO [dbo].[PatientEnrollment]
			   ([PatientId]
			   ,[ServiceAreaId]
			   ,[EnrollmentDate]
			   ,[EnrollmentStatusId]
			   ,[TransferIn]
			   ,[CareEnded]
			   ,[DeleteFlag]
			   ,[CreatedBy]
			   ,[CreateDate]
			   ,[AuditData])
		 VALUES
			   (@PatientId,1,(SELECT top 1 StartDate FROM Lnk_PatientProgramStart WHERE Ptn_pk=@ptn_pk),0, @transferIn,0 ,0
			   ,@UserID
			   ,@CreateDate
			   ,NULL)
		SELECT @Id=@@IDENTITY;

	-- Patient Identifier
	  INSERT INTO [dbo].[PatientIdentifier]
           ([PatientId]
           ,[PatientEnrollmentId]
           ,[IdentifierTypeId]
           ,[IdentifierValue]
           ,[DeleteFlag]
           ,[CreatedBy]
           ,[CreateDate]
           ,[Active]
           ,[AuditData])
     VALUES
           (@PatientId
           ,@Id
           ,(SELECT Id FROM LookupItem WHERE Name='CCCNumber')
           ,@CCCNumber
           ,0
           ,@UserID
           ,@CreateDate
           ,0
           ,NULL)
	  
	--Insert into PatientEnrollment(PatientId, ServiceAreaId, EnrollmentDate, EnrollmentStatusId, TransferIn, CareEnded, DeleteFlag, CreatedBy, CreateDate)
	--Values(@PatientId,
	--DECLARE ProgramStart CURSOR FOR
	--SELECT ModuleId,StartDate,UserID,CreateDate
	--FROM Lnk_PatientProgramStart WHERE Ptn_pk = @ptn_pk

	--OPEN ProgramStart
	--FETCH NEXT FROM ProgramStart 
	--INTO @ModuleId, @StartDate
	--WHILE @@FETCH_STATUS = 0  
	--BEGIN 
	--  INSERT INTO 
	--END
    
    -- Get the next mst_patient.
    FETCH NEXT FROM mstPatient_cursor   
    INTO @ptn_pk, @FirstName, @MiddleName, @LastName, @Sex, @Status, @DeleteFlag, @CreateDate, @UserID, @PatientFacilityId, @FacilityId, @DateOfBirth, @DobPrecision, @NationalId,@CCCNumber
END   
CLOSE mstPatient_cursor;  
DEALLOCATE mstPatient_cursor;  
END

GO
/****** Object:  StoredProcedure [dbo].[sp_savePatientEncounterAdverseEvents]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		John Macharia
-- Create date: 29th Jan 2017
-- Description:	save patient encounter - Adverse Events
-- =============================================
CREATE PROCEDURE [dbo].[sp_savePatientEncounterAdverseEvents]
	-- Add the parameters for the stored procedure here
	@masterVisitID int = null,
	@PatientID int = null,
	@adverseEvent varchar(250) = null,
	@medicineCausingAE varchar(250) = null,
	@adverseSeverity varchar(250) = null,
	@adverseAction varchar(250) = null

AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
Set Nocount On;
-- Insert statements for procedure here
if exists(select 1 from AdverseEvent where PatientMasterVisitId = @masterVisitID and PatientId = @PatientID and EventName = @adverseEvent)
	BEGIN
		update AdverseEvent set EventCause = @medicineCausingAE, Severity = @adverseSeverity,[Action] = @adverseAction, DeleteFlag = 0
		where PatientMasterVisitId = @masterVisitID and PatientId = @PatientID and EventName = @adverseEvent
	END
	ELSE
	BEGIN
		insert into AdverseEvent(PatientId,PatientMasterVisitId,EventName,EventCause,Severity,[Action],DeleteFlag,CreateBy,CreateDate) 
		values(@PatientID,@MasterVisitID,@adverseEvent,@medicineCausingAE,@adverseSeverity,@adverseAction,0,1,GETDATE())
	END
	
End



GO
/****** Object:  StoredProcedure [dbo].[sp_savePatientEncounterAllergies]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		John Macharia
-- Create date: 19th Mar 2017
-- Description:	save patient encounter - Allergies
-- =============================================
CREATE PROCEDURE [dbo].[sp_savePatientEncounterAllergies]
	-- Add the parameters for the stored procedure here
	@MasterVisitID int = null,
	@PatientID int = null,
	@allergy varchar(50) = null,
	@allergyResponse varchar(50) = null,
	@allergyDate varchar(50) = null

AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
Set Nocount On;
-- Insert statements for procedure here
	if exists(select 1 from patientallergy where Allergen = @allergy and PatientId = @PatientID)
	BEGIN
		update patientallergy set Allergen = @allergy, AllergyResponse = @allergyResponse, DeleteFlag = 0
		where Allergen = @allergy and PatientId = @PatientID
	END
	ELSE
	BEGIN
		insert into patientallergy(PatientId,PatientMasterVisitId,Allergen,AllergyResponse,DeleteFlag,CreateBy,CreateDate) 
		values(@PatientID,@MasterVisitID,@allergy,@allergyResponse, 0,1,GETDATE())
	END
	
End



GO
/****** Object:  StoredProcedure [dbo].[sp_savePatientEncounterChronicIllness]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		John Macharia
-- Create date: 29th Jan 2017
-- Description:	save patient encounter - Chronic Illness
-- =============================================
CREATE PROCEDURE [dbo].[sp_savePatientEncounterChronicIllness]
	-- Add the parameters for the stored procedure here
	@MasterVisitID int = null,
	@PatientID int = null,
	@chronicIllness varchar(50) = null,
	@treatment varchar(250) = null,
	@dose varchar(50) = null,
	@duration varchar(50) = null

AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
Set Nocount On;
-- Insert statements for procedure here
	if exists(select 1 from PatientChronicIllness where ChronicIllness = @chronicIllness and PatientId = @PatientID)
	BEGIN
		update PatientChronicIllness set Treatment = @treatment,Dose = @dose,Duration = @duration, DeleteFlag = 0
		where ChronicIllness = @chronicIllness and PatientId = @PatientID
	END
	ELSE
	BEGIN
		insert into PatientChronicIllness(PatientId,PatientMasterVisitId,ChronicIllness,Treatment,Dose,Duration,DeleteFlag,CreateBy,CreateDate) 
		values(@PatientID,@MasterVisitID,@chronicIllness,@treatment,@dose,@duration,0,1,GETDATE())
	END
	
End



GO
/****** Object:  StoredProcedure [dbo].[sp_savePatientEncounterDiagnosis]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		John Macharia
-- Create date: 29th Jan 2017
-- Description:	save patient encounter - Adverse Events
-- =============================================
CREATE PROCEDURE [dbo].[sp_savePatientEncounterDiagnosis]
	-- Add the parameters for the stored procedure here
	@masterVisitID int = null,
	@PatientID int = null,
	@diagnosis varchar(250) = null,
	@treatment varchar(250) = null

AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
Set Nocount On;
-- Insert statements for procedure here
	insert into PatientDiagnosis(PatientId,PatientMasterVisitId,Diagnosis,ManagementPlan,DeleteFlag,CreateBy,CreateDate) 
	values(@PatientID,@MasterVisitID,@diagnosis,@treatment,0,1,GETDATE())
	
	
End



GO
/****** Object:  StoredProcedure [dbo].[sp_savePatientEncounterPatientManagement]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		John Macharia
-- Create date: 29th Jan 2017
-- Description:	save patient encounter - Patient Management
-- =============================================
CREATE PROCEDURE [dbo].[sp_savePatientEncounterPatientManagement]
	-- Add the parameters for the stored procedure here
	@PatientMasterVisitID int = null,
	@PatientID int = null,
	@ARVAdherence int = null,
	@CTXAdherence int = null,
	@nextAppointment varchar(50) = null,
	@appointmentType varchar(50) = null

AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
Set Nocount On;
-- Insert statements for procedure here
	declare @ARVAdherenceType int = (Select Id from LookupMaster where name = 'ARVAdherence')
	declare @CTXAdherenceType int = (Select Id from LookupMaster where name = 'CTXAdherence')

	if(@PatientMasterVisitID > 0)
	BEGIN
		if(@ARVAdherence > 0)
		BEGIN
			if exists(select 1 from AdherenceOutcome where PatientMasterVisitId = @PatientMasterVisitID and PatientId = @PatientID and AdherenceType = @ARVAdherenceType)
			BEGIN
				update AdherenceOutcome set Score = @ARVAdherence
				where PatientMasterVisitId = @PatientMasterVisitID and PatientId = @PatientID and AdherenceType = @ARVAdherenceType
			END
			ELSE
			BEGIN
				insert into [dbo].[AdherenceOutcome] (PatientId, PatientMasterVisitId,AdherenceType,Score,DeleteFlag,CreateBy,CreateDate)
				values(@PatientID,@PatientMasterVisitID,@ARVAdherenceType,@ARVAdherence,0,1,GETDATE())
			END
		END

		if(@CTXAdherence > 0)
		BEGIN
			if exists(select 1 from AdherenceOutcome where PatientMasterVisitId = @PatientMasterVisitID and PatientId = @PatientID and AdherenceType = @CTXAdherenceType)
			BEGIN
				update AdherenceOutcome set Score = @CTXAdherence
				where PatientMasterVisitId = @PatientMasterVisitID and PatientId = @PatientID and AdherenceType = @CTXAdherenceType
			END
			ELSE
			BEGIN
				insert into [dbo].[AdherenceOutcome] (PatientId, PatientMasterVisitId,AdherenceType,Score,DeleteFlag,CreateBy,CreateDate)
				values(@PatientID,@PatientMasterVisitID,@CTXAdherenceType,@CTXAdherence,0,1,GETDATE())
			END
		END

		if exists(select 1 from PatientAppointment where PatientMasterVisitId = @PatientMasterVisitID and PatientId = @PatientID)
		BEGIN
			update PatientAppointment set AppointmentDate = @nextAppointment, ReasonId = @appointmentType
			where PatientMasterVisitId = @PatientMasterVisitID and PatientId = @PatientID
		END
		ELSE
		BEGIN
			insert into PatientAppointment(PatientId,PatientMasterVisitId,ServiceAreaId,AppointmentDate,ReasonId,DeleteFlag,CreatedBy,CreateDate) 
			values(@PatientID,@PatientMasterVisitID,211,@nextAppointment,@appointmentType,0,1,GETDATE())
		END
	END
	ELSE
	BEGIN
		if(@ARVAdherence > 0)
		BEGIN
			insert into [dbo].[AdherenceOutcome] (PatientId, PatientMasterVisitId,AdherenceType,Score,DeleteFlag,CreateBy,CreateDate)
			values(@PatientID,@PatientMasterVisitID,@ARVAdherenceType,@ARVAdherence,0,1,GETDATE())
		END

		if(@CTXAdherence > 0)
		BEGIN
			insert into [dbo].[AdherenceOutcome] (PatientId, PatientMasterVisitId,AdherenceType,Score,DeleteFlag,CreateBy,CreateDate)
			values(@PatientID,@PatientMasterVisitID,@CTXAdherenceType,@CTXAdherence,0,1,GETDATE())
		END

		insert into PatientAppointment(PatientId,PatientMasterVisitId,ServiceAreaId,AppointmentDate,ReasonId,DeleteFlag,CreatedBy,CreateDate) 
		values(@PatientID,@PatientMasterVisitID,211,@nextAppointment,@appointmentType,0,1,GETDATE())
	END
End



GO
/****** Object:  StoredProcedure [dbo].[sp_savePatientEncounterPHDP]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		John Macharia
-- Create date: 29th Jan 2017
-- Description:	save patient encounter - Chronic Illness
-- =============================================
CREATE PROCEDURE [dbo].[sp_savePatientEncounterPHDP]
	-- Add the parameters for the stored procedure here
	@MasterVisitID int = null,
	@PatientID int = null,
	@phdp varchar(50) = null

AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
Set Nocount On;
-- Insert statements for procedure here
	declare @phdpMasterID int = (select Id from LookupMaster where Name = 'PHDP')
	declare @phdpID int = (select LookupItemId from LookupMasterItem where LookupMasterId = @phdpMasterID and DisplayName = @phdp)

	if exists(select 1 from PatientPHDP where PatientMasterVisitId = @MasterVisitID and PatientId = @PatientID and Phdp = @phdpID)
	BEGIN
		UPDATE PatientPHDP SET DeleteFlag = 0
		where PatientMasterVisitId = @MasterVisitID and PatientId = @PatientID and Phdp = @phdpID
	END
	ELSE
	BEGIN
		insert into PatientPHDP(PatientId,PatientMasterVisitId,phdp,DeleteFlag,CreateBy,CreateDate) 
		values(@PatientID,@MasterVisitID,@phdpID,0,1,GETDATE())
	END
	
	
End


GO
/****** Object:  StoredProcedure [dbo].[sp_savePatientEncounterPhysicalExam]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		John Macharia
-- Create date: 7th Feb 2017
-- Description:	save patient encounter - Physical Examination
-- =============================================
CREATE PROCEDURE [dbo].[sp_savePatientEncounterPhysicalExam]
	-- Add the parameters for the stored procedure here
	@MasterVisitID int = null,
	@PatientID int = null,
	@examType int = null,
	@exam varchar(250) = null,
	@findings varchar(50) = null

AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
Set Nocount On;
-- Insert statements for procedure here
	if exists(select 1 from PhysicalExamination where PatientMasterVisitId = @MasterVisitID
	and PatientId = @PatientID and ExaminationTypeId = @examType and ExamId = @exam)
	BEGIN
		update PhysicalExamination set Finding = @findings, DeleteFlag = 0
		where PatientMasterVisitId = @MasterVisitID and PatientId = @PatientID and ExaminationTypeId = @examType and ExamId = @exam
	END
	ELSE
	BEGIN
		insert into PhysicalExamination(PatientId,PatientMasterVisitId,ExaminationTypeId,ExamId,Finding,DeleteFlag,CreateBy,CreateDate) 
		values(@PatientID,@MasterVisitID,@examType,@exam,@findings,0,1,GETDATE())
	END
	
End



GO
/****** Object:  StoredProcedure [dbo].[sp_savePatientEncounterPresentingComplaints]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		John Macharia
-- Create date: 20th Jan 2017
-- Description:	save patient encounter - Presenting Complaints
-- =============================================
CREATE PROCEDURE [dbo].[sp_savePatientEncounterPresentingComplaints]
	-- Add the parameters for the stored procedure here
	@PatientMasterVisitID int = null,
	@PatientID int = null,
	@serviceID int = null,
	@VisitDate datetime = null,
	@VisitScheduled int =null,
	@VisitBy int = null,
	@Complaints nvarchar(1000) = null,
	@TBScreening int = null,
	@NutritionalStatus int = null,
	@lmp nvarchar(50) = null,
	@PregStatus nvarchar(50) = null,
	@edd nvarchar(50) = null,
	@ANC nvarchar(50) = null,
	@OnFP int = null,
	@ReasonNotOnFPMethod int = null,
	@CaCx nvarchar(50) = null,
	@STIScreening nvarchar(50) = null,
	@STIPartnerNotification nvarchar(50) = null

AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
Set Nocount On;

	declare @TBScreeningTypeID int = (Select Id from LookupMaster where name = 'TBStatus')
	declare @NutritionScreeningTypeID int = (Select Id from LookupMaster where name = 'NutritionStatus')
	declare @CaCxScreeningTypeID int = (Select Id from LookupMaster where name = 'CaCxScreening')
	declare @STIScreeningTypeID int = (Select Id from LookupMaster where name = 'STIScreening')
	declare @FPId int

	IF(@PatientMasterVisitID > 0)
	BEGIN
		update PatientMasterVisit set visitDate = @VisitDate, visitScheduled = @VisitScheduled, visitBy = @VisitBy
		where id = @PatientMasterVisitID and PatientId = @PatientID

		if exists(select 1 from ComplaintsHistory where PatientMasterVisitId = @PatientMasterVisitID and PatientId = @PatientID)
		BEGIN
			update ComplaintsHistory set PresentingComplaint = @Complaints 
			where PatientMasterVisitId = @PatientMasterVisitID and PatientId = @PatientID
		END
		ELSE
		BEGIN
			insert into ComplaintsHistory (PatientId,PatientMasterVisitId,PresentingComplaint,DeleteFlag,CreateBy,CreateDate) 
			values(@PatientID,@PatientMasterVisitID,@Complaints,0,1,GETDATE())
		END

		if(@TBScreening > 0)
		begin
			IF EXISTS(SELECT 1 FROM PatientScreening WHERE PatientMasterVisitId = @PatientMasterVisitID and PatientId = @PatientID 
			and ScreeningTypeId = @TBScreeningTypeID)
			BEGIN
				update PatientScreening set ScreeningValueId = @TBScreening
				where PatientMasterVisitId = @PatientMasterVisitID and PatientId = @PatientID and ScreeningTypeId = @TBScreeningTypeID
			END
			ELSE
			BEGIN
				insert into PatientScreening (PatientId,PatientMasterVisitId,ScreeningTypeId,ScreeningDone,ScreeningValueId,DeleteFlag,CreateBy,CreateDate)
				values(@PatientID,@PatientMasterVisitID,@TBScreeningTypeID,1,@TBScreening,0,1,GETDATE())
			END
		end

		if(@NutritionalStatus > 0)
		begin
			IF EXISTS(SELECT 1 FROM PatientScreening WHERE PatientMasterVisitId = @PatientMasterVisitID and PatientId = @PatientID 
			and ScreeningTypeId = @NutritionScreeningTypeID)
			BEGIN
				update PatientScreening set ScreeningValueId = @NutritionalStatus
				where PatientMasterVisitId = @PatientMasterVisitID and PatientId = @PatientID and ScreeningTypeId = @NutritionScreeningTypeID
			END
			ELSE
			BEGIN
				insert into PatientScreening (PatientId,PatientMasterVisitId,ScreeningTypeId,ScreeningDone,ScreeningValueId,DeleteFlag,CreateBy,CreateDate)
				values(@PatientID,@PatientMasterVisitID,@NutritionScreeningTypeID,1,@NutritionalStatus,0,1,GETDATE())
			END
		end

		if(@CaCx > 0)
		begin
			IF EXISTS(SELECT 1 FROM PatientScreening WHERE PatientMasterVisitId = @PatientMasterVisitID and PatientId = @PatientID 
			and ScreeningTypeId = @CaCxScreeningTypeID)
			BEGIN
				update PatientScreening set ScreeningValueId = @CaCx
				where PatientMasterVisitId = @PatientMasterVisitID and PatientId = @PatientID and ScreeningTypeId = @CaCxScreeningTypeID
			END
			ELSE
			BEGIN
				insert into PatientScreening (PatientId,PatientMasterVisitId,ScreeningTypeId,ScreeningDone,ScreeningValueId,DeleteFlag,CreateBy,CreateDate)
				values(@PatientID,@PatientMasterVisitID,@CaCxScreeningTypeID,1,@CaCx,0,1,GETDATE())
			END
		end

		if(@STIScreening > 0)
		begin
			IF EXISTS(SELECT 1 FROM PatientScreening WHERE PatientMasterVisitId = @PatientMasterVisitID and PatientId = @PatientID 
			and ScreeningTypeId = @STIScreeningTypeID)
			BEGIN
				update PatientScreening set ScreeningValueId = @STIScreening
				where PatientMasterVisitId = @PatientMasterVisitID and PatientId = @PatientID and  ScreeningTypeId = @STIScreeningTypeID
			END
			ELSE
			BEGIN
				insert into PatientScreening (PatientId,PatientMasterVisitId,ScreeningTypeId,ScreeningDone,ScreeningValueId,DeleteFlag,CreateBy,CreateDate)
				values(@PatientID,@PatientMasterVisitID,@STIScreeningTypeID,1,@STIScreening,0,1,GETDATE())
			END
		end

		IF EXISTS(SELECT 1 FROM PatientFamilyPlanning where PatientMasterVisitId = @PatientMasterVisitID and PatientId = @PatientID)
		BEGIN
			update PatientFamilyPlanning set FPStatusId = @OnFP, ReasonNotOnFPId = @ReasonNotOnFPMethod
			where PatientMasterVisitId = @PatientMasterVisitID and PatientId = @PatientID
			set @FPId = (select id from PatientFamilyPlanning where PatientMasterVisitId = @PatientMasterVisitID and PatientId = @PatientID)
		END
		ELSE
		BEGIN
			insert into PatientFamilyPlanning (PatientId,PatientMasterVisitId,FPStatusId, ReasonNotOnFPId, DeleteFlag,CreateBy,CreateDate)
			values(@PatientID,@PatientMasterVisitID,@OnFP,@ReasonNotOnFPMethod, 0,1,GETDATE())
			set @FPId = scope_identity()
		END
		
		--IF EXISTS(SELECT 1 FROM PatientFamilyPlanningMethod where PatientFPId = @FPId and FPMethodId = @fpMethod)
		--BEGIN
		--	update PatientFamilyPlanningMethod set DeleteFlag = 0
		--	where PatientFPId = @FPId and FPMethodId = @fpMethod
		--END
		--ELSE
		--BEGIN
		--	insert into PatientFamilyPlanningMethod (PatientId,PatientFPId, FPMethodId,DeleteFlag)
		--	values(@PatientID,@FPId,@fpMethod,0)
		--END

		IF EXISTS(SELECT 1 FROM PatientPhysicalExamination where PatientMasterVisitId = @PatientMasterVisitID and PatientId = @PatientID)
		BEGIN
			update PatientPhysicalExamination set FemaleLMP = @lmp,PregnancyStatus=@PregStatus,ExpectedDateOfChild=@edd,
			ANCPNCProfile=@ANC,STIPartnerNotification=@STIPartnerNotification
			where PatientMasterVisitId = @PatientMasterVisitID and PatientId = @PatientID
		END
		ELSE
		BEGIN
			insert into PatientPhysicalExamination (PatientId,PatientMasterVisitId,FemaleLMP,PregnancyStatus,ExpectedDateOfChild,ANCPNCProfile,STIPartnerNotification,CreateBy,CreateDate)
			values(@PatientID,@PatientMasterVisitID,@lmp,@PregStatus,@edd,@ANC,@STIPartnerNotification,1,GETDATE())
		END

		select @PatientMasterVisitID as PatientMasterVisitID, @FPId as FPId
	END
	ELSE
	BEGIN
		insert into PatientMasterVisit (patientId,serviceId,start,active,createdBy,createDate,visitDate,visitScheduled,visitBy)
		values(@PatientID,@serviceID,CONVERT (time, GETDATE()),1,1,GETDATE(),@VisitDate,@VisitScheduled,@VisitBy)
		SELECT @PatientMasterVisitID = SCOPE_IDENTITY()

		insert into ComplaintsHistory (PatientId,PatientMasterVisitId,PresentingComplaint,DeleteFlag,CreateBy,CreateDate) 
		values(@PatientID,@PatientMasterVisitID,@Complaints,0,1,GETDATE())

		if(@TBScreening > 0)
		begin
			insert into PatientScreening (PatientId,PatientMasterVisitId,ScreeningTypeId,ScreeningDone,ScreeningValueId,DeleteFlag,CreateBy,CreateDate)
			values(@PatientID,@PatientMasterVisitID,@TBScreeningTypeID,1,@TBScreening,0,1,GETDATE())
		end
		if(@NutritionalStatus > 0)
		begin
			insert into PatientScreening (PatientId,PatientMasterVisitId,ScreeningTypeId,ScreeningDone,ScreeningValueId,DeleteFlag,CreateBy,CreateDate)
			values(@PatientID,@PatientMasterVisitID,@NutritionScreeningTypeID,1,@NutritionalStatus,0,1,GETDATE())
		end
		if(@STIScreening > 0)
		begin
			insert into PatientScreening (PatientId,PatientMasterVisitId,ScreeningTypeId,ScreeningDone,ScreeningValueId,DeleteFlag,CreateBy,CreateDate)
			values(@PatientID,@PatientMasterVisitID,@STIScreeningTypeID,1,@STIScreening,0,1,GETDATE())
		end
		if(@CaCx > 0)
		begin
			insert into PatientScreening (PatientId,PatientMasterVisitId,ScreeningTypeId,ScreeningDone,ScreeningValueId,DeleteFlag,CreateBy,CreateDate)
			values(@PatientID,@PatientMasterVisitID,@CaCxScreeningTypeID,1,@CaCx,0,1,GETDATE())
		end

		insert into PatientFamilyPlanning (PatientId,PatientMasterVisitId,FPStatusId,ReasonNotOnFPId, DeleteFlag ,CreateBy,CreateDate)
		values(@PatientID,@PatientMasterVisitID,@OnFP, @ReasonNotOnFPMethod ,0,1,GETDATE())
		set @FPId = scope_identity()

		--insert into PatientFamilyPlanningMethod (PatientId,PatientFPId, FPMethodId,DeleteFlag)
		--values(@PatientID,@FPId,@fpMethod,0)

		insert into PatientPhysicalExamination (PatientId,PatientMasterVisitId,FemaleLMP,PregnancyStatus,ExpectedDateOfChild,ANCPNCProfile,STIPartnerNotification,CreateBy,CreateDate)
		values(@PatientID,@PatientMasterVisitID,@lmp,@PregStatus,@edd,@ANC,@STIPartnerNotification,1,GETDATE())

		select @PatientMasterVisitID as PatientMasterVisitID, @FPId as FPId

	END
End



GO
/****** Object:  StoredProcedure [dbo].[sp_savePatientEncounterVaccines]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		John Macharia
-- Create date: 29th Jan 2017
-- Description:	save patient encounter - Chronic Illness
-- =============================================
CREATE PROCEDURE [dbo].[sp_savePatientEncounterVaccines]
	-- Add the parameters for the stored procedure here
	@MasterVisitID int = null,
	@PatientID int = null,
	@vaccine varchar(50) = null,
	@vaccineStage varchar(50) = null,
	@vaccineDate varchar(50) = null,
	@dose int = null,
	@duration int = null

AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
Set Nocount On;
-- Insert statements for procedure here
	if exists(select 1 from Vaccination where Vaccine = @vaccine and VaccineStage = @vaccineStage and PatientId = @PatientID)
	BEGIN
		update Vaccination set VaccineDate = @vaccineDate, DeleteFlag = 0
		where Vaccine = @vaccine and VaccineStage = @vaccineStage and PatientId = @PatientID
	END
	ELSE
	BEGIN
		insert into Vaccination(PatientId,PatientMasterVisitId,Vaccine,VaccineStage,VaccineDate,DeleteFlag,CreatedBy,CreateDate) 
		values(@PatientID,@MasterVisitID,@vaccine,@vaccineStage,@vaccineDate, 0,1,GETDATE())
	END
	
End



GO
/****** Object:  StoredProcedure [dbo].[sp_savePatientFamilyPlanningMethod]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		John Macharia
-- Create date: 11th Mar 2017
-- Description:	save patient family planning method
-- =============================================
CREATE PROCEDURE [dbo].[sp_savePatientFamilyPlanningMethod]
	-- Add the parameters for the stored procedure here
	@PatientID int = null,
	@FPId int = null,
	@fpMethod int = null
	

AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
Set Nocount On;

	IF EXISTS(SELECT 1 FROM PatientFamilyPlanningMethod where patientid = @PatientID and PatientFPId = @FPId and FPMethodId = @fpMethod)
	BEGIN
		update PatientFamilyPlanningMethod set DeleteFlag = 0
		where patientid = @PatientID and PatientFPId = @FPId and FPMethodId = @fpMethod
	END
	ELSE
	BEGIN
		insert into PatientFamilyPlanningMethod (PatientId,PatientFPId, FPMethodId,DeleteFlag)
		values(@PatientID,@FPId,@fpMethod,0)
	END
END


GO
/****** Object:  StoredProcedure [dbo].[sp_SaveUpdatePharmacy_GreenCard]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_SaveUpdatePharmacy_GreenCard]                                                
( 
 @PatientMasterVisitID int = 0,                                               
 @PatientId int = null,                                                
 @LocationID int = null,                                                
 @OrderedBy int = null,                                                                                                                                          
 @UserID int = null,                                                 
 @RegimenType varchar(50) = null,                                                
 @DispensedBy int=null,                                                
 @DispensedByDate datetime=null,    
 @RegimenLine int = null,                
 @PharmacyNotes varchar(200) = null,
 @ModuleID int = null                   
)                                                
                                                
As       
Begin               
	Declare @ptn_pharmacy int,@RegimenId int,@ARTStartDate datetime,@Ptn_Pharmacy_Pk int

	Select @RegimenType = Nullif(Ltrim(Rtrim(@RegimenType)), '')

	IF EXISTS(select 1 from ord_PatientPharmacyOrder where masterVisitID = @PatientMasterVisitID) 
	BEGIN
		set @Ptn_Pharmacy_Pk = (select ptn_pharmacy_pk from ord_PatientPharmacyOrder where masterVisitID = @PatientMasterVisitID)
		Update [ord_PatientPharmacyOrder] Set
			[OrderedBy] = @OrderedBy, [DispensedBy] = @DispensedBy,
			[ProgID] = 222,	[UpdateDate] = Getdate(),
			[ProviderID] = 1, [DispensedByDate] = @DispensedByDate,
			UserID = @UserID,	Regimenline = @Regimenline,
			PharmacyNotes = @PharmacyNotes
		Where masterVisitID = @PatientMasterVisitID;
		
		If (@DispensedByDate Is Not Null And @DispensedBy > 0) 
		Begin
			Update ord_PatientPharmacyOrder Set
				OrderStatus = 2
			Where masterVisitID = @PatientMasterVisitID;
		End

		If(@RegimenType Is Not Null) 
		Begin
		
			Select @RegimenId = RegimenMap_Pk
			From dtl_regimenmap a, ord_patientpharmacyorder b
			Where a.ptn_pk = b.ptn_pk
			And b.ptn_pharmacy_pk = a.orderID
			And b.Ptn_Pharmacy_Pk = @Ptn_Pharmacy_Pk;

			Update [dtl_RegimenMap] Set
				[RegimenType] = @RegimenType,
				[UpdateDate] = Getdate()
			Where ([RegimenMap_Pk] = @RegimenId);
		End

		Select @PatientId = ptn_pk
		From ord_PatientPharmacyOrder
		Where ptn_pharmacy_pk = @ptn_pharmacy_pk;
		
		Select @ARTStartDate = dbo.fn_GetPatientARTStartDate_constella(@PatientId);
		
		Update mst_Patient Set
			ARTStartDate = @ARTStartDate
		Where ptn_pk = @PatientId;

		If Exists (Select *
			From ord_PatientPharmacyOrder
			Where orderstatus = 1
			And Ptn_Pk = @PatientId
			And ptn_pharmacy_pk = @ptn_pharmacy_pk) 
			Begin
				Delete From dtl_PatientPharmacyOrder
				Where ptn_pharmacy_pk = @ptn_pharmacy_pk
			End

		Select @ptn_pharmacy_pk;
	END
	ELSE
	BEGIN
		Insert Into dbo.ord_PatientPharmacyOrder (
			Ptn_pk,	masterVisitID, LocationID, OrderedBy, OrderedByDate, DispensedBy, DispensedByDate, ProgID,
			UserID, CreateDate, ProviderID, Regimenline, PharmacyNotes)
		Values (
			@PatientId, @PatientMasterVisitID, @LocationID, @OrderedBy, getdate(), @DispensedBy, @DispensedByDate, 222, 
			@UserID, Getdate(), 1, @RegimenLine, @PharmacyNotes);

		Set @ptn_pharmacy =SCOPE_IDENTITY();

		Update ord_PatientPharmacyOrder Set
			ReportingID = (Select Right('000000' + Convert(varchar, @ptn_pharmacy), 6))
		Where ptn_pharmacy_pk = @ptn_pharmacy;

		If (@DispensedByDate Is Not Null And @DispensedBy > 0) Begin
			Update ord_PatientPharmacyOrder Set
				OrderStatus = 2
			Where ptn_pharmacy_pk = @ptn_pharmacy;
		End

		
		If(@RegimenType Is Not Null) 
		Begin	
			Insert Into dtl_RegimenMap (Ptn_Pk,	LocationID,	Visit_Pk, RegimenType, OrderId,	UserID,	CreateDate)
			Values (@PatientId, @LocationID, @PatientMasterVisitID, @RegimenType, @ptn_pharmacy, @UserID, Getdate());
		End

		Select @ARTStartDate = dbo.fn_GetPatientARTStartDate_constella(@PatientId);
		Update mst_Patient Set
			ARTStartDate = @ARTStartDate
		Where ptn_pk = @PatientId;

		Select @ptn_pharmacy;

	END
End

GO
/****** Object:  StoredProcedure [dbo].[sp_SaveUpdatePharmacyPrescription_GreenCard]    Script Date: 3/22/2017 12:06:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_SaveUpdatePharmacyPrescription_GreenCard]                                    
	@ptn_pharmacy_pk int = null,
	@DrugId int = null,
	@BatchId varchar(50) = null,
	@Dose decimal(18,2)=0,                                 
	@FreqId int = null,
	@Duration decimal(18,2) = null,
	@qtyPres decimal(18,2) = null,
	@qtyDisp decimal(18,2) = null,
	@UserID int = null,                
	@Prophylaxis int = null,
	@pmscm varchar(50) = null                               
                                    
AS                                        
Begin
	declare @TotalOrderedQuantity int,@TotalDispensedQuantity int
	Select @TotalOrderedQuantity = 0, @TotalDispensedQuantity = 0
			
	if exists(select 1 from dtl_PatientPharmacyOrder where ptn_pharmacy_pk = @ptn_pharmacy_pk And Drug_Pk = @DrugId)
	BEGIN
		Update dtl_PatientPharmacyOrder Set
			SingleDose = @Dose,
			FrequencyID = @FreqId,
			Duration = @Duration,
			OrderedQuantity = @qtyPres,
			BatchNo = @BatchId,
			UserID = @UserID,
			UpdateDate = Getdate(),
			Prophylaxis = @Prophylaxis
		Where ptn_pharmacy_pk = @ptn_pharmacy_pk And Drug_Pk = @DrugId

		if(@pmscm = 1 and @qtyDisp > 0)
		BEGIN
			INSERT into dtl_patientPharmacyDispensed
			(ptn_pharmacy_pk,drug_pk,batchId,frequencyID,dose,duration,dispensedQuantity,dispensedDate,deleteFlag)
			values(@ptn_pharmacy_pk,@DrugId,@BatchId,@FreqId,@Dose,@Duration,@qtyDisp,GETDATE(),0)

			update ord_PatientPharmacyOrder set DispensedByDate = GETDATE(), DispensedBy = @UserID
		END
	
	END
	ELSE
	BEGIN
		Insert Into dtl_PatientPharmacyOrder (
			ptn_pharmacy_pk,Drug_Pk,SingleDose,FrequencyID,Duration,OrderedQuantity,BatchNo,UserID,CreateDate,Prophylaxis,
			genericid,StrengthID)
		Values (
			@ptn_pharmacy_pk,@DrugId,@Dose,@FreqId,@Duration,@qtyPres,@BatchId,@UserID,Getdate(),@Prophylaxis,0,0);

		if(@pmscm = 1 and @qtyDisp > 0)
		BEGIN
			INSERT into dtl_patientPharmacyDispensed
			(ptn_pharmacy_pk,drug_pk,batchId,frequencyID,dose,duration,dispensedQuantity,dispensedDate,deleteFlag)
			values(@ptn_pharmacy_pk,@DrugId,@BatchId,@FreqId,@Dose,@Duration,@qtyDisp,GETDATE(),0)

			update ord_PatientPharmacyOrder set DispensedByDate = GETDATE(), DispensedBy = @UserID
		END
		
	END

	Select	@TotalOrderedQuantity = Sum(a.OrderedQuantity),
			@TotalDispensedQuantity = Sum(b.dispensedQuantity)
	From dtl_PatientPharmacyOrder a left join dtl_patientPharmacyDispensed b on a.ptn_pharmacy_pk = b.ptn_pharmacy_pk
	Where a.ptn_pharmacy_pk = @ptn_pharmacy_pk

	Update ord_PatientPharmacyOrder Set
		OrderStatus = Case 
						When DispensedByDate Is Null Then 1 --new order
						When DispensedByDate Is Not Null  And @TotalDispensedQuantity = @TotalOrderedQuantity Then 2 --complete
						When DispensedByDate Is Not Null  And @TotalDispensedQuantity < @TotalOrderedQuantity Then 3 --partial
						Else orderstatus End
	Where ptn_pharmacy_pk = @ptn_pharmacy_pk

                                     
End


GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Defaults to zero(0) and one (1) when deleted' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AdherenceOutcome', @level2type=N'COLUMN',@level2name=N'DeleteFlag'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Track patient adherance on both CTX/Dapsone or ARV ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AdherenceOutcome'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Track adverse events courses,medication causing the adverse events,severity and actiontaken.Recorded per visit' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AdverseEvent'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'HIVEnrollmentBaseline'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Master patient details.Captures generic patient information to be used across all service areas' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Patient'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tracks patient allergies per visit' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PatientAllergies'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tracks patient allergies per visit' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PatientAllergy'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tracks patient appointments and ststus of the appointments' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PatientAppointment'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Records Prior ART use experience.Especially for TI patients' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PatientARVHistory'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Baseline summary of Initiation parameters,collected once during enrollment' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PatientBaselineAssessment'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tracks care ending for patients either deaths/TO' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PatientCareending'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tracks Chronic Illnesses cormodities and the current treatment of the illnesses per visit' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PatientChronicIllness'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tracks and manages patient Consent information,can be updated to reflect the current Consent details with history of the previous Consents' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PatientConsent'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tracks and manages patient contact information,can be updated to reflect the current contact details with history of the previous contacts' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PatientContact'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Clinician conclusions on the treatment plan,done per visit' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PatientDiagnosis'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tracks and manages all patient encounters per visit per service' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PatientEncounter'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tracks patient enrollment into the different service areas' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PatientEnrollment'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PatientHivDiagnosis'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tracks and manages patient service identifier information' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PatientIdentifier'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tracks and manages patient contact information,can be updated to reflect the current contact details with history of the previous contacts' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PersonContact'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "X"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 221
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'LookupItemView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'LookupItemView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "PatientHivDiagnosis"
            Begin Extent = 
               Top = 12
               Left = 275
               Bottom = 142
               Right = 480
            End
            DisplayFlags = 280
            TopColumn = 5
         End
         Begin Table = "PatientTransferIn"
            Begin Extent = 
               Top = 18
               Left = 17
               Bottom = 148
               Right = 211
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PatientTreatmentInitiation"
            Begin Extent = 
               Top = 6
               Left = 513
               Bottom = 136
               Right = 723
            End
            DisplayFlags = 280
            TopColumn = 7
         End
         Begin Table = "PatientBaselineAssessment"
            Begin Extent = 
               Top = 6
               Left = 761
               Bottom = 136
               Right = 955
            End
            DisplayFlags = 280
            TopColumn = 12
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 31
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 2175
         Width = 1500
         Width = 1500
         Width = 2385
         Width = 2595
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Wi' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PatientBaselineView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'dth = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PatientBaselineView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PatientBaselineView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "PersonContact"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 228
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 11
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PersonContactView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PersonContactView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Person"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 8
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 13
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PersonView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PersonView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[43] 4[12] 2[14] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "PatientMasterVisit"
            Begin Extent = 
               Top = 12
               Left = 263
               Bottom = 204
               Right = 433
            End
            DisplayFlags = 280
            TopColumn = 5
         End
         Begin Table = "mst_User"
            Begin Extent = 
               Top = 20
               Left = 21
               Bottom = 149
               Right = 191
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 2190
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_patientVisit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_patientVisit'
GO
