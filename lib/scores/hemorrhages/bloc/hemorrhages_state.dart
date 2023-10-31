part of 'hemorrhages_bloc.dart';

class HemorrhagesState extends Equatable
{
	final bool renalOrLiver;
	final bool alcohol;
	final bool cancer;
	final bool ageOver75;
	final bool thrombopenia;
	final bool bleeding;
	final bool hypertension;
	final bool anemia;
	final bool genetics;
	final bool fallrisk;
	final bool stroke;
	
	HemorrhagesScore get score => new HemorrhagesScore(
		renalOrLiver: this.renalOrLiver,
		alcohol: this.alcohol,
		cancer: this.cancer,
		ageOver75: this.ageOver75,
		thrombopenia: this.thrombopenia,
		bleeding: this.bleeding,
		hypertension: this.hypertension,
		anemia: this.anemia,
		genetics: this.genetics,
		fallrisk: this.fallrisk,
		stroke: this.stroke
	);
	
	const HemorrhagesState({
		this.renalOrLiver = false,
		this.alcohol = false,
		this.cancer = false,
		this.ageOver75 = false,
		this.thrombopenia = false,
		this.bleeding = false,
		this.hypertension = false,
		this.anemia = false,
		this.genetics = false,
		this.fallrisk = false,
		this.stroke = false,
	});
	
	@override
	List<Object?> get props =>
		[renalOrLiver, alcohol, cancer, ageOver75, thrombopenia, bleeding, hypertension, anemia, genetics, fallrisk, stroke];
	
	HemorrhagesState copyWith({
		bool? renalOrLiver,
		bool? alcohol,
		bool? cancer,
		bool? ageOver75,
		bool? thrombopenia,
		bool? bleeding,
		bool? hypertension,
		bool? anemia,
		bool? genetics,
		bool? fallrisk,
		bool? stroke
	})
	{
		return HemorrhagesState(
			renalOrLiver: renalOrLiver ?? this.renalOrLiver,
			alcohol: alcohol ?? this.alcohol,
			cancer: cancer ?? this.cancer,
			ageOver75: ageOver75 ?? this.ageOver75,
			thrombopenia: thrombopenia ?? this.thrombopenia,
			bleeding: bleeding ?? this.bleeding,
			hypertension: hypertension ?? this.hypertension,
			anemia: anemia ?? this.anemia,
			genetics: genetics ?? this.genetics,
			fallrisk: fallrisk ?? this.fallrisk,
			stroke: stroke ?? this.stroke
		);
	}
}