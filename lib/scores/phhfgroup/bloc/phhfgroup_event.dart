part of 'phhfgroup_bloc.dart';

abstract class PhhfGroupEvent extends Equatable
{
	const PhhfGroupEvent();
	
	@override
	List<Object> get props => [];
}

class DiabetesToggled extends PhhfGroupEvent
{
	const DiabetesToggled({required this.diabetes});
	final bool diabetes;
	@override
	List<Object> get props => [diabetes];
}

class AtrialFibrillationToggled extends PhhfGroupEvent
{
	const AtrialFibrillationToggled({required this.atrialFibrillation});
	final bool atrialFibrillation;
	@override
	List<Object> get props => [atrialFibrillation];
}

class LvMassKnowledgeToggled extends PhhfGroupEvent
{
	const LvMassKnowledgeToggled({required this.lvmassIsKnown});
	final bool lvmassIsKnown;
	@override
	List<Object> get props => [lvmassIsKnown];
}

class LeftAtriumAreaChanged extends PhhfGroupEvent
{
	const LeftAtriumAreaChanged({required this.leftAtriumArea});
	final String leftAtriumArea;
	@override
	List<Object> get props => [leftAtriumArea];
}

class RightVentricleAreaChanged extends PhhfGroupEvent
{
	const RightVentricleAreaChanged({required this.rightVentricleArea});
	final String rightVentricleArea;
	@override
	List<Object> get props => [rightVentricleArea];
}

class LVMassChanged extends PhhfGroupEvent
{
	const LVMassChanged({required this.lvmass});
	final String lvmass;
	@override
	List<Object> get props => [lvmass];
}

class SeptumChanged extends PhhfGroupEvent
{
	const SeptumChanged({required this.septum});
	final String septum;
	@override
	List<Object> get props => [septum];
}

class LVDiamChanged extends PhhfGroupEvent
{
	const LVDiamChanged({required this.lvdiam});
	final String lvdiam;
	@override
	List<Object> get props => [lvdiam];
}

class LVWallChanged extends PhhfGroupEvent
{
	const LVWallChanged({required this.lvwall});
	final String lvwall;
	@override
	List<Object> get props => [lvwall];
}

class HeightChanged extends PhhfGroupEvent
{
	const HeightChanged({required this.height});
	final String height;
	@override
	List<Object> get props => [height];
}

class WeightChanged extends PhhfGroupEvent
{
	const WeightChanged({required this.weight});
	final String weight;
	@override
	List<Object> get props => [weight];
}