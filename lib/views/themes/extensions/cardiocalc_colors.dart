
import 'package:flutter/material.dart';

class CardioCalcColors extends ThemeExtension<CardioCalcColors>
{
	final Color? hyperlinkColor;
	
	const CardioCalcColors({this.hyperlinkColor});
	
	@override
	CardioCalcColors copyWith({Color? hyperlinkColor})
	{
		return CardioCalcColors(
			hyperlinkColor: hyperlinkColor ?? this.hyperlinkColor,
		);
	}
	
	@override
	CardioCalcColors lerp(ThemeExtension<CardioCalcColors>? other, double t)
	{
		if (other is! CardioCalcColors) return this;
		
		return CardioCalcColors(
			hyperlinkColor: Color.lerp(hyperlinkColor, other.hyperlinkColor, t),
		);
	}	
}