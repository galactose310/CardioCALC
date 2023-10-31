part of 'hemorrhages_bloc.dart';

abstract class HemorrhagesEvent extends Equatable
{
	const HemorrhagesEvent();
	
	@override
	List<Object> get props => [];
}

class RenalOrLiverToggled extends HemorrhagesEvent
{
	const RenalOrLiverToggled({required this.renalOrLiver});
	final bool renalOrLiver;
	@override
	List<Object> get props => [renalOrLiver];
}

class AlcoholToggled extends HemorrhagesEvent
{
	const AlcoholToggled({required this.alcohol});
	final bool alcohol;
	@override
	List<Object> get props => [alcohol];
}

class CancerToggled extends HemorrhagesEvent
{
	const CancerToggled({required this.cancer});
	final bool cancer;
	@override
	List<Object> get props => [cancer];
}

class AgeOver75Toggled extends HemorrhagesEvent
{
	const AgeOver75Toggled({required this.ageOver75});
	final bool ageOver75;
	@override
	List<Object> get props => [ageOver75];
}

class ThrombopeniaToggled extends HemorrhagesEvent
{
	const ThrombopeniaToggled({required this.thrombopenia});
	final bool thrombopenia;
	@override
	List<Object> get props => [thrombopenia];
}

class BleedingToggled extends HemorrhagesEvent
{
	const BleedingToggled({required this.bleeding});
	final bool bleeding;
	@override
	List<Object> get props => [bleeding];
}

class HypertensionToggled extends HemorrhagesEvent
{
	const HypertensionToggled({required this.hypertension});
	final bool hypertension;
	@override
	List<Object> get props => [hypertension];
}

class AnemiaToggled extends HemorrhagesEvent
{
	const AnemiaToggled({required this.anemia});
	final bool anemia;
	@override
	List<Object> get props => [anemia];
}

class GeneticsToggled extends HemorrhagesEvent
{
	const GeneticsToggled({required this.genetics});
	final bool genetics;
	@override
	List<Object> get props => [genetics];
}

class FallRiskToggled extends HemorrhagesEvent
{
	const FallRiskToggled({required this.fallrisk});
	final bool fallrisk;
	@override
	List<Object> get props => [fallrisk];
}

class StrokeToggled extends HemorrhagesEvent
{
	const StrokeToggled({required this.stroke});
	final bool stroke;
	@override
	List<Object> get props => [stroke];
}