part of 'canadiansyncope_bloc.dart';

class CanadianSyncopeState extends Equatable
{
	final bool vagalPredisposition;
	final bool cardiacHistory;
	final bool abnormalBP;
	final bool troponin;
	final bool abnormalAxis;
	final bool largeQRS;
	final bool longQT;
	final EmergencyDiagnosis diagnosis;
	
	late final CanadianSyncopeScore score;
	
	CanadianSyncopeState({
		this.vagalPredisposition = false,
		this.cardiacHistory = false,
		this.abnormalBP = false,
		this.troponin = false,
		this.abnormalAxis = false,
		this.largeQRS = false,
		this.longQT = false,
		this.diagnosis = EmergencyDiagnosis.other
	})
	{
		this.score = new CanadianSyncopeScore(
			vagalPredisposition: this.vagalPredisposition,
			cardiacHistory: this.cardiacHistory,
			abnormalBP: this.abnormalBP,
			troponin: this.troponin,
			abnormalAxis: this.abnormalAxis,
			largeQRS: this.largeQRS,
			longQT: this.longQT,
			diagnosis: this.diagnosis
		);
	}
	
	@override
	List<Object?> get props =>
		[vagalPredisposition, cardiacHistory, abnormalBP, troponin, abnormalAxis, largeQRS, longQT, diagnosis];
	
	CanadianSyncopeState copyWith({
		bool? vagalPredisposition,
		bool? cardiacHistory,
		bool? abnormalBP,
		bool? troponin,
		bool? abnormalAxis,
		bool? largeQRS,
		bool? longQT,
		EmergencyDiagnosis? diagnosis
	})
	{
		return CanadianSyncopeState(
			vagalPredisposition: vagalPredisposition ?? this.vagalPredisposition,
			cardiacHistory: cardiacHistory ?? this.cardiacHistory,
			abnormalBP: abnormalBP ?? this.abnormalBP,
			troponin: troponin ?? this.troponin,
			abnormalAxis: abnormalAxis ?? this.abnormalAxis,
			largeQRS: largeQRS ?? this.largeQRS,
			longQT: longQT ?? this.longQT,
			diagnosis: diagnosis ?? this.diagnosis
		);
	}
}