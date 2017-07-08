
/****** Object:  StoredProcedure [dbo].[SP_Bluecard_ToGreenCard]    Script Date: 6/25/2017 1:19:29 PM ******/
DROP PROCEDURE [dbo].[SP_Bluecard_ToGreenCard]
GO
/****** Object:  StoredProcedure [dbo].[Pr_Clinical_GetPatientSearchresults]    Script Date: 6/25/2017 1:19:29 PM ******/
DROP PROCEDURE [dbo].[Pr_Clinical_GetPatientSearchresults]
GO
/****** Object:  StoredProcedure [dbo].[pr_Admin_InsertDrug_Constella]    Script Date: 6/25/2017 1:19:29 PM ******/
DROP PROCEDURE [dbo].[pr_Admin_InsertDrug_Constella]
GO
/****** Object:  UserDefinedFunction [dbo].[FN_DistinctList]    Script Date: 6/25/2017 1:19:29 PM ******/
DROP FUNCTION [dbo].[FN_DistinctList]
GO
/****** Object:  UserDefinedFunction [dbo].[FN_DistinctList]    Script Date: 6/25/2017 1:19:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[FN_DistinctList]
(
@List VARCHAR(MAX),
@Delim CHAR
)
RETURNS VARCHAR(MAX)
AS
BEGIN
	DECLARE @ParsedList TABLE
	(
		Item VARCHAR(MAX)
	)
	DECLARE @list1 VARCHAR(MAX), @Pos INT, @rList VARCHAR(MAX)
	SET @list = LTRIM(RTRIM(@list)) + @Delim
	SET @pos = CHARINDEX(@delim, @list, 1)
	WHILE @pos > 0
	BEGIN
		SET @list1 = LTRIM(RTRIM(LEFT(@list, @pos - 1)))
		IF @list1 <> ''
		INSERT INTO @ParsedList VALUES (CAST(@list1 AS VARCHAR(MAX)))
		SET @list = SUBSTRING(@list, @pos+1, LEN(@list))
		SET @pos = CHARINDEX(@delim, @list, 1)
	END
	SELECT @rlist = COALESCE(@rlist+'/','') + item
	FROM (SELECT DISTINCT Item FROM @ParsedList) t

	RETURN @rlist
END

GO
/****** Object:  StoredProcedure [dbo].[pr_Admin_InsertDrug_Constella]    Script Date: 6/25/2017 1:19:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[pr_Admin_InsertDrug_Constella]              
(              
 @DrugId int,          
 @DrugName varchar(150),              
 @DrugAbbreviation varchar(50),              
 @DrugTypeID int,              
 @UserID int,          
 @Status int,      
 @Update int             
             
)              
AS              
              
Begin             
    Declare  @ItemTypeID int;
    Select @ItemTypeID=ItemTypeID From Mst_ItemType Where ItemName='Pharmaceuticals'     ;
	     
	If (@Update > 0 ) Begin
		Update [mst_Drug] Set
			[DeleteFlag] = @Status,
			[UpdateDate] = getdate()
		Where [Drug_Pk] = @DrugId

		Select *
		From mst_Drug
		Where (Drug_pk = @DrugId)
	End 
	Else Begin
		If Exists(Select *	From mst_Drug Where DrugName = @DrugName) 
		Begin
			Update [mst_Drug] Set
				[DeleteFlag] = @Status,
				[UpdateDate] = getdate()
			Where [Drug_Pk] = @DrugId;
			Select 0
			Return
		End
 
		Declare @table Table(Id int); Declare @DrugPk int;
		Insert Into Mst_ItemMaster(
			ItemTypeID,
			ItemName, 
			CreatedBy,
			DeleteFlag,
			CreateDate,
			Abbreviation
		)
		Values(
			@ItemTypeID,
			nullif(@DrugName,''),
			@UserId,
			0,
			getdate(),
			@DrugAbbreviation
		)

		--Insert Into [mst_Drug] (
		--	[DrugName],
		--	[UserID],
		--	[DeleteFlag],
		--	CreateDate)
		--	--Output Inserted.Drug_Pk Into @table (Id)
		--	Values (
		--			nullIf(@DrugName, ''),
		--			@UserID,
		--			0,
		--			getdate() );
			Select @DrugPk= scope_identity();
			Select D.* From mst_Drug D Where (Drug_pk = @DrugPk) --	(Select	ID	From @table));
		
	End

End

GO
/****** Object:  StoredProcedure [dbo].[Pr_Clinical_GetPatientSearchresults]    Script Date: 6/25/2017 1:19:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Joseph Njung'e>
-- Create date: <08-08-2014,>
-- Description:	<Modified Find Patient>
-- =============================================
CREATE PROCEDURE [dbo].[Pr_Clinical_GetPatientSearchresults]
	-- Add the parameters for the stored procedure here
	@Sex int = Null, 
	@Firstname varchar(50) = Null, 
	@LastName varchar(50) = Null, 
	@MiddleName varchar(50) = Null, 
	@DOB datetime = Null, 
	@RegistrationDate datetime = Null,
	@EnrollmentType int = null,
	@EnrollmentId varchar(50) = Null, 
	@FacilityId int = Null,  
	@Status int = Null,
	@Password varchar(50) = Null,    
	@ModuleId int = 999,
	@FilterByModuleId bit= 0,
	@PhoneNumber varchar(50) = Null,
	@top int = 100,
	@RuleFilter varchar(400)=''
	With Recompile
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Declare @Query nvarchar(max), 
			@ParamDefinition nvarchar(2000),
			@Identifiers varchar(4000),
			@ByModule varchar(1000), @ByStatus varchar(120);
			
	Declare @SymKey nvarchar(400)	;	 
	Select	@Identifiers = '',@ByModule='',@ByStatus=' Status =  Null ,';
			
	 --                                                                                    
	 --Set @SymKey = 'Open symmetric key Key_CTC decryption by password='+ @password + ''                                                                                        
	 --Exec(@SymKey) 
	 
	
Select @Firstname = Nullif(Ltrim(Rtrim(@Firstname)), '');
If  (@Firstname Is Not Null) Select @Firstname = '%' + @Firstname + '%';

Select @MiddleName = Nullif(Ltrim(Rtrim(@MiddleName)), '');
If  (@MiddleName Is Not Null) Select @MiddleName = '%' + @MiddleName + '%';

Select @LastName = Nullif(Ltrim(Rtrim(@LastName)), '')
If  (@LastName Is Not Null) Select @LastName ='%' + @LastName + '%';

Select @EnrollmentId = Convert(varchar,Nullif(Ltrim(Rtrim(@EnrollmentID)), ''));

Select @PhoneNumber =Nullif(ltrim(rtrim(@PhoneNumber)),'');

If (@EnrollmentId Is Not Null) 
Begin
	declare @SS varchar(1000)
	Select @ss = Substring((Select ',P.[' + Convert(varchar(Max), FieldName) + ']'
			From dbo.mst_patientidentifier
			Order By Id
			For xml Path (''))
		, 2, 1000);
	Select @Identifiers = ' AND(' + Replace(@SS, ',', ' like ''%' + Convert(varchar,@enrollmentid) + ''' or ') + ' = ''' 
	+ Convert(varchar,@enrollmentid) + ''' or P.IQNumber=''' + Convert(varchar,@enrollmentid) 
	+ ''' or P.PatientFacilityID = ''' + Convert(varchar,@enrollmentid) + ''')';


End
If(@ModuleID <> 999)
Begin
	Select @ByModule= ' Left Outer Join (Select	P.Ptn_pk,P.ModuleId,P.StartDate EnrollmentDate,	Case CT.CareEnded When 1 Then ''Care Ended'' When 0 Then ''Active (Restarted)''  Else ''Active'' End CareStatus,		
		Case CT.CareEnded When 1 Then CT.PatientExitReasonName Else Null End  CareEndReason,	Isnull(CT.EnrollmentIndex,1)EnrollmentIndex From dbo.Lnk_PatientProgramStart As P
Left Outer Join (Select	CE.Ptn_Pk,	CE.CareEnded,	CE.PatientExitReason,	D.Name As PatientExitReasonName,CE.CareEndedDate,TC.TrackingID,
TC.ModuleId	,Row_number() Over(Partition By TC.Ptn_Pk Order By TC.TrackingId Desc) EnrollmentIndex From dbo.dtl_PatientCareEnded As CE Inner Join	dbo.dtl_PatientTrackingCare As TC On TC.TrackingID = CE.TrackingId
Inner Join	dbo.mst_Decode As D On D.ID = CE.PatientExitReason Where TC.ModuleId = @ModuleID ) As CT On CT.Ptn_Pk = P.Ptn_pk And CT.ModuleId = P.ModuleId Where P.ModuleID=@ModuleID ) CT On CT.Ptn_Pk=P.Ptn_Pk And CT.ModuleID=@ModuleID And EnrollmentIndex=1'

Select @ByStatus = ' [Status] = Case When CT.ModuleID Is Null Then ''Not Enrolled'' Else IsNull(CT.CareEndReason,CT.CareStatus) End , '
End


Set @Query=N'Select Top (@top) * From (Select  P.Ptn_Pk PatientId,Convert(varchar(50), Decryptbykey(FirstName)) As FirstName, Convert(varchar(50), Decryptbykey(MiddleName)) As Middlename,
		Convert(varchar(50), Decryptbykey(LastName)) As LastName,IQNumber, PatientEnrollmentId PatientFacilityId, LocationId,	F.FacilityName,
		Case DOBPrecision	When 0 Then ''No'' When 1 Then ''Yes'' End As [Precision],Dob ,	Convert(varchar(100), Decryptbykey([Address])) [Address],	Convert(varchar(100), Decryptbykey(Phone)) [Phone],
		convert(decimal(5,2),round(cast(datediff(dd,P.DOB,isnull(P.DateofDeath,getdate()))/365.25 as decimal(5,2)),2)) Age,	P.RegistrationDate,'+@ByStatus +' Sex = Case P.Sex When 16 Then ''Male'' Else ''Female'' End
From dbo.mst_Patient As P Inner Join dbo.mst_Facility F	On F.FacilityID = P.LocationID'+ @ByModule +' Where  (P.DeleteFlag = 0 OR P.DeleteFlag Is Null)
And Case When @FirstName Is  Null Or Convert(varchar(50), decryptbykey(P.FirstName)) Like  @Firstname Then 1 Else 0 End = 1
And Case When @LastName Is  Null Or Convert(varchar(50), decryptbykey(P.LastName)) Like  @LastName Then 1	Else 0 End = 1
And Case When @MiddleName Is  Null Or Convert(varchar(50), decryptbykey(P.MiddleName)) Like  @MiddleName Then 1	Else 0 End = 1
And (@DOB Is Null Or P.DOB = @DOB) And (@RegistrationDate Is Null Or P.RegistrationDate= @RegistrationDate) And (@Sex Is Null Or P.Sex = @Sex) And (@Status Is Null Or P.[Status] = @status)
And Case When @PhoneNumber Is  Null Or Convert(varchar(50), decryptbykey(P.Phone)) =  @PhoneNumber Then 1	Else 0 End = 1
And (@FacilityID Is Null Or P.LocationID=@FacilityID)' +@Identifiers + ') P '+ @RuleFilter  ;

Set @Query = @Query + ' Order By [Status],P.RegistrationDate';
	  
Set @ParamDefinition= N'@Sex int = Null, 
	@Firstname varchar(50) = Null, 
	@LastName varchar(50) = Null, 
	@MiddleName varchar(50) = Null, 
	@DOB datetime = Null, 
	@RegistrationDate datetime = Null,
	@EnrollmentID varchar(50) = Null,  
	@FacilityID int = Null,  
	@Status int = Null,
	@Password varchar(50) = Null,    
	@ModuleID int = 999,
	@PhoneNumber varchar(50) = Null,
	@top int=100 ';
							 
--Set @SymKey = 'Open symmetric key Key_CTC decryption by password=' + @password ;
--Exec sp_executesql @SymKey ;
Execute sp_Executesql @Query, @ParamDefinition, @Sex, @Firstname,@LastName,@MiddleName,@DOB,@RegistrationDate,@EnrollmentID,@FacilityID,@status,@password,@moduleId,@PhoneNumber,@top;
	 
End	   
  
	  

GO
/****** Object:  StoredProcedure [dbo].[SP_Bluecard_ToGreenCard]    Script Date: 6/25/2017 1:19:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<felix/stephen>
-- Create date: <03-22-2017>
-- Description:	<Patient registration migration from bluecard to greencard>
-- =============================================
CREATE PROCEDURE [dbo].[SP_Bluecard_ToGreenCard]
	-- Add the parameters for the stored procedure here
	@ptn_pk int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

DECLARE @FirstName varbinary(max), @MiddleName varbinary(max), @LastName varbinary(max), @Sex int, @Status bit , @DeleteFlag bit, 
		@CreateDate datetime, @UserID int,  @message varchar(80), @Id int, @PatientFacilityId varchar(50), @PatientType int, 
		@FacilityId varchar(10), @DateOfBirth datetime, @DobPrecision int, @NationalId varchar(100), @PatientId int,  
		@ARTStartDate date,@transferIn int,@CCCNumber varchar(20), @entryPoint int, @ReferredFrom int, @RegistrationDate datetime,
		@MaritalStatusId int, @MaritalStatus int, @DistrictName varchar(50), @CountyID int, @SubCountyID int, @WardID int,
		@Address varbinary(max), @Phone varbinary(max), @EnrollmentId int, @PatientIdentifierId int, @ServiceEntryPointId int,
		@PatientMaritalStatusID int, @PatientTreatmentSupporterID int, @PersonContactID int, @IDNational varbinary(max);

DECLARE @FirstNameT varchar(50), @LastNameT varchar(50), @TreatmentSupportTelNumber varbinary(max), 
			@CreateDateT datetime, @UserIDT int, @IDT int;
			
DECLARE @TreatmentSupportTelNumber_VARCHAR varchar(100);
  
PRINT '-------- Patients Report --------'; 
SELECT @message = '----- ptn_pk ' + CAST(@ptn_pk as varchar(50));
PRINT @message;
  
DECLARE mstPatient_cursor CURSOR FOR   
SELECT FirstName, MiddleName ,LastName,Sex, [Status], DeleteFlag, dbo.mst_Patient.CreateDate, dbo.mst_Patient.UserID, PatientFacilityId, PosId, DOB, DobPrecision, [ID/PassportNo],PatientEnrollmentID, [ReferredFrom], [RegistrationDate], MaritalStatus, DistrictName, Address, Phone
FROM mst_Patient
INNER JOIN
 dbo.Lnk_PatientProgramStart ON dbo.mst_Patient.Ptn_Pk = dbo.Lnk_PatientProgramStart.Ptn_pk
WHERE        (dbo.Lnk_PatientProgramStart.ModuleId = 203) AND dbo.mst_Patient.Ptn_Pk = @ptn_pk
  
OPEN mstPatient_cursor  
  
FETCH NEXT FROM mstPatient_cursor   
INTO @FirstName, @MiddleName, @LastName, @Sex, @Status, @DeleteFlag, @CreateDate, @UserID, @PatientFacilityId, @FacilityId, @DateOfBirth, @DobPrecision, @NationalId,@CCCNumber, @ReferredFrom, @RegistrationDate, @MaritalStatus , @DistrictName, @Address, @Phone
  
WHILE @@FETCH_STATUS = 0  
BEGIN  
    PRINT ' '  
    SELECT @message = '----- patients From mst_patient: ' + CAST(@ptn_pk as varchar(50))
  
    PRINT @message  

	exec pr_OpenDecryptedSession;

	--set null dates
	IF @CreateDate IS NULL
		BEGIN
			SELECT @CreateDate = getdate();
		END
	--Due to the logic of green card
	IF @Status = 1
		BEGIN
			SELECT @Status = 0
		END
	ELSE
		BEGIN
			SELECT @Status = 1
		END

	IF @NationalId IS NULL
		SET @IDNational = 99999999;

	IF @Sex IS NOT NULL
		SET @Sex = (SELECT TOP 1 ItemId FROM LookupItemView WHERE MasterName like '%gender%' and ItemName like (select Name from mst_Decode where id = @Sex) + '%');
	ELSE
		SET @Sex = (select TOP 1 ItemId from LookupItemView where MasterName = 'Unknown' and ItemName = 'Unknown');

	--Default all persons to new
	SET @ARTStartDate=( SELECT TOP 1 ARTTransferInDate FROM dtl_PatientHivPrevCareIE WHERE Ptn_pk=@ptn_pk);
	if(@ARTStartDate Is NULL) BEGIN SET @PatientType=(SELECT TOP 1 Id FROM LookupItem WHERE Name='New');SET @transferIn=0; END ELSE BEGIN SET @PatientType=(SELECT TOP 1 Id FROM LookupItem WHERE Name='TransferIn');SET @transferIn=1; END
	-- SELECT @PatientType = 1285

	--encrypt nationalid
	SET @IDNational=ENCRYPTBYKEY(KEY_GUID('Key_CTC'),@IDNational);

	IF NOT EXISTS ( SELECT TOP 1 ptn_pk FROM Patient WHERE ptn_pk = @ptn_pk)
		BEGIN
			Insert into Person(FirstName, MidName, LastName, Sex, Active, DeleteFlag, CreateDate, CreatedBy)
			Values(@FirstName, @MiddleName, @LastName, @Sex, @Status, @DeleteFlag, @CreateDate, @UserID);

			SELECT @Id=@@IDENTITY;
			SELECT @message = 'Created Person Id: ' + CAST(@Id as varchar(50));
			PRINT @message;

			Insert into Patient(ptn_pk, PersonId, PatientIndex, PatientType, FacilityId, Active, DateOfBirth, DobPrecision, NationalId, DeleteFlag, CreatedBy, CreateDate, RegistrationDate)
			Values(@ptn_pk, @Id, @PatientFacilityId, ISNULL(@PatientType,0), @FacilityId, @Status, @DateOfBirth, @DobPrecision, @IDNational, @DeleteFlag, @UserID, @CreateDate, @RegistrationDate);

			SELECT @PatientId=@@IDENTITY;
			SELECT @message = 'Created Patient Id: ' + CAST(@PatientId as varchar);
			PRINT @message;

			-- Insert to PatientEnrollment
			INSERT INTO [dbo].[PatientEnrollment] ([PatientId] ,[ServiceAreaId] ,[EnrollmentDate] ,[EnrollmentStatusId] ,[TransferIn] ,[CareEnded] ,[DeleteFlag] ,[CreatedBy] ,[CreateDate] ,[AuditData])
			VALUES (@PatientId,1,(SELECT top 1 StartDate FROM Lnk_PatientProgramStart WHERE Ptn_pk=@ptn_pk),0, @transferIn,0 ,0 ,@UserID ,@CreateDate ,NULL)
		
			SELECT @EnrollmentId=@@IDENTITY;
			SELECT @message = 'Created PatientEnrollment Id: ' + CAST(@EnrollmentId as varchar);
			PRINT @message;

			IF @CCCNumber IS NOT NULL
				BEGIN
					-- Patient Identifier
					INSERT INTO [dbo].[PatientIdentifier] ([PatientId], [PatientEnrollmentId], [IdentifierTypeId], [IdentifierValue] ,[DeleteFlag] ,[CreatedBy] ,[CreateDate] ,[Active] ,[AuditData])
					VALUES (@PatientId , @EnrollmentId ,(select top 1 Id from Identifiers where Code='CCCNumber') ,@CCCNumber ,0 ,@UserID ,@CreateDate ,0 ,NULL);

					SELECT @PatientIdentifierId=@@IDENTITY;
					SELECT @message = 'Created PatientIdentifier Id: ' + CAST(@PatientIdentifierId as varchar);
					PRINT @message;
				END

			--Insert into ServiceEntryPoint
			IF @ReferredFrom > 0
				SET @entryPoint = (select TOP 1 ItemId from [dbo].[LookupItemView] where ItemName like '%' + (SELECT Name FROM mst_Decode WHERE ID=@ReferredFrom AND CodeID=17) + '%');
				IF @entryPoint IS NULL
					BEGIN
						SET @entryPoint = (select TOP 1 ItemId from LookupItemView where MasterName = 'Unknown' and ItemName = 'Unknown');
					END
			ELSE
				SET @entryPoint = (select TOP 1 ItemId from LookupItemView where MasterName = 'Unknown' and ItemName = 'Unknown');

			INSERT INTO ServiceEntryPoint([PatientId], [ServiceAreaId], [EntryPointId], [DeleteFlag], [CreatedBy], [CreateDate], [Active])
			VALUES(@PatientId, 1, @entryPoint, 0 , @UserID, @CreateDate, 0);

			SELECT @ServiceEntryPointId=@@IDENTITY;
			SELECT @message = 'Created ServiceEntryPoint Id: ' + CAST(@ServiceEntryPointId as varchar);
			PRINT @message;
	
			--Insert into MaritalStatus
			IF @MaritalStatus > 0
				BEGIN
					IF EXISTS (select TOP 1 ItemId from [dbo].[LookupItemView] where ItemName like '%' + (select Name from mst_Decode where ID = @MaritalStatus and CodeID = 12) + '%')
						SET @MaritalStatusId = (select TOP 1 ItemId from [dbo].[LookupItemView] where ItemName like '%' + (select Name from mst_Decode where ID = @MaritalStatus and CodeID = 12) + '%');
					ELSE
						SET @MaritalStatusId = (select TOP 1 ItemId from LookupItemView where MasterName = 'Unknown' and ItemName = 'Unknown');
				END
			ELSE
				SET @MaritalStatusId = (select TOP 1 ItemId from LookupItemView where MasterName = 'Unknown' and ItemName = 'Unknown');

			INSERT INTO PatientMaritalStatus(PersonId, MaritalStatusId, Active, DeleteFlag, CreatedBy, CreateDate)
			VALUES(@Id, @MaritalStatusId, 1, 0, @UserID, @CreateDate);

			SELECT @PatientMaritalStatusID=@@IDENTITY;
			SELECT @message = 'Created PatientMaritalStatus Id: ' + CAST(@PatientMaritalStatusID as varchar);
			PRINT @message;

			--Insert into PersonLocation
			--SET @CountyID = (SELECT TOP 1 CountyId from County where CountyName like '%' + @DistrictName  + '%');
			--SET @WardID = (SELECT TOP 1 WardId FROM County WHERE WardName LIKE '%' +  +'%')

			--INSERT INTO PersonLocation(PersonId, County, SubCounty, Ward, Village, Location, SubLocation, LandMark, NearestHealthCentre, Active, DeleteFlag, CreatedBy, CreateDate)
			--VALUES(@Id, @CountyID, @SubCountyID, @WardID, @Village, @Location, @SubLocation, @LandMark, @NearestHealthCentre, 1, @DeleteFlag, @UserID, @CreateDate);
    
			--Insert into Treatment Supporter
			DECLARE Treatment_Supporter_cursor CURSOR FOR
			SELECT SUBSTRING(TreatmentSupporterName,0,charindex(' ',TreatmentSupporterName))as firstname ,
			SUBSTRING(TreatmentSupporterName,charindex(' ',TreatmentSupporterName) + 1,len(TreatmentSupporterName)+1)as lastname,
			TreatmentSupportTelNumber, CreateDate, UserID
			from dtl_PatientContacts WHERE ptn_pk = @ptn_pk;

			OPEN Treatment_Supporter_cursor
			FETCH NEXT FROM Treatment_Supporter_cursor INTO @FirstNameT, @LastNameT, @TreatmentSupportTelNumber_VARCHAR, @CreateDateT , @UserIDT

			IF @@FETCH_STATUS <> 0   
				PRINT '         <<None>>'       

			WHILE @@FETCH_STATUS = 0  
			BEGIN  

				--SELECT @message = '         ' + @product  
				--PRINT @message
				--SET @TreatmentSupportTelNumber = ENCRYPTBYKEY(KEY_GUID('Key_CTC'),@TreatmentSupportTelNumber_VARCHAR);
				IF @FirstNameT IS NOT NULL AND @LastNameT IS NOT NULL 
					BEGIN
						Insert into Person(FirstName, MidName, LastName, Sex, Active, DeleteFlag, CreateDate, CreatedBy)
						Values(ENCRYPTBYKEY(KEY_GUID('Key_CTC'),@FirstNameT), NULL, ENCRYPTBYKEY(KEY_GUID('Key_CTC'),@LastNameT), (select ItemId from LookupItemView where MasterName = 'Unknown' and ItemName = 'Unknown'), 1, 0, @CreateDateT, @UserIDT);

						SELECT @IDT=@@IDENTITY;
						SELECT @message = 'Created Person Treatment Supporter Id: ' + CAST(@IDT as varchar(50));
						PRINT @message;

						IF @TreatmentSupportTelNumber_VARCHAR IS NOT NULL
						 SET @TreatmentSupportTelNumber = ENCRYPTBYKEY(KEY_GUID('Key_CTC'),@TreatmentSupportTelNumber_VARCHAR)

						INSERT INTO PatientTreatmentSupporter(PersonId, [SupporterId], [MobileContact], [DeleteFlag], [CreatedBy], [CreateDate])
						VALUES(@Id, @IDT, @TreatmentSupportTelNumber, 0, @UserIDT, @CreateDateT);

						SELECT @PatientTreatmentSupporterID=@@IDENTITY;
						SELECT @message = 'Created PatientTreatmentSupporterID Id: ' + CAST(@PatientTreatmentSupporterID as varchar);
						PRINT @message;
					END

				FETCH NEXT FROM Treatment_Supporter_cursor INTO  @FirstNameT, @LastNameT, @TreatmentSupportTelNumber_VARCHAR, @CreateDateT, @UserIDT
				END  

			CLOSE Treatment_Supporter_cursor  
			DEALLOCATE Treatment_Supporter_cursor

			--Insert into Person Contact
			IF @Address IS NOT NULL AND @Phone IS NOT NULL
				BEGIN
					INSERT INTO PersonContact(PersonId, [PhysicalAddress], [MobileNumber], [AlternativeNumber], [EmailAddress], [Active], [DeleteFlag], [CreatedBy], [CreateDate])
					VALUES(@Id, @Address, @Phone, null, null, @Status, 0, @UserID, @CreateDate);

					SELECT @PersonContactID=@@IDENTITY;
					SELECT @message = 'Created PersonContact Id: ' + CAST(@PersonContactID as varchar);
					PRINT @message;
				END
		END
	ELSE
		BEGIN
			SET @Id = (SELECT TOP 1 PersonId FROM Patient WHERE ptn_pk = @ptn_pk);
			UPDATE Person
			SET FirstName = @FirstName, MidName = @MiddleName, LastName = @LastName, Sex = @Sex, Active = @Status, DeleteFlag = @DeleteFlag, CreateDate = @CreateDate, CreatedBy = @UserID
			WHERE Id = @Id;

			SELECT @message = 'Update Person Id: ' + CAST(@Id as varchar(50));
			PRINT @message;

			PRINT @Status;

			UPDATE Patient
			SET PatientIndex = @PatientFacilityId, PatientType = ISNULL(@PatientType,0), FacilityId = @FacilityId, Active = @Status, DateOfBirth = @DateOfBirth, DobPrecision = @DobPrecision, NationalId = @IDNational, DeleteFlag = @DeleteFlag, CreatedBy = @UserID, CreateDate = @CreateDate, RegistrationDate = @RegistrationDate
			WHERE PersonId = @Id;

			SELECT @PatientId=(SELECT TOP 1 Id FROM Patient WHERE PersonId = @Id);
			SELECT @message = 'Updated Patient';
			PRINT @message;

			-- UPDATE to PatientEnrollment
			UPDATE PatientEnrollment
			SET EnrollmentDate = (SELECT top 1 StartDate FROM Lnk_PatientProgramStart WHERE Ptn_pk=@ptn_pk), EnrollmentStatusId = 0, TransferIn = @transferIn, CareEnded = 0, DeleteFlag = 0, CreatedBy = @UserID, CreateDate = @CreateDate
			WHERE PatientId = @PatientId;

			SELECT @EnrollmentId = (SELECT TOP 1 Id FROM PatientEnrollment WHERE PatientId = @PatientId);
			SELECT @message = 'Updated PatientEnrollment Id: ' + CAST(@EnrollmentId as varchar);
			PRINT @message;

			BEGIN
			IF @CCCNumber IS NOT NULL
				BEGIN
				IF NOT EXISTS ( SELECT PatientId FROM PatientIdentifier WHERE PatientId = @PatientId AND PatientEnrollmentId = @EnrollmentId AND IdentifierTypeId = (SELECT Id FROM LookupItem WHERE Name='CCCNumber'))
					BEGIN
						-- Patient Identifier
						INSERT INTO [dbo].[PatientIdentifier] ([PatientId], [PatientEnrollmentId], [IdentifierTypeId], [IdentifierValue] ,[DeleteFlag] ,[CreatedBy] ,[CreateDate] ,[Active] ,[AuditData])
						VALUES (@PatientId , @EnrollmentId ,(select top 1 Id from Identifiers where Code='CCCNumber') ,@CCCNumber ,0 ,@UserID ,@CreateDate ,0 ,NULL);

						SELECT @PatientIdentifierId=@@IDENTITY;
						SELECT @message = 'Created PatientIdentifier Id: ' + CAST(@PatientIdentifierId as varchar);
						PRINT @message;
					END
				ELSE
					BEGIN
						UPDATE PatientIdentifier
						SET IdentifierTypeId = (select top 1 Id from Identifiers where Code='CCCNumber'), IdentifierValue = @CCCNumber, DeleteFlag = 0, CreatedBy = @UserID, CreateDate = @CreateDate, Active = 0
						WHERE PatientId = @PatientId AND PatientEnrollmentId = @EnrollmentId AND IdentifierTypeId = (SELECT Id FROM LookupItem WHERE Name='CCCNumber')
					END
				END
			END

			--Insert into ServiceEntryPoint
			IF @ReferredFrom > 0
				BEGIN
					SET @entryPoint = (select TOP 1 ItemId from [dbo].[LookupItemView] where ItemName like '%' + (SELECT Name FROM mst_Decode WHERE ID=@ReferredFrom AND CodeID=17) + '%');
					
					IF @entryPoint IS NULL
						BEGIN
							SET @entryPoint = (select top 1 ItemId from LookupItemView where MasterName = 'Unknown' and ItemName = 'Unknown');
						END
						
					UPDATE ServiceEntryPoint
					SET EntryPointId = @entryPoint, CreatedBy = @UserID, CreateDate = @CreateDate
					WHERE PatientId = @PatientId;
					
					SELECT @ServiceEntryPointId=@@IDENTITY;
					SELECT @message = 'Updated ServiceEntryPoint Id: ' + CAST(@ServiceEntryPointId as varchar);
					PRINT @message;
				END
	
			--Updated into MaritalStatus
			IF @MaritalStatus > 0
				BEGIN
					BEGIN
						IF EXISTS (select TOP 1 ItemId from [dbo].[LookupItemView] where ItemName like '%' + (select Name from mst_Decode where ID = @MaritalStatus and CodeID = 12) + '%')
							SET @MaritalStatusId = (select TOP 1 ItemId from [dbo].[LookupItemView] where ItemName like '%' + (select Name from mst_Decode where ID = @MaritalStatus and CodeID = 12) + '%');
						ELSE
							SET @MaritalStatusId = (select TOP 1 ItemId from LookupItemView where MasterName = 'Unknown' and ItemName = 'Unknown');
					END
					UPDATE PatientMaritalStatus
					SET MaritalStatusId = @MaritalStatusId, CreatedBy = @UserID, CreateDate = @CreateDate
					WHERE PersonId = @Id;

					SELECT @PatientMaritalStatusID=@@IDENTITY;
					SELECT @message = 'Updated PatientMaritalStatus Id: ' + CAST(@PatientMaritalStatusID as varchar);
					PRINT @message;
				END

			--Update into Treatment Supporter
			DECLARE Treatment_Supporter_cursor CURSOR FOR
			SELECT SUBSTRING(TreatmentSupporterName,0,charindex(' ',TreatmentSupporterName))as firstname ,
			SUBSTRING(TreatmentSupporterName,charindex(' ',TreatmentSupporterName) + 1,len(TreatmentSupporterName)+1)as lastname,
			TreatmentSupportTelNumber, CreateDate, UserID
			from dtl_PatientContacts WHERE ptn_pk = @ptn_pk;


			OPEN Treatment_Supporter_cursor
			FETCH NEXT FROM Treatment_Supporter_cursor INTO @FirstNameT, @LastNameT, @TreatmentSupportTelNumber_VARCHAR, @CreateDateT , @UserIDT

			IF @@FETCH_STATUS <> 0   
				PRINT '         <<None>>'       

			WHILE @@FETCH_STATUS = 0  
			BEGIN

				--SET @TreatmentSupportTelNumber = ENCRYPTBYKEY(KEY_GUID('Key_CTC'),@TreatmentSupportTelNumber);
				IF @FirstNameT IS NOT NULL AND @LastNameT IS NOT NULL
					BEGIN
						IF NOT EXISTS (SELECT PersonId FROM PatientTreatmentSupporter WHERE PersonId = @Id)
							BEGIN
								Insert into Person(FirstName, MidName, LastName, Sex, Active, DeleteFlag, CreateDate, CreatedBy)
								Values(ENCRYPTBYKEY(KEY_GUID('Key_CTC'),@FirstNameT), NULL, ENCRYPTBYKEY(KEY_GUID('Key_CTC'),@LastNameT), (select ItemId from LookupItemView where MasterName = 'Unknown' and ItemName = 'Unknown'), 1, 0, @CreateDateT, @UserIDT);

								SELECT @IDT=@@IDENTITY;
								SELECT @message = 'Created Person Treatment Supporter Id: ' + CAST(@IDT as varchar(50));
								PRINT @message;

								IF @TreatmentSupportTelNumber_VARCHAR IS NOT NULL
								SET @TreatmentSupportTelNumber = ENCRYPTBYKEY(KEY_GUID('Key_CTC'),@TreatmentSupportTelNumber_VARCHAR)

								INSERT INTO PatientTreatmentSupporter(PersonId, [SupporterId], [MobileContact], [DeleteFlag], [CreatedBy], [CreateDate])
								VALUES(@Id, @IDT, @TreatmentSupportTelNumber, 0, @UserIDT, @CreateDateT);

							END
						ELSE
							BEGIN
								SET @IDT = (SELECT TOP 1 SupporterId FROM PatientTreatmentSupporter WHERE PersonId = @Id);

								UPDATE Person
								SET FirstName = ENCRYPTBYKEY(KEY_GUID('Key_CTC'),@FirstNameT), LastName = ENCRYPTBYKEY(KEY_GUID('Key_CTC'),@LastNameT)
								WHERE Id = @IDT;

								IF @TreatmentSupportTelNumber_VARCHAR IS NOT NULL
								SET @TreatmentSupportTelNumber = ENCRYPTBYKEY(KEY_GUID('Key_CTC'),@TreatmentSupportTelNumber_VARCHAR)

								UPDATE PatientTreatmentSupporter
								SET MobileContact = @TreatmentSupportTelNumber
								WHERE PersonId = @Id;

							END
						END

				FETCH NEXT FROM Treatment_Supporter_cursor INTO  @FirstNameT, @LastNameT, @TreatmentSupportTelNumber_VARCHAR, @CreateDateT, @UserIDT
				END 

			CLOSE Treatment_Supporter_cursor  
			DEALLOCATE Treatment_Supporter_cursor

			--UPDATE into Person Contact
			IF @Address IS NOT NULL AND @Phone IS NOT NULL
				BEGIN
					UPDATE PersonContact
					SET PhysicalAddress = @Address, MobileNumber = @Phone
					WHERE PersonId = @Id;
				END

		END

    -- Get the next mst_patient.
    FETCH NEXT FROM mstPatient_cursor   
    INTO @FirstName, @MiddleName, @LastName, @Sex, @Status, @DeleteFlag, @CreateDate, @UserID, @PatientFacilityId, @FacilityId, @DateOfBirth, @DobPrecision, @NationalId, @CCCNumber, @ReferredFrom, @RegistrationDate, @MaritalStatus , @DistrictName, @Address, @Phone
END   
CLOSE mstPatient_cursor;  
DEALLOCATE mstPatient_cursor;  
END


GO
