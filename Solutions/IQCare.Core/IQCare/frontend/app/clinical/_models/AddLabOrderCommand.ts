export interface AddLabOrderCommand {
  Ptn_Pk: number,
  PatientId : number,
 LocationId : number,
 VisitId : number,
 Module : string,
 OrderedBy : number,
 OrderDate : Date,
 ClinicalOrderNotes : string,
 CreateDate : Date,
 OrderStatus : string,
 UserId : number
 PatientMasterVisitId : number
 LabTests : LabTestInfo[]
}

export interface LabTestInfo{
    Id : number,
    Notes : string,
    LabTestName : string,
    OrderReason : string
}