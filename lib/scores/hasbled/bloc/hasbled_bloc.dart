import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/hasbled_score.dart';

part 'hasbled_event.dart';
part 'hasbled_state.dart';

class HasBledBloc extends Bloc<HasBledEvent, HasBledState>
{
	HasBledBloc() : super(const HasBledState())
	{
		on<HypertensionToggled>(_mapHypertensionToggledToState);
		on<RenalFailureToggled>(_mapRenalFailureToggledToState);
		on<HepaticFailureToggled>(_mapHepaticFailureToggledToState);
		on<StrokeToggled>(_mapStrokeToggledToState);
		on<BleedingToggled>(_mapBleedingToggledToState);
		on<LabileInrToggled>(_mapLabileInrToggledToState);
		on<AgeOver65Toggled>(_mapAgeOver65ToggledToState);
		on<DrugsToggled>(_mapDrugsToggledToState);
		on<AlcoholToggled>(_mapAlcoholToggledToState);
	}
	
	void _mapHypertensionToggledToState(HypertensionToggled event, Emitter<HasBledState> emit)
		=> emit(this.state.copyWith(hypertension: event.hypertension));

	void _mapRenalFailureToggledToState(RenalFailureToggled event, Emitter<HasBledState> emit)
		=> emit(this.state.copyWith(renalFailure: event.renalFailure));

	void _mapHepaticFailureToggledToState(HepaticFailureToggled event, Emitter<HasBledState> emit)
		=> emit(this.state.copyWith(hepaticFailure: event.hepaticFailure));

	void _mapStrokeToggledToState(StrokeToggled event, Emitter<HasBledState> emit)
		=> emit(this.state.copyWith(stroke: event.stroke));

	void _mapBleedingToggledToState(BleedingToggled event, Emitter<HasBledState> emit)
		=> emit(this.state.copyWith(bleeding: event.bleeding));

	void _mapLabileInrToggledToState(LabileInrToggled event, Emitter<HasBledState> emit)
		=> emit(this.state.copyWith(labileINR: event.labileINR));

	void _mapAgeOver65ToggledToState(AgeOver65Toggled event, Emitter<HasBledState> emit)
		=> emit(this.state.copyWith(ageOver65: event.ageOver65));

	void _mapDrugsToggledToState(DrugsToggled event, Emitter<HasBledState> emit)
		=> emit(this.state.copyWith(drugs: event.drugs));

	void _mapAlcoholToggledToState(AlcoholToggled event, Emitter<HasBledState> emit)
		=> emit(this.state.copyWith(alcohol: event.alcohol));
}