// ignore_for_file: prefer_initializing_formals

import 'package:cardiocalc/models/formulas.dart';

class CorrectedQTScore
{
	final int qtinterval;
	final IntervalUnit qtIntervalUnit;
	
	late final int heartRate;
	late final int rrinterval;
	late final IntervalUnit rrIntervalUnit;
	
	late final int? qrsinterval;
	late final bool? female;
	
	late final int result;
	
	CorrectedQTScore.fromInterval({
		required this.qtinterval,
		required this.qtIntervalUnit,
		required this.rrinterval,
		required this.rrIntervalUnit
	})
	{
		this.qrsinterval = null; this.female = null; // Unnecessary with narrow QRS
		this.heartRate = this.heartRateFromInterval();
		
		this.result = this.framingham();
	}
	
	CorrectedQTScore.fromHeartRate({
		required this.qtinterval,
		required this.qtIntervalUnit,
		required this.heartRate
	})
	{
		this.qrsinterval = null; this.female = null; // Unnecessary with narrow QRS
		this.rrIntervalUnit = this.qtIntervalUnit;
		this.rrinterval = this.intervalFromHeartRate();
		
		this.result = this.framingham();
	}
	
	CorrectedQTScore.fromIntervalWideQrs({
		required this.qtinterval,
		required this.qtIntervalUnit,
		required this.rrinterval,
		required this.rrIntervalUnit,
		required int qrsinterval,
		required bool female
	})
	{
		this.qrsinterval = qrsinterval;
		this.female = female;
		
		this.heartRate = this.heartRateFromInterval();
		
		this.result = this.rautaharju();
	}
	
	CorrectedQTScore.fromHeartRateWideQrs({
		required this.qtinterval,
		required this.qtIntervalUnit,
		required this.heartRate,
		required int qrsinterval,
		required bool female
	})
	{
		this.qrsinterval = qrsinterval;
		this.female = female;
		
		this.rrIntervalUnit = this.qtIntervalUnit;
		this.rrinterval = this.intervalFromHeartRate();
		
		this.result = this.rautaharju();
	}
	
	int framingham()
	{
		// Framingham in case of narrow QRS
		// Framingham formula : QTc = QTm + 0,154 * [1-RR].
		
		return 	(Formulas.convertInMilliseconds(interval: this.qtinterval, unit: this.qtIntervalUnit) +
				(0.154 * (1 - Formulas.convertInMilliseconds(interval: this.rrinterval, unit: this.rrIntervalUnit)))).round();
	}
	
	int rautaharju()
	{
		// Rautaharju in case of wide QRS
		// Rautaharju formula : QTc = QTm - 155 * (60/HR - 1) - 0.93 * (QRS - 139) + K
		// K = sex coefficient ; male = -22 ; female = -34
		
		int sexcoefficient = this.female! ? -34 : -22;
		return (this.qtinterval - 155 * (60 / this.heartRate - 1) - 0.93 * (this.qrsinterval! - 139) + sexcoefficient).round();
	}
	
	int heartRateFromInterval()
	{
		return Formulas.millisecondsToBpm(
			interval: Formulas.convertInMilliseconds(
				interval: this.rrinterval,
				unit: this.rrIntervalUnit
			)
		);
	}
	
	int intervalFromHeartRate()
	{
		return Formulas.bpmToMilliseconds(heartrate: this.heartRate);
	}
}