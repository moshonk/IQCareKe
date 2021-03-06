import { SnotifyService } from 'ng-snotify';
import { LookupItemView } from './../../../shared/_models/LookupItemView';
import { FormBuilder, FormGroup, FormControl, Validators } from '@angular/forms';
import { Component, OnInit, EventEmitter, Output, Input } from '@angular/core';
import { MatDialog, MatDialogConfig, MatTableDataSource } from '@angular/material';
import { HivStatusComponent } from '../hiv-status/hiv-status.component';
import { Subscription } from 'rxjs/index';
import { AncService } from '../../_services/anc.service';
import { PncService } from '../../_services/pnc.service';
import { NotificationService } from '../../../shared/_services/notification.service';
import { DataService } from '../../_services/data.service';
import { LookupItemService } from '../../../shared/_services/lookup-item.service';

@Component({
    selector: 'app-anc-hivtesting',
    templateUrl: './anc-hivtesting.component.html',
    styleUrls: ['./anc-hivtesting.component.css']
})
export class AncHivtestingComponent implements OnInit {
    ancHivStatusInitialVisitOptions: LookupItemView[];
    yesnoOptions: LookupItemView[];
    hivFinalResultsOptions: LookupItemView[];
    baseline$: Subscription;

    isHivTestingDone: boolean = false;

    public hiv_testing_table_data: HivTestingTableData[] = [];
    public historical_hiv_testing_data: HivTestingTableData[] = [];

    displayedColumns = ['testdate', 'testtype', 'kitname', 'lotnumber',
        'expirydate', 'testresult', 'nexthivtest', 'testpoint', 'action'];
    dataSource = new MatTableDataSource(this.hiv_testing_table_data);

    HivTestingForm: FormGroup;
    @Input('hivTestingOptions') hivTestingOptions: any;
    @Output() notify: EventEmitter<Object> = new EventEmitter<Object>();
    @Input('isEdit') isEdit: boolean;
    @Input('PatientId') PatientId: number;
    @Input('PatientMasterVisitId') PatientMasterVisitId: number;
    @Input() patientEncounterId: number;
    @Input() personId: number;
    @Input() serviceAreaId: number;
    @Input() visitDate: Date;

    lookupItemView$: Subscription;
    LookupItems$: Subscription;

    public testVisits: LookupItemView[] = [];
    public kits: LookupItemView[] = [];
    public tests: LookupItemView[] = [];
    public testResults: LookupItemView[] = [];

    serviceAreaName: string;

    constructor(
        private dialog: MatDialog,
        private _formBuilder: FormBuilder,
        private ancService: AncService,
        private pncService: PncService,
        private notificationService: NotificationService,
        private snotifyService: SnotifyService,
        private dataservice: DataService,
        private _lookupItemService: LookupItemService) {

    }

    ngOnInit() {
        this.HivTestingForm = this._formBuilder.group({
            hivStatusBeforeFirstVisit: new FormControl('', [Validators.required]),
            hivTestingDone: new FormControl('', [Validators.required]),
            testType: new FormControl('', [Validators.required]),
            finalTestResult: new FormControl('', [Validators.required])
        });

        // console.log(this.serviceAreaId);
        if (this.serviceAreaId == 3) {
            this.serviceAreaName = 'ANC';
        } else if (this.serviceAreaId == 4) {
            this.serviceAreaName = 'PNC';
        } else if (this.serviceAreaId == 5) {
            this.serviceAreaName = 'Maternity';
        } else if (this.serviceAreaId == 6) {
            this.serviceAreaName = 'HEI';
        } else {
            this.serviceAreaName = 'HTS';
        }

        this.HivTestingForm.controls['testType'].disable({ onlySelf: true });
        this.HivTestingForm.controls['finalTestResult'].disable({ onlySelf: true });

        const { ancHivStatusInitialVisitOptions, yesnoOptions, hivFinalResultsOptions } = this.hivTestingOptions[0];
        this.ancHivStatusInitialVisitOptions = ancHivStatusInitialVisitOptions;
        this.yesnoOptions = yesnoOptions;
        this.hivFinalResultsOptions = hivFinalResultsOptions;

        this.getLookupOptions('PMTCTHIVTestVisit', this.testVisits);
        this.getLookupOptions('HIVTestKits', this.kits);
        this.getLookupOptions('PMTCTHIVTests', this.tests);
        this.getLookupOptions('HIVResults', this.testResults);

        this.notify.emit({ 'form': this.HivTestingForm, 'table_data': this.hiv_testing_table_data });

        if (this.isEdit) {
            this.getBaselineAncProfile(this.PatientId);
            this.loadHivTests();
        } else {
            this.getBaselineAncProfile(this.PatientId);
        }

        this.personCurrentHivStatus();
    }

    loadHivTests(): void {
        this.pncService.getHivTests(this.PatientMasterVisitId, this.patientEncounterId).subscribe(
            (result) => {
                // console.log(result);
                if (result && result['encounter'] && result['encounter'].length > 0) {
                    const tests = result['testing'];
                    if (tests.length > 0) {
                        for (let i = 0; i < tests.length; i++) {
                            const testRound = tests[i].testRound == 1 ? 'HIV Test-1' : 'HIV Test-2';
                            const testType = this.tests.find(obj => obj.itemName == testRound);
                            const kitName = this.kits.find(obj => obj.itemId == tests[i].kitId);
                            const lotnumber = tests[i].kitLotNumber;
                            const expirydate = tests[i].expiryDate;
                            const outcome = this.testResults.find(obj => obj.itemId == tests[i].outcome);
                            const testEntryPoint = result['encounter'];


                            this.historical_hiv_testing_data.push({
                                testdate: new Date(),
                                testtype: testType,
                                kitname: kitName,
                                lotnumber: lotnumber,
                                expirydate: expirydate,
                                testresult: outcome,
                                nexthivtest: null,
                                testpoint: this.serviceAreaName
                            });
                            // console.log(this.historical_hiv_testing_data);
                        }
                    }

                    if (result['encounterResults'].length > 0) {
                        this.HivTestingForm.controls.testType.setValue(result['encounter'][0]['encounterType']);
                        const finalTestResult = this.hivFinalResultsOptions.find(
                            obj => obj.itemId == result['encounterResults'][0]['finalResult']);
                        if (finalTestResult) {
                            this.HivTestingForm.get('finalTestResult').setValue(finalTestResult.itemId);
                            if (finalTestResult.itemName == 'Positive') {
                                this.HivTestingForm.get('hivTestingDone').disable({ onlySelf: false });
                            }
                        }
                    }
                    // console.log(this.historical_hiv_testing_data, 'datasource');
                    this.dataSource = new MatTableDataSource(this.historical_hiv_testing_data);
                }
            },
            (error) => {

            }
        );
    }

    AddHivTests() {
        const dialogConfig = new MatDialogConfig();
        dialogConfig.disableClose = true;
        dialogConfig.autoFocus = true;

        dialogConfig.data = {
            'visitDate': this.visitDate
        };

        // console.log(this.serviceAreaName);
        const dialogRef = this.dialog.open(HivStatusComponent, dialogConfig);

        dialogRef.afterClosed().subscribe(
            data => {
                if (!data) {
                    return;
                }

                // console.log(data);

                this.hiv_testing_table_data.push({
                    testdate: new Date(),
                    testtype: data.hivTest,
                    kitname: data.kitName,
                    lotnumber: data.lotNumber,
                    expirydate: data.expiryDate,
                    testresult: data.testResult,
                    nexthivtest: data.nextAppointmentDate,
                    testpoint: this.serviceAreaName
                });

                this.historical_hiv_testing_data.push({
                    testdate: new Date(),
                    testtype: data.hivTest,
                    kitname: data.kitName,
                    lotnumber: data.lotNumber,
                    expirydate: data.expiryDate,
                    testresult: data.testResult,
                    nexthivtest: data.nextAppointmentDate,
                    testpoint: this.serviceAreaName
                });

                this.dataSource = new MatTableDataSource(this.historical_hiv_testing_data);
            }
        );
    }

    onHivTestDoneChange(event) {
        if (event.isUserInput && event.source.selected && event.source.viewValue == 'Yes') {
            this.isHivTestingDone = true;
            this.HivTestingForm.controls['testType'].enable({ onlySelf: true });
            this.HivTestingForm.controls['finalTestResult'].enable({ onlySelf: true });
        } else if (event.isUserInput && event.source.selected && event.source.viewValue == 'No') {
            this.isHivTestingDone = false;
            this.HivTestingForm.controls['testType'].disable({ onlySelf: true });
            this.HivTestingForm.controls['finalTestResult'].disable({ onlySelf: true });

            // set default value to null
            this.HivTestingForm.controls['testType'].setValue('');
            this.HivTestingForm.controls['finalTestResult'].setValue('');
        }
    }

    onHivStatusBeforeFirstVisitChange(event) {
        // console.log(event);
        if (event.isUserInput && event.source.selected && event.source.viewValue == 'Known Positive') {
            this.HivTestingForm.controls['hivTestingDone'].disable({ onlySelf: true });
            this.HivTestingForm.controls['testType'].disable({ onlySelf: true });
            this.HivTestingForm.controls['finalTestResult'].disable({ onlySelf: true });
        } else if (event.isUserInput && event.source.selected) {
            this.HivTestingForm.controls['hivTestingDone'].enable();
        }
    }

    public getBaselineAncProfile(patientId: number): void {
        this.baseline$ = this.ancService.getBaselineAncProfile(patientId)
            .subscribe(
                p => {
                    const baseline = p;

                    if (baseline) {
                        this.HivTestingForm.get('hivStatusBeforeFirstVisit').setValue(baseline['hivStatusBeforeAnc']);
                    }
                },
                error1 => {

                },
                () => {

                }
            );
    }

    public personCurrentHivStatus() {
        this.pncService.getPersonCurrentHivStatus(this.personId).subscribe(
            (res) => {
                if (res.length > 0) {
                    const hivPositiveResult = this.ancHivStatusInitialVisitOptions.filter(obj => obj.itemName == 'Known Positive');
                    if (hivPositiveResult.length > 0) {
                        this.HivTestingForm.get('hivStatusBeforeFirstVisit').setValue(hivPositiveResult[0].itemId);

                        // set hiv_status
                        this.dataservice.changeHivStatus('Positive');
                        // set the default to null
                        this.isHivTestingDone = false;
                        this.HivTestingForm.controls['testType'].setValue('');
                        this.HivTestingForm.controls['finalTestResult'].setValue('');
                    } else {
                        this.dataservice.changeHivStatus('Negative');
                    }
                }
            },
            (error) => {
                this.snotifyService.error('Error loading previous hiv status ', 'Maternity',
                    this.notificationService.getConfig());
            }
        );
    }

    public onHivTestFinalResultChange(event) {
        if (event.isUserInput && event.source.selected && event.source.viewValue == 'Positive') {
            this.dataservice.changeHivStatus('Positive');
        } else if (event.isUserInput && event.source.selected && event.source.viewValue == 'Negative') {
            this.dataservice.changeHivStatus('Negative');
        } else if (event.isUserInput && event.source.selected && event.source.viewValue == 'Inconclusive') {
            this.dataservice.changeHivStatus('Inconclusive');
        }
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
}

export interface HivTestingTableData {
    testdate?: Date;
    testtype?: any;
    kitname?: any;
    lotnumber?: string;
    expirydate?: Date;
    testresult?: any;
    nexthivtest?: Date;
    testpoint?: string;
}
