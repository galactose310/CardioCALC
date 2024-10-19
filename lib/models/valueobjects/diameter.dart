part of 'medicalvalues.dart';

/// Defines Diameter as a [MedicalValue] : has a value, a unit, and ranges of possible and usual values.
abstract class Diameter extends MedicalValue {
	@override
	DistanceUnit get unit => super.unit as DistanceUnit;
	
	double get valueInMm => this.value * this.unit.getConversionFactorTo(DistanceUnit.mm);
	double get valueInCm => this.value * this.unit.getConversionFactorTo(DistanceUnit.cm);
	
	const Diameter({required super.value, DistanceUnit unit = DistanceUnit.mm}) : super(unit: unit);
}

/// A value object to define the left ventricle wall thickness (ie: septum, or posterior wall).
class LeftVentricleWallThickness extends Diameter {
	@override
	LimitRange get _possibleRange => LimitRange(min: 2, max: 80, unit: DistanceUnit.mm);
	@override
	LimitRange get _usualRange => LimitRange(min: 4, max: 45, unit: DistanceUnit.mm);
	
	/// Builds a value object to express the left ventricle wall thickness (ie: septum, or posterior wall).
	const LeftVentricleWallThickness({required super.value, super.unit});
}

/// A value object to define the left ventricle end-diastolic diameter (measured in PLAX, or PSAX).
class LeftVentricleEndDiastolicDiameter extends Diameter {
	@override
	LimitRange get _possibleRange => LimitRange(min: 20, max: 100, unit: DistanceUnit.mm);
	@override
	LimitRange get _usualRange => LimitRange(min: 30, max: 80, unit: DistanceUnit.mm);
	
	/// Builds a value object to express the left ventricle end-diastolic diameter (measured in PLAX, or PSAX).
	const LeftVentricleEndDiastolicDiameter({required super.value, super.unit});
}