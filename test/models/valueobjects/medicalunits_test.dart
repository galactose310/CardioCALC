import 'package:cardiocalc/models/valueobjects/medicalvalues.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
	test('TimeUnit testing', () {
		TimeUnit unit = TimeUnit.h;
		
		expect(unit.getConversionFactor(TimeUnit.h, TimeUnit.h), 1);
		expect(unit.getConversionFactor(TimeUnit.day, TimeUnit.h), 24);
		expect(unit.getConversionFactor(TimeUnit.year, TimeUnit.week), closeTo(52, 0.5));
		expect(unit.getConversionFactor(TimeUnit.month, TimeUnit.min), closeTo(43920, 5));
		expect(unit.getConversionFactor(TimeUnit.h, TimeUnit.ms), 3600000);
		expect(unit.getConversionFactor(TimeUnit.week, TimeUnit.h), 24*7);
		expect(unit.name, "h");
	});
	
	test('MassUnit testing', () {
		MassUnit unit = MassUnit.g;
		
		expect(unit.getConversionFactor(MassUnit.g, MassUnit.kg), 1/1000);
		expect(unit.getConversionFactor(MassUnit.kg, MassUnit.g), 1000);
	});
}