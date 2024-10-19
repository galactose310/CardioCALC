import 'package:cardiocalc/models/valueobjects/medicalvalues.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
	test('Diameter testing', () {
		LeftVentricleWallThickness lvWallInM = const LeftVentricleWallThickness(value: 25, unit: DistanceUnit.m);
		expect(lvWallInM.valueInMm, 25000);
		expect(lvWallInM.isValid, false);
		
		LeftVentricleWallThickness lvWallInMm = const LeftVentricleWallThickness(value: 25);
		expect(lvWallInMm.isValid, true);
	});
}