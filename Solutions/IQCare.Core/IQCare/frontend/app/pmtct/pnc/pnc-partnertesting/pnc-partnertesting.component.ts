import { Component, OnInit, Output, EventEmitter, Input } from '@angular/core';
import { FormGroup, FormBuilder, FormControl, Validators } from '@angular/forms';
import { LookupItemView } from '../../../shared/_models/LookupItemView';

@Component({
    selector: 'app-pnc-partnertesting',
    templateUrl: './pnc-partnertesting.component.html',
    styleUrls: ['./pnc-partnertesting.component.css']
})
export class PncPartnertestingComponent implements OnInit {
    PartnerTestingForm: FormGroup;
    yesNoNaOptions: LookupItemView[] = [];
    finalPartnerHivResultOptions: LookupItemView[] = [];

    @Input('partnerTestingOptions') partnerTestingOptions: any[] = [];
    @Output() notify: EventEmitter<FormGroup> = new EventEmitter<FormGroup>();

    constructor(private _formBuilder: FormBuilder) { }

    ngOnInit() {
        this.PartnerTestingForm = this._formBuilder.group({
            partnerHivTestDone: new FormControl('', [Validators.required]),
            finalPartnerHivResult: new FormControl('', [Validators.required])
        });

        const { yesNoNaOptions, finalPartnerHivResultOptions } = this.partnerTestingOptions[0];
        this.yesNoNaOptions = yesNoNaOptions;
        this.finalPartnerHivResultOptions = finalPartnerHivResultOptions;
        console.log('partner testing');
        console.log(this.yesNoNaOptions );


        this.notify.emit(this.PartnerTestingForm);
    }

}