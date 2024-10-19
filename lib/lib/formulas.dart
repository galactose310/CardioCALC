enum IntervalUnit { ms, mm25, mm50 }

class Formulas
{
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
            default: throw Exception("convertInMilliseconds requires adequate unit");
        }
    }
}