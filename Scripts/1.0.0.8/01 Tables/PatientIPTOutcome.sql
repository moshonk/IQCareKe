IF NOT EXISTS (SELECT * FROM sys.all_columns WHERE object_id = OBJECT_ID('PatientIptOutcome') AND name = 'IptDiscontinuationReason')
	ALTER TABLE PatientIptOutcome ADD IptDiscontinuationReason INT