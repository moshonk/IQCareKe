export class Encounter {
    id?: number;
    PersonId?: number;
    ProviderId?: number;
    PatientEncounterID?: number;
    EverTested?: number;
    MonthsSinceLastTest?: number;
    MonthSinceSelfTest?: number;
    TestEntryPoint?: number;
    HasDisability?: number;
    EverSelfTested?: number;
    Disabilities?: any[];
    Consent?: number;
    TestedAs?: number;
    TestingStrategy?: number;
    EncounterRemarks?: string;
    TbScreening?: number;
    GeoLocation?: string;
}
