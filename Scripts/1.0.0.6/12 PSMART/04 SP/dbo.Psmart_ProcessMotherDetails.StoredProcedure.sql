/****** Object:  StoredProcedure [dbo].[Psmart_ProcessMotherDetails]    Script Date: 25-May-2018 10:43:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Psmart_ProcessMotherDetails]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Psmart_ProcessMotherDetails]
GO
/****** Object:  StoredProcedure [dbo].[Psmart_ProcessMotherDetails]    Script Date: 25-May-2018 10:43:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Psmart_ProcessMotherDetails]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Psmart_ProcessMotherDetails] AS' 
END
GO
-- =============================================
-- Author:		<sosewe>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[Psmart_ProcessMotherDetails]
	-- Add the parameters for the stored procedure here
	@firstName varchar(100),
	@middleName varchar(100),
	@lastName varchar(100),
	@cccNumber varchar(20),
	@ptnpk int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	Declare @hivStatus int,@hivCareStatus int,@PersonId int,@RelationshipTypeId int,@PatientId int;


    -- Insert statements for procedure here
	if(@cccNumber IS NULL)BEGIN SET @hivStatus=37 END ELSE BEGIN SET @hivStatus=37 END
	if(@cccNumber IS NULL)BEGIN SET @hivCareStatus=1 END ELSE BEGIN SET @hivStatus=null END

	--SET @PersonId=(SELECT PersonId FROM Patient WHERE ptn_pk=@ptnpk);
	SET @RelationshipTypeId=(SELECT Id FROM LookupItem WHERE Name='mother');
	SET @PatientId=(SELECT Id FROM Patient WHERE ptn_pk=@ptnpk)

	INSERT INTO [dbo].[dtl_FamilyInfo]
           ([Ptn_pk],[RFirstName],[RLastName],[Sex],[AgeYear],[AgeMonth],[RelationshipDate],[RelationshipType],[HivStatus],[HivCareStatus],[RegistrationNo],[UserId] ,[DeleteFlag],[CreateDate]	)
     VALUES
           (@ptnpk
           , encryptbykey(key_guid('Key_CTC'), @firstName)--<RFirstName, varbinary(max),>
           , encryptbykey(key_guid('Key_CTC'), @lastName) --<RLastName, varbinary(max),>
           ,17
           ,0 --<AgeYear, int,>
           ,0 --<AgeMonth, int,>
           ,GETDATE() --<RelationshipDate, datetime,>
           ,10 -- <RelationshipType, int,>
           ,@hivStatus
           ,@hivCareStatus
           ,@cccNumber
           ,1 -- <UserId, int,>
           ,0 --<DeleteFlag, int,>
           ,GETDATE()
           )
	
	 -- INSERT TO PERSON
    INSERT INTO Person (FirstName,LastName,Sex,CreatedBy,CreateDate) VALUES(
		ENCRYPTBYKEY(KEY_GUID('Key_CTC'),@FirstName),
		ENCRYPTBYKEY(KEY_GUID('Key_CTC'),@LastName),
		(SELECT Id FROM LookupItem WHERE Name='female'),
		1,
		GETDATE()
	)
	SELECT @PersonId=SCOPE_IDENTITY();

	INSERT INTO PersonRelationship (PersonId,RelationshipTypeId,CreatedBy,CreateDate,PatientId) VALUES(
		@PersonId,@RelationshipTypeId,1,GETDATE(),@PatientId
	)

END



GO
