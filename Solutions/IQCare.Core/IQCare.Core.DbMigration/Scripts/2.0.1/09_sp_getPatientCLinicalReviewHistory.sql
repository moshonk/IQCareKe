-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================

IF EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('sp_getPatientClinicalReviewHistory') AND type='P')
	DROP PROCEDURE sp_getPatientClinicalReviewHistory
GO
-- =============================================
-- Author:		KOchieng
-- Create date: 08-04-2019
-- Description:	Get patient clinical review history
-- =============================================
CREATE PROCEDURE sp_getPatientClinicalReviewHistory 
	-- Add the parameters for the stored procedure here
	@PatientId int = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    -- Insert statements for procedure here
	SELECT DISTINCT TOP 5 ReviewDate, CONCAT(u.UserFirstName, ' ', u.UserLastName) ProviderName  FROM PatientClinicalReviewChecklist r INNER JOIN mst_User u  ON r.CreatedBy = u.UserID 
	WHERE PatientId = @PatientId
END
GO
