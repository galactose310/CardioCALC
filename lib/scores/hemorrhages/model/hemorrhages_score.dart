class HemorrhagesScore
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
	
	const HemorrhagesScore({
		required this.renalOrLiver,
		required this.alcohol,
		required this.cancer,
		required this.ageOver75,
		required this.thrombopenia,
		required this.bleeding,
		required this.hypertension,
		required this.anemia,
		required this.genetics,
		required this.fallrisk,
		required this.stroke
	});
	
	int get result
	{
		int score = 0;
		List<bool> vars = [
			this.renalOrLiver,
			this.alcohol,
			this.cancer,
			this.ageOver75,
			this.thrombopenia,
			this.bleeding,
			this.bleeding, // count for 2 points
			this.hypertension,
			this.anemia,
			this.genetics,
			this.fallrisk,
			this.stroke
		];
		
		for(bool variable in vars) if(variable) score += 1;
		
		return score;
	}
	
	double get risk
	{
		switch (this.result)
		{
			case 0: return 1.9;
			case 1: return 2.5;
			case 2: return 5.3;
			case 3: return 8.4;
			case 4: return 10.4;
			case 5:
			case 6:
			case 7:
			case 8:
			case 9:
			case 10:
			case 11:
			case 12: return 12.3;
			default: throw Exception("HemorrhagesScore: invalid result.");
		}
	}
}