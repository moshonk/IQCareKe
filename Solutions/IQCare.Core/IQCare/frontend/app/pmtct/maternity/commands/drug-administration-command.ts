import {AdministeredDrugInfo} from './administer-drug-info';

export interface DrugAdministrationCommand {
    Id?: number;
    PatientId?: number;
    PatientMasterVisitId?: number;
    CreatedBy?: number;
    AdministeredDrugs: AdministeredDrugInfo[];
}


export interface UpdateDrugAdministrationCommand{
    PatientMasterVisitId?: number;
    AdministeredDrugs: AdministeredDrugInfo[];
}
