part of 'ventriculartachycardia_bloc.dart';

class VentricularTachycardiaState extends Equatable
{
	final bool var1;
	
	VentricularTachycardiaScore get score => new VentricularTachycardiaScore(
		var1: this.var1
	);
	
	const VentricularTachycardiaState({
		this.var1 = false
	});
	
	@override
	List<Object?> get props =>
		[var1];
	
	VentricularTachycardiaState copyWith({
		bool? var1,
		// exemple if value from TextField
		//double? var2,
		//bool updateVar2 = false,
	})
	{
		return VentricularTachycardiaState(
			var1: var1 ?? this.var1,
			//var2: updateVar2 ? var2 : this.var2,
		);
	}
}