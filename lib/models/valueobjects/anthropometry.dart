part of 'medicalvalues.dart';

enum BSAFormula { boyd, dubois, gehanGeorge, haycock, mosteller }

/// A value object to define the age of an individual.
class Age extends MedicalValue {
	@override
	TimeUnit get unit => super.unit as TimeUnit;
	
	double get valueInDays => this.value * this.unit.getConversionFactorTo(TimeUnit.day);
	double get valueInWeeks => this.value * this.unit.getConversionFactorTo(TimeUnit.week);
	double get valueInMonths => this.value * this.unit.getConversionFactorTo(TimeUnit.month);
	double get valueInYears => this.value * this.unit.getConversionFactorTo(TimeUnit.year);
	
	@override
	LimitRange get _possibleRange => LimitRange(min: 0, max: 130, unit: TimeUnit.year);
	@override
	LimitRange get _usualRange => LimitRange(min: 0, max: 110, unit: TimeUnit.year);
	
	/// Builds a value object to express the age of an individual.
	const Age({required super.value, TimeUnit unit = TimeUnit.year}) : super(unit: unit);
}

/// A value object to define the body surface area.
class BodySurfaceArea extends MedicalValue {
	@override
	AreaUnit get unit => super.unit as AreaUnit;
	
	@override
	LimitRange get _possibleRange => LimitRange(min: 0.02, max: 7, unit: AreaUnit.m2);
	@override
	LimitRange get _usualRange => LimitRange(min: 0.1, max: 3.5, unit: AreaUnit.m2);
	
	/// Builds a value object to express the BSA of an individual (default constructor).
	/// 
	/// For BSA from height and weight use BodySurfaceArea.fromHeightWeight().
	const BodySurfaceArea({required super.value}) : super(unit: AreaUnit.m2);
	
	/// Builds a value object to express the BSA of an individual (from height and weight).
	/// 
	/// Is BSA already known prefer to use default constructor BodySurfaceArea().
	factory BodySurfaceArea.fromHeightWeight({
		required Height height,
		required Weight weight,
		BSAFormula method = BSAFormula.boyd,
		int decimal = 3
	}) {
		double value = BodySurfaceArea.calculateBodySurfaceArea(height: height, weight: weight, method: method, decimal: decimal);
		
		return BodySurfaceArea(value: value);
	}
	
	/// Computes body surface area from adequate formula.
	static double calculateBodySurfaceArea({required Height height, required Weight weight, BSAFormula method = BSAFormula.boyd, int decimal = 3}) {
		switch(method) {
			case BSAFormula.dubois:
				return (0.20247 * math.pow(height.valueInM, 0.725) * math.pow(weight.valueInKg, 0.425)).roundToDecimal(decimal);
			case BSAFormula.gehanGeorge:
				return (0.0235 * math.pow(height.valueInCm, 0.42246) * math.pow(weight.valueInKg, 0.51456)).roundToDecimal(decimal);
			case BSAFormula.haycock:
				return (0.024265 * math.pow(height.valueInCm, 0.3964) * math.pow(weight.valueInKg, 0.5378)).roundToDecimal(decimal);
			case BSAFormula.mosteller:
				return math.sqrt(height.valueInCm * weight.valueInKg / 3600).roundToDecimal(decimal);
			case BSAFormula.boyd:
			default:
				// Note: for log10(x), use log(x)/log(10) or faster, log(x)/ln10
				return (0.0003207 * math.pow(height.valueInCm, 0.3) * math.pow(weight.valueInKg*1000, 0.7285 - (0.0188 * math.log(weight.valueInKg*1000)/math.ln10))).roundToDecimal(decimal);
		}
	}
}

/// A value object to define the height of an individual.
class Height extends MedicalValue {
	@override
	DistanceUnit get unit => super.unit as DistanceUnit;
	
	double get valueInCm => this.value * this.unit.getConversionFactorTo(DistanceUnit.cm);
	double get valueInM => this.value * this.unit.getConversionFactorTo(DistanceUnit.m);
	
	@override
	LimitRange get _possibleRange => LimitRange(min: 10, max: 280, unit: DistanceUnit.cm);
	@override
	LimitRange get _usualRange => LimitRange(min: 100, max: 220, unit: DistanceUnit.cm);
	
	/// Builds a value object to express the height of an individual.
	const Height({required super.value, DistanceUnit unit = DistanceUnit.cm}) : super(unit: unit);
}

/// A value object to define the weight of an individual.
class Weight extends MedicalValue {
	@override
	MassUnit get unit => super.unit as MassUnit;
	
	double get valueInG => this.value * this.unit.getConversionFactorTo(MassUnit.g);
	double get valueInKg => this.value * this.unit.getConversionFactorTo(MassUnit.kg);
	
	@override
	LimitRange get _possibleRange => LimitRange(min: 0.4, max: 500, unit: MassUnit.kg);
	@override
	LimitRange get _usualRange => LimitRange(min: 10, max: 300, unit: MassUnit.kg);
	
	/// Builds a value object to express the weight of an individual.
	const Weight({required super.value, MassUnit unit = MassUnit.kg}) : super(unit: unit);
}