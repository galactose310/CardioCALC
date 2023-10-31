enum FieldStatus { initial, empty, nonnumeric, numeric }

extension FieldStatusTest on FieldStatus
{
	bool get isInitial => this == FieldStatus.initial;
	bool get isEmpty => this == FieldStatus.empty;
	bool get isNotNumeric => this == FieldStatus.nonnumeric;
	bool get isNumeric => this == FieldStatus.numeric;
	
	static bool areNumeric(List<FieldStatus> statuses)
	{
		for(FieldStatus status in statuses) if(!status.isNumeric) return false;
		return true;
	}
}

enum ScoreStatus { valid, notvalid }

extension ScoreStatusTest on ScoreStatus
{
	bool get isValid => this == ScoreStatus.valid;
}