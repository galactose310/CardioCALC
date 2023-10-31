import 'package:cardiocalc/models/formulas.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/phhfgroup_interpretation.dart';
import '../model/phhfgroup_score.dart';

part 'phhfgroup_event.dart';
part 'phhfgroup_state.dart';

class PhhfGroupBloc extends Bloc<PhhfGroupEvent, PhhfGroupState>
{
	PhhfGroupBloc({bool? lvMassIsKnown})
	: super(PhhfGroupState(lvmassIsKnown: lvMassIsKnown ?? true))
	{
		on<DiabetesToggled>(_mapDiabetesEventToState);
		on<AtrialFibrillationToggled>(_mapAtrialFibrillationEventToState);
		on<LvMassKnowledgeToggled>(_mapLvMassKnowledgeEventToState);
		on<LeftAtriumAreaChanged>(_mapLeftAtriumAreaEventToState);
		on<RightVentricleAreaChanged>(_mapRightVentricleAreaEventToState);
		on<LVMassChanged>(_mapLVMassEventToState);
		on<SeptumChanged>(_mapSeptumEventToState);
		on<LVDiamChanged>(_mapLVDiamEventToState);
		on<LVWallChanged>(_mapLVWallEventToState);
		on<HeightChanged>(_mapHeightEventToState);
		on<WeightChanged>(_mapWeightEventToState);
	}
	
	void _mapDiabetesEventToState(DiabetesToggled event, Emitter<PhhfGroupState> emit)
		=> emit(this.state.copyWith(diabetes: event.diabetes));
	
	void _mapAtrialFibrillationEventToState(AtrialFibrillationToggled event, Emitter<PhhfGroupState> emit)
		=> emit(this.state.copyWith(atrialFibrillation: event.atrialFibrillation));
	
	void _mapLvMassKnowledgeEventToState(LvMassKnowledgeToggled event, Emitter<PhhfGroupState> emit)
		=> emit(this.state.copyWith(lvmassIsKnown: event.lvmassIsKnown));
	
	void _mapLeftAtriumAreaEventToState(LeftAtriumAreaChanged event, Emitter<PhhfGroupState> emit)
	{
		double? leftAtriumArea = double.tryParse(event.leftAtriumArea);
		emit(this.state.copyWith(leftAtriumArea: leftAtriumArea, updateLeftAtriumArea: true));
	}
	
	void _mapRightVentricleAreaEventToState(RightVentricleAreaChanged event, Emitter<PhhfGroupState> emit)
	{
		double? rightVentricleArea = double.tryParse(event.rightVentricleArea);
		emit(this.state.copyWith(rightVentricleArea: rightVentricleArea, updateRightVentricleArea: true));
	}
	
	void _mapLVMassEventToState(LVMassChanged event, Emitter<PhhfGroupState> emit)
	{
		double? lvmass = double.tryParse(event.lvmass);
		emit(this.state.copyWith(lvmass: lvmass, updateLvmass: true));
	}
	
	void _mapSeptumEventToState(SeptumChanged event, Emitter<PhhfGroupState> emit)
	{
		double? septum = double.tryParse(event.septum);
		emit(this.state.copyWith(septum: septum, updateSeptum: true));
	}
	
	void _mapLVDiamEventToState(LVDiamChanged event, Emitter<PhhfGroupState> emit)
	{
		double? lvdiam = double.tryParse(event.lvdiam);
		emit(this.state.copyWith(lvdiam: lvdiam, updateLvdiam: true));
	}
	
	void _mapLVWallEventToState(LVWallChanged event, Emitter<PhhfGroupState> emit)
	{
		double? lvwall = double.tryParse(event.lvwall);
		emit(this.state.copyWith(lvwall: lvwall, updateLvwall: true));
	}
	
	void _mapHeightEventToState(HeightChanged event, Emitter<PhhfGroupState> emit)
	{
		double? height = double.tryParse(event.height);
		emit(this.state.copyWith(height: height, updateHeight: true));
	}
	
	void _mapWeightEventToState(WeightChanged event, Emitter<PhhfGroupState> emit)
	{
		double? weight = double.tryParse(event.weight);
		emit(this.state.copyWith(weight: weight, updateWeight: true));
	}
}