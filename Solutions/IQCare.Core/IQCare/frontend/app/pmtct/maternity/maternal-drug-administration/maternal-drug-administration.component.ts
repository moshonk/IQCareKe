import { Component, EventEmitter, Input, OnInit, Output } from '@angular/core';
import { FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { NotificationService } from '../../../shared/_services/notification.service';
import { SnotifyService } from 'ng-snotify';
import { DataService } from '../../_services/data.service';
import { MaternityService } from '../../_services/maternity.service';

@Component({
    selector: 'app-maternal-drug-administration',
    templateUrl: './maternal-drug-administration.component.html',
    styleUrls: ['./maternal-drug-administration.component.css']
})
export class MaternalDrugAdministrationComponent implements OnInit {

    maternalDrugAdministrationFormGroup: FormGroup;
    @Input() drugAdministrationOptions: any[] = [];
    @Output() notify: EventEmitter<FormGroup> = new EventEmitter<FormGroup>();
    public yesnoOptions: any[] = [];
    public finaResultOptions: any[] = [];
    public yesnonaOptions: any[] = [];
    hiv_status: string;

    @Input('PatientId') PatientId: number;
    @Input('isEdit') isEdit: boolean;
    @Input('PatientMasterVisitId') PatientMasterVisitId: number;


    constructor(private formBuilder: FormBuilder,
        private notificationService: NotificationService,
        private snotifyService: SnotifyService,
        private maternityService: MaternityService,
        private dataservice: DataService) {
    }

    ngOnInit() {
        this.maternalDrugAdministrationFormGroup = this.formBuilder.group({
            VitaminASupplementation: new FormControl('', [Validators.required]),
            StartedHAARTinANC: new FormControl('', [Validators.required]),
            ARVsStartedinMaternity: new FormControl('', [Validators.required]),
            Cotrimoxazole: new FormControl('', [Validators.required]),
            InfantProvidedWithARVprophylaxis: new FormControl('', [Validators.required]),
            id: new FormControl('')
        });

        const {
            yesNo,
            finalResult,
            yesNoNa
        } = this.drugAdministrationOptions[0];
        this.yesnoOptions = yesNo;
        this.yesnonaOptions = yesNoNa;
        this.finaResultOptions = finalResult;

        this.notify.emit(this.maternalDrugAdministrationFormGroup);

        this.dataservice.currentHivStatus.subscribe(hivStatus => {
            this.hiv_status = hivStatus;

            if (this.hiv_status !== '' && this.hiv_status != 'Positive') {
                this.maternalDrugAdministrationFormGroup.get('VitaminASupplementation').disable({ onlySelf: true });
                this.maternalDrugAdministrationFormGroup.get('StartedHAARTinANC').disable({ onlySelf: true });
                this.maternalDrugAdministrationFormGroup.get('ARVsStartedinMaternity').disable({ onlySelf: true });
                this.maternalDrugAdministrationFormGroup.get('Cotrimoxazole').disable({ onlySelf: true });
                this.maternalDrugAdministrationFormGroup.get('InfantProvidedWithARVprophylaxis').disable({ onlySelf: true });
                this.maternalDrugAdministrationFormGroup.get('id').setValue('0');
            } else {
                this.maternalDrugAdministrationFormGroup.get('VitaminASupplementation').enable({ onlySelf: false });
                this.maternalDrugAdministrationFormGroup.get('StartedHAARTinANC').enable({ onlySelf: false });
                this.maternalDrugAdministrationFormGroup.get('ARVsStartedinMaternity').enable({ onlySelf: false });
                this.maternalDrugAdministrationFormGroup.get('Cotrimoxazole').enable({ onlySelf: false });
                this.maternalDrugAdministrationFormGroup.get('InfantProvidedWithARVprophylaxis').enable({ onlySelf: false });
            }
        });
        if (this.isEdit) {
            this.getDrugsAdministered(this.PatientId, this.PatientMasterVisitId);
        }
    }

    private getDrugsAdministered(patientId: any, patientMasterVisitId: any) {
        this.maternityService.getPatientAdministeredDrugs(patientId, patientMasterVisitId).subscribe(res => {
              res.forEach(data => {
                const drugName = data.strDrugAdministered.split(' ').join('');

                 this.maternalDrugAdministrationFormGroup
                 .get(drugName)
                 .setValue(data.value);
              });
           }, (err) => {
            console.log(err);
        });
    }

}
