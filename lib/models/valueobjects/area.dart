part of 'medicalvalues.dart';

/// Defines Area as a [MedicalValue] : has a value, a unit, and ranges of possible and usual values.
abstract class Area extends MedicalValue {
	@override
	AreaUnit get unit => super.unit as AreaUnit;
	
	double get valueInMm2 => this.value * this.unit.getConversionFactorTo(AreaUnit.mm2);
	double get valueInCm2 => this.value * this.unit.getConversionFactorTo(AreaUnit.cm2);
	double get valueInM2 => this.value * this.unit.getConversionFactorTo(AreaUnit.m2);
	
	const Area({required super.value, AreaUnit unit = AreaUnit.cm2}) : super(unit: unit);
}

/// A value object to define the left atrium area.
class LeftAtriumArea extends Area {
	@override
	LimitRange get _possibleRange => LimitRange(min: 1, max: 200, unit: AreaUnit.mm2);
	@override
	LimitRange get _usualRange => LimitRange(min: 7, max: 50, unit: AreaUnit.mm2);
	
	/// Builds a value object to express the left atrium area.
	const LeftAtriumArea({required super.value, super.unit});
}

/// A value object to define the left ventricle area.
class LeftVentricleArea extends Area {
	@override
	LimitRange get _possibleRange => LimitRange(min: 5, max: 100, unit: AreaUnit.mm2);
	@override
	LimitRange get _usualRange => LimitRange(min: 10, max: 50, unit: AreaUnit.mm2);
	
	/// Builds a value object to express the left ventricle area.
	const LeftVentricleArea({required super.value, super.unit});
}

/// A value object to define the right atrium area.
class RightAtriumArea extends Area {
	@override
	LimitRange get _possibleRange => LimitRange(min: 1, max: 100, unit: AreaUnit.mm2);
	@override
	LimitRange get _usualRange => LimitRange(min: 7, max: 50, unit: AreaUnit.mm2);
	
	/// Builds a value object to express the right atrium area.
	const RightAtriumArea({required super.value, super.unit});
}

/// A value object to define the right ventricle area.
class RightVentricleArea extends Area {
	@override
	LimitRange get _possibleRange => LimitRange(min: 5, max: 100, unit: AreaUnit.mm2);
	@override
	LimitRange get _usualRange => LimitRange(min: 10, max: 50, unit: AreaUnit.mm2);
	
	/// Builds a value object to express the right ventricle area.
	const RightVentricleArea({required super.value, super.unit});
}