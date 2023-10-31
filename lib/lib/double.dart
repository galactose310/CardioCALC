import 'dart:math' as math;

extension DoubleExtension on double
{
	double roundToDecimal(int precision)
	{
		num factor = math.pow(10, precision);
		return (this * factor).round() / factor;
	}
	
	double log10() => math.log(this) / math.ln10;
}