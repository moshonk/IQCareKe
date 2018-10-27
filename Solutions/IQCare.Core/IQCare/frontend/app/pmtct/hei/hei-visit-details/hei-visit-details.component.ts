import { Component, EventEmitter, OnInit, Output, Input } from '@angular/core';
import { FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { SnotifyService } from 'ng-snotify';
import { Subscription } from 'rxjs/index';
import { LookupItemService } from '../../../shared/_services/lookup-item.service';
import { NotificationService } from '../../../shared/_services/notification.service';

@Component({
    selector: 'app-hei-visit-details',
    templateUrl: './hei-visit-details.component.html',
    styleUrls: ['./hei-visit-details.component.css']
})
export class HeiVisitDetailsComponent implements OnInit {
    isVisitNumberShown: boolean = false;
    isdayPostPartumShown: boolean = false;
    isCohortShown: boolean = true;
    maxDate: Date;

    public HeiVisitDetailsFormGroup: FormGroup;
    public lookupItems$: Subscription;
    public visitTypes: any[] = [];

    @Input('formtype') formtype: string;
    @Output() notify: EventEmitter<FormGroup> = new EventEmitter<FormGroup>();

    constructor(private _formBuilder: FormBuilder,
        private _lookupItemService: LookupItemService,
        private snotifyService: SnotifyService,
        private notificationService: NotificationService) {
        this.maxDate = new Date();
    }

    ngOnInit() {

        this.HeiVisitDetailsFormGroup = this._formBuilder.group({
            visitType: new FormControl('', [Validators.required]),
            visitDate: new FormControl('', [Validators.required]),
            cohort: new FormControl(''),
            visitNumber: new FormControl('', [Validators.required]),
            dayPostPartum: new FormControl('', [Validators.required])
        });

        this.HeiVisitDetailsFormGroup.get('visitNumber').disable({ onlySelf: true });
        this.HeiVisitDetailsFormGroup.get('dayPostPartum').disable({ onlySelf: true });

        switch (this.formtype) {
            case 'hei':
                this.getLookupItems('ANCVisitType', this.visitTypes);
                break;
            case 'maternity':
                this.getLookupItems('ANCVisitType', this.visitTypes);
                this.HeiVisitDetailsFormGroup.get('visitType').disable({ onlySelf: true });
                this.HeiVisitDetailsFormGroup.get('cohort').disable({ onlySelf: true });
                break;
            case 'pnc':
                this.getLookupItems('PNCVisitType', this.visitTypes);
                this.HeiVisitDetailsFormGroup.get('cohort').disable({ onlySelf: true });
                this.HeiVisitDetailsFormGroup.get('visitNumber').enable({ onlySelf: true });
                this.HeiVisitDetailsFormGroup.get('dayPostPartum').enable({ onlySelf: true });
                this.isVisitNumberShown = true;
                this.isdayPostPartumShown = true;
                this.isCohortShown = false;
                break;
            default:
        }

        this.notify.emit(this.HeiVisitDetailsFormGroup);
    }

    public getLookupItems(groupName: string, _options: any[]) {
        this.lookupItems$ = this._lookupItemService.getByGroupName(groupName)
            .subscribe(
                p => {
                    const options = p['lookupItems'];
                    console.log(options);
                    for (let i = 0; i < options.length; i++) {
                        _options.push({ 'itemId': options[i]['itemId'], 'itemName': options[i]['itemName'] });
                    }
                },
                (err) => {
                    console.log(err);
                    this.snotifyService.error('Error editing encounter ' + err, 'Encounter', this.notificationService.getConfig());
                },
                () => {
                    console.log(this.lookupItems$);
                });
    }

}