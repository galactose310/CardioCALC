import 'dart:math' as math;
import 'package:cardiocalc/lib/double.dart';

enum BSAFormula { boyd, dubois, gehanGeorge, haycock, mosteller }

enum IntervalUnit { ms, mm25, mm50 }

extension IndexedValue on double
{
	double indexToBSA({required int height, required int weight, BSAFormula method = BSAFormula.boyd, int decimal = 3})
	{
		return (this / Formulas.bodySurfaceArea(height: height, weight: weight, method: method)).roundToDecimal(decimal);
	}
}

class Formulas
{
	static double bodySurfaceArea({required int height, required int weight, BSAFormula method = BSAFormula.boyd, int decimal = 3})
	{
		switch(method)
		{
			case BSAFormula.dubois:
				return (0.20247 * math.pow(height/100, 0.725) * math.pow(weight, 0.425)).roundToDecimal(decimal);
			case BSAFormula.gehanGeorge:
				return (0.0235 * math.pow(height, 0.42246) * math.pow(weight, 0.51456)).roundToDecimal(decimal);
			case BSAFormula.haycock:
				return (0.024265 * math.pow(height, 0.3964) * math.pow(weight, 0.5378)).roundToDecimal(decimal);
			case BSAFormula.mosteller:
				return math.sqrt(height * weight / 3600).roundToDecimal(decimal);
			case BSAFormula.boyd:
			default:
				return (0.0003207 * math.pow(height, 0.3) * math.pow(weight*1000, 0.7285 - (0.0188 * math.log(weight*1000)/math.ln10))).roundToDecimal(decimal); // Note: for log10(x), use log(x)/log(10) or faster, log(x)/ln10
		}
	}
	
	static double lvMass({required double septum, required double lvdiam, required double lvwall})
	{
		return ((1.04 * 0.8 * (math.pow(septum/10 + lvdiam/10 + lvwall/10, 3) - math.pow(lvdiam/10, 3))) + 0.6);
	}
	
	static int bpmToMilliseconds({required heartrate})
		=> (60 * 1000 / heartrate).round();
	
	static int millisecondsToBpm({required interval})
		=> (60 * 1000 / interval).round();
	
	static int convertInMilliseconds({required int interval, required IntervalUnit unit})
    {
        switch (unit)
        {
            case IntervalUnit.ms: return interval;
            case IntervalUnit.mm25: return interval * 40;
            case IntervalUnit.mm50: return interval * 20;
            default: return interval;
        }
    }
}