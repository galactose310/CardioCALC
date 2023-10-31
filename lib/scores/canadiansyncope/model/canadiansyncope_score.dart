part 'enum_emergencydiagnosis.dart';
part 'enum_risklevel.dart';

class CanadianSyncopeScore
{
	final bool vagalPredisposition;
	final bool cardiacHistory;
	final bool abnormalBP;
	final bool troponin;
	final bool abnormalAxis;
	final bool largeQRS;
	final bool longQT;
	final EmergencyDiagnosis diagnosis;
	
	const CanadianSyncopeScore({
		required this.vagalPredisposition,
		required this.cardiacHistory,
		required this.abnormalBP,
		required this.troponin,
		required this.abnormalAxis,
		required this.largeQRS,
		required this.longQT,
		required this.diagnosis
	});
	
	int get score
	{
		int score = 0;
		
		if (this.vagalPredisposition) score -= 1;
		if (this.cardiacHistory) score += 1;
		if (this.abnormalBP) score += 2;
		if (this.troponin) score += 2;
		if (this.abnormalAxis) score += 1;
		if (this.largeQRS) score += 1;
		if (this.longQT) score += 2;
		
		switch (this.diagnosis)
		{
			case EmergencyDiagnosis.cardiacSyncope:
				score += 2;
				break;
			case EmergencyDiagnosis.vasovagalSyncope:
				score -= 2;
				break;
			case EmergencyDiagnosis.other:
			default:
				break;
		}
		
		return score;
	}
	
	double get riskPercentage
	{
		switch (score)
		{
			case -3: return 0.4;
			case -2: return 0.7;
			case -1: return 1.2;
			case 0: return 1.9;
			case 1: return 3.1;
			case 2: return 5.1;
			case 3: return 8.1;
			case 4: return 12.9;
			case 5: return 19.7;
			case 6: return 28.9;
			case 7: return 40.3;
			case 8: return 52.8;
			case 9: return 65.0;
			case 10: return 75.5;
			case 11: return 83.6;
			
			default:
				throw Exception("Cannot compute CanadianSyncopeScore.riskPercentage: as this is a core issue, please contact the development team.");
		}
	}
	
	CanadianSyncopeRiskLevel get riskLevel
	{
		switch (score)
		{
			case -3:
			case -2:
				return CanadianSyncopeRiskLevel.veryLow;
			case -1:
			case 0:
				return CanadianSyncopeRiskLevel.low;
			case 1:
			case 2:
			case 3:
				return CanadianSyncopeRiskLevel.intermediate;
			case 4:
			case 5:
				return CanadianSyncopeRiskLevel.high;
			case 6:
			case 7:
			case 8:
			case 9:
			case 10:
			case 11:
				return CanadianSyncopeRiskLevel.veryHigh;
			
			default:
				throw Exception("Cannot compute CanadianSyncopeScore.riskLevel: as this is a core issue, please contact the development team.");
		}
	}
}