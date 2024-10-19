
/// Handles events from PhhfGroupView and set its new states
import 'package:flutter/widgets.dart';
import 'package:cardiocalc/models/valueobjects/medicalvalues.dart';

import './model/phhfgroup_score.dart';

class PhhfGroupViewModel extends ChangeNotifier {
	bool diabetes, atrialFibrillation, lvmassIsKnown;
	
	LeftAtriumArea? leftAtriumArea;
	RightVentricleArea? rightVentricleArea;
	LeftVentricleWallThickness? septum;
	LeftVentricleEndDiastolicDiameter? lvdiam;
	LeftVentricleWallThickness? lvwall;
	Height? height;
	Weight? weight;
	IndexedLeftVentricularMass? indexedLvMass;
	
	AreaUnit leftAtriumAreaUnit = AreaUnit.mm2;
	AreaUnit rightVentricleAreaUnit = AreaUnit.mm2;
	DistanceUnit septumUnit = DistanceUnit.mm;
	DistanceUnit lvdiamUnit = DistanceUnit.mm;
	DistanceUnit lvwallUnit = DistanceUnit.mm;
	DistanceUnit heightUnit = DistanceUnit.cm;
	MassUnit weightUnit = MassUnit.kg;
	MassUnit nonIndexedLvMassUnit = MassUnit.g;
	IndexedUnit indexedLvMassUnit = IndexedUnit(indexedUnit: MassUnit.g, indexerUnit: AreaUnit.m2);
	
	bool get isReadyToCalculate
	{
		if(isNullOrInvalid(leftAtriumArea) || isNullOrInvalid(rightVentricleArea)) return false;
		if(lvmassIsKnown) {
			if(indexedLvMass == null) return false;
		}
		else {
			List<MedicalValue?> varList = [septum, lvdiam, lvwall, height, weight];
			if(varList.map((e) => isNullOrInvalid(e)).contains(true)) return false;
		}
		return true;
	}
	
	bool isNullOrInvalid(MedicalValue? field) {
		return !(field?.isValid ?? false);
	}
	
	PhhfGroupScore? get score {
		if(!isReadyToCalculate) return null;
		
		IndexedLeftVentricularMass leftVentricularMass;
		if(lvmassIsKnown) leftVentricularMass = this.indexedLvMass!;
		else {
			leftVentricularMass = IndexedLeftVentricularMass(
				indexed: LeftVentricularMass.fromLVDiameters(septum: septum!, lvdiam: lvdiam!, lvwall: lvwall!, unit: nonIndexedLvMassUnit),
				indexer: BodySurfaceArea.fromHeightWeight(height: height!, weight: weight!)
			);
		}
		
		return PhhfGroupScore(
			diabetes: diabetes,
			atrialFibrillation: atrialFibrillation,
			leftAtriumArea: leftAtriumArea!,
			rightVentricleArea: rightVentricleArea!,
			lvmass: leftVentricularMass
		);
	}
	
	PhhfGroupInterpretation? get scoreInterpretation => score?.interpretation;
	
	PhhfGroupViewModel({this.diabetes = false, this.atrialFibrillation = false, this.lvmassIsKnown = true});
	
	void onDiabetesToggled(bool value) {
		diabetes = value;
		notifyListeners();
	}
	
	void onAtrialFibrillationToggled(bool value) {
		atrialFibrillation = value;
		notifyListeners();
	}
	
	void onLvMassIsKnownToggled(bool value) {
		lvmassIsKnown = value;
		notifyListeners();
	}
	
	void onLeftAtriumAreaChanged(String value) {
		double? newValue = double.tryParse(value);
		if(newValue == null) leftAtriumArea = null;
		else leftAtriumArea = LeftAtriumArea(value: newValue, unit: leftAtriumAreaUnit);
		notifyListeners();
	}
	
	void onRightVentricleAreaChanged(String value) {
		double? newValue = double.tryParse(value);
		if(newValue == null) rightVentricleArea = null;
		else rightVentricleArea = RightVentricleArea(value: newValue, unit: rightVentricleAreaUnit);
		notifyListeners();
	}
	
	void onSeptumChanged(String value) {
		double? newValue = double.tryParse(value);
		if(newValue == null) septum = null;
		else septum = LeftVentricleWallThickness(value: newValue, unit: septumUnit);
		notifyListeners();
	}
	
	void onLvDiamChanged(String value) {
		double? newValue = double.tryParse(value);
		if(newValue == null) lvdiam = null;
		else lvdiam = LeftVentricleEndDiastolicDiameter(value: newValue, unit: lvdiamUnit);
		notifyListeners();
	}
	
	void onLvWallChanged(String value) {
		double? newValue = double.tryParse(value);
		if(newValue == null) lvwall = null;
		else lvwall = LeftVentricleWallThickness(value: newValue, unit: lvwallUnit);
		notifyListeners();
	}
	
	void onHeightChanged(String value) {
		double? newValue = double.tryParse(value);
		if(newValue == null) height = null;
		else height = Height(value: newValue, unit: heightUnit);
		notifyListeners();
	}
	
	void onWeightChanged(String value) {
		double? newValue = double.tryParse(value);
		if(newValue == null) weight = null;
		else weight = Weight(value: newValue, unit: weightUnit);
		notifyListeners();
	}
	
	void onIndexedLvMassChanged(String value) {
		double? newValue = double.tryParse(value);
		if(newValue == null) indexedLvMass = null;
		else {
			indexedLvMass = IndexedLeftVentricularMass(
				indexed: LeftVentricularMass(value: newValue, unit: nonIndexedLvMassUnit),
				 // Input is expected to already be an indexed value
				indexer: const BodySurfaceArea(value: 1)
			);
		}
		notifyListeners();
	}
}