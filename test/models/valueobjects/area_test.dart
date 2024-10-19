import 'package:cardiocalc/models/valueobjects/medicalvalues.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
	test('LA Area testing', () {
		LeftAtriumArea laArea = const LeftAtriumArea(value: 25);
		expect(laArea.valueInMm2, closeTo(25 * 100, 0.0001));
		expect(laArea.valueInCm2, 25);
		expect(laArea.valueInM2, closeTo(25 * 1/10000, 0.0001));
	});
}