part of 'correctedqt_bloc.dart';

enum CorrectionMethod { heartRate, rrInterval }

class CorrectedQTState extends Equatable
{
	final int? qtinterval;
	final IntervalUnit qtIntervalUnit;
	
	final CorrectionMethod method;
	
	final int? heartRate;
	final int? rrinterval;
	final IntervalUnit rrIntervalUnit;
	
	final bool wideQRS;
	final int? qrsinterval;
	final bool female;
	
	bool get isValid => (
		this.qtinterval != null
		&& (
			(this.method == CorrectionMethod.heartRate && this.heartRate != null)
			|| (this.method == CorrectionMethod.rrInterval && this.rrinterval != null)
		)
		&& (!this.wideQRS || this.qrsinterval != null)
	);
	
	CorrectedQTScore? get score
	{
		if(!this.isValid) return null;
		
		if(!this.wideQRS && this.method == CorrectionMethod.heartRate) return CorrectedQTScore(
			qtinterval: this.qtinterval!,
			qtIntervalUnit: qtIntervalUnit,
			heartRate: this.heartRate!
		);
		
		if(!this.wideQRS && this.method == CorrectionMethod.rrInterval) return CorrectedQTScore.fromInterval(
			qtinterval: this.qtinterval!,
			qtIntervalUnit: qtIntervalUnit,
			rrinterval: this.rrinterval!,
			rrIntervalUnit: rrIntervalUnit
		);
		
		if(this.wideQRS && this.method == CorrectionMethod.heartRate) return CorrectedQTScoreWideQRS(
			qtinterval: this.qtinterval!,
			qtIntervalUnit: qtIntervalUnit,
			heartRate: this.heartRate!,
			qrsinterval: this.qrsinterval!,
			female: this.female
		);
		
		if(this.wideQRS && this.method == CorrectionMethod.rrInterval) return CorrectedQTScoreWideQRS.fromInterval(
			qtinterval: this.qtinterval!,
			qtIntervalUnit: qtIntervalUnit,
			rrinterval: this.rrinterval!,
			rrIntervalUnit: rrIntervalUnit,
			qrsinterval: this.qrsinterval!,
			female: this.female
		);
		
		return null;
	}
	
	const CorrectedQTState({
		this.qtinterval,
		this.qtIntervalUnit = IntervalUnit.ms,
		this.method = CorrectionMethod.heartRate,
		this.heartRate,
		this.rrinterval,
		this.rrIntervalUnit = IntervalUnit.ms,
		this.wideQRS = false,
		this.qrsinterval,
		this.female = false
	});
	
	@override
	List<Object?> get props =>
		[qtinterval, qtIntervalUnit, method, heartRate, rrinterval, rrIntervalUnit, wideQRS, qrsinterval, female];
	
	CorrectedQTState copyWith({
		int? qtinterval,
		bool updateQtInterval = false,
		IntervalUnit? qtIntervalUnit,
		CorrectionMethod? method,
		int? heartRate,
		bool updateHeartRate = false,
		int? rrinterval,
		bool updateRrInterval = false,
		IntervalUnit? rrIntervalUnit,
		bool? wideQRS,
		int? qrsinterval,
		bool updateQrsInterval = false,
		bool? female
	})
	{
		return CorrectedQTState(
			qtinterval: updateQtInterval ? qtinterval : this.qtinterval,
			qtIntervalUnit: qtIntervalUnit ?? this.qtIntervalUnit,
			method: method ?? this.method,
			heartRate: updateHeartRate ? heartRate : this.heartRate,
			rrinterval: updateRrInterval ? rrinterval : this.rrinterval,
			rrIntervalUnit: rrIntervalUnit ?? this.rrIntervalUnit,
			wideQRS: wideQRS ?? this.wideQRS,
			qrsinterval: updateQrsInterval ? qrsinterval : this.qrsinterval,
			female: female ?? this.female,
		);
	}
}