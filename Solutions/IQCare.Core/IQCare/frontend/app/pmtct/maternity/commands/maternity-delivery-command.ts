export interface MaternityDeliveryCommand {
   PatientMasterVisitId?: number;
   PregnancyId?: number;
   DurationOfLabour?: string;
   DateOfDelivery?: Date;
   TimeOfDelivery?: Date;
   ModeOfDelivery?: number;
   PlacentaComplete?: number;
   BloodLossCapacity?: number;
   BloodLossClassification?: number;
   MotherCondition?: number;
   MaternalDeathAudited?: number;
    MaternalDeathAuditDate?: Date;
    DeliveryComplicationsExperienced?: boolean;
    DeliveryComplicationNotes?: string;
    DeliveryConductedBy?: string;
    CreatedBy?: number;
}


export interface UpdateMaternalPatientDeliveryCommand
{
    PatientDeliveryInfoId? : number;
    MaternalPatientDeliveryInfoCommand : MaternityDeliveryCommand
}
