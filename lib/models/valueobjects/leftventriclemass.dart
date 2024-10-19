part of 'medicalvalues.dart';

/// Defines left ventricle mass.
/// Can be computed by the default constructor, or a factory method using LV diameters:
/// ```dart
/// // Default
/// LVMass({required double value, MassUnit unit = MassUnit.g})
///
/// // Factory
/// LVMass.fromLVDiameters({required LeftVentricleWallThickness septum, required LeftVentricleEndDiastolicDiameter lvdiam, required LeftVentricleWallThickness lvwall, MassUnit unit = MassUnit.g})
/// ```
class LeftVentricularMass extends MedicalValue {
	@override
	MassUnit get unit => super.unit as MassUnit;
	
	@override
	LimitRange get _possibleRange => LimitRange(min: 5, max: 2000, unit: MassUnit.g);
	@override
	LimitRange get _usualRange => LimitRange(min: 50, max: 800, unit: MassUnit.g);
	
	/// Left ventricular mass (default constructor).
	/// 
	/// For LV mass from diameters use LeftVentricularMass.fromLVDiameters().
	const LeftVentricularMass({required super.value, MassUnit unit = MassUnit.g}) : super(unit: unit);
	
	/// Left ventricular mass from LV diameters (measured in PLAX).
	/// 
	/// Is LV mass already known prefer to use default constructor LeftVentricularMass().
	factory LeftVentricularMass.fromLVDiameters({
		required LeftVentricleWallThickness septum,
		required LeftVentricleEndDiastolicDiameter lvdiam,
		required LeftVentricleWallThickness lvwall,
		MassUnit unit = MassUnit.g
	}) {
		double value = LeftVentricularMass.calculateLvMass(septum: septum, lvdiam: lvdiam, lvwall: lvwall);
		
		return LeftVentricularMass(value: value, unit: unit);
	}
	
	/// Computes left ventricular mass from LV diameters (measured in PLAX).
	static double calculateLvMass({
		required LeftVentricleWallThickness septum,
		required LeftVentricleEndDiastolicDiameter lvdiam,
		required LeftVentricleWallThickness lvwall
	}) {
		return ((1.04 * 0.8 * (math.pow(septum.valueInCm + lvdiam.valueInCm + lvwall.valueInCm, 3) - math.pow(lvdiam.valueInCm, 3))) + 0.6);
	}
}

/// A composite value object from two objects: [LeftVentricularMass], [BodySurfaceArea].
/// 
/// Index the LV mass value on BSA ; [unit] is computed according to each object unit.
class IndexedLeftVentricularMass extends IndexedValue {
	@override
	LeftVentricularMass get indexed => super.indexed as LeftVentricularMass;
	@override
	BodySurfaceArea get indexer => super.indexer as BodySurfaceArea;
	
	IndexedLeftVentricularMass({required LeftVentricularMass indexed, required BodySurfaceArea indexer}) :
		super(indexed: indexed, indexer: indexer);
}