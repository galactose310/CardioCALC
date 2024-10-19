import 'package:cardiocalc/lib/formulas.dart';

class CorrectedQTScore
{
	final int qtinterval;
	final IntervalUnit qtIntervalUnit;
	
	late final int rrinterval;
	late final IntervalUnit rrIntervalUnit;
	
	late final int heartRate;
	
	int get result => this.formula();
	
	CorrectedQTScore({
		required this.qtinterval,
		required this.qtIntervalUnit,
		required this.heartRate
	})
	{
		this.rrIntervalUnit = IntervalUnit.ms;
		this.rrinterval = this.intervalFromHeartRate();
	}
	
	CorrectedQTScore.fromInterval({
		required this.qtinterval,
		required this.qtIntervalUnit,
		required this.rrinterval,
		required this.rrIntervalUnit
	})
	{
		this.heartRate = this.heartRateFromInterval();
	}
	
	/// Framingham in case of narrow QRS
	/// 
	/// Framingham formula : QTc = QTm + 0,154 * [1-RR] (in second so 1000-RR using milliseconds)
	int formula()
	{
		return 	(Formulas.convertInMilliseconds(interval: this.qtinterval, unit: this.qtIntervalUnit) +
				(0.154 * (1000 - Formulas.convertInMilliseconds(interval: this.rrinterval, unit: this.rrIntervalUnit)))).round();
	}
	
	/// Returns HR in bpm from an interval giving its unit
	int heartRateFromInterval()
	{
		return Formulas.millisecondsToBpm(
			interval: Formulas.convertInMilliseconds(
				interval: this.rrinterval,
				unit: this.rrIntervalUnit
			)
		);
	}
	
	/// Returns interval in milliseconds from heart rate
	int intervalFromHeartRate()
	{
		return Formulas.bpmToMilliseconds(heartrate: this.heartRate);
	}
}

class CorrectedQTScoreWideQRS extends CorrectedQTScore
{
	late final int qrsinterval;
	late final IntervalUnit qrsIntervalUnit;
	late final bool female;
	
	CorrectedQTScoreWideQRS({
		required super.qtinterval,
		required super.qtIntervalUnit,
		required super.heartRate,
		required this.qrsinterval,
		required this.qrsIntervalUnit,
		required this.female
	}) : super();
	
	CorrectedQTScoreWideQRS.fromInterval({
		required super.qtinterval,
		required super.qtIntervalUnit,
		required super.rrinterval,
		required super.rrIntervalUnit,
		required this.qrsinterval,
		required this.qrsIntervalUnit,
		required this.female
	}) : super.fromInterval();
	
	/// Rautaharju in case of wide QRS
	/// 
	/// Rautaharju formula : QTc = QTm - 155 * (60/HR - 1) - 0.93 * (QRS - 139) + K
	/// 
	/// K = sex coefficient ; male = -22 ; female = -34
	@override
	int formula()
	{
		int sexcoefficient = this.female ? -34 : -22;
		return (Formulas.convertInMilliseconds(interval: this.qtinterval, unit: this.qtIntervalUnit) - 155 * (60 / this.heartRate - 1) - 0.93 * (Formulas.convertInMilliseconds(interval: this.qrsinterval, unit: this.qrsIntervalUnit) - 139) + sexcoefficient).round();
	}
}