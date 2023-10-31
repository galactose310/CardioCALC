import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/hemorrhages_score.dart';

part 'hemorrhages_event.dart';
part 'hemorrhages_state.dart';

class HemorrhagesBloc extends Bloc<HemorrhagesEvent, HemorrhagesState>
{
	HemorrhagesBloc() : super(HemorrhagesState())
	{
		on<RenalOrLiverToggled>(_mapRenalOrLiverToggledToState);
		on<AlcoholToggled>(_mapAlcoholToggledToState);
		on<CancerToggled>(_mapCancerToggledToState);
		on<AgeOver75Toggled>(_mapAgeOver75ToggledToState);
		on<ThrombopeniaToggled>(_mapThrombopeniaToggledToState);
		on<BleedingToggled>(_mapBleedingToggledToState);
		on<HypertensionToggled>(_mapHypertensionToggledToState);
		on<AnemiaToggled>(_mapAnemiaToggledToState);
		on<GeneticsToggled>(_mapGeneticsToggledToState);
		on<FallRiskToggled>(_mapFallRiskToggledToState);
		on<StrokeToggled>(_mapStrokeToggledToState);
	}
	
	void _mapRenalOrLiverToggledToState(RenalOrLiverToggled event, Emitter<HemorrhagesState> emit)
		=> emit(this.state.copyWith(renalOrLiver: event.renalOrLiver));

	void _mapAlcoholToggledToState(AlcoholToggled event, Emitter<HemorrhagesState> emit)
		=> emit(this.state.copyWith(alcohol: event.alcohol));

	void _mapCancerToggledToState(CancerToggled event, Emitter<HemorrhagesState> emit)
		=> emit(this.state.copyWith(cancer: event.cancer));

	void _mapAgeOver75ToggledToState(AgeOver75Toggled event, Emitter<HemorrhagesState> emit)
		=> emit(this.state.copyWith(ageOver75: event.ageOver75));

	void _mapThrombopeniaToggledToState(ThrombopeniaToggled event, Emitter<HemorrhagesState> emit)
		=> emit(this.state.copyWith(thrombopenia: event.thrombopenia));

	void _mapBleedingToggledToState(BleedingToggled event, Emitter<HemorrhagesState> emit)
		=> emit(this.state.copyWith(bleeding: event.bleeding));

	void _mapHypertensionToggledToState(HypertensionToggled event, Emitter<HemorrhagesState> emit)
		=> emit(this.state.copyWith(hypertension: event.hypertension));

	void _mapAnemiaToggledToState(AnemiaToggled event, Emitter<HemorrhagesState> emit)
		=> emit(this.state.copyWith(anemia: event.anemia));

	void _mapGeneticsToggledToState(GeneticsToggled event, Emitter<HemorrhagesState> emit)
		=> emit(this.state.copyWith(genetics: event.genetics));

	void _mapFallRiskToggledToState(FallRiskToggled event, Emitter<HemorrhagesState> emit)
		=> emit(this.state.copyWith(fallrisk: event.fallrisk));

	void _mapStrokeToggledToState(StrokeToggled event, Emitter<HemorrhagesState> emit)
		=> emit(this.state.copyWith(stroke: event.stroke));
}