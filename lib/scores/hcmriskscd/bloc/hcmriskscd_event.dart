part of 'hcmriskscd_bloc.dart';

abstract class HcmRiskScdEvent extends Equatable
{
	const HcmRiskScdEvent();
	
	@override
	List<Object> get props => [];
}

class AgeChanged extends HcmRiskScdEvent
{
	const AgeChanged({required this.age});
	final int age;
	@override
	List<Object> get props => [age];
}

class LvThicknessChanged extends HcmRiskScdEvent
{
	const LvThicknessChanged({required this.lvThickness});
	final int lvThickness;
	@override
	List<Object> get props => [lvThickness];
}

class LaDiamChanged extends HcmRiskScdEvent
{
	const LaDiamChanged({required this.ladiam});
	final int ladiam;
	@override
	List<Object> get props => [ladiam];
}

class LvGradientChanged extends HcmRiskScdEvent
{
	const LvGradientChanged({required this.lvGradient});
	final int lvGradient;
	@override
	List<Object> get props => [lvGradient];
}

class FamilySuddenDeathToggled extends HcmRiskScdEvent
{
	const FamilySuddenDeathToggled({required this.familySuddenDeath});
	final bool familySuddenDeath;
	@override
	List<Object> get props => [familySuddenDeath];
}

class NSVTToggled extends HcmRiskScdEvent
{
	const NSVTToggled({required this.nsvt});
	final bool nsvt;
	@override
	List<Object> get props => [nsvt];
}

class SyncopeToggled extends HcmRiskScdEvent
{
	const SyncopeToggled({required this.syncope});
	final bool syncope;
	@override
	List<Object> get props => [syncope];
}