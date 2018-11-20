import {Component, EventEmitter, Input, OnInit, Output} from '@angular/core';
import {FormBuilder, FormControl, FormGroup, Validators} from '@angular/forms';
import {Subscription} from 'rxjs';
import {SnotifyService} from 'ng-snotify';
import {PatientEducationEmitter} from '../../emitters/PatientEducationEmitter';
import {CounsellingTopicsEmitters} from '../../emitters/counsellingTopicsEmitters';
import {PatientEducationCommand} from '../../_models/PatientEducationCommand';
import {LookupItemService} from '../../../shared/_services/lookup-item.service';
import {NotificationService} from '../../../shared/_services/notification.service';
import * as moment from 'moment';
import {AncService} from '../../_services/anc.service';


export interface PeriodicElement {
    topicId: number;
    topic: string;
    onSetDate: string;
}

const ELEMENT_DATA: PeriodicElement[] = [
    {topicId: 1, topic: 'sex', onSetDate: 'Hydrogen'},
    {topicId: 2, topic: 'church', onSetDate: 'Helium'}
];


@Component({
    selector: 'app-patient-education-examination',
    templateUrl: './patient-education-examination.component.html',
    styleUrls: ['./patient-education-examination.component.css']
})


export class PatientEducationExaminationComponent implements OnInit {
    PatientEducationFormGroup: FormGroup;

    public yesnos: any[] = [];
    public testResults: any[] = [];
    public userId: number;
    public maxDate: Date = moment().toDate();

    public patientCounseling$: Subscription;

    public patientEducationEmitterData: PatientEducationEmitter;
    public counsellingOptions: any[] = [];
    public yesNoOptions: any[] = [];
    public hivStatusOptions: any[] = [];

    public counselling_data: CounsellingTopicsEmitters[] = [];
    public counseling_db_data: CounsellingTopicsEmitters[] = [];
    @Output() nextStep = new EventEmitter<PatientEducationEmitter>();
    @Output() notify: EventEmitter<object> = new EventEmitter<object>();
    @Input() patientEducationData: PatientEducationCommand;
    @Input() patientEducationFormOptions: any[] = [];
    @Input('isEdit') isEdit: boolean;
    @Input('PatientId') PatientId: number;
    @Input('PatientMasterVisitId') PatientMasterVisitId: number;

    displayedColumns: string[] = ['topicId', 'topic', 'onSetDate'];
    dataSource = ELEMENT_DATA;

    constructor(private _formBuilder: FormBuilder, private _lookupItemService: LookupItemService,
                private  snotifyService: SnotifyService,
                private notificationService: NotificationService,
                private ancService: AncService) {
    }

    ngOnInit() {
        this.PatientEducationFormGroup = this._formBuilder.group({
            breastExamDone: ['', Validators.required],
            counsellingDate: ['', Validators.required],
            counselledOn: ['', Validators.required],
            treatedSyphilis: ['', Validators.required]
           // testResult: new FormControl(['', Validators.required])
        });
        this.userId = JSON.parse(localStorage.getItem('appUserId'));
        //  this.getLookupOptions('counselledOn', this.topics);
        //  this.getLookupOptions('yesno', this.yesnos);
        //  this.getLookupOptions('HivTestingResult', this.testResults);

        const {
            yesnoOptions,
            patientEducationOptions,
            hivStatusOptions
        } = this.patientEducationFormOptions[0];
        this.yesNoOptions = yesnoOptions;
        this.counsellingOptions = patientEducationOptions;
        this.hivStatusOptions = hivStatusOptions;


        this.nextStep.emit(this.patientEducationEmitterData);
        this.notify.emit({ 'form': this.PatientEducationFormGroup, 'counselling_data': this.counselling_data});

        if (this.isEdit) {

            this.getPatientCounselingData(this.PatientId, this.PatientMasterVisitId);
        }
    }

    /*  public getLookupOptions(groupName: string, masterName: any[]) {
          this.LookupItems$ = this._lookupItemService.getByGroupName(groupName)
              .subscribe(
                  p => {
                      const lookupOptions = p['lookupItems'];
                      for (let i = 0; i < lookupOptions.length; i++) {
                          masterName.push({'itemId': lookupOptions[i]['itemId'], 'itemName': lookupOptions[i]['itemName']});
                      }
                  },
                  (err) => {
                      console.log(err);
                      this.snotifyService.error('Error fetching lookups' + err, 'Encounter', this.notificationService.getConfig());
                  },
                  () => {
                      console.log(this.lookupItemView$);
                  });
      }*/

    public moveNextStep() {
        console.log(this.PatientEducationFormGroup.value);

        this.patientEducationEmitterData = {
            breastExamDone: parseInt(this.PatientEducationFormGroup.get('breastExamDone').value, 10),
            treatedSyphilis: parseInt(this.PatientEducationFormGroup.get('treatedSyphilis').value, 10),
            counsellingTopics: this.counselling_data
        };
            console.log('breastexamDone' + this.patientEducationEmitterData.breastExamDone + 'from form ' +
                this.PatientEducationFormGroup.get('breastExamDone').value.itemId);
        console.log(this.patientEducationEmitterData);
        this.nextStep.emit(this.patientEducationEmitterData);
    }

    public addTopics() {

        const topic = this.PatientEducationFormGroup.controls['counselledOn'].value.itemName;
        const topicId = this.PatientEducationFormGroup.controls['counselledOn'].value.itemId;

        if (this.counselling_data.filter(x => x.counsellingTopic === topic).length > 0) {
            this.snotifyService.warning('' + topic + ' exists', 'Counselling', this.notificationService.getConfig());
        } else {
            this.counselling_data.push({
                counselledOn: parseInt(topicId, 10),
                counsellingTopic: topic,
                counsellingTopicId: topicId,
                description: 'n/a',
                CounsellingDate: this.PatientEducationFormGroup.controls['counsellingDate'].value
            });
        }
    }

    public removeRow(idx) {
        this.counselling_data.splice(idx, 1);
    }

    public getPatientCounselingData(patientId: number, patientMasterVisitId: number): void {
         this.patientCounseling$ = this.ancService.getPatientCounselingInfo(patientId, patientMasterVisitId)
             .subscribe(
                 p => {
                     console.log('counseling data');
                     console.log(p);
                     if (p) {
                         for (let i = 0; i < p.length; i++) {
                             this.counselling_data.push({
                                counselledOn: p[i]['counsellingTopicId'],
                                 counsellingTopic: p[i]['counsellingTopic'],
                                 counsellingTopicId: p['counsellingTopicId'],
                                 description: p[i]['description'],
                                 CounsellingDate: p[i]['counsellingDate']
                             });
                         }
                     }
                 },
                 (err) => {

                 },
                 () => {

                 }
             );
    }
}
