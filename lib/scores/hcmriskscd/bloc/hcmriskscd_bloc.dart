import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/hcmriskscd_score.dart';

part 'hcmriskscd_event.dart';
part 'hcmriskscd_state.dart';

class HcmRiskScdBloc extends Bloc<HcmRiskScdEvent, HcmRiskScdState>
{
	HcmRiskScdBloc() : super(const HcmRiskScdState())
	{
		on<AgeChanged>(_mapAgeChangedToState);
		on<LvThicknessChanged>(_mapLvThicknessChangedToState);
		on<LaDiamChanged>(_mapLaDiamChangedToState);
		on<LvGradientChanged>(_mapLvGradientChangedToState);
		on<FamilySuddenDeathToggled>(_mapFamilySuddenDeathToggledToState);
		on<NSVTToggled>(_mapNSVTToggledToState);
		on<SyncopeToggled>(_mapSyncopeToggledToState);
	}
	
	void _mapAgeChangedToState(AgeChanged event, Emitter<HcmRiskScdState> emit)
		=> emit(this.state.copyWith(age: event.age));

	void _mapLvThicknessChangedToState(LvThicknessChanged event, Emitter<HcmRiskScdState> emit)
		=> emit(this.state.copyWith(lvThickness: event.lvThickness));

	void _mapLaDiamChangedToState(LaDiamChanged event, Emitter<HcmRiskScdState> emit)
		=> emit(this.state.copyWith(ladiam: event.ladiam));

	void _mapLvGradientChangedToState(LvGradientChanged event, Emitter<HcmRiskScdState> emit)
		=> emit(this.state.copyWith(lvGradient: event.lvGradient));

	void _mapFamilySuddenDeathToggledToState(FamilySuddenDeathToggled event, Emitter<HcmRiskScdState> emit)
		=> emit(this.state.copyWith(familySuddenDeath: event.familySuddenDeath));

	void _mapNSVTToggledToState(NSVTToggled event, Emitter<HcmRiskScdState> emit)
		=> emit(this.state.copyWith(nsvt: event.nsvt));

	void _mapSyncopeToggledToState(SyncopeToggled event, Emitter<HcmRiskScdState> emit)
		=> emit(this.state.copyWith(syncope: event.syncope));
}