part of 'canadiansyncope_bloc.dart';

abstract class CanadianSyncopeEvent extends Equatable
{
	const CanadianSyncopeEvent();
	
	@override
	List<Object> get props => [];
}

class VagalPredispositionToggled extends CanadianSyncopeEvent
{
	const VagalPredispositionToggled({required this.vagalPredisposition});
	final bool vagalPredisposition;
	@override
	List<Object> get props => [vagalPredisposition];
}

class CardiacHistoryToggled extends CanadianSyncopeEvent
{
	const CardiacHistoryToggled({required this.cardiacHistory});
	final bool cardiacHistory;
	@override
	List<Object> get props => [cardiacHistory];
}

class AbnormalBPToggled extends CanadianSyncopeEvent
{
	const AbnormalBPToggled({required this.abnormalBP});
	final bool abnormalBP;
	@override
	List<Object> get props => [abnormalBP];
}

class TroponinToggled extends CanadianSyncopeEvent
{
	const TroponinToggled({required this.troponin});
	final bool troponin;
	@override
	List<Object> get props => [troponin];
}

class AbnormalAxisToggled extends CanadianSyncopeEvent
{
	const AbnormalAxisToggled({required this.abnormalAxis});
	final bool abnormalAxis;
	@override
	List<Object> get props => [abnormalAxis];
}

class LargeQRSToggled extends CanadianSyncopeEvent
{
	const LargeQRSToggled({required this.largeQRS});
	final bool largeQRS;
	@override
	List<Object> get props => [largeQRS];
}

class LongQTToggled extends CanadianSyncopeEvent
{
	const LongQTToggled({required this.longQT});
	final bool longQT;
	@override
	List<Object> get props => [longQT];
}

class DiagnosisToggled extends CanadianSyncopeEvent
{
	const DiagnosisToggled({required this.diagnosis});
	final EmergencyDiagnosis diagnosis;
	@override
	List<Object> get props => [diagnosis];
}