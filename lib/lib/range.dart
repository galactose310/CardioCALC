import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Range extends Equatable {
	late final num min;
	late final num max;
	
	Range(num min, num max) {
		if(min == max)
			throw Exception("Range($min, $max): [min] and [max] must be different values.");
		
		if(min < max) {
			this.min = min;
			this.max = max;
		}
		
		else {
			this.min = max;
			this.max = min;
		}
	}
	
	bool contains(num number) => this.min <= number && number <= this.max;
	
	/// Do the range includes a number, excluding the range limits ?
	bool containsExclusive(num number) => this.min < number && number < this.max;
	
	bool excludes(num number) => number < this.min || number > this.max;
	
	@override
	List<Object> get props => [min, max];
}