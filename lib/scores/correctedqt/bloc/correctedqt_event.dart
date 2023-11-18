part of 'correctedqt_bloc.dart';

abstract class CorrectedQTEvent extends Equatable
{
	const CorrectedQTEvent();
	
	@override
	List<Object> get props => [];
}

class QtIntervalChanged extends CorrectedQTEvent
{
	const QtIntervalChanged({required this.qtinterval});
	final String qtinterval;
	@override
	List<Object> get props => [qtinterval];
}

class QtIntervalUnitChanged extends CorrectedQTEvent
{
	const QtIntervalUnitChanged({required this.qtIntervalUnit});
	final IntervalUnit qtIntervalUnit;
	@override
	List<Object> get props => [qtIntervalUnit];
}

class CorrectionMethodChanged extends CorrectedQTEvent
{
	const CorrectionMethodChanged({required this.method});
	final CorrectionMethod method;
	@override
	List<Object> get props => [method];
}

class HeartRateChanged extends CorrectedQTEvent
{
	const HeartRateChanged({required this.heartRate});
	final String heartRate;
	@override
	List<Object> get props => [heartRate];
}

class RrIntervalChanged extends CorrectedQTEvent
{
	const RrIntervalChanged({required this.rrinterval});
	final String rrinterval;
	@override
	List<Object> get props => [rrinterval];
}

class RrIntervalUnitChanged extends CorrectedQTEvent
{
	const RrIntervalUnitChanged({required this.rrIntervalUnit});
	final IntervalUnit rrIntervalUnit;
	@override
	List<Object> get props => [rrIntervalUnit];
}

class WideQRSToggled extends CorrectedQTEvent
{
	const WideQRSToggled({required this.wideQRS});
	final bool wideQRS;
	@override
	List<Object> get props => [wideQRS];
}

class QrsIntervalChanged extends CorrectedQTEvent
{
	const QrsIntervalChanged({required this.qrsinterval});
	final String qrsinterval;
	@override
	List<Object> get props => [qrsinterval];
}

class FemaleToggled extends CorrectedQTEvent
{
	const FemaleToggled({required this.female});
	final bool female;
	@override
	List<Object> get props => [female];
}