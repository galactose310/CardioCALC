import 'package:cardiocalc/models/formulas.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/correctedqt_score.dart';

part 'correctedqt_event.dart';
part 'correctedqt_state.dart';

class CorrectedQTBloc extends Bloc<CorrectedQTEvent, CorrectedQTState>
{
	CorrectedQTBloc() : super(const CorrectedQTState())
	{
		on<QtIntervalChanged>(_mapQtIntervalChangedToState);
		on<QtIntervalUnitChanged>(_mapQtIntervalUnitChangedToState);
		on<CorrectionMethodChanged>(_mapCorrectionMethodChangedToState);
		on<HeartRateChanged>(_mapHeartRateChangedToState);
		on<RrIntervalChanged>(_mapRrIntervalChangedToState);
		on<RrIntervalUnitChanged>(_mapRrIntervalUnitChangedToState);
		on<WideQRSToggled>(_mapWideQRSToggledToState);
		on<QrsIntervalChanged>(_mapQrsIntervalChangedToState);
		on<QrsIntervalUnitChanged>(_mapQrsIntervalUnitChangedToState);
		on<FemaleToggled>(_mapFemaleToggledToState);
	}
	
	void _mapQtIntervalChangedToState(QtIntervalChanged event, Emitter<CorrectedQTState> emit)
	{
		int? qtinterval = int.tryParse(event.qtinterval);
		emit(this.state.copyWith(qtinterval: qtinterval, updateQtInterval: true));
	}
	
	void _mapQtIntervalUnitChangedToState(QtIntervalUnitChanged event, Emitter<CorrectedQTState> emit)
		=> emit(this.state.copyWith(qtIntervalUnit: event.qtIntervalUnit));
	
	void _mapCorrectionMethodChangedToState(CorrectionMethodChanged event, Emitter<CorrectedQTState> emit)
		=> emit(this.state.copyWith(method: event.method));
	
	void _mapHeartRateChangedToState(HeartRateChanged event, Emitter<CorrectedQTState> emit)
	{
		int? heartRate = int.tryParse(event.heartRate);
		emit(this.state.copyWith(heartRate: heartRate, updateHeartRate: true));
	}
	
	void _mapRrIntervalChangedToState(RrIntervalChanged event, Emitter<CorrectedQTState> emit)
	{
		int? rrinterval = int.tryParse(event.rrinterval);
		emit(this.state.copyWith(rrinterval: rrinterval, updateRrInterval: true));
	}
	
	void _mapRrIntervalUnitChangedToState(RrIntervalUnitChanged event, Emitter<CorrectedQTState> emit)
		=> emit(this.state.copyWith(rrIntervalUnit: event.rrIntervalUnit));
	
	void _mapWideQRSToggledToState(WideQRSToggled event, Emitter<CorrectedQTState> emit)
		=> emit(this.state.copyWith(wideQRS: event.wideQRS));
	
	void _mapQrsIntervalChangedToState(QrsIntervalChanged event, Emitter<CorrectedQTState> emit)
	{
		int? qrsinterval = int.tryParse(event.qrsinterval);
		emit(this.state.copyWith(qrsinterval: qrsinterval, updateQrsInterval: true));
	}
	
	void _mapQrsIntervalUnitChangedToState(QrsIntervalUnitChanged event, Emitter<CorrectedQTState> emit)
		=> emit(this.state.copyWith(qrsIntervalUnit: event.qrsIntervalUnit));
	
	void _mapFemaleToggledToState(FemaleToggled event, Emitter<CorrectedQTState> emit)
		=> emit(this.state.copyWith(female: event.female));
}