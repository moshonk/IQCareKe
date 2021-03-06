import { PncService } from './../../_services/pnc.service';
import { Component, EventEmitter, Input, OnInit, Output } from '@angular/core';
import { FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { NotificationService } from '../../../shared/_services/notification.service';
import { SnotifyService } from 'ng-snotify';

@Component({
    selector: 'app-maternity-referral',
    templateUrl: './maternity-referral.component.html',
    styleUrls: ['./maternity-referral.component.css']
})
export class MaternityReferralComponent implements OnInit {

    referralFormGroup: FormGroup;
    @Input() dischargeOptions: any[] = [];
    @Input('isEdit') isEdit: boolean;
    @Input('patientId') patientId: number;
    @Input('patientMasterVisitId') patientMasterVisitId: number;

    @Output() notify: EventEmitter<FormGroup> = new EventEmitter<FormGroup>();
    public referralOptions: any[] = [];

    constructor(private formBuilder: FormBuilder,
        private notificationService: NotificationService,
        private snotifyService: SnotifyService,
        private pncservice: PncService) {
    }

    ngOnInit() {
        this.referralFormGroup = this.formBuilder.group({
            referredFrom: new FormControl(''),
            referredTo: new FormControl(''),
            'id': new FormControl('')
        });

        const {
            referrals,
        } = this.dischargeOptions[0];
        this.referralOptions = referrals;


        this.notify.emit(this.referralFormGroup);

        if (this.isEdit) {
            this.loadMaternityReferral();
        }
    }

    loadMaternityReferral(): void {
        this.pncservice.getReferral(this.patientId, this.patientMasterVisitId).subscribe(
            (result) => {
                if (result) {
                    this.referralFormGroup.get('referredFrom').setValue(result.referredFrom);
                    this.referralFormGroup.get('referredTo').setValue(result.referredTo);
                    this.referralFormGroup.get('id').setValue(result.id);
                }
            },
            (error) => {
                this.snotifyService.error('Fetching referal ' + error, 'Encounter',
                    this.notificationService.getConfig());
            },
            () => { }
        );
    }

}
