part of 'hcmriskscd_bloc.dart';

class HcmRiskScdState extends Equatable
{
	final int age;
	final int lvThickness;
	final int ladiam;
	final int lvGradient;
	final bool familySuddenDeath;
	final bool nsvt;
	final bool syncope;
	
	HcmRiskScdScore get score => new HcmRiskScdScore(
		age: this.age,
		lvThickness: this.lvThickness,
		ladiam: this.ladiam,
		lvGradient: this.lvGradient,
		familySuddenDeath: this.familySuddenDeath,
		nsvt: this.nsvt,
		syncope: this.syncope
	);
	
	const HcmRiskScdState({
		this.age = HcmRiskScdScore.MIN_AGE,
		this.lvThickness = HcmRiskScdScore.MIN_LV_THICKNESS,
		this.ladiam = HcmRiskScdScore.MIN_LA_DIAM,
		this.lvGradient = HcmRiskScdScore.MIN_LV_GRADIENT,
		this.familySuddenDeath = false,
		this.nsvt = false,
		this.syncope = false
	});
	
	@override
	List<Object?> get props =>
		[age, lvThickness, ladiam, lvGradient, familySuddenDeath, nsvt, syncope];
	
	HcmRiskScdState copyWith({
		int? age,
		int? lvThickness,
		int? ladiam,
		int? lvGradient,
		bool? familySuddenDeath,
		bool? nsvt,
		bool? syncope
	})
	{
		return HcmRiskScdState(
			age: age ?? this.age,
			lvThickness: lvThickness ?? this.lvThickness,
			ladiam: ladiam ?? this.ladiam,
			lvGradient: lvGradient ?? this.lvGradient,
			familySuddenDeath: familySuddenDeath ?? this.familySuddenDeath,
			nsvt: nsvt ?? this.nsvt,
			syncope: syncope ?? this.syncope
		);
	}
}