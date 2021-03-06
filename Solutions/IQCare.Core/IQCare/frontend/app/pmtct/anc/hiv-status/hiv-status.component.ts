import { Component, EventEmitter, Input, OnInit, Output, Inject } from '@angular/core';
import { FormBuilder, FormGroup, Validators, FormControl } from '@angular/forms';
import { Subscription } from 'rxjs/index';
import { NotificationService } from '../../../shared/_services/notification.service';
import { LookupItemService } from '../../../shared/_services/lookup-item.service';
import { SnotifyService } from 'ng-snotify';
import { HIVTestingEmitter } from '../../emitters/HIVTestingEmitter';
import { VisitDetailsService } from '../../_services/visit-details.service';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material';
export interface Topic {
    value: number;
    viewValue: string;
}

@Component({
    selector: 'app-hiv-status',
    templateUrl: './hiv-status.component.html',
    styleUrls: ['./hiv-status.component.css']
})

export class HivStatusComponent implements OnInit {

    LookupItems$: Subscription;
    public testVisits: any[] = [];
    public kits: any[] = [];
    public tests: any[] = [];
    public testResults: any[] = [];
    public finalResults: any[] = [];
    public consentOption: number;
    public ancTestEntryPoint: number;

    lookupItemView$: Subscription;
    @Output() nextStep = new EventEmitter<HIVTestingEmitter>();
    @Output() notify: EventEmitter<FormGroup> = new EventEmitter<FormGroup>();
    @Input() hivTestingData: HIVTestingEmitter;

    minDate: Date;

    HIVStatusFormGroup: FormGroup;
    constructor(private _formBuilder: FormBuilder,
        private _lookupItemService: LookupItemService,
        private notificationService: NotificationService,
        private snotifyService: SnotifyService,
        private visitDetailsService: VisitDetailsService,
        private dialogRef: MatDialogRef<HivStatusComponent>,
        @Inject(MAT_DIALOG_DATA) data) {
        this.minDate = data.visitDate;
        // this.minDate = new Date();
    }

    ngOnInit() {

        this.HIVStatusFormGroup = this._formBuilder.group({
            hivTest: new FormControl('', [Validators.required]),
            kitName: new FormControl('', [Validators.required]),
            testResult: new FormControl('', [Validators.required]),
            lotNumber: new FormControl('', [Validators.required]),
            expiryDate: new FormControl('', [Validators.required]),
            nextAppointmentDate: new FormControl('')
        });

        this.getLookupOptions('PMTCTHIVTestVisit', this.testVisits);
        this.getLookupOptions('HIVTestKits', this.kits);
        this.getLookupOptions('PMTCTHIVTests', this.tests);
        this.getLookupOptions('HIVResults', this.testResults);
        // this.getLookupOptions('HIVFinalResults', this.finalResults);
        this.visitDetailsService.getConsentOptions().subscribe(
            (result) => {
                const { itemId } = result;
                this.consentOption = itemId;
            }
        );

        this.visitDetailsService.getTestEntryPointANC().subscribe(
            (result) => {
                const { itemId } = result;
                this.ancTestEntryPoint = itemId;
            }
        );

        this.notify.emit(this.HIVStatusFormGroup);
    }

    public getLookupOptions(groupName: string, masterName: any[]) {
        this.LookupItems$ = this._lookupItemService.getByGroupName(groupName)
            .subscribe(
                p => {
                    const lookupOptions = p['lookupItems'];
                    for (let i = 0; i < lookupOptions.length; i++) {
                        masterName.push({ 'itemId': lookupOptions[i]['itemId'], 'itemName': lookupOptions[i]['itemName'] });
                    }
                },
                (err) => {
                    // console.log(err);
                    this.snotifyService.error('Error fetching lookups' + err, 'Encounter', this.notificationService.getConfig());
                },
                () => {
                    // console.log(this.lookupItemView$);
                });
    }

    public save() {
        if (this.HIVStatusFormGroup.valid) {
            this.dialogRef.close(this.HIVStatusFormGroup.value);
        } else {
            return;
        }
    }

    close() {
        this.dialogRef.close();
    }
}
