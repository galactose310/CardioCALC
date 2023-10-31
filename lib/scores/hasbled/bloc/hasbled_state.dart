part of 'hasbled_bloc.dart';

class HasBledState extends Equatable
{
	final bool hypertension;
	final bool renalFailure;
	final bool hepaticFailure;
	final bool stroke;
	final bool bleeding;
	final bool labileINR;
	final bool ageOver65;
	final bool drugs;
	final bool alcohol;
	
	HasBledScore get score => new HasBledScore(
		hypertension: this.hypertension,
		renalFailure: this.renalFailure,
		hepaticFailure: this.hepaticFailure,
		stroke: this.stroke,
		bleeding: this.bleeding,
		labileINR: this.labileINR,
		ageOver65: this.ageOver65,
		drugs: this.drugs,
		alcohol: this.alcohol
	);
	
	const HasBledState({
		this.hypertension = false,
		this.renalFailure = false,
		this.hepaticFailure = false,
		this.stroke = false,
		this.bleeding = false,
		this.labileINR = false,
		this.ageOver65 = false,
		this.drugs = false,
		this.alcohol = false
	});
	
	@override
	List<Object?> get props =>
		[hypertension, renalFailure, hepaticFailure, stroke, bleeding, labileINR, ageOver65, drugs, alcohol];
	
	HasBledState copyWith({
		bool? hypertension,
		bool? renalFailure,
		bool? hepaticFailure,
		bool? stroke,
		bool? bleeding,
		bool? labileINR,
		bool? ageOver65,
		bool? drugs,
		bool? alcohol
	})
	{
		return HasBledState(
			hypertension: hypertension ?? this.hypertension,
			renalFailure: renalFailure ?? this.renalFailure,
			hepaticFailure: hepaticFailure ?? this.hepaticFailure,
			stroke: stroke ?? this.stroke,
			bleeding: bleeding ?? this.bleeding,
			labileINR: labileINR ?? this.labileINR,
			ageOver65: ageOver65 ?? this.ageOver65,
			drugs: drugs ?? this.drugs,
			alcohol: alcohol ?? this.alcohol
		);
	}
}