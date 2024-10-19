import 'package:cardiocalc/models/valueobjects/medicalvalues.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
	test('Age testing', () {
		Age age = const Age(value: 40);
		
		expect(age.valueInDays, 40*365);
		expect(age.valueInWeeks, 40*365/7);
		expect(age.valueInMonths, closeTo(40*365/30.5, 0.001));
		expect(age.valueInYears, 40);
	});
	
	test('BSA testing', () {
		BodySurfaceArea bsa = const BodySurfaceArea(value: 12);
		
		expect(bsa.value, 12);
		expect(bsa.isValid, false);
		
		Height height = const Height(value: 170);
		Weight weight = const Weight(value: 70);
		
		BodySurfaceArea bsaBoyd = BodySurfaceArea.fromHeightWeight(
			height: height, weight: weight,
		);
		
		expect(bsaBoyd.isValid, true);
		expect(bsaBoyd.value, closeTo(1.83, 0.006));
		
		BodySurfaceArea bsaDubois = BodySurfaceArea.fromHeightWeight(
			height: height, weight: weight,
			method: BSAFormula.dubois,
			decimal: 2
		);
		expect(bsaDubois.value, 1.81);
		
		BodySurfaceArea bsaGehan = BodySurfaceArea.fromHeightWeight(
			height: height, weight: weight,
			method: BSAFormula.gehanGeorge,
			decimal: 2
		);
		expect(bsaGehan.value, 1.83);
		
		BodySurfaceArea bsaHaycock = BodySurfaceArea.fromHeightWeight(
			height: height, weight: weight,
			method: BSAFormula.haycock,
			decimal: 2
		);
		expect(bsaHaycock.value, 1.83);
		
		BodySurfaceArea bsaMosteller = BodySurfaceArea.fromHeightWeight(
			height: height, weight: weight,
			method: BSAFormula.mosteller,
			decimal: 2
		);
		expect(bsaMosteller.value, 1.82);
	});
	
	test('Height testing', () {
		Height height = const Height(value: 182);
		expect(height.valueInCm, 182);
		expect(height.valueInM, 1.82);
		
		Height heightInM = const Height(value: 1.78, unit: DistanceUnit.m);
		expect(heightInM.valueInCm, 178);
		expect(heightInM.valueInM, 1.78);
	});
	
	test('Weight testing', () {
		Weight weight = const Weight(value: 81);
		expect(weight.valueInG, 81000);
		expect(weight.valueInKg, 81);
		
		Weight weightInG = const Weight(value: 62, unit: MassUnit.g);
		expect(weightInG.valueInG, 62);
		expect(weightInG.valueInKg, 0.062);
	});
}