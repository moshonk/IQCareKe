/****** Object:  StoredProcedure [dbo].[pr_Clinical_SaveUpdate_IPTDetails]    Script Date: 8/15/2018 12:19:57 PM ******/

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pr_Clinical_SaveUpdate_IPTDetails]') AND type in (N'P', N'PC'))
BEGIN

EXEC('
Alter PROCEDURE [dbo].[pr_Clinical_SaveUpdate_IPTDetails] (
	@Ptn_pk INT = NULL
	,@Visit_Pk INT = NULL
	,@INHStartDate VARCHAR(30) = NULL
	,@INHEndDate VARCHAR(30) = NULL
	)
AS
BEGIN
	IF EXISTS (
			SELECT 1
			FROM dtl_TBScreening
			WHERE ptn_pk = @Ptn_pk
				--AND Visit_Pk = @Visit_Pk
			)
	BEGIN
		UPDATE dtl_TBScreening
		SET INHStartDate = CONVERT(DATETIME, @INHStartDate, 103)
			,INHEndDate = CONVERT(DATETIME, @INHEndDate, 103)
		WHERE ptn_pk = @Ptn_pk
			--AND visit_pk = @Visit_Pk
	END
END
')
END



IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pr_Clinical_SaveUpdate_IPTDetails]') AND type in (N'P', N'PC'))
BEGIN

EXEC('
Create PROCEDURE [dbo].[pr_Clinical_SaveUpdate_IPTDetails] (
	@Ptn_pk INT = NULL
	,@Visit_Pk INT = NULL
	,@INHStartDate VARCHAR(30) = NULL
	,@INHEndDate VARCHAR(30) = NULL
	)
AS
BEGIN
	IF EXISTS (
			SELECT 1
			FROM dtl_TBScreening
			WHERE ptn_pk = @Ptn_pk
				--AND Visit_Pk = @Visit_Pk
			)
	BEGIN
		UPDATE dtl_TBScreening
		SET INHStartDate = CONVERT(DATETIME, @INHStartDate, 103)
			,INHEndDate = CONVERT(DATETIME, @INHEndDate, 103)
		WHERE ptn_pk = @Ptn_pk
			--AND visit_pk = @Visit_Pk
	END
END
')
END



