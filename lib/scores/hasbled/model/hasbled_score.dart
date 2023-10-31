class HasBledScore
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
	
	const HasBledScore({
		required this.hypertension,
		required this.renalFailure,
		required this.hepaticFailure,
		required this.stroke,
		required this.bleeding,
		required this.labileINR,
		required this.ageOver65,
		required this.drugs,
		required this.alcohol
	});
	
	int get result
	{
		int score = 0;
		List<bool> vars = [
			this.hypertension,
			this.renalFailure,
			this.hepaticFailure,
			this.stroke,
			this.bleeding,
			this.labileINR,
			this.ageOver65,
			this.drugs,
			this.alcohol
		];
		
		for(bool variable in vars) if(variable) score += 1;
		
		return score;
	}
	
	String get risk
	{
		switch (this.result)
		{
			case 0: return "0.9";
			case 1: return "3.4";
			case 2: return "4.1";
			case 3: return "5.8";
			case 4: return "8.9";
			case 5: return "9.1";
			case 6: case 7: case 8: case 9: return "> 12";
			default: return "0.9";
		}
	}
}