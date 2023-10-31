// ignore_for_file: constant_identifier_names

import 'dart:math' as math;

enum HcmRiskLevel { low, intermediate, high }

class HcmRiskScdScore
{
	static const int MIN_AGE = 16;
	static const int MAX_AGE = 80;
	static const int MIN_LV_THICKNESS = 10;
	static const int MAX_LV_THICKNESS = 35;
	static const int MIN_LA_DIAM = 28;
	static const int MAX_LA_DIAM = 67;
	static const int MIN_LV_GRADIENT = 2;
	static const int MAX_LV_GRADIENT = 154;
	
	final int age;
	final int lvThickness;
	final int ladiam;
	final int lvGradient;
	final bool familySuddenDeath;
	final bool nsvt;
	final bool syncope;
	
	const HcmRiskScdScore({
		required this.age,
		required this.lvThickness,
		required this.ladiam,
		required this.lvGradient,
		required this.familySuddenDeath,
		required this.nsvt,
		required this.syncope
	});
	
	double get result
	{
		int age, lvThickness, ladiam, lvGradient;
		
		age = (this.age < MIN_AGE) ? MIN_AGE : this.age;
		age = (this.age > MAX_AGE) ? MAX_AGE : this.age;
		
		lvThickness = (this.lvThickness < MIN_LV_THICKNESS) ? MIN_LV_THICKNESS : this.lvThickness;
		lvThickness = (this.lvThickness > MAX_LV_THICKNESS) ? MAX_LV_THICKNESS : this.lvThickness;
		
		ladiam = (this.ladiam < MIN_LA_DIAM) ? MIN_LA_DIAM : this.ladiam;
		ladiam = (this.ladiam > MAX_LA_DIAM) ? MAX_LA_DIAM : this.ladiam;
		
		lvGradient = (this.lvGradient < MIN_LV_GRADIENT) ? MIN_LV_GRADIENT : this.lvGradient;
		lvGradient = (this.lvGradient > MAX_LV_GRADIENT) ? MAX_LV_GRADIENT : this.lvGradient;
		
		return (10 *
            (1 -
                (math.pow(
                    0.998,
                    math.exp((0.15939858 * lvThickness) -
                        (0.00294271 * lvThickness * lvThickness) +
                        (0.0259082 * ladiam) +
                        (0.00446131 * lvGradient) +
                        (0.4583082 * (this.familySuddenDeath ? 1 : 0)) +
                        (0.82639195 * (this.nsvt ? 1 : 0)) +
                        (0.71650361 * (this.syncope ? 1 : 0)) -
                        (0.01799934 * age))))
			) * 100).round() / 10;
	}
	
	HcmRiskLevel get riskStratification
	{
		if (this.result < 4) return HcmRiskLevel.low;
		if (this.result >= 6) return HcmRiskLevel.high;
		else return HcmRiskLevel.intermediate;
	}
}