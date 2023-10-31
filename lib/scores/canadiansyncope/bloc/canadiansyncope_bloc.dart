import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/canadiansyncope_score.dart';

part 'canadiansyncope_event.dart';
part 'canadiansyncope_state.dart';

class CanadianSyncopeBloc extends Bloc<CanadianSyncopeEvent, CanadianSyncopeState>
{
	CanadianSyncopeBloc() : super(CanadianSyncopeState())
	{
		on<VagalPredispositionToggled>(_mapVagalPredispositionEventToState);
		on<CardiacHistoryToggled>(_mapCardiacHistoryEventToState);
		on<AbnormalBPToggled>(_mapAbnormalBPEventToState);
		on<TroponinToggled>(_mapTroponinEventToState);
		on<AbnormalAxisToggled>(_mapAbnormalAxisEventToState);
		on<LargeQRSToggled>(_mapLargeQRSEventToState);
		on<LongQTToggled>(_mapLongQTEventToState);
		on<DiagnosisToggled>(_mapDiagnosisEventToState);
	}
	
	void _mapVagalPredispositionEventToState(VagalPredispositionToggled event, Emitter<CanadianSyncopeState> emit)
		=> emit(this.state.copyWith(vagalPredisposition: event.vagalPredisposition));
		
	void _mapCardiacHistoryEventToState(CardiacHistoryToggled event, Emitter<CanadianSyncopeState> emit)
		=> emit(this.state.copyWith(cardiacHistory: event.cardiacHistory));
	
	void _mapAbnormalBPEventToState(AbnormalBPToggled event, Emitter<CanadianSyncopeState> emit)
		=> emit(this.state.copyWith(abnormalBP: event.abnormalBP));
	
	void _mapTroponinEventToState(TroponinToggled event, Emitter<CanadianSyncopeState> emit)
		=> emit(this.state.copyWith(troponin: event.troponin));
	
	void _mapAbnormalAxisEventToState(AbnormalAxisToggled event, Emitter<CanadianSyncopeState> emit)
		=> emit(this.state.copyWith(abnormalAxis: event.abnormalAxis));
	
	void _mapLargeQRSEventToState(LargeQRSToggled event, Emitter<CanadianSyncopeState> emit)
		=> emit(this.state.copyWith(largeQRS: event.largeQRS));
	
	void _mapLongQTEventToState(LongQTToggled event, Emitter<CanadianSyncopeState> emit)
		=> emit(this.state.copyWith(longQT: event.longQT));
	
	void _mapDiagnosisEventToState(DiagnosisToggled event, Emitter<CanadianSyncopeState> emit)
		=> emit(this.state.copyWith(diagnosis: event.diagnosis));
}