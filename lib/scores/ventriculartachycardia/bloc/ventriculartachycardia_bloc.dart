import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/ventriculartachycardia_score.dart';

part 'ventriculartachycardia_event.dart';
part 'ventriculartachycardia_state.dart';

class VentricularTachycardiaBloc extends Bloc<VentricularTachycardiaEvent, VentricularTachycardiaState>
{
	VentricularTachycardiaBloc() : super(const VentricularTachycardiaState())
	{
		on<YourEvent>(_mapYourEventToState);
	}
	
	void _mapYourEventToState(YourEvent event, Emitter<VentricularTachycardiaState> emit)
		=> emit(this.state.copyWith(var1: event.var1));
}