part of 'chadsvasc_bloc.dart';

class ChadsVascState extends Equatable
{
	final bool heartFailure;
	final bool hypertension;
	final bool ageOver65;
	final bool diabetes;
	final bool stroke;
	final bool vascularDisease;
	final bool ageOver75;
	final bool female;
	
	ChadsVascScore get score => new ChadsVascScore(
		heartFailure: this.heartFailure,
		hypertension: this.hypertension,
		ageOver65: this.ageOver65,
		diabetes: this.diabetes,
		stroke: this.stroke,
		vascularDisease: this.vascularDisease,
		ageOver75: this.ageOver75,
		female: this.female
	);
	
	const ChadsVascState({
		this.heartFailure = false,
		this.hypertension = false,
		this.ageOver65 = false,
		this.diabetes = false,
		this.stroke = false,
		this.vascularDisease = false,
		this.ageOver75 = false,
		this.female = false
	});
	
	@override
	List<Object?> get props =>
		[heartFailure, hypertension, ageOver65, diabetes, stroke, vascularDisease, ageOver75, female];
	
	ChadsVascState copyWith({
		bool? heartFailure,
		bool? hypertension,
		bool? ageOver65,
		bool? diabetes,
		bool? stroke,
		bool? vascularDisease,
		bool? ageOver75,
		bool? female,
	})
	{
		return ChadsVascState(
			heartFailure: heartFailure ?? this.heartFailure,
			hypertension: hypertension ?? this.hypertension,
			ageOver65: ageOver65 ?? this.ageOver65,
			diabetes: diabetes ?? this.diabetes,
			stroke: stroke ?? this.stroke,
			vascularDisease: vascularDisease ?? this.vascularDisease,
			ageOver75: ageOver75 ?? this.ageOver75,
			female: female ?? this.female
		);
	}
}