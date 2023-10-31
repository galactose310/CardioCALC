import 'package:cardiocalc/scores/phhfgroup/model/phhfgroup_interpretation.dart';

class PhhfGroupScore
{
	PhhfGroupScore({required this.diabetes, required this.atrialFibrillation, required this.leftAtriumArea, required this.rightVentricleArea, required this.lvmass});
	
	final bool diabetes;
	final bool atrialFibrillation;
	final double leftAtriumArea;
	final double rightVentricleArea;
	final double lvmass;
	
	int get result
    {
		// Temporary variable to save score calculation
		int result = 0;
		
		// Increment if diabetes, fibrillation, or rventricle dilatation
		result += (this.diabetes ? 1 : 0) + (this.atrialFibrillation ? 2 : 0) + (this.rightVentricleArea < 27 ? 2 : 0);
		
		// Score calculation : left atrium area
		if(this.leftAtriumArea < 15) result += 0;
		else if(this.leftAtriumArea < 19) result += 1;
		else if(this.leftAtriumArea < 24) result += 2;
		else result += 3;
		
		/*
		if (15 <= this.latriumArea && this.latriumArea < 19) result += 1;
		else if (19 <= this.latriumArea && this.latriumArea < 24) result += 2;
		else if (this.latriumArea >= 24) result += 3;
		else result += 0;
		*/
		
		// Score calculation : lV mass index
		if(this.lvmass <= 46) result += 0;
		else if(this.lvmass <= 62) result += 1;
		else if(this.lvmass <= 81) result += 2;
		else result += 3;
		
		/*
		if (46 < this.LVMass() && this.LVMass() <= 62) result += 1;
		else if (62 < this.LVMass() && this.LVMass() <= 81) result += 2;
		else if (this.LVMass() > 81) result += 3;
		else result += 0;
		*/
		
		return result;
    }
	
	PhhfGroupInterpretation get interpretation
	{
		if (this.result <= 4) return PhhfGroupInterpretation.precapillary;
		else if (this.result >= 7) return PhhfGroupInterpretation.postacapillary;
		else return PhhfGroupInterpretation.intermediate;
	}
}