import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/chadsvasc_score.dart';

part 'chadsvasc_event.dart';
part 'chadsvasc_state.dart';

class ChadsVascBloc extends Bloc<ChadsVascEvent, ChadsVascState>
{
	ChadsVascBloc() : super(const ChadsVascState())
	{
		on<HeartFailureToggled>(_mapHeartFailureToggledToState);
		on<HypertensionToggled>(_mapHypertensionToggledToState);
		on<AgeOver65Toggled>(_mapAgeOver65ToggledToState);
		on<DiabetesToggled>(_mapDiabetesToggledToState);
		on<StrokeToggled>(_mapStrokeToggledToState);
		on<VascularDiseaseToggled>(_mapVascularDiseaseToggledToState);
		on<AgeOver75Toggled>(_mapAgeOver75ToggledToState);
		on<FemaleSexToggled>(_mapFemaleSexToggledToState);
	}

	void _mapHeartFailureToggledToState(HeartFailureToggled event, Emitter<ChadsVascState> emit)
		=> emit(this.state.copyWith(heartFailure: event.heartFailure));

	void _mapHypertensionToggledToState(HypertensionToggled event, Emitter<ChadsVascState> emit)
		=> emit(this.state.copyWith(hypertension: event.hypertension));

	void _mapAgeOver65ToggledToState(AgeOver65Toggled event, Emitter<ChadsVascState> emit)
	{
		emit(this.state.copyWith(ageOver65: event.ageOver65));
		
		if(!this.state.ageOver65 && this.state.ageOver75)
			this.add(const AgeOver75Toggled(ageOver75: false));
	}

	void _mapDiabetesToggledToState(DiabetesToggled event, Emitter<ChadsVascState> emit)
		=> emit(this.state.copyWith(diabetes: event.diabetes));

	void _mapStrokeToggledToState(StrokeToggled event, Emitter<ChadsVascState> emit)
		=> emit(this.state.copyWith(stroke: event.stroke));

	void _mapVascularDiseaseToggledToState(VascularDiseaseToggled event, Emitter<ChadsVascState> emit)
		=> emit(this.state.copyWith(vascularDisease: event.vascularDisease));

	void _mapAgeOver75ToggledToState(AgeOver75Toggled event, Emitter<ChadsVascState> emit)
	{
		emit(this.state.copyWith(ageOver75: event.ageOver75));
		
		if(this.state.ageOver75 && !this.state.ageOver65)
			this.add(const AgeOver65Toggled(ageOver65: true));
	}
	
	void _mapFemaleSexToggledToState(FemaleSexToggled event, Emitter<ChadsVascState> emit)
		=> emit(this.state.copyWith(female: event.female));
}