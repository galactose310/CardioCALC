import 'package:cardiocalc/models/valueobjects/medicalvalues.dart';

enum PhhfGroupInterpretation {
	precapillary,
	intermediate,
	postacapillary
}

class PhhfGroupScore {
	final bool diabetes;
	final bool atrialFibrillation;
	final LeftAtriumArea leftAtriumArea;
	final RightVentricleArea rightVentricleArea;
	final IndexedLeftVentricularMass lvmass;
	
	int get result
    {
		// Temporary variable to save score calculation
		int result = 0;
		
		// Increment if diabetes, fibrillation, or rventricle dilatation
		result += (this.diabetes ? 1 : 0) + (this.atrialFibrillation ? 2 : 0) + (this.rightVentricleArea.value < 27 ? 2 : 0);
		
		// Score calculation : left atrium area
		if(this.leftAtriumArea.value < 15) result += 0;
		else if(this.leftAtriumArea.value < 19) result += 1;
		else if(this.leftAtriumArea.value < 24) result += 2;
		else result += 3;
		
		// Score calculation : lV mass index
		if(this.lvmass.value <= 46) result += 0;
		else if(this.lvmass.value <= 62) result += 1;
		else if(this.lvmass.value <= 81) result += 2;
		else result += 3;
		
		return result;
    }
	
	PhhfGroupInterpretation get interpretation
	{
		if (this.result <= 4) return PhhfGroupInterpretation.precapillary;
		else if (this.result >= 7) return PhhfGroupInterpretation.postacapillary;
		else return PhhfGroupInterpretation.intermediate;
	}
	
	PhhfGroupScore({
		required this.diabetes,
		required this.atrialFibrillation,
		required this.leftAtriumArea,
		required this.rightVentricleArea,
		required this.lvmass
	});
}