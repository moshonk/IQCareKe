import {ApgarScoreCommand} from './apgar-score-command';
import {TestCondition} from './testCondition';

export interface BabyConditionCommand {
PatientDeliveryInformationId?: number;
PatientMasterVisitId?: number;
BirthWeight?: number;
Sex?: number;
DeliveryOutcome?: Date;
ResuscitationDone?: boolean;
BirthDeformity?: boolean;
TeoGiven?: boolean;
BreastFedWithinHour?: boolean;
BirthNotificationNumber?: string;
Comment?: string;
CreatedBy?: number;
ApgarScores: ApgarScoreCommand[];
}