﻿ALTER TABLE PatientDelivery ADD CONSTRAINT FK_PatientDelivery_LookUpItem_Id FOREIGN KEY (BloodLossType) REFERENCES LookUpItem(Id)