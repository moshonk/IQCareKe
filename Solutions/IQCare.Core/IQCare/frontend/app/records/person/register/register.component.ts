import { CheckDuplicatesComponent } from './../check-duplicates/check-duplicates.component';
import { forkJoin } from 'rxjs';
import { LookupItemView } from './../../../shared/_models/LookupItemView';
import { County } from '../../_models/county';
import { SnotifyService, SnotifyPosition } from 'ng-snotify';
import { EmergencyContact } from '../../_models/emergencycontact';
import { ClientAddress } from '../../_models/clientaddress';
import { Validators } from '@angular/forms';
import { FormControl } from '@angular/forms';
import { Component, OnInit, NgZone } from '@angular/core';
import { FormGroup, FormBuilder, AbstractControl } from '@angular/forms';
import { Person } from '../../_models/person';
import { ClientContact } from '../../_models/clientcontact';
import { NextOfKin } from '../../_models/nextofkin';
import { MatDatepickerInputEvent, MatDialogConfig, MatDialog, MatTableDataSource } from '@angular/material';
import * as moment from 'moment';
import { NotificationService } from '../../../shared/_services/notification.service';
import { ActivatedRoute, Router } from '@angular/router';
import { CountyService } from '../../_services/county.service';
import { PersonRegistrationService } from '../../_services/person-registration.service';
import { PersoncontactsComponent } from '../personcontacts/personcontacts.component';
import { RecordsService } from '../../_services/records.service';
import { SearchService } from '../../_services/search.service';
import { Search } from '../../_models/search';
import { Store } from '@ngrx/store';
import * as AppState from '../../../shared/reducers/app.states';
import { Partner } from '../../../shared/_models/partner';
import { NgxSpinnerService } from 'ngx-spinner';

@Component({
    selector: 'app-register',
    templateUrl: './register.component.html',
    styleUrls: ['./register.component.css']
})
export class RegisterComponent implements OnInit {
    /**
     * Component variables
     */
    isLinear = true;
    registerEmergencyContact: boolean = false;
    formGroup: FormGroup;
    /** Returns a FormArray with the name 'formArray'. */
    get formArray(): AbstractControl | null { return this.formGroup.get('formArray'); }

    person: Person;
    clientAddress: ClientAddress;
    clientContact: ClientContact;
    nextOfKin: NextOfKin;
    maxDate: Date;
    enrolledServices: any[];
    counties: County[];
    subCounties: County[];
    wards: County[];
    gender: LookupItemView[];
    maritalStatus: LookupItemView[];
    educationLevel: LookupItemView[];
    PatientCCCEnrolled: boolean = false;
    occupation: LookupItemView[];
    relationship: LookupItemView[];
    consentSms: LookupItemView[];
    contactCategory: LookupItemView[];
    personIdentifiers: any[];
    NHIFIdentifiers: any[];
    yesnoOptions: LookupItemView[];
    services: any[];
    clientSearch: Search;

    dataSource: any[];
    newContacts: any[];
    id: number;
    PatientId: number;
    partnerType: Partner;
    PatientEnrollmentId: number;
    public phonePattern = /^(?:\+254|0|254)(\d{9})$/;

    constructor(private _formBuilder: FormBuilder,
        private snotifyService: SnotifyService,
        private notificationService: NotificationService,
        private route: ActivatedRoute,
        private countyService: CountyService,
        private personRegistration: PersonRegistrationService,
        private dialog: MatDialog,
        private recordsService: RecordsService,
        public zone: NgZone,
        private router: Router,
        private searchService: SearchService,
        private store: Store<AppState>,
        private spinner: NgxSpinnerService) {
        this.maxDate = new Date();
        this.clientSearch = new Search();
    }

    ngOnInit() {
        this.person = new Person();
        this.clientAddress = new ClientAddress();
        this.clientContact = new ClientContact();
        this.nextOfKin = new NextOfKin();
        this.dataSource = [];
        this.newContacts = [];
        this.person.PosId = JSON.parse(localStorage.getItem('appPosID'));

        this.formGroup = this._formBuilder.group({
            formArray: this._formBuilder.array([
                this._formBuilder.group({
                    FirstName: new FormControl(this.person.firstName, [Validators.required]),
                    MiddleName: new FormControl(this.person.middleName),
                    LastName: new FormControl(this.person.lastName, [Validators.required]),
                    NickName: new FormControl(this.person.nickName),
                    Sex: new FormControl(this.person.sex, [Validators.required]),
                    registrationDate: new FormControl(this.person.registrationDate, [Validators.required]),
                    DateOfBirth: new FormControl(this.person.dateOfBirth, [Validators.required]),
                    AgeYears: new FormControl(this.person.ageYears, [Validators.required]),
                    AgeMonths: new FormControl(this.person.ageMonths, [Validators.required]),
                    DobPrecision: new FormControl(this.person.dobPrecision, [Validators.required]),
                    MaritalStatus: new FormControl(this.person.maritalStatus),
                    EducationLevel: new FormControl(this.person.EducationLevel),
                    Occupation: new FormControl(this.person.Occupation),
                    IdentifierType: new FormControl(this.person.IdentifierType),
                    NHIFNumber: new FormControl(),
                    IdentifierNumber: new FormControl(this.person.IdentifierNumber,
                        Validators.compose([Validators.required, Validators.maxLength(50)]))
                }),
                this._formBuilder.group({
                    County: new FormControl(this.clientAddress.County, [Validators.required]),
                    SubCounty: new FormControl(this.clientAddress.SubCounty, [Validators.required]),
                    Ward: new FormControl(this.clientAddress.Ward, [Validators.required]),
                    NearestHealthCenter: new FormControl(this.clientAddress.NearestHealthCenter, [Validators.required]),
                    Landmark: new FormControl(this.clientAddress.Landmark, [Validators.required])
                }),
                this._formBuilder.group({
                    MobileNumber: new FormControl(this.clientContact.MobileNumber),
                    AlternativeMobileNumber: new FormControl(this.clientContact.AlternativeMobileNumber),
                    EmailAddress: new FormControl(this.clientContact.EmailAddress),
                }),
                this._formBuilder.group({
                })
            ])
        });

        this.formGroup.controls['formArray']['controls'][0]['controls']['IdentifierNumber'].disable({ onlySelf: true });

        this.route.data.subscribe((res) => {
            // console.log(res);
            const { countiesArray, genderArray, maritalStatusArray, educationLevelArray,
                occupationArray, relationshipArray, consentSmsArray, contactCategoryArray,
                personIdentifiersArray, yesnoArray, PersonNHIFArray } = res;
            this.counties = countiesArray;
            this.gender = genderArray;
            this.maritalStatus = maritalStatusArray;
            this.educationLevel = educationLevelArray;
            this.occupation = occupationArray;
            this.relationship = relationshipArray;
            this.consentSms = consentSmsArray;
            this.contactCategory = contactCategoryArray;
            this.personIdentifiers = personIdentifiersArray['identifers'];
            this.NHIFIdentifiers = PersonNHIFArray['identifers'];
            this.yesnoOptions = yesnoArray['lookupItems'];
            // console.log(personIdentifiersArray['identifers']);
        });

        this.route.params.subscribe(params => {
            this.id = params['id'];
        });
        this.getServices();

        if (this.id) {
            this.getPersonDetails(this.id);
            this.getPersonEnrolledServices(this.id);
        }

        this.partnerType = new Partner();
        this.partnerType = JSON.parse(localStorage.getItem('isPartner'));
        if (this.partnerType == null) {
            this.store.dispatch(new AppState.ClearState());
        }
    }

    async getServices() {
        await this.recordsService.getAllServices().subscribe((res) => {
            if (res) {

                this.services = res;
            }
            console.log(this.services);
        }, (err) => {
            //  console.log(err);
        })
    }
    getPersonEnrolledServices(id: any) {
        this.recordsService.getEnrolledServices(id).subscribe((res) => {
            this.enrolledServices = res['personEnrollmentList'];
            if (this.enrolledServices && this.enrolledServices.length > 0) {
                this.PatientId = this.enrolledServices[0]['patientId'];

                let isCCCEnrolled;
                if (this.enrolledServices) {
                    isCCCEnrolled = this.enrolledServices.filter(obj => obj.serviceAreaId == 1);
                    if (isCCCEnrolled != undefined) {
                        if (isCCCEnrolled && isCCCEnrolled.length > 0) {
                            this.PatientCCCEnrolled=true;
                            this.loadPatientEnrollmentDetails(this.PatientId ,isCCCEnrolled[0].serviceAreaId);
                        }
                    }
                }

            }

        });
    }

    loadPatientEnrollmentDetails(patientId: any, serviceId: any): void {
        this.recordsService.getPatientEnrollmentDateByServiceAreaId(patientId, serviceId).subscribe(
            (result) => {
                console.log('EnrollmentDetails');
                console.log(result);
                // console.log(result);

            },
            (error) => {
                console.log(error);
            }
        );
    }
    getPersonDetails(id: number): any {
        this.recordsService.getPersonDetails(id).subscribe(
            (result) => {

                const {
                    alternativeNumber, county, countyId, dateOfBirth, dobPrecision, educationLevel, educationLevelId,
                    emailAddress, firstName, gender, lastName, maritalStatus, maritalStatusId, middleName, nickName,
                    mobileNumber, nearestHealthCentre, occupation, occupationId, registrationDate, sex,
                    subCounty, subCountyId, village, ward, wardId } = result[0];


                let exact = null;
                if (dobPrecision && dobPrecision == true) {
                    exact = 1;
                } else if (dobPrecision == false) {
                    exact = 0;
                }

                // first tab wizard
                this.formGroup.controls['formArray']['controls'][0]['controls'].FirstName.setValue(firstName);
                this.formGroup.controls['formArray']['controls'][0]['controls'].MiddleName.setValue(middleName);
                this.formGroup.controls['formArray']['controls'][0]['controls'].LastName.setValue(lastName);
                this.formGroup.controls['formArray']['controls'][0]['controls'].NickName.setValue(nickName);
                this.formGroup.controls['formArray']['controls'][0]['controls'].Sex.setValue(sex);
                this.formGroup.controls['formArray']['controls'][0]['controls'].registrationDate.setValue(registrationDate);
                this.formGroup.controls['formArray']['controls'][0]['controls'].DateOfBirth.setValue(dateOfBirth);
                this.formGroup.controls['formArray']['controls'][0]['controls'].DobPrecision.setValue(exact);
                this.formGroup.controls['formArray']['controls'][0]['controls'].MaritalStatus.setValue(maritalStatusId);
                this.formGroup.controls['formArray']['controls'][0]['controls'].EducationLevel.setValue(educationLevelId);
                this.formGroup.controls['formArray']['controls'][0]['controls'].Occupation.setValue(occupationId);
                if (dateOfBirth) {
                    this.getAge(moment(dateOfBirth));
                }

                // second tab wizard
                this.formGroup.controls['formArray']['controls'][1]['controls'].County.setValue(countyId);
                this.countyService.getSubCounties(countyId).subscribe((res) => {
                    this.subCounties = res;
                    this.formGroup.controls['formArray']['controls'][1]['controls'].SubCounty.setValue(subCountyId);
                });
                this.countyService.getWards(subCountyId).subscribe((res) => {
                    this.wards = res;
                    this.formGroup.controls['formArray']['controls'][1]['controls'].Ward.setValue(wardId);
                });
                this.formGroup.controls['formArray']['controls'][1]['controls'].NearestHealthCenter.setValue(nearestHealthCentre);
                this.formGroup.controls['formArray']['controls'][1]['controls'].Landmark.setValue(village);

                // third tab wizard
                this.formGroup.controls['formArray']['controls'][2]['controls'].MobileNumber.setValue(mobileNumber);
                this.formGroup.controls['formArray']['controls'][2]['controls'].AlternativeMobileNumber.setValue(alternativeNumber);
                this.formGroup.controls['formArray']['controls'][2]['controls'].EmailAddress.setValue(emailAddress);
            }
        );

        this.personRegistration.getPersonKinContacts(id).subscribe(
            (res) => {
                for (let i = 0; i < res.length; i++) {
                    // console.log(res[i]);
                    this.dataSource.push({
                        'firstName': res[i].firstName,
                        'middleName': res[i].middleName,
                        'lastName': res[i].lastName,
                        'gender': res[i].genderList[0],
                        'contactcategory': res[i].contactCategoryList[0],
                        'relationship': res[i].contactRelationshipList[0],
                        'phoneno': res[i].mobileNo,
                        'consent': res[i].consentList[0],
                        'disabled': 'none'
                    });
                }
            }
        );

        this.personRegistration.getPersonIdentifiers(id).subscribe(
            (res) => {
                console.log(res);
                if (res.length > 0) {


                    for (let i = 0; i < res.length; i++) {

                        if (res[i]['identifierId'].toString() !== this.NHIFIdentifiers[0]['id'].toString()) {
                            this.formGroup.controls['formArray']['controls'][0]['controls'].IdentifierType.setValue(res[i]['identifierId']);
                            this.formGroup.controls['formArray']['controls'][0]['controls'].IdentifierNumber.setValue(res[i]['identifierValue']);
                            this.formGroup.controls['formArray']['controls'][0]['controls']['IdentifierNumber'].enable({ onlySelf: false });
                        }

                        if (res[i]['identifierId'].toString() === this.NHIFIdentifiers[0]['id'].toString()) {
                            this.formGroup.controls['formArray']['controls'][0]['controls'].NHIFNumber.setValue(res[i]['identifierValue']);

                        }

                    }
                }
            }
        );
    }

    onDate(event: MatDatepickerInputEvent<moment.Moment>) {
        this.getAge(event.value, true);
    }

    getAge(dob: moment.Moment, setDobPrecision: boolean = false): any {
        const today = new Date();

        let age = today.getFullYear() - dob.toDate().getFullYear();
        let ageMonths = today.getMonth() - dob.toDate().getMonth();
        if (ageMonths < 0 || (ageMonths === 0 && today.getDate() < dob.toDate().getDate())) {
            age--;
        }

        if (ageMonths < 0) {
            ageMonths = 12 - (-ageMonths + 1);
        }

        this.formArray['controls'][0]['controls']['AgeYears'].setValue(age);
        this.formArray['controls'][0]['controls']['AgeMonths'].setValue(ageMonths);
        if (setDobPrecision) {
            this.formArray['controls'][0]['controls']['DobPrecision'].setValue(1);
        }

        this.validateRegistrationDate();
    }

    validateRegistrationDate(): void {
        const regDate = this.formArray['controls'][0]['controls']['registrationDate'].value;
        const dob = this.formArray['controls'][0]['controls']['DateOfBirth'].value;
        if (regDate && dob) {
            const isBefore = moment(regDate).isBefore(dob);
            if (isBefore) {
                this.formArray['controls'][0]['controls']['registrationDate'].setValue('');
                this.snotifyService.error('Registration Date should not be before the date of Birth',
                    'Registration', this.notificationService.getConfig());
                return;
            }
        }
    }

    estimateDob() {
        const ageYears = this.formGroup.value.formArray[0]['AgeYears'];
        const ageMonths = this.formGroup.value.formArray[0]['AgeMonths'];

        if (!ageYears) {
            this.snotifyService.error('Please enter (age years)', 'Registration', this.notificationService.getConfig());
            return;
        }

        if (ageYears < 0) {
            this.snotifyService.error('Age in years should not be negative', 'Registration', this.notificationService.getConfig());
            this.formArray['controls'][0]['controls']['AgeYears'].setValue('');
            return;
        }

        if (ageYears > 120) {
            this.snotifyService.error('Age in years should not be more than 120 years old',
                'Registration', this.notificationService.getConfig());
            this.formArray['controls'][0]['controls']['AgeYears'].setValue('');
            return;
        }

        if (ageMonths < 0) {
            this.snotifyService.error('Age in months should not be negative', 'Registration', this.notificationService.getConfig());
            this.formArray['controls'][0]['controls']['AgeMonths'].setValue('');
            return;
        }

        if (ageMonths > 11) {
            this.snotifyService.error('Age in months should not be more than 11', 'Registration', this.notificationService.getConfig());
            this.formArray['controls'][0]['controls']['AgeMonths'].setValue('');
            return;
        }

        if (!ageMonths) {
            this.formArray['controls'][0]['controls']['AgeMonths'].setValue(0);
        }

        const today = new Date();
        today.setDate(15);
        if (ageYears > 0) {
            today.setMonth(5);
        }

        if (ageYears == 0 && (!ageMonths || ageMonths == 0)) {
            today.setDate(new Date().getDate());
        }

        const estDob = moment(today.toISOString());
        let dob = estDob.add((ageYears * -1), 'years');
        if (ageMonths) {
            dob = estDob.add(ageMonths * -1, 'months');
        }

        this.formArray['controls'][0]['controls']['DateOfBirth'].setValue(moment(dob).toDate());
        this.formArray['controls'][0]['controls']['DobPrecision'].setValue(0);

        this.validateRegistrationDate();
    }

    onCountyChange() {
        const county = this.formGroup.value.formArray[1]['County'];
        this.countyService.getSubCounties(county).subscribe((res) => {
            this.subCounties = res;
            this.wards = [];
        });
    }

    onSubCountyChange() {
        const subCountyId = this.formGroup.value.formArray[1]['SubCounty'];
        this.countyService.getWards(subCountyId).subscribe((res) => {
            this.wards = res;
        });
    }

    onSubmitForm(tabIndex: number) {
        if (this.formGroup.valid) {
            this.spinner.show();
            this.person = { ...this.formArray.value[0] };
            this.clientAddress = { ...this.formArray.value[1] };
            this.clientContact = { ...this.formArray.value[2] };
            this.person.dateOfBirth = moment(this.formArray.value[0]['DateOfBirth']).toDate();
            this.person.registrationDate = moment(this.person.registrationDate).toDate();

            this.person.personId = 0;
            this.person.createdBy = JSON.parse(localStorage.getItem('appUserId'));
            this.person.PosId = JSON.parse(localStorage.getItem('appPosID'));

            if (this.id) {
                // set person id for update
                this.person.id = this.id;
            }
            if(this.id) {
                if(this.PatientCCCEnrolled == true)
                {
                    let messageType:number;
                       
                                messageType=2;
               
                        
                       let enrollmentId:number;
                       let posId: number;
                       
                        enrollmentId=parseInt(this.PatientEnrollmentId.toString(),10);
                        if(enrollmentId > 0)
                        {
                            
                            this.recordsService.sendIL(this.PatientId,this.PatientEnrollmentId,parseInt(this.person.PosId.toString() ,10),messageType)
                            .subscribe();

                            
                        }
                }
            }

            this.personRegistration.registerPerson(this.person).subscribe(
                (response) => {
                    const { personId } = response;

                    // Add Contact
                    const personContact = this.personRegistration.addPersonContact(personId, this.person.createdBy, this.clientContact);
                    // Add Address
                    const personAddress = this.personRegistration.addPersonAddress(personId, this.person.createdBy, this.clientAddress);
                    // Add Marital Status
                    const personMaritalStatus = this.personRegistration.addPersonMaritalStatus(personId,
                        this.person.createdBy, this.person['MaritalStatus']);
                    // Add Education Level
                    const personEducationLevel = this.personRegistration.addPersonEducationLevel(personId,
                        this.person.createdBy, this.person.EducationLevel);
                    // Add Occupation
                    const personOccupation = this.personRegistration.addPersonOccupation(personId,
                        this.person.createdBy, this.person.Occupation);
                    // Add Emergency Contact
                    const personEmergencyContact = this.personRegistration.registerPersonEmergencyContact(personId,
                        this.person.createdBy, this.newContacts);
                    // Add Person Identifiers
                    const personIdentifiersAdd = this.personRegistration.addPersonIdentifiers(personId, this.person.createdBy,
                        this.person.IdentifierType, this.person.IdentifierNumber);

                    const nhifnumber = this.formGroup.controls['formArray']['controls'][0]['controls'].NHIFNumber.value;
                    if (nhifnumber !== undefined && nhifnumber !== '' && nhifnumber !== null) {
                        const personNHIFIdentifier = this.personRegistration.addPersonIdentifiers(personId, this.person.createdBy,
                            parseInt(this.NHIFIdentifiers[0]['id'].toString(), 10), nhifnumber).subscribe(res => {
                                this.snotifyService.success('Successfully Registered NHIF Number', 'NHIF Number',
                                    this.notificationService.getConfig());
                            }, (error) => {
                                this.snotifyService.error('Error creating person NHIF Number ' + error, 'NHIF Number',
                                    this.notificationService.getConfig());
                            });
                    }
                    forkJoin([personContact, personAddress, personMaritalStatus,
                        personEducationLevel, personOccupation, personEmergencyContact,
                        personIdentifiersAdd]).subscribe(
                            (forkRes) => {
                                // console.log(forkRes);
                            },
                            (forkError) => {
                                this.snotifyService.error('Error creating person ' + forkError, 'Person Registration',
                                    this.notificationService.getConfig());
                            },
                            () => {
                                this.snotifyService.success('Successfully Registered Person', 'Person Registration',
                                    this.notificationService.getConfig());

                                if (this.partnerType != null) {
                                    if (this.partnerType != null) {
                                        if (this.partnerType.partner == 1) {
                                            this.zone.run(() => {
                                                this.router.navigate(['/hts/family/familysearch/' + personId],
                                                    { relativeTo: this.route });
                                            });
                                        } else if (this.partnerType.family == 1) {
                                            this.zone.run(() => {
                                                this.router.navigate(['/hts/family/familysearch/' + personId],
                                                    { relativeTo: this.route });
                                            });
                                        }
                                    }
                                } else {
                                    if (tabIndex == 1) {
                                        this.zone.run(() => {
                                            this.router.navigate(['/dashboard/personhome/' + personId],
                                                { relativeTo: this.route });
                                        });
                                    } else if (tabIndex == 2) {
                                        this.person = new Person();
                                        this.clientAddress = new ClientAddress();
                                        this.clientContact = new ClientContact();
                                        this.nextOfKin = new NextOfKin();

                                        window.location.reload();
                                    }
                                }
                            }
                        );

                    this.spinner.hide();
                },
                (error) => {
                    this.snotifyService.error('Error creating person ' + error, 'Person Registration',
                        this.notificationService.getConfig());
                },
                () => {
                }
            );
        } else {
            return;
        }
    }

    closeForm() {
        this.router.navigate(['/dashboard'], { relativeTo: this.route });
    }

    addRow() {
        const dialogConfig = new MatDialogConfig();

        dialogConfig.disableClose = true;
        dialogConfig.autoFocus = true;
        dialogConfig.height = '90%';
        dialogConfig.width = '80%';

        dialogConfig.data = {
            gender: this.gender,
            relationship: this.relationship,
            consentSms: this.consentSms,
            contactCategory: this.contactCategory,
            yesno: this.yesnoOptions
        };

        const dialogRef = this.dialog.open(PersoncontactsComponent, dialogConfig);

        dialogRef.afterClosed().subscribe(
            data => {
                if (!data) {
                    return;
                }

                console.log(data);

                this.dataSource.push(
                    {
                        'firstName': data.firstName,
                        'middleName': data.middleName,
                        'lastName': data.lastName,
                        'gender': data.sex,
                        'contactcategory': data.kinContactType,
                        'relationship': data.kinContactRelationship,
                        'phoneno': data.kinMobileNumber,
                        'consent': data.kinConsentToSMS,
                        'disabled': 'all'
                    }
                );

                this.newContacts.push({
                    'firstName': data.firstName,
                    'middleName': data.middleName,
                    'lastName': data.lastName,
                    'gender': data.sex,
                    'contactcategory': data.kinContactType,
                    'relationship': data.kinContactRelationship,
                    'phoneno': data.kinMobileNumber,
                    'consent': data.kinConsentToSMS,
                    'consentDecline': data.consentDeclineReason,
                    'personRegistered': data.registeredPersonId,
                    'posid': this.person.PosId
                });

                console.log(this.newContacts);
            }
        );
    }

    deleteContact(data: any, index: number, event: any) {
        const result = this.snotifyService.confirm('Are you sure you want to delete?', 'Contacts', {
            closeOnClick: true,
            position: SnotifyPosition.centerCenter,
            buttons: [
                {
                    text: 'Yes', action: () => {
                        const contactsFiltered = this.newContacts.filter((obj) => {
                            return obj.firstName !== data.firstName
                                && obj.lastName !== data.lastName
                                && obj.gender.itemId !== data.gender.itemId
                                && obj.relationship.itemId !== data.relationship.itemId
                                && obj.contactcategory !== data.contactcategory.itemId;
                        });

                        this.newContacts = contactsFiltered;
                        this.dataSource.splice(index, 1);

                        console.log(this.newContacts);
                    }, bold: false
                },
                { text: 'No', action: () => console.log('Clicked: No') }
            ]
        });
    }

    onIdentifierTypeChange() {
        const selectedIdentifier = this.personIdentifiers.filter(obj => obj.id == this.formArray.value[0]['IdentifierType']);
        if (selectedIdentifier.length > 0) {
            const ageInYears = this.formArray['controls'][0]['controls']['AgeYears'].value;

            if (selectedIdentifier[0]['name'] == 'NationalID' && ageInYears < 18) {
                // this.formArray['controls'][0]['controls']['IdentifierType'].disable({ onlySelf: true });
                this.snotifyService.error('Children of less than 18 years are not assigned National IDs ', 'Person Registration',
                    this.notificationService.getConfig());
                return;
            }
        }

        if (this.formArray.value[0]['IdentifierType']) {
            this.formGroup.controls['formArray']['controls'][0]['controls']['IdentifierNumber'].enable({ onlySelf: false });
        } else {
            this.formGroup.controls['formArray']['controls'][0]['controls']['IdentifierNumber'].disable({ onlySelf: true });
            this.formGroup.controls['formArray']['controls'][0]['controls']['IdentifierNumber'].setValue('');
        }
    }

    public checkAgeForValidation() {
        const ageInYears = this.formArray['controls'][0]['controls']['AgeYears'].value;
        if (ageInYears < 10) {
            this.formArray['controls'][0]['controls']['MaritalStatus'].disable({ onlySelf: true });
            this.formArray['controls'][0]['controls']['MaritalStatus'].setValidators('');
            this.formArray['controls'][0]['controls']['MaritalStatus'].updateValueAndValidity();
            this.formArray['controls'][0]['controls']['EducationLevel'].disable({ onlySelf: true });
            this.formArray['controls'][0]['controls']['Occupation'].disable({ onlySelf: true });
        } else {
            this.formArray['controls'][0]['controls']['MaritalStatus'].setValidators([Validators.required]);
            this.formArray['controls'][0]['controls']['MaritalStatus'].enable();
            this.formArray['controls'][0]['controls']['EducationLevel'].enable();
            this.formArray['controls'][0]['controls']['Occupation'].enable();
        }
    }

    public checkDuplicates() {
        const firstName = this.formGroup.controls['formArray']['controls'][0]['controls']['FirstName'].value;
        const middleName = this.formGroup.controls['formArray']['controls'][0]['controls']['MiddleName'].value;
        const lastName = this.formGroup.controls['formArray']['controls'][0]['controls']['LastName'].value;
        const gender = this.formGroup.controls['formArray']['controls'][0]['controls']['Sex'].value;
        const dateOfBirth = this.formGroup.controls['formArray']['controls'][0]['controls']['DateOfBirth'].value;

        this.clientSearch.firstName = firstName == null ? '' : firstName;
        this.clientSearch.middleName = middleName == null ? '' : middleName;
        this.clientSearch.lastName = lastName == null ? '' : lastName;
        this.clientSearch.identifierValue = '';
        this.clientSearch.mobileNumber = '';
        this.clientSearch.dateOfBirth = dateOfBirth;
        this.clientSearch.sex = gender;

        if (firstName && lastName && gender && dateOfBirth) {
            this.searchService.searchClient(this.clientSearch).subscribe(
                (result) => {
                    if ((!this.id) && result && result['personSearch'] && result['personSearch'].length > 0) {
                        const dialogConfig = new MatDialogConfig();

                        dialogConfig.disableClose = true;
                        dialogConfig.autoFocus = true;
                        dialogConfig.height = '90%';
                        dialogConfig.width = '80%';

                        dialogConfig.data = {
                            'persons': result['personSearch']
                        };

                        const dialogRef = this.dialog.open(CheckDuplicatesComponent, dialogConfig);

                        dialogRef.afterClosed().subscribe(
                            data => {
                                if (!data) {
                                    return;
                                }

                                this.zone.run(() => {
                                    this.router.navigate(['/dashboard/personhome/' + data[0]['id']], { relativeTo: this.route });
                                });
                            }
                        );
                    }
                }
            );
        }
    }
}
