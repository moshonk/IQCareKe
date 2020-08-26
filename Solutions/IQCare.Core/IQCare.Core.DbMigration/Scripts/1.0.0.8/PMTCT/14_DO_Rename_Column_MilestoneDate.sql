/*IF (EXISTS (SELECT *  FROM sys.all_columns  WHERE name = 'MilestoneDate'))
BEGIN 
EXEC sp_rename 'PatientMilestone.MilestoneDate', 'DateAssessed', 'COLUMN';
END
 */


IF (EXISTS (SELECT sch.COLUMN_NAME, sch.* 
FROM INFORMATION_SCHEMA.COLUMNS AS sch
WHERE TABLE_NAME = 'PatientMilestone'  
  AND COLUMN_NAME LIKE 'MilestoneDate'))
  BEGIN 
EXEC sp_rename 'PatientMilestone.MilestoneDate', 'DateAssessed', 'COLUMN';
END
