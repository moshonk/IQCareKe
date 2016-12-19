USE [master]
GO
/****** Object:  Database [Greencard]    Script Date: 12/14/2016 4:18:55 PM ******/
CREATE DATABASE [Greencard]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Greencard', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\Greencard.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Greencard_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\Greencard_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Greencard] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Greencard].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Greencard] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Greencard] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Greencard] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Greencard] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Greencard] SET ARITHABORT OFF 
GO
ALTER DATABASE [Greencard] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Greencard] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Greencard] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Greencard] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Greencard] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Greencard] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Greencard] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Greencard] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Greencard] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Greencard] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Greencard] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Greencard] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Greencard] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Greencard] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Greencard] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Greencard] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Greencard] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Greencard] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Greencard] SET  MULTI_USER 
GO
ALTER DATABASE [Greencard] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Greencard] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Greencard] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Greencard] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [Greencard] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Greencard', N'ON'
GO
USE [Greencard]
GO
/****** Object:  Table [dbo].[AdherenceOutcome]    Script Date: 12/14/2016 4:18:55 PM ******/
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
	[Treatment] [varchar](50) NOT NULL,
	[AdherenceType] [int] NOT NULL,
	[Score] [int] NOT NULL,
	[ScoreDescription] [varchar](150) NULL,
	[Void] [bit] NOT NULL,
	[VoidBy] [int] NULL,
	[VoidDate] [date] NULL,
	[CreateBy] [int] NOT NULL,
	[CreateDate] [date] NOT NULL,
 CONSTRAINT [PK_PatientAdheranceAssessment] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AdultChildVaccination]    Script Date: 12/14/2016 4:18:55 PM ******/
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
/****** Object:  Table [dbo].[AdverseEvent]    Script Date: 12/14/2016 4:18:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AdverseEvent](
	[id] [int] NOT NULL,
	[patientId] [int] NOT NULL,
	[PatientmasterVisitId] [int] NOT NULL,
	[EventName] [varchar](50) NOT NULL,
	[EventCause] [varchar](50) NOT NULL,
	[Severity] [varchar](50) NOT NULL,
	[Action] [varchar](250) NOT NULL,
	[Void] [int] NULL,
	[VoidBy] [int] NULL,
	[VoidDate] [datetime] NULL,
	[CreateBy] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_AdverseEvents] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ARTInitiationBaseline]    Script Date: 12/14/2016 4:18:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ARTInitiationBaseline](
	[id] [int] NOT NULL,
	[PatientId] [int] NOT NULL,
	[PatientMasterVisitID] [int] NOT NULL,
	[HBVInfected] [int] NOT NULL,
	[Pregnant] [int] NOT NULL,
	[TBinfected] [int] NOT NULL,
	[WHOStage] [int] NOT NULL,
	[BreastFeeding] [int] NOT NULL,
	[CD4Count] [int] NULL,
	[ViralLoad] [int] NULL,
	[ViralLoadDate] [date] NULL,
	[MUAC] [decimal](4, 1) NULL,
	[Weight] [decimal](4, 1) NOT NULL,
	[Height] [decimal](4, 1) NOT NULL,
	[BMI] [decimal](3, 1) NOT NULL,
	[ARTCohort] [varchar](50) NULL,
	[ARTStartDate] [date] NULL,
	[StartRegimen] [int] NULL,
	[StartRegimenLine] [int] NULL,
	[EnrollmentDate] [date] NOT NULL,
	[Void] [int] NULL,
	[VoidBy] [int] NULL,
	[VoidDate] [date] NOT NULL,
	[CreateDate] [date] NOT NULL,
	[CreateBy] [int] NOT NULL,
 CONSTRAINT [PK_PatientARTInitiationBaseline] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ARTUseHistory]    Script Date: 12/14/2016 4:18:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ARTUseHistory](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[PatientId] [int] NOT NULL,
	[Purpose] [varchar](150) NOT NULL,
	[Regimen] [varchar](50) NOT NULL,
	[DateLastUsed] [date] NOT NULL,
	[Void] [bit] NOT NULL,
	[VoidBy] [int] NULL,
	[VoidDate] [datetime] NULL,
	[CreateBy] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_art_use_history] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ComplaintsHistory]    Script Date: 12/14/2016 4:18:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ComplaintsHistory](
	[id] [int] NOT NULL,
	[patientId] [int] NOT NULL,
	[PatientMasterVisitId] [int] NOT NULL,
	[complaints] [varchar](max) NOT NULL,
	[Void] [int] NOT NULL,
	[VoidBy] [int] NULL,
	[VoidDate] [datetime] NULL,
	[createBy] [int] NOT NULL,
	[createDate] [datetime] NOT NULL,
 CONSTRAINT [PK_ComplaintsHistory] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DiagnosisARVHistory]    Script Date: 12/14/2016 4:18:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DiagnosisARVHistory](
	[id] [int] NOT NULL,
	[PatientId] [int] NOT NULL,
	[HIVDiagnosisDate] [date] NOT NULL,
	[EnrollmentDate] [date] NOT NULL,
	[EnrollmentWHOStage] [int] NOT NULL,
	[ARTInitiationDate] [date] NOT NULL,
	[ARTHistory] [int] NOT NULL,
	[Void] [bit] NOT NULL,
	[VoidBy] [int] NULL,
	[VoidDate] [datetime] NULL,
	[CreateBy] [int] NULL,
	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_diagnosis_arv_history] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Disclosure]    Script Date: 12/14/2016 4:18:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Disclosure](
	[Id] [int] NOT NULL,
	[PatientId] [int] NOT NULL,
	[PatientMasterVisitId] [int] NOT NULL,
	[Category] [varchar](15) NOT NULL,
	[DisclosureStage] [varchar](10) NOT NULL,
	[DisclosureDate] [date] NULL,
	[Void] [bit] NOT NULL,
	[VoidBy] [int] NULL,
	[VoidDate] [date] NULL,
	[CreateBy] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Disclosure] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[INHProphylaxis]    Script Date: 12/14/2016 4:18:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[INHProphylaxis](
	[Id] [int] NOT NULL,
	[PatientId] [int] NOT NULL,
	[PatientMasterVisitId] [int] NOT NULL,
	[StartDate] [date] NOT NULL,
	[Completion] [varchar](5) NOT NULL,
	[CompletionDate] [date] NULL,
	[Void] [bit] NOT NULL,
	[VoidBy] [int] NULL,
	[VoidDate] [date] NULL,
	[CreateBy] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_INHProphylaxis] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Patient]    Script Date: 12/14/2016 4:18:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Patient](
	[id] [int] NOT NULL,
	[ptn_pk] [int] IDENTITY(1,1) NOT NULL,
	[uuid] [varbinary](16) NOT NULL,
	[FName] [varchar](50) NOT NULL,
	[MName] [varchar](50) NOT NULL,
	[LName] [varchar](50) NOT NULL,
	[DateOfBirth] [date] NOT NULL,
	[Gender] [int] NOT NULL,
	[IdentificationType] [int] NULL,
	[IdentificationNo] [varchar](50) NULL,
	[Status] [bit] NOT NULL,
	[Void] [bit] NOT NULL,
	[VoidDate] [datetime] NULL,
	[CreateBy] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_person_1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PatientAllergies]    Script Date: 12/14/2016 4:18:55 PM ******/
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
/****** Object:  Table [dbo].[PatientAppointment]    Script Date: 12/14/2016 4:18:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PatientAppointment](
	[id] [int] NOT NULL,
	[PatientMasterVisitId] [int] NOT NULL,
	[ModuleId] [int] NOT NULL,
	[PatientId] [int] NOT NULL,
	[AppointmentDate] [date] NOT NULL,
	[ReasonId] [int] NOT NULL,
	[Description] [varchar](250) NULL,
	[Status] [int] NOT NULL,
	[StatusDate] [date] NULL,
	[Void] [bit] NOT NULL,
	[VoidBy] [int] NULL,
	[VoidDate] [datetime] NULL,
	[CreateBy] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_PatientAppointment] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PatientCareending]    Script Date: 12/14/2016 4:18:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PatientCareending](
	[id] [int] NOT NULL,
	[patientId] [int] NOT NULL,
	[PatientMasterVisitId] [int] NOT NULL,
	[PatientEnrollmentId] [int] NOT NULL,
	[ExitReason] [int] NOT NULL,
	[ExitDate] [date] NOT NULL,
	[Void] [bit] NOT NULL,
	[VoidBy] [int] NULL,
	[VoidDate] [datetime] NULL,
	[CreateBy] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_PatientCareending] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PatientChronicIllness]    Script Date: 12/14/2016 4:18:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PatientChronicIllness](
	[id] [int] NOT NULL,
	[PatientId] [int] NOT NULL,
	[PatientMasterVisitId] [int] NOT NULL,
	[ChronicIllness] [int] NOT NULL,
	[Treatment] [varchar](150) NOT NULL,
	[Dose] [int] NOT NULL,
	[Duration] [int] NOT NULL,
	[void] [bit] NOT NULL,
	[VoidBy] [int] NULL,
	[VoidDate] [date] NULL,
	[CreateBy] [int] NOT NULL,
	[CreateDate] [date] NOT NULL,
 CONSTRAINT [PK_ChronicIllness] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PatientContact]    Script Date: 12/14/2016 4:18:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PatientContact](
	[id] [int] NOT NULL,
	[patientId] [int] NOT NULL,
	[postalAddress] [varchar](150) NOT NULL,
	[mobileNo] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[Void] [int] NULL,
	[VoidBy] [int] NULL,
	[VoidDate] [date] NULL,
	[CreateBy] [int] NOT NULL,
	[CreateDate] [date] NOT NULL,
 CONSTRAINT [PK_patient_contact] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PatientDiagnosis]    Script Date: 12/14/2016 4:18:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PatientDiagnosis](
	[id] [int] NOT NULL,
	[patientId] [int] NOT NULL,
	[MasterVisitId] [int] NOT NULL,
	[diagnosis] [int] NOT NULL,
	[treatment] [varchar](250) NOT NULL,
	[dose] [int] NOT NULL,
	[duration] [int] NOT NULL,
	[void] [int] NULL,
	[voidBy] [int] NULL,
	[voidDate] [date] NULL,
	[createBy] [int] NOT NULL,
	[createDate] [date] NOT NULL,
 CONSTRAINT [PK_PatientDiagnosis] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PatientEncounter]    Script Date: 12/14/2016 4:18:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PatientEncounter](
	[id] [int] NOT NULL,
	[PatientId] [int] NOT NULL,
	[ptn_pk] [int] NOT NULL,
	[EncounterTypeId] [int] NOT NULL,
	[PatientMasterVisitId] [int] NOT NULL,
	[EncounterStartTime] [time](7) NOT NULL,
	[EncounterEndTime] [time](7) NOT NULL,
	[ServiceId] [int] NOT NULL,
	[Void] [bit] NULL,
	[VoidDate] [datetime] NULL,
	[VoidBy] [int] NULL,
	[createBy] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_patient_encounter] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PatientEnrollment]    Script Date: 12/14/2016 4:18:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PatientEnrollment](
	[id] [int] NOT NULL,
	[personId] [int] NOT NULL,
	[moduleId] [int] NOT NULL,
	[EnrollmentDate] [date] NOT NULL,
	[EnrollmentStatus] [varchar](10) NOT NULL,
	[OutcomeDate] [date] NULL,
	[OutCome] [varchar](50) NULL,
	[void] [bit] NOT NULL,
	[voidBy] [int] NULL,
	[voidDate] [datetime] NULL,
	[createBy] [int] NOT NULL,
	[createDate] [datetime] NOT NULL,
 CONSTRAINT [PK_patient_enrollment] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PatientIdentifier]    Script Date: 12/14/2016 4:18:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PatientIdentifier](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[PatientId] [int] NOT NULL,
	[PatientEnrollmentId] [int] NOT NULL,
	[IdentifierType] [int] NOT NULL,
	[IdentifierValue] [varchar](50) NOT NULL,
	[Void] [int] NULL,
	[VoidDate] [datetime] NULL,
	[VoidBy] [int] NULL,
	[CreateBy] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_person_identifier] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PatientLabTracker]    Script Date: 12/14/2016 4:18:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PatientLabTracker](
	[id] [int] NOT NULL,
	[patientId] [int] NOT NULL,
	[masterVisitId] [int] NOT NULL,
	[LabName] [varchar](50) NOT NULL,
	[SampleDate] [date] NOT NULL,
	[Reasons] [varchar](50) NOT NULL,
	[Results] [varchar](50) NOT NULL,
	[Void] [bit] NOT NULL,
	[VoidBy] [int] NULL,
	[VoidDate] [datetime] NULL,
	[CreateBy] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_PatientLabTracker] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PatientLocation]    Script Date: 12/14/2016 4:18:55 PM ******/
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
	[Village] [varchar](250) NOT NULL,
	[Estate] [varchar](250) NOT NULL,
	[LandMark] [varchar](250) NOT NULL,
	[NearestHealthCentre] [varchar](250) NOT NULL,
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
/****** Object:  Table [dbo].[PatientMaritalStatus]    Script Date: 12/14/2016 4:18:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PatientMaritalStatus](
	[id] [int] NOT NULL,
	[PatientId] [int] NOT NULL,
	[MaritalStatus] [int] NOT NULL,
	[Void] [int] NULL,
	[VoidBy] [int] NULL,
	[VoidDate] [date] NULL,
	[createBy] [int] NOT NULL,
	[createDate] [date] NOT NULL,
 CONSTRAINT [PK_patient_maritalstatus] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PatientMasterVisit]    Script Date: 12/14/2016 4:18:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PatientMasterVisit](
	[id] [int] NOT NULL,
	[patientId] [int] NOT NULL,
	[start] [time](7) NOT NULL,
	[end] [time](7) NULL,
	[status] [bit] NOT NULL,
	[Void] [int] NULL,
	[VoidBy] [int] NULL,
	[VoidDate] [datetime] NULL,
	[createBy] [int] NOT NULL,
	[createDate] [datetime] NOT NULL,
 CONSTRAINT [PK_PatientMasterVisit] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PatientOVCStatus]    Script Date: 12/14/2016 4:18:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PatientOVCStatus](
	[id] [int] NOT NULL,
	[PatientId] [int] NOT NULL,
	[GuardianNames] [varchar](250) NOT NULL,
	[GuardianIdentifictionNo] [int] NOT NULL,
	[Orphan] [varchar](5) NOT NULL,
	[InSchool] [varchar](5) NOT NULL,
	[Active] [int] NOT NULL,
	[Void] [bit] NOT NULL,
	[VoidBy] [int] NULL,
	[VoidDate] [datetime] NULL,
	[CreateBy] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_patient_ovcstatus] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PatientPHDP]    Script Date: 12/14/2016 4:18:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PatientPHDP](
	[id] [int] NOT NULL,
	[PatientId] [int] NOT NULL,
	[PatientMasterVisitId] [int] NOT NULL,
	[phdp] [int] NOT NULL,
	[Void] [bit] NULL,
	[VoidBy] [int] NULL,
	[VoidDate] [date] NULL,
	[CreateBy] [int] NOT NULL,
	[CreateDate] [date] NOT NULL,
 CONSTRAINT [PK_PatientPHDP] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PatientPhysicalExamination]    Script Date: 12/14/2016 4:18:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PatientPhysicalExamination](
	[id] [int] NOT NULL,
	[PatientId] [int] NOT NULL,
	[PhysicalExaminationId] [int] NOT NULL,
	[PatientMasterVisitId] [int] NOT NULL,
	[FemaleLMP] [date] NULL,
	[PregnancyStatus] [int] NULL,
	[ExpectedDateOfChild] [date] NULL,
	[ANCPNCProfile] [varchar](50) NULL,
	[OnFamilyPlanning] [int] NULL,
	[FPMethod] [int] NULL,
	[CaCxScreen] [int] NULL,
	[STIScreen] [int] NOT NULL,
	[STIPartnerNotification] [int] NOT NULL,
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
/****** Object:  Table [dbo].[PatientPopulation]    Script Date: 12/14/2016 4:18:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PatientPopulation](
	[id] [int] NOT NULL,
	[PatientId] [int] NOT NULL,
	[PopulationType] [int] NOT NULL,
	[Population] [int] NOT NULL,
	[Void] [bit] NOT NULL,
	[VoidBy] [int] NULL,
	[VoidDate] [datetime] NULL,
	[CreateBy] [int] NULL,
	[CreateDate] [date] NOT NULL,
 CONSTRAINT [PK_patient_population] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PatientScreening]    Script Date: 12/14/2016 4:18:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PatientScreening](
	[Id] [int] NOT NULL,
	[PatientId] [int] NOT NULL,
	[PatientMasterVisitId] [int] NOT NULL,
	[ScreeningDone] [int] NOT NULL,
	[ScreeningTypeId] [int] NULL,
	[ScreeningValueId] [int] NULL,
	[ScreeningValue] [varchar](50) NULL,
	[ScreeningDate] [date] NULL,
	[Void] [bit] NOT NULL,
	[VoidBy] [int] NULL,
	[VoidDate] [datetime] NULL,
	[CreateBy] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_PatientScreening] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PatientTransferIn]    Script Date: 12/14/2016 4:18:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PatientTransferIn](
	[id] [int] NOT NULL,
	[PatientId] [int] NOT NULL,
	[ModuleId] [int] NULL,
	[TransferinDate] [date] NOT NULL,
	[TreatmentStartDate] [date] NOT NULL,
	[CurrentTreatment] [varchar](50) NOT NULL,
	[FacilityFrom] [varchar](150) NOT NULL,
	[MFLCode] [int] NOT NULL,
	[CountyFrom] [varchar](150) NOT NULL,
	[TransferInNotes] [varchar](250) NOT NULL,
	[Active] [bit] NOT NULL,
	[Void] [bit] NOT NULL,
	[VoidBy] [int] NULL,
	[VoidDate] [date] NULL,
	[CreateBy] [int] NOT NULL,
	[CreateDate] [date] NOT NULL,
 CONSTRAINT [PK_transfer_in] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PatientTreatementDiagnosis]    Script Date: 12/14/2016 4:18:55 PM ******/
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
/****** Object:  Table [dbo].[PatientTreatmentSupporter]    Script Date: 12/14/2016 4:18:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PatientTreatmentSupporter](
	[Id] [int] NOT NULL,
	[PatientId] [int] NOT NULL,
	[SupporterName] [varchar](250) NOT NULL,
	[Phone] [int] NOT NULL,
	[Void] [bit] NOT NULL,
	[VoidBy] [int] NULL,
	[VoidDate] [datetime] NULL,
	[CreateBy] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_PatientTreatmentSupporter] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PatientVitals]    Script Date: 12/14/2016 4:18:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PatientVitals](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PatientId] [int] NOT NULL,
	[PatientMasterVisitId] [int] NOT NULL,
	[Temperature] [decimal](18, 1) NULL,
	[RR] [decimal](18, 0) NULL,
	[HR] [decimal](18, 0) NULL,
	[BPDiastolic] [decimal](18, 0) NULL,
	[BPSystolic] [decimal](18, 0) NULL,
	[Height] [decimal](18, 1) NULL,
	[Weight] [decimal](18, 1) NULL,
	[Pain] [int] NULL,
	[TLC] [int] NULL,
	[TLCPercent] [int] NULL,
	[Oedema] [int] NULL,
	[Muac] [decimal](4, 1) NULL,
	[SP02] [decimal](7, 2) NULL,
	[LMP] [date] NULL,
	[Void] [bit] NOT NULL,
	[VoidBy] [int] NULL,
	[VoidDate] [datetime] NULL,
	[CreateBy] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_PatientVitals] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PhysicalExamination]    Script Date: 12/14/2016 4:18:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PhysicalExamination](
	[Id] [int] NOT NULL,
	[PatientId] [int] NOT NULL,
	[MasterVisitId] [int] NULL,
	[ExaminationType] [int] NOT NULL,
	[Exam] [varchar](50) NOT NULL,
	[Findings] [varchar](250) NOT NULL,
	[ManagementPlan] [varchar](250) NOT NULL,
	[Void] [int] NULL,
	[VoidBy] [int] NULL,
	[VoidDate] [date] NULL,
	[CreateBy] [int] NOT NULL,
	[CreateDate] [date] NOT NULL,
 CONSTRAINT [PK_PhysicalExamination] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Pregnancy]    Script Date: 12/14/2016 4:18:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pregnancy](
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
 CONSTRAINT [PK_Pregnancy] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PregnancyLog]    Script Date: 12/14/2016 4:18:55 PM ******/
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
/****** Object:  Table [dbo].[Referrals]    Script Date: 12/14/2016 4:18:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Referrals](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[PatientId] [int] NOT NULL,
	[PatientMasterVisitId] [int] NOT NULL,
	[ReferredFrom] [int] NOT NULL,
	[ReferredTo] [int] NOT NULL,
	[ReferralReason] [varchar](150) NOT NULL,
	[ReferralDate] [datetime] NOT NULL,
	[ReferredBy] [varchar](50) NOT NULL,
	[Void] [bit] NOT NULL,
	[VoidBy] [int] NULL,
	[VoidDate] [datetime] NULL,
	[CreateBy] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Referrals] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ServiceEntryPoint]    Script Date: 12/14/2016 4:18:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServiceEntryPoint](
	[id] [int] NOT NULL,
	[PatientId] [int] NOT NULL,
	[ModuleId] [int] NOT NULL,
	[EntryPointId] [int] NOT NULL,
	[Void] [bit] NOT NULL,
	[VoidBy] [int] NULL,
	[VoidDate] [datetime] NULL,
	[CreateBy] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_ServiceEntryPoint] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TreatmentEventTracker]    Script Date: 12/14/2016 4:18:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TreatmentEventTracker](
	[id] [int] NOT NULL,
	[patientId] [int] NOT NULL,
	[MasterVisitId] [int] NOT NULL,
	[eventDate] [date] NOT NULL,
	[eventType] [int] NOT NULL,
	[category] [varchar](50) NOT NULL,
	[previous] [varchar](50) NOT NULL,
	[current] [varchar](50) NOT NULL,
	[reason] [varchar](150) NOT NULL,
	[Notes] [varchar](250) NOT NULL,
	[void] [int] NULL,
	[voidBy] [int] NULL,
	[voidDate] [date] NULL,
	[createBy] [int] NOT NULL,
	[createDate] [date] NOT NULL,
 CONSTRAINT [PK_TreatmentEventTracker] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[AdherenceOutcome] ADD  CONSTRAINT [DF_PatientAdheranceAssessment_Void]  DEFAULT ((0)) FOR [Void]
GO
ALTER TABLE [dbo].[AdultChildVaccination] ADD  CONSTRAINT [DF_AdultChildVaccination_Void]  DEFAULT ((0)) FOR [Void]
GO
ALTER TABLE [dbo].[ARTInitiationBaseline] ADD  CONSTRAINT [DF_PatientARTInitiationBaseline_void]  DEFAULT ((0)) FOR [Void]
GO
ALTER TABLE [dbo].[ARTUseHistory] ADD  CONSTRAINT [DF_ARTUseHistory_Void]  DEFAULT ((0)) FOR [Void]
GO
ALTER TABLE [dbo].[DiagnosisARVHistory] ADD  CONSTRAINT [DF_DiagnosisARVHistory_Void]  DEFAULT ((0)) FOR [Void]
GO
ALTER TABLE [dbo].[Disclosure] ADD  CONSTRAINT [DF_Disclosure_Void]  DEFAULT ((0)) FOR [Void]
GO
ALTER TABLE [dbo].[INHProphylaxis] ADD  CONSTRAINT [DF_INHProphylaxis_Void]  DEFAULT ((0)) FOR [Void]
GO
ALTER TABLE [dbo].[Patient] ADD  CONSTRAINT [DF_Patient_Status]  DEFAULT ((0)) FOR [Status]
GO
ALTER TABLE [dbo].[Patient] ADD  CONSTRAINT [DF_person_void]  DEFAULT ((0)) FOR [Void]
GO
ALTER TABLE [dbo].[PatientAllergies] ADD  CONSTRAINT [DF_PatientAllergies_void]  DEFAULT ((0)) FOR [Void]
GO
ALTER TABLE [dbo].[PatientAppointment] ADD  CONSTRAINT [DF_PatientAppointment_Status]  DEFAULT ((0)) FOR [Status]
GO
ALTER TABLE [dbo].[PatientAppointment] ADD  CONSTRAINT [DF_PatientAppointment_Void]  DEFAULT ((0)) FOR [Void]
GO
ALTER TABLE [dbo].[PatientCareending] ADD  CONSTRAINT [DF_PatientCareending_void]  DEFAULT ((0)) FOR [Void]
GO
ALTER TABLE [dbo].[PatientChronicIllness] ADD  CONSTRAINT [DF_ChronicIllness_void]  DEFAULT ((0)) FOR [void]
GO
ALTER TABLE [dbo].[PatientContact] ADD  CONSTRAINT [DF_PatientContact_IsActive]  DEFAULT ((0)) FOR [IsActive]
GO
ALTER TABLE [dbo].[PatientContact] ADD  CONSTRAINT [DF_patient_contact_void]  DEFAULT ((0)) FOR [Void]
GO
ALTER TABLE [dbo].[PatientEncounter] ADD  CONSTRAINT [DF_patient_encounter_void]  DEFAULT ((0)) FOR [Void]
GO
ALTER TABLE [dbo].[PatientEnrollment] ADD  CONSTRAINT [DF_patient_enrollment_void]  DEFAULT ((0)) FOR [void]
GO
ALTER TABLE [dbo].[PatientIdentifier] ADD  CONSTRAINT [DF_patient_identifier_void]  DEFAULT ((0)) FOR [Void]
GO
ALTER TABLE [dbo].[PatientLabTracker] ADD  CONSTRAINT [DF_PatientLabTracker_Void]  DEFAULT ((0)) FOR [Void]
GO
ALTER TABLE [dbo].[PatientLocation] ADD  CONSTRAINT [DF_PatientLocation_Village]  DEFAULT (NULL) FOR [Village]
GO
ALTER TABLE [dbo].[PatientLocation] ADD  CONSTRAINT [DF_PatientLocation_Estate]  DEFAULT (NULL) FOR [Estate]
GO
ALTER TABLE [dbo].[PatientLocation] ADD  CONSTRAINT [DF_PatientLocation_LandMark]  DEFAULT (NULL) FOR [LandMark]
GO
ALTER TABLE [dbo].[PatientLocation] ADD  CONSTRAINT [DF_PatientLocation_NearestHealthCentre]  DEFAULT (NULL) FOR [NearestHealthCentre]
GO
ALTER TABLE [dbo].[PatientLocation] ADD  CONSTRAINT [DF_person_location_is_active]  DEFAULT ((0)) FOR [is_active]
GO
ALTER TABLE [dbo].[PatientLocation] ADD  CONSTRAINT [DF_person_location_void]  DEFAULT ((0)) FOR [Void]
GO
ALTER TABLE [dbo].[PatientLocation] ADD  CONSTRAINT [DF_person_location_create_by]  DEFAULT ((0)) FOR [createBy]
GO
ALTER TABLE [dbo].[PatientMaritalStatus] ADD  CONSTRAINT [DF_patient_maritalstatus_void]  DEFAULT ((0)) FOR [Void]
GO
ALTER TABLE [dbo].[PatientMaritalStatus] ADD  CONSTRAINT [DF_patient_maritalstatus_create_date]  DEFAULT (getdate()) FOR [createDate]
GO
ALTER TABLE [dbo].[PatientMasterVisit] ADD  CONSTRAINT [DF_PatientMasterVisit_status]  DEFAULT ((0)) FOR [status]
GO
ALTER TABLE [dbo].[PatientMasterVisit] ADD  CONSTRAINT [DF_PatientMasterVisit_void]  DEFAULT ((0)) FOR [Void]
GO
ALTER TABLE [dbo].[PatientOVCStatus] ADD  CONSTRAINT [DF_patient_ovcstatus_void]  DEFAULT ((0)) FOR [Void]
GO
ALTER TABLE [dbo].[PatientPHDP] ADD  CONSTRAINT [DF_PatientPHDP_Void]  DEFAULT ((0)) FOR [Void]
GO
ALTER TABLE [dbo].[PatientPhysicalExamination] ADD  CONSTRAINT [DF_PatientPhysicalExamination_Void]  DEFAULT ((0)) FOR [Void]
GO
ALTER TABLE [dbo].[PatientPopulation] ADD  CONSTRAINT [DF_patient_population_void]  DEFAULT ((0)) FOR [Void]
GO
ALTER TABLE [dbo].[PatientPopulation] ADD  CONSTRAINT [DF_patient_population_create_date]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[PatientScreening] ADD  CONSTRAINT [DF_PatientScreening_Void]  DEFAULT ((0)) FOR [Void]
GO
ALTER TABLE [dbo].[PatientTransferIn] ADD  CONSTRAINT [DF_PatientTransferIn_Active]  DEFAULT ((0)) FOR [Active]
GO
ALTER TABLE [dbo].[PatientTransferIn] ADD  CONSTRAINT [DF_transfer_in_void]  DEFAULT ((0)) FOR [Void]
GO
ALTER TABLE [dbo].[PatientTreatementDiagnosis] ADD  CONSTRAINT [DF_PatientTreatementDiagnosis_Void]  DEFAULT ((0)) FOR [Void]
GO
ALTER TABLE [dbo].[PatientTreatementDiagnosis] ADD  CONSTRAINT [DF_PatientTreatementDiagnosis_VoidBy]  DEFAULT ((0)) FOR [VoidBy]
GO
ALTER TABLE [dbo].[PatientTreatmentSupporter] ADD  CONSTRAINT [DF_PatientTreatmentSupporter_Void]  DEFAULT ((0)) FOR [Void]
GO
ALTER TABLE [dbo].[PatientVitals] ADD  CONSTRAINT [DF_PatientVitals_Void]  DEFAULT ((0)) FOR [Void]
GO
ALTER TABLE [dbo].[PhysicalExamination] ADD  CONSTRAINT [DF_PhysicalExamination_Void]  DEFAULT ((0)) FOR [Void]
GO
ALTER TABLE [dbo].[Pregnancy] ADD  CONSTRAINT [DF_Pregnancy_Void]  DEFAULT ((0)) FOR [Void]
GO
ALTER TABLE [dbo].[Referrals] ADD  CONSTRAINT [DF_Referrals_Void]  DEFAULT ((0)) FOR [Void]
GO
ALTER TABLE [dbo].[ServiceEntryPoint] ADD  CONSTRAINT [DF_ServiceEntryPoint_void]  DEFAULT ((0)) FOR [Void]
GO
ALTER TABLE [dbo].[TreatmentEventTracker] ADD  CONSTRAINT [DF_TreatmentEventTracker_void]  DEFAULT ((0)) FOR [void]
GO
ALTER TABLE [dbo].[AdherenceOutcome]  WITH CHECK ADD  CONSTRAINT [FK_PatientAdheranceAssessment_PatientMasterVisit] FOREIGN KEY([PatientMasterVisitId])
REFERENCES [dbo].[PatientMasterVisit] ([id])
GO
ALTER TABLE [dbo].[AdherenceOutcome] CHECK CONSTRAINT [FK_PatientAdheranceAssessment_PatientMasterVisit]
GO
ALTER TABLE [dbo].[AdultChildVaccination]  WITH CHECK ADD  CONSTRAINT [FK_AdultChildVaccination_Patient] FOREIGN KEY([PatientId])
REFERENCES [dbo].[Patient] ([id])
GO
ALTER TABLE [dbo].[AdultChildVaccination] CHECK CONSTRAINT [FK_AdultChildVaccination_Patient]
GO
ALTER TABLE [dbo].[AdultChildVaccination]  WITH CHECK ADD  CONSTRAINT [FK_AdultChildVaccination_PatientMasterVisit] FOREIGN KEY([PatientMasterVisitId])
REFERENCES [dbo].[PatientMasterVisit] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AdultChildVaccination] CHECK CONSTRAINT [FK_AdultChildVaccination_PatientMasterVisit]
GO
ALTER TABLE [dbo].[AdverseEvent]  WITH CHECK ADD  CONSTRAINT [FK_AdverseEvent_PatientMasterVisit] FOREIGN KEY([PatientmasterVisitId])
REFERENCES [dbo].[PatientMasterVisit] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AdverseEvent] CHECK CONSTRAINT [FK_AdverseEvent_PatientMasterVisit]
GO
ALTER TABLE [dbo].[ARTInitiationBaseline]  WITH CHECK ADD  CONSTRAINT [FK_ARTInitiationBaseline_PatientMasterVisit] FOREIGN KEY([PatientMasterVisitID])
REFERENCES [dbo].[PatientMasterVisit] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ARTInitiationBaseline] CHECK CONSTRAINT [FK_ARTInitiationBaseline_PatientMasterVisit]
GO
ALTER TABLE [dbo].[ARTUseHistory]  WITH CHECK ADD  CONSTRAINT [FK_ARTUseHistory_Patient] FOREIGN KEY([PatientId])
REFERENCES [dbo].[Patient] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ARTUseHistory] CHECK CONSTRAINT [FK_ARTUseHistory_Patient]
GO
ALTER TABLE [dbo].[ComplaintsHistory]  WITH CHECK ADD  CONSTRAINT [FK_ComplaintsHistory_PatientMasterVisit] FOREIGN KEY([PatientMasterVisitId])
REFERENCES [dbo].[PatientMasterVisit] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ComplaintsHistory] CHECK CONSTRAINT [FK_ComplaintsHistory_PatientMasterVisit]
GO
ALTER TABLE [dbo].[DiagnosisARVHistory]  WITH CHECK ADD  CONSTRAINT [FK_DiagnosisARVHistory_Patient] FOREIGN KEY([PatientId])
REFERENCES [dbo].[Patient] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DiagnosisARVHistory] CHECK CONSTRAINT [FK_DiagnosisARVHistory_Patient]
GO
ALTER TABLE [dbo].[Disclosure]  WITH CHECK ADD  CONSTRAINT [FK_Disclosure_Patient] FOREIGN KEY([PatientId])
REFERENCES [dbo].[Patient] ([id])
GO
ALTER TABLE [dbo].[Disclosure] CHECK CONSTRAINT [FK_Disclosure_Patient]
GO
ALTER TABLE [dbo].[Disclosure]  WITH CHECK ADD  CONSTRAINT [FK_Disclosure_PatientMasterVisit] FOREIGN KEY([PatientMasterVisitId])
REFERENCES [dbo].[PatientMasterVisit] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Disclosure] CHECK CONSTRAINT [FK_Disclosure_PatientMasterVisit]
GO
ALTER TABLE [dbo].[INHProphylaxis]  WITH CHECK ADD  CONSTRAINT [FK_INHProphylaxis_Patient] FOREIGN KEY([PatientId])
REFERENCES [dbo].[Patient] ([id])
GO
ALTER TABLE [dbo].[INHProphylaxis] CHECK CONSTRAINT [FK_INHProphylaxis_Patient]
GO
ALTER TABLE [dbo].[INHProphylaxis]  WITH CHECK ADD  CONSTRAINT [FK_INHProphylaxis_PatientMasterVisit] FOREIGN KEY([PatientMasterVisitId])
REFERENCES [dbo].[PatientMasterVisit] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[INHProphylaxis] CHECK CONSTRAINT [FK_INHProphylaxis_PatientMasterVisit]
GO
ALTER TABLE [dbo].[PatientAllergies]  WITH CHECK ADD  CONSTRAINT [FK_PatientAllergies_PatientMasterVisit] FOREIGN KEY([PatientMasterVisitId])
REFERENCES [dbo].[PatientMasterVisit] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PatientAllergies] CHECK CONSTRAINT [FK_PatientAllergies_PatientMasterVisit]
GO
ALTER TABLE [dbo].[PatientAppointment]  WITH CHECK ADD  CONSTRAINT [FK_PatientAppointment_PatientMasterVisit] FOREIGN KEY([PatientMasterVisitId])
REFERENCES [dbo].[PatientMasterVisit] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PatientAppointment] CHECK CONSTRAINT [FK_PatientAppointment_PatientMasterVisit]
GO
ALTER TABLE [dbo].[PatientCareending]  WITH CHECK ADD  CONSTRAINT [FK_PatientCareending_patient] FOREIGN KEY([patientId])
REFERENCES [dbo].[Patient] ([id])
GO
ALTER TABLE [dbo].[PatientCareending] CHECK CONSTRAINT [FK_PatientCareending_patient]
GO
ALTER TABLE [dbo].[PatientCareending]  WITH CHECK ADD  CONSTRAINT [FK_PatientCareending_PatientMasterVisit] FOREIGN KEY([PatientMasterVisitId])
REFERENCES [dbo].[PatientMasterVisit] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PatientCareending] CHECK CONSTRAINT [FK_PatientCareending_PatientMasterVisit]
GO
ALTER TABLE [dbo].[PatientChronicIllness]  WITH CHECK ADD  CONSTRAINT [FK_PatientChronicIllness_PatientMasterVisit] FOREIGN KEY([PatientMasterVisitId])
REFERENCES [dbo].[PatientMasterVisit] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PatientChronicIllness] CHECK CONSTRAINT [FK_PatientChronicIllness_PatientMasterVisit]
GO
ALTER TABLE [dbo].[PatientContact]  WITH CHECK ADD  CONSTRAINT [FK_PatientContact_patient] FOREIGN KEY([patientId])
REFERENCES [dbo].[Patient] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PatientContact] CHECK CONSTRAINT [FK_PatientContact_patient]
GO
ALTER TABLE [dbo].[PatientDiagnosis]  WITH CHECK ADD  CONSTRAINT [FK_PatientDiagnosis_PatientMasterVisit] FOREIGN KEY([MasterVisitId])
REFERENCES [dbo].[PatientMasterVisit] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PatientDiagnosis] CHECK CONSTRAINT [FK_PatientDiagnosis_PatientMasterVisit]
GO
ALTER TABLE [dbo].[PatientEncounter]  WITH CHECK ADD  CONSTRAINT [FK_PatientEncounter_PatientMasterVisit] FOREIGN KEY([PatientMasterVisitId])
REFERENCES [dbo].[PatientMasterVisit] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PatientEncounter] CHECK CONSTRAINT [FK_PatientEncounter_PatientMasterVisit]
GO
ALTER TABLE [dbo].[PatientEnrollment]  WITH CHECK ADD  CONSTRAINT [FK_patient_enrollment_person] FOREIGN KEY([personId])
REFERENCES [dbo].[Patient] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PatientEnrollment] CHECK CONSTRAINT [FK_patient_enrollment_person]
GO
ALTER TABLE [dbo].[PatientIdentifier]  WITH CHECK ADD  CONSTRAINT [FK_PatientIdentifier_Patient] FOREIGN KEY([PatientId])
REFERENCES [dbo].[Patient] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PatientIdentifier] CHECK CONSTRAINT [FK_PatientIdentifier_Patient]
GO
ALTER TABLE [dbo].[PatientLabTracker]  WITH CHECK ADD  CONSTRAINT [FK_PatientLabTracker_PatientMasterVisit] FOREIGN KEY([masterVisitId])
REFERENCES [dbo].[PatientMasterVisit] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PatientLabTracker] CHECK CONSTRAINT [FK_PatientLabTracker_PatientMasterVisit]
GO
ALTER TABLE [dbo].[PatientLocation]  WITH CHECK ADD  CONSTRAINT [FK_PatientLocation_Patient] FOREIGN KEY([PatientId])
REFERENCES [dbo].[Patient] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PatientLocation] CHECK CONSTRAINT [FK_PatientLocation_Patient]
GO
ALTER TABLE [dbo].[PatientMaritalStatus]  WITH CHECK ADD  CONSTRAINT [FK_PatientMaritalStatus_Patient] FOREIGN KEY([PatientId])
REFERENCES [dbo].[Patient] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PatientMaritalStatus] CHECK CONSTRAINT [FK_PatientMaritalStatus_Patient]
GO
ALTER TABLE [dbo].[PatientMasterVisit]  WITH CHECK ADD  CONSTRAINT [FK_PatientMasterVisit_patient] FOREIGN KEY([patientId])
REFERENCES [dbo].[Patient] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PatientMasterVisit] CHECK CONSTRAINT [FK_PatientMasterVisit_patient]
GO
ALTER TABLE [dbo].[PatientOVCStatus]  WITH CHECK ADD  CONSTRAINT [FK_PatientOVCstatus_Patient] FOREIGN KEY([PatientId])
REFERENCES [dbo].[Patient] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PatientOVCStatus] CHECK CONSTRAINT [FK_PatientOVCstatus_Patient]
GO
ALTER TABLE [dbo].[PatientPHDP]  WITH CHECK ADD  CONSTRAINT [FK_PatientPHDP_PatientMasterVisit] FOREIGN KEY([PatientMasterVisitId])
REFERENCES [dbo].[PatientMasterVisit] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PatientPHDP] CHECK CONSTRAINT [FK_PatientPHDP_PatientMasterVisit]
GO
ALTER TABLE [dbo].[PatientPhysicalExamination]  WITH CHECK ADD  CONSTRAINT [FK_PatientPhysicalExamination_PatientMasterVisit] FOREIGN KEY([PatientMasterVisitId])
REFERENCES [dbo].[PatientMasterVisit] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PatientPhysicalExamination] CHECK CONSTRAINT [FK_PatientPhysicalExamination_PatientMasterVisit]
GO
ALTER TABLE [dbo].[PatientPopulation]  WITH CHECK ADD  CONSTRAINT [FK_PatientPopulation_Patient] FOREIGN KEY([PatientId])
REFERENCES [dbo].[Patient] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PatientPopulation] CHECK CONSTRAINT [FK_PatientPopulation_Patient]
GO
ALTER TABLE [dbo].[PatientScreening]  WITH CHECK ADD  CONSTRAINT [FK_PatientScreening_ComplaintsHistory] FOREIGN KEY([PatientMasterVisitId])
REFERENCES [dbo].[ComplaintsHistory] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PatientScreening] CHECK CONSTRAINT [FK_PatientScreening_ComplaintsHistory]
GO
ALTER TABLE [dbo].[PatientTransferIn]  WITH CHECK ADD  CONSTRAINT [FK_PatientTransferIn_Patient] FOREIGN KEY([PatientId])
REFERENCES [dbo].[Patient] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PatientTransferIn] CHECK CONSTRAINT [FK_PatientTransferIn_Patient]
GO
ALTER TABLE [dbo].[PatientTreatementDiagnosis]  WITH CHECK ADD  CONSTRAINT [FK_PatientTreatementDiagnosis_PatientMasterVisit] FOREIGN KEY([PatientId])
REFERENCES [dbo].[PatientMasterVisit] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PatientTreatementDiagnosis] CHECK CONSTRAINT [FK_PatientTreatementDiagnosis_PatientMasterVisit]
GO
ALTER TABLE [dbo].[PatientTreatmentSupporter]  WITH CHECK ADD  CONSTRAINT [FK_PatientTreatmentSupporter_PatientTreatmentSupporter] FOREIGN KEY([PatientId])
REFERENCES [dbo].[Patient] ([id])
GO
ALTER TABLE [dbo].[PatientTreatmentSupporter] CHECK CONSTRAINT [FK_PatientTreatmentSupporter_PatientTreatmentSupporter]
GO
ALTER TABLE [dbo].[PatientVitals]  WITH CHECK ADD  CONSTRAINT [FK_PatientVitals_PatientMasterVisit] FOREIGN KEY([PatientMasterVisitId])
REFERENCES [dbo].[PatientMasterVisit] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PatientVitals] CHECK CONSTRAINT [FK_PatientVitals_PatientMasterVisit]
GO
ALTER TABLE [dbo].[PhysicalExamination]  WITH CHECK ADD  CONSTRAINT [FK_PhysicalExamination_PatientMasterVisit] FOREIGN KEY([MasterVisitId])
REFERENCES [dbo].[PatientMasterVisit] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PhysicalExamination] CHECK CONSTRAINT [FK_PhysicalExamination_PatientMasterVisit]
GO
ALTER TABLE [dbo].[Pregnancy]  WITH CHECK ADD  CONSTRAINT [FK_Pregnancy_PatientMasterVisit] FOREIGN KEY([PatientMasterVisitId])
REFERENCES [dbo].[PatientMasterVisit] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Pregnancy] CHECK CONSTRAINT [FK_Pregnancy_PatientMasterVisit]
GO
ALTER TABLE [dbo].[Referrals]  WITH CHECK ADD  CONSTRAINT [FK_Referrals_PatientMasterVisit] FOREIGN KEY([PatientMasterVisitId])
REFERENCES [dbo].[PatientMasterVisit] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Referrals] CHECK CONSTRAINT [FK_Referrals_PatientMasterVisit]
GO
ALTER TABLE [dbo].[ServiceEntryPoint]  WITH CHECK ADD  CONSTRAINT [FK_ServiceEntryPoint_Patient] FOREIGN KEY([PatientId])
REFERENCES [dbo].[Patient] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ServiceEntryPoint] CHECK CONSTRAINT [FK_ServiceEntryPoint_Patient]
GO
ALTER TABLE [dbo].[TreatmentEventTracker]  WITH CHECK ADD  CONSTRAINT [FK_TreatmentEventTracker_PatientMasterVisit] FOREIGN KEY([MasterVisitId])
REFERENCES [dbo].[PatientMasterVisit] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TreatmentEventTracker] CHECK CONSTRAINT [FK_TreatmentEventTracker_PatientMasterVisit]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Defaults to zero(0) and one (1) when deleted' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AdherenceOutcome', @level2type=N'COLUMN',@level2name=N'Void'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Track patient adherance on both CTX/Dapsone or ARV ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AdherenceOutcome'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Track adverse events courses,medication causing the adverse events,severity and actiontaken.Recorded per visit' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AdverseEvent'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Baseline summary of Initiation parameters,collected once during enrollment' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ARTInitiationBaseline'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Records Prior ART use experience.Especially for TI patients' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ARTUseHistory'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DiagnosisARVHistory'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Master patient details.Captures generic patient information to be used across all service areas' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Patient'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tracks patient allergies per visit' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PatientAllergies'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tracks patient appointments and ststus of the appointments' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PatientAppointment'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tracks care ending for patients either deaths/TO' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PatientCareending'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tracks Chronic Illnesses cormodities and the current treatment of the illnesses per visit' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PatientChronicIllness'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tracks and manages patient contact information,can be updated to reflect the current contact details with history of the previous contacts' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PatientContact'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Clinician conclusions on the treatment plan,done per visit' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PatientDiagnosis'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tracks and manages all patient encounters per visit per service' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PatientEncounter'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tracks patient enrollment into the different service areas' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PatientEnrollment'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tracks and manages patient service identifier information' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'PatientIdentifier'
GO
USE [master]
GO
ALTER DATABASE [Greencard] SET  READ_WRITE 
GO
