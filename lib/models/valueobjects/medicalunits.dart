/// Lists all units used to express medical values.
part of 'medicalvalues.dart';

// Uses generics to prevent bad usage, ie. conversion from another unit type.
mixin ConvertibleImplementor<T extends Convertible> implements Convertible {
	@override
	double getConversionFactor(Convertible from, Convertible to) {
		return from.factor / to.factor;
	}
	
	@override
	double getConversionFactorFrom(T from) => this.getConversionFactor(from, this);
	
	@override
	double getConversionFactorTo(T to) => this.getConversionFactor(this, to);
}

enum TimeUnit with ConvertibleImplementor<TimeUnit> {
	ms(factor: 1/(24*60*60*1000)),
	s(factor: 1/(24*60*60)),
	min(factor: 1/(24*60)),
	h(factor: 1/24),
	day(factor: 1),
	week(factor: 7),
	month(factor: 30.5),
	year(factor: 365);
	
	@override
	final double factor;
	
	const TimeUnit({required this.factor});
}

enum AreaUnit with ConvertibleImplementor<AreaUnit> {
	mm2(factor: 1/1000000, stringRepresentation: 'mm²'),
	cm2(factor: 1/10000, stringRepresentation: 'cm²'),
	m2(factor: 1, stringRepresentation: 'm²');
	
	@override
	final double factor;
	final String stringRepresentation;
	
	const AreaUnit({required this.factor, required this.stringRepresentation});
	
	String get name => stringRepresentation;
}

enum DistanceUnit with ConvertibleImplementor<DistanceUnit> {
	mm(factor: 1/1000),
	cm(factor: 1/100),
	m(factor: 1);
	
	@override
	final double factor;
	
	const DistanceUnit({required this.factor});
}

enum MassUnit with ConvertibleImplementor<MassUnit> {
	g(factor: 1),
	kg(factor: 1000);
	
	@override
	final double factor;
	
	const MassUnit({required this.factor});
}

/// Constructs a new indexed unit from the original unit, and its indexer (ie: kg and m² gives kg/m²).
class IndexedUnit {
	String get name => this.toString();
	
	final Convertible indexedUnit;
	final Convertible indexerUnit;
	
	IndexedUnit({required this.indexedUnit, required this.indexerUnit});
	
	@override
	String toString() {
		if(indexerUnit is AreaUnit) {
			AreaUnit areaUnit = indexerUnit as AreaUnit;
			return '${indexedUnit.name}/${areaUnit.stringRepresentation}';
		}
		return '${indexedUnit.name}/${indexerUnit.name}';
	}
}