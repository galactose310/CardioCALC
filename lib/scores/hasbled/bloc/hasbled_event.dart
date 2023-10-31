part of 'hasbled_bloc.dart';

abstract class HasBledEvent extends Equatable
{
	const HasBledEvent();
	
	@override
	List<Object> get props => [];
}

class HypertensionToggled extends HasBledEvent
{
	const HypertensionToggled({required this.hypertension});
	final bool hypertension;
	@override
	List<Object> get props => [hypertension];
}

class RenalFailureToggled extends HasBledEvent
{
	const RenalFailureToggled({required this.renalFailure});
	final bool renalFailure;
	@override
	List<Object> get props => [renalFailure];
}

class HepaticFailureToggled extends HasBledEvent
{
	const HepaticFailureToggled({required this.hepaticFailure});
	final bool hepaticFailure;
	@override
	List<Object> get props => [hepaticFailure];
}

class StrokeToggled extends HasBledEvent
{
	const StrokeToggled({required this.stroke});
	final bool stroke;
	@override
	List<Object> get props => [stroke];
}

class BleedingToggled extends HasBledEvent
{
	const BleedingToggled({required this.bleeding});
	final bool bleeding;
	@override
	List<Object> get props => [bleeding];
}
class LabileInrToggled extends HasBledEvent
{
	const LabileInrToggled({required this.labileINR});
	final bool labileINR;
	@override
	List<Object> get props => [labileINR];
}

class AgeOver65Toggled extends HasBledEvent
{
	const AgeOver65Toggled({required this.ageOver65});
	final bool ageOver65;
	@override
	List<Object> get props => [ageOver65];
}

class DrugsToggled extends HasBledEvent
{
	const DrugsToggled({required this.drugs});
	final bool drugs;
	@override
	List<Object> get props => [drugs];
}

class AlcoholToggled extends HasBledEvent
{
	const AlcoholToggled({required this.alcohol});
	final bool alcohol;
	@override
	List<Object> get props => [alcohol];
}