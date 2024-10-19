/// Lists all medical values expressed with value object types in the app.
library medical_values;

import 'dart:math' as math;
import 'package:cardiocalc/exceptions.dart';
import 'package:cardiocalc/extensions/double.dart';
import 'package:cardiocalc/extensions/statuses.dart';
import 'package:cardiocalc/lib/range.dart';
import 'package:equatable/equatable.dart';
import 'package:cardiocalc/interfaces/validable.dart';

part 'package:cardiocalc/interfaces/convertible.dart';

part 'anthropometry.dart';
part 'area.dart';
part 'diameter.dart';
part 'leftventriclemass.dart';
part 'medicalunits.dart';

/// Abstract class to construct value objects for medical values.
/// 
/// Medical numerical values are defined by their value, and their unit.
/// 
/// Defines a range of possible values, and a range of "usual" values.
/// 
/// ie: Age is a MedicalValue in years. Possible range is "0 to 130" and a usual range could be "0 to 110".
abstract class MedicalValue extends Equatable implements Validable {
	final double value;
	final Convertible unit;
	
	// Will be defined in each specific derived class.
	LimitRange get _possibleRange;
	LimitRange get _usualRange;
	
	Range get possibleRange {
		Convertible defaultUnit = this._possibleRange.unit;
		double conversionFactor = this.unit.getConversionFactorFrom(defaultUnit);
		double min = this._possibleRange.range.min * conversionFactor;
		double max = this._possibleRange.range.max * conversionFactor;
		return Range(min, max);
	}
	
	Range get usualRange {
		Convertible defaultUnit = this._usualRange.unit;
		double conversionFactor = this.unit.getConversionFactorFrom(defaultUnit);
		double min = this._usualRange.range.min * conversionFactor;
		double max = this._usualRange.range.max * conversionFactor;
		return Range(min, max);
	}
	
	const MedicalValue({required this.value, required this.unit});
	
	/// Cheks if the value is in a valid range for this type of cavity.
	@override
	bool get isValid => this.possibleRange.contains(value);
	/// Cheks if the value is beyond extreme values.
	@override
	bool get isOffLimits => this.possibleRange.excludes(value);
	/// Checks if the value is a possible value but should be verified by user.
	@override
	bool get isUnusual => this.usualRange.excludes(value);
	
	@override
	List<Object> get props => [value, unit];
}

/// Abstract class to index a [MedicalValue] (value object) to another.
/// 
/// The [unit] is directly computed combining the units of each value object.
/// 
/// ie: can be used to index a value ([Volume], [Area]...) on the [BodySurfaceArea].
/// 
/// Caution: will throw a DivisionByZeroException if [indexer.value] is equal to 0.
abstract class IndexedValue extends Equatable {
	final MedicalValue indexed;
	final MedicalValue indexer;
	
	/// Does not checks the [value] itself, but whether [indexed] and [indexer] have valid values.
	bool get isValid => indexed.isValid && indexer.isValid;
	
	double get value => this.indexed.value / this.indexer.value;
	IndexedUnit get unit => IndexedUnit(indexedUnit: this.indexed.unit, indexerUnit: this.indexer.unit);
	
	IndexedValue({required this.indexed, required this.indexer}) {
		if(this.indexer.value == 0)
			throw const DivisionByZeroException('Error in IndexedValue (or subtype): IndexedValue.indexer.value cannot be zero.');
	}
	
	@override
	List<Object> get props => [value, unit];
}

/// A class to define a range of expected values according to the used unit.
class LimitRange {
	late final Range range;
	final Convertible unit;
	
	LimitRange({required num min, required num max, required this.unit}) {
		this.range = Range(min, max);
	}
}