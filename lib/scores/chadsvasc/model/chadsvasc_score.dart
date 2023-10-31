class ChadsVascScore
{
	final bool heartFailure;
	final bool hypertension;
	final bool ageOver65;
	final bool diabetes;
	final bool stroke;
	final bool vascularDisease;
	final bool ageOver75;
	final bool female;
	
	const ChadsVascScore({
		required this.heartFailure,
		required this.hypertension,
		required this.ageOver65,
		required this.diabetes,
		required this.stroke,
		required this.vascularDisease,
		required this.ageOver75,
		required this.female
	});
	
	int get result
	{
		int score = 0;
		List<bool> vars = [
			this.heartFailure,
			this.hypertension,
			this.ageOver65,
			this.diabetes,
			this.stroke,
			this.stroke,
			this.vascularDisease,
			this.ageOver75,
			this.female
		];
		
		for(bool variable in vars) if(variable) score += 1;
		
		if(score == 1 && this.female) return 0;
		
		return score;
	}
	
	double get risk
	{
		switch (this.result)
        {
			case 0: return 0;
			case 1: return 1.3;
			case 2: return 2.2;
			case 3: return 3.2;
			case 4: return 4.0;
			case 5: return 6.7;
			case 6: return 9.8;
			case 7: return 9.6;
			case 8: return 12.5;
			case 9: return 15.2;
			default: return 0;
			}
	}
}