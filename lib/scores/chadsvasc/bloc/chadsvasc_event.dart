part of 'chadsvasc_bloc.dart';

abstract class ChadsVascEvent extends Equatable
{
	const ChadsVascEvent();
	
	@override
	List<Object> get props => [];
}

class HeartFailureToggled extends ChadsVascEvent
{
	const HeartFailureToggled({required this.heartFailure});
	final bool heartFailure;
	@override
	List<Object> get props => [heartFailure];
}

class HypertensionToggled extends ChadsVascEvent
{
	const HypertensionToggled({required this.hypertension});
	final bool hypertension;
	@override
	List<Object> get props => [hypertension];
}

class AgeOver65Toggled extends ChadsVascEvent
{
	const AgeOver65Toggled({required this.ageOver65});
	final bool ageOver65;
	@override
	List<Object> get props => [ageOver65];
}

class DiabetesToggled extends ChadsVascEvent
{
	const DiabetesToggled({required this.diabetes});
	final bool diabetes;
	@override
	List<Object> get props => [diabetes];
}

class StrokeToggled extends ChadsVascEvent
{
	const StrokeToggled({required this.stroke});
	final bool stroke;
	@override
	List<Object> get props => [stroke];
}

class VascularDiseaseToggled extends ChadsVascEvent
{
	const VascularDiseaseToggled({required this.vascularDisease});
	final bool vascularDisease;
	@override
	List<Object> get props => [vascularDisease];
}

class AgeOver75Toggled extends ChadsVascEvent
{
	const AgeOver75Toggled({required this.ageOver75});
	final bool ageOver75;
	@override
	List<Object> get props => [ageOver75];
}

class FemaleSexToggled extends ChadsVascEvent
{
	const FemaleSexToggled({required this.female});
	final bool female;
	@override
	List<Object> get props => [female];
}