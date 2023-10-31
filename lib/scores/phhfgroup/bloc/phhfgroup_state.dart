part of 'phhfgroup_bloc.dart';

class PhhfGroupState extends Equatable
{
	final bool diabetes, atrialFibrillation, lvmassIsKnown;
	
	final double? leftAtriumArea, rightVentricleArea, septum, lvdiam, lvwall, height, weight, lvmass;
	
	late final int? _result;
	int? get result => this.isValid ? this._result : null;
	
	bool get isValid
	{
		if(this.leftAtriumArea == null || this.rightVentricleArea == null) return false;
		if(this.lvmassIsKnown && this.lvmass == null) return false;
		if(!this.lvmassIsKnown && (septum == null || lvdiam == null || lvwall == null || height == null || weight == null)) return false;
		
		return true;
	}
	
	late final PhhfGroupInterpretation? _interpretation;
	PhhfGroupInterpretation? get interpretation => this.isValid ? this._interpretation : null;
	
	PhhfGroupState({
		this.diabetes = false,
		this.atrialFibrillation = false,
		this.lvmassIsKnown = true,
		this.leftAtriumArea,
		this.rightVentricleArea,
		this.septum,
		this.lvdiam,
		this.lvwall,
		this.height,
		this.weight,
		this.lvmass
	})
	{
		if(this.isValid)
		{
			double leftVentricularMass = lvmassIsKnown
				? this.lvmass!
				: Formulas.lvMass(septum: this.septum!, lvdiam: this.lvdiam!, lvwall: this.lvwall!) / Formulas.bodySurfaceArea(height: this.height!.toInt(), weight: this.weight!.toInt());
				
			PhhfGroupScore score = new PhhfGroupScore(
				diabetes: this.diabetes,
				atrialFibrillation: this.atrialFibrillation,
				leftAtriumArea: this.leftAtriumArea!,
				rightVentricleArea: this.rightVentricleArea!,
				lvmass: leftVentricularMass
			);
			
			this._result = score.result;
			
			this._interpretation = score.interpretation;
		}
	}
	
	@override
	List<Object?> get props =>
		[diabetes, atrialFibrillation, leftAtriumArea, rightVentricleArea, septum, lvdiam, lvwall, height, weight, lvmass, lvmassIsKnown];
	
	PhhfGroupState copyWith({
		bool? diabetes,
		bool? atrialFibrillation,
		bool? lvmassIsKnown,
		double? leftAtriumArea,
		bool updateLeftAtriumArea = false,
		double? rightVentricleArea,
		bool updateRightVentricleArea = false,
		double? septum,
		bool updateSeptum = false,
		double? lvdiam,
		bool updateLvdiam = false,
		double? lvwall,
		bool updateLvwall = false,
		double? height,
		bool updateHeight = false,
		double? weight,
		bool updateWeight = false,
		double? lvmass,
		bool updateLvmass = false
	})
	{
		return PhhfGroupState(
			diabetes: diabetes ?? this.diabetes,
			atrialFibrillation: atrialFibrillation ?? this.atrialFibrillation,
			lvmassIsKnown: lvmassIsKnown ?? this.lvmassIsKnown,
			leftAtriumArea: updateLeftAtriumArea ? leftAtriumArea : this.leftAtriumArea,
			rightVentricleArea: updateRightVentricleArea ? rightVentricleArea : this.rightVentricleArea,
			septum: updateSeptum ? septum : this.septum,
			lvdiam: updateLvdiam ? lvdiam : this.lvdiam,
			lvwall: updateLvwall ? lvwall : this.lvwall,
			height: updateHeight ? height : this.height,
			weight: updateWeight ? weight : this.weight,
			lvmass: updateLvmass ? lvmass : this.lvmass
		);
	}
}