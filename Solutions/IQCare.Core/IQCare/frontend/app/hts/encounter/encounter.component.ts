import {Component, NgZone, OnInit} from '@angular/core';
import {Encounter} from '../_models/encounter';
import {EncounterService} from '../_services/encounter.service';
import {FinalTestingResults, Testing} from '../_models/testing';
import {ActivatedRoute, Router} from '@angular/router';
import {Store} from '@ngrx/store';
import * as Consent from '../../shared/reducers/app.states';
import {AppStateService} from '../../shared/_services/appstate.service';
import {AppEnum} from '../../shared/reducers/app.enum';
import {SnotifyService} from 'ng-snotify';
import {NotificationService} from '../../shared/_services/notification.service';
import {FormBuilder, FormControl, FormGroup, Validators} from '@angular/forms';

declare var $: any;

@Component({
  selector: 'app-encounter',
  templateUrl: './encounter.component.html',
  styleUrls: ['./encounter.component.css']
})
export class EncounterComponent implements OnInit {
    encounter: Encounter;
    form: FormGroup;

    isNoOfMonths: boolean = true;
    isDisabilitiesEnabled: boolean = true;
    isClientTestedDisabled: boolean = false;
    isStrategyDisabled: boolean = false;

    entryPoints: any[];
    yesNoOptions: any[];
    disabilities: any[];
    testedAs: any[];
    strategyOptions: any[];
    tbStatus: any[];
    hivResultsOptions: any[];
    hivFinalResultsOptions: any[];
    hivTestKits: any[];

    maxDate: any;


    constructor(private _encounterService: EncounterService,
                private router: Router,
                private route: ActivatedRoute,
                public zone: NgZone,
                private store: Store<AppState>,
                private appStateService: AppStateService,
                private snotifyService: SnotifyService,
                private notificationService: NotificationService,
                private fb: FormBuilder) {
        this.maxDate = new Date();
    }

    ngOnInit() {
        this.encounter = new Encounter();
        // set default values
        this.encounter.PersonId = JSON.parse(localStorage.getItem('personId'));
        this.encounter.PatientId = JSON.parse(localStorage.getItem('patientId'));
        this.encounter.ServiceAreaId = 2;

        this.encounter.ProviderId = JSON.parse(localStorage.getItem('appUserId'));
        this.encounter.PatientEncounterID = 1;
        this.encounter.MonthSinceSelfTest = null;
        this.encounter.GeoLocation = null;

        this.getHtsOptions();
        this.getEncounterType();

        this.form = this.fb.group({
            EncounterType: new FormControl(this.encounter.EncounterType, [Validators.required]),
            EncounterDate: new FormControl(this.encounter.EncounterDate, [Validators.required]),
            EverTested: new FormControl(this.encounter.EverTested, [Validators.required]),
            MonthsSinceLastTest: new FormControl(this.encounter.MonthsSinceLastTest, [Validators.required]),
            TestEntryPoint: new FormControl(this.encounter.TestEntryPoint, [Validators.required]),
            EverSelfTested: new FormControl(this.encounter.EverSelfTested, [Validators.required]),
            HasDisability: new FormControl(this.encounter.HasDisability, [Validators.required]),
            Consent: new FormControl(this.encounter.Consent, [Validators.required]),
            TestedAs: new FormControl(this.encounter.TestedAs, [Validators.required]),
            TestingStrategy: new FormControl(this.encounter.TestingStrategy, [Validators.required]),
            TbScreening: new FormControl(this.encounter.TbScreening, [Validators.required]),
            EncounterRemarks: new FormControl(this.encounter.EncounterRemarks),
            Disabilities: new FormControl(this.encounter.Disabilities, [Validators.required]),
        });
    }

    validate() {
        // console.log(this.form);
        if (this.form.valid) {
            this.encounter = {...this.encounter, ...this.form.value};
            if (!this.encounter.Disabilities) {
                this.encounter.Disabilities = [];
            }
            this.onSubmitForm();
        } else {
            return false;
        }
    }

    getHtsOptions() {
        this._encounterService.getHtsEncounterOptions().subscribe(res => {
            const options = res['lookupItems'];
            for (let i = 0; i < options.length; i++) {
                // console.log(options[i]);
                if (options[i].key == 'HTSEntryPoints') {
                    this.entryPoints = options[i].value;
                } else if (options[i].key == 'YesNo') {
                    this.yesNoOptions = options[i].value;
                } else if (options[i].key == 'Disabilities') {
                    this.disabilities = options[i].value;
                } else if (options[i].key == 'TestedAs') {
                    this.testedAs = options[i].value;
                } else if (options[i].key == 'Strategy') {
                    this.strategyOptions = options[i].value;
                } else if (options[i].key == 'TBStatus') {
                    this.tbStatus = options[i].value;
                }
            }
        });
    }

    getEncounterType() {
        this._encounterService.getEncounterType().subscribe(res => {
            this.encounter.EncounterTypeId = res['itemId'];
        });
    }

    onSubmitForm() {
        // console.log(this.encounter);
        const isConsented = this.encounter.Consent;
        const testedAs = this.encounter.TestedAs;

        this._encounterService.addEncounter(this.encounter).subscribe(data => {
            console.log(data);
            localStorage.setItem('htsEncounterId', data['htsEncounterId']);
            localStorage.setItem('patientMasterVisitId', data['patientMasterVisitId']);

            const optionSelected = this.yesNoOptions.filter(function( obj ) {
                return obj.itemId == isConsented;
            });

            if (testedAs) {
                const optionTestedAs = this.testedAs.filter(function (obj) {
                    return obj.itemId == testedAs;
                });

                if (optionTestedAs[0]['itemName'] == 'I: Individual') {
                    this.store.dispatch(new Consent.TestedAs(true));
                    this.appStateService.addAppState(AppEnum.TESTED_AS, this.encounter.PersonId,
                        this.encounter.PatientId, data['patientMasterVisitId'], data['htsEncounterId']).subscribe();
                }
            }

            this.snotifyService.success('Successfully saved encounter', 'Encounter', this.notificationService.getConfig());

            if (optionSelected[0]['itemName'] == 'Yes') {
                this.store.dispatch(new Consent.ConsentTesting(true));
                this.appStateService.addAppState(AppEnum.CONSENT_TESTING, this.encounter.PersonId,
                    this.encounter.PatientId, data['patientMasterVisitId'], data['htsEncounterId']).subscribe();


                this.zone.run(() => { this.router.navigate(['/hts/testing'], {relativeTo: this.route }); });
            } else {
                this.zone.run(() => { this.router.navigate(['/registration/home'], { relativeTo: this.route }); });
            }

        }, err => {
            console.log(err);
            this.snotifyService.error('Error saving encounter', 'Encounter', this.notificationService.getConfig());
        });
    }

    everTestedChanged() {
        const everTested = this.form.controls.EverTested.value;
        const optionSelected = this.yesNoOptions.filter(function( obj ) {
            return obj.itemId == everTested;
        });

        if (optionSelected[0].itemName == 'Yes') {
            this.form.controls.MonthsSinceLastTest.enable({onlySelf: false});
        } else {
            this.form.controls.MonthsSinceLastTest.disable({onlySelf: true});
            this.form.controls.MonthsSinceLastTest.setValue('');
        }
    }

    hasDisabilityChanged() {
        const hasDisability = this.form.controls.HasDisability.value;
        const optionSelected = this.yesNoOptions.filter(function( obj ) {
            return obj.itemId == hasDisability;
        });

        if (optionSelected[0].itemName == 'Yes') {
            this.form.controls.Disabilities.enable({onlySelf: false});
        } else {
            this.form.controls.Disabilities.disable({onlySelf: true});
            this.form.controls.Disabilities.setValue([]);
        }
    }

    onConsentChanged() {
        const consent = this.form.controls.Consent.value;

        const optionSelected = this.yesNoOptions.filter(function( obj ) {
            return obj.itemId == consent;
        });

        if (optionSelected[0].itemName == 'No') {
            this.form.controls.TestedAs.disable({onlySelf: true});
            this.form.controls.TestingStrategy.disable({onlySelf: true});
            this.form.controls.TestedAs.setValue('');
            this.form.controls.TestingStrategy.setValue('');
        } else {
            this.form.controls.TestedAs.enable({onlySelf: false});
            this.form.controls.TestingStrategy.enable({onlySelf: false});
        }
    }
}