part of '../models/valueobjects/medicalvalues.dart';

/// Interface to create valid units for subclasses of MedicalValues.
/// Caution: to be implemented by Enum only.
abstract interface class Convertible implements Enum {
	final double factor;
	
	Convertible({required this.factor});
	
	/// Returns a multiplicator for unit conversion.
	double getConversionFactor(covariant Convertible from, covariant Convertible to);
	
	/// Returns a multiplicator for unit conversion (from any unit to the current one).
	double getConversionFactorFrom(covariant Convertible from);
	
	/// Returns a multiplicator for unit conversion (from current unit to another).
	double getConversionFactorTo(covariant Convertible to);
}