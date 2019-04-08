IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('sp_saveClincalReview'))
	DROP PROCEDURE sp_saveClincalReview 
GO
-- =============================================
-- Author:		Kochieng
-- Create date: 03/04/3019
-- Description:	Procedure to save clinical review data
-- =============================================
CREATE PROCEDURE sp_saveClincalReview 
	-- Add the parameters for the stored procedure here
			@PatientMasterVisitId INT = NULL
           ,@PatientId INT = NULL
           ,@ReviewDate DATE = NULL
           ,@DrtDate DATE = NULL
           ,@DrtResult INT = NULL
           ,@HBDone INT = NULL
           ,@HBDate DATE = NULL
           ,@HBResult INT = NULL
           ,@CreatinineDone INT = NULL
           ,@CreatinineDate DATE = NULL
           ,@CreatinineResult INT = NULL
           ,@AltDone INT = NULL
           ,@AltDate DATE = NULL
           ,@AltResult INT = NULL
           ,@HbsagDone INT = NULL
           ,@HbsagDate DATE = NULL
           ,@HbsagResult INT = NULL
           ,@VdrlDone INT = NULL
           ,@VdrlDate DATE = NULL
           ,@VdrlResult INT = NULL
           ,@CragDone INT = NULL
           ,@CragDate DATE = NULL
           ,@CragResult INT = NULL
           ,@TbLamDone INT = NULL
           ,@TbLamdate DATE = NULL
           ,@DewormingDone INT = NULL
           ,@DewormingDate DATE = NULL
           ,@DepressionScreening INT = NULL
           ,@DepressionScreeningDate DATE = NULL
           ,@DepressionScreeningResult INT = NULL
           ,@CacxScreeningDone INT = NULL
           ,@CacxScreeningDate DATE = NULL
           ,@CacxScreeningResult INT = NULL
           ,@DentalReviewDone INT = NULL
           ,@DentalReviewDate DATE = NULL
           ,@Recommendations NVARCHAR(MAX) = NULL
           ,@CreateDate DATE = NULL
           ,@CreatedBy INT = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
IF NOT EXISTS (SELECT * FROM [PatientClinicalReviewChecklist] WHERE PatientId = @PatientId AND ReviewDate = @ReviewDate)
	BEGIN
		INSERT INTO [dbo].[PatientClinicalReviewChecklist]
				   ([PatientMasterVisitId]
				   ,[PatientId]
				   ,[ReviewDate]
				   ,[DrtDate]
				   ,[DrtResult]
				   ,[HBDone]
				   ,[HBDate]
				   ,[HBResult]
				   ,[CreatinineDone]
				   ,[CreatinineDate]
				   ,[CreatinineResult]
				   ,[AltDone]
				   ,[AltDate]
				   ,[AltResult]
				   ,[HbsagDone]
				   ,[HbsagDate]
				   ,[HbsagResult]
				   ,[VdrlDone]
				   ,[VdrlDate]
				   ,[VdrlResult]
				   ,[CragDone]
				   ,[CragDate]
				   ,[CragResult]
				   ,[TbLamDone]
				   ,[TbLamDate]
				   ,[DewormingDone]
				   ,[DewormingDate]
				   ,[DepressionScreeningDone]
				   ,[DepressionScreeningDate]
				   ,[DepressionScreeningResult]
				   ,[CacxScreeningDone]
				   ,[CacxScreeningDate]
				   ,[CacxScreeningResult]
				   ,[DentalReviewDone]
				   ,[DentalReviewDate]
				   ,[Recommendations]
				   ,[CreateDate]
				   ,[CreatedBy])
			 VALUES
				   (@PatientMasterVisitId
				   ,@PatientId
				   ,@ReviewDate
				   ,@DrtDate
				   ,@DrtResult
				   ,@HBDone
				   ,@HBDate
				   ,@HBResult
				   ,@CreatinineDone
				   ,@CreatinineDate
				   ,@CreatinineResult
				   ,@AltDone
				   ,@AltDate
				   ,@AltResult
				   ,@HbsagDone
				   ,@HbsagDate
				   ,@HbsagResult
				   ,@VdrlDone
				   ,@VdrlDate
				   ,@VdrlResult
				   ,@CragDone
				   ,@CragDate
				   ,@CragResult
				   ,@TbLamDone
				   ,@TbLamdate
				   ,@DewormingDone
				   ,@DewormingDate
				   ,@DepressionScreening
				   ,@DepressionScreeningDate
				   ,@DepressionScreeningResult
				   ,@CacxScreeningDone
				   ,@CacxScreeningDate
				   ,@CacxScreeningResult
				   ,@DentalReviewDone
				   ,@DentalReviewDate
				   ,@Recommendations
				   ,@CreateDate
				   ,@CreatedBy)

		SELECT @@identity
	END
ELSE
	BEGIN
		UPDATE [dbo].[PatientClinicalReviewChecklist]
		   SET [PatientMasterVisitId] = @PatientMasterVisitId
			  ,[DrtDate] = @DrtDate
			  ,[DrtResult] = @DrtResult
			  ,[HBDone] = @HBDone
			  ,[HBDate] = @HBDate
			  ,[HBResult] = @HBResult
			  ,[CreatinineDone] = @CreatinineDone
			  ,[CreatinineDate] = @CreatinineDate
			  ,[CreatinineResult] = @CreatinineResult
			  ,[AltDone] = @AltDone
			  ,[AltDate] = @AltDate
			  ,[AltResult] = @AltResult
			  ,[HbsagDone] = @HbsagDone
			  ,[HbsagDate] = @HbsagDate
			  ,[HbsagResult] = @HbsagResult
			  ,[VdrlDone] = @VdrlDone
			  ,[VdrlDate] = @VdrlDate
			  ,[VdrlResult] = @VdrlResult
			  ,[CragDone] = @CragDone
			  ,[CragDate] = @CragDate
			  ,[CragResult] = @CragResult
			  ,[TbLamDone] = @TbLamDone
			  ,[TbLamDate] = @TbLamDate
			  ,[DewormingDone] = @DewormingDone
			  ,[DewormingDate] = @DewormingDate
			  ,[DepressionScreeningDone] = @DepressionScreening
			  ,[DepressionScreeningDate] = @DepressionScreeningDate
			  ,[DepressionScreeningResult] = @DepressionScreeningResult
			  ,[CacxScreeningDone] = @cacxScreeningDone
			  ,[CacxScreeningDate] = @CacxScreeningDate
			  ,[CacxScreeningResult] = @CacxScreeningResult
			  ,[DentalReviewDone] = @DentalReviewDone
			  ,[DentalReviewDate] = @DentalReviewDate
			  ,[Recommendations] = @Recommendations
		 WHERE PatientId = @PatientId AND ReviewDate = @ReviewDate
		SELECT id FROM [PatientClinicalReviewChecklist] WHERE PatientId = @PatientId AND ReviewDate = @ReviewDate
	END	
END

