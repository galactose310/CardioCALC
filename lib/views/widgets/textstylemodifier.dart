part of 'widgets.dart';

class TextStyleModifier extends StatelessWidget
{
	final TextStyle? defaultTextStyle;
	final Text text;
	
	const TextStyleModifier({Key? key, this.defaultTextStyle, required this.text}) : super(key: key);
	
	@override
	Widget build(BuildContext context)
	{
		return Text(
			text.data ?? "",
			style: text.style?.copyWith(
                inherit: text.style?.inherit ?? defaultTextStyle?.inherit,
                color: text.style?.color ?? defaultTextStyle?.color,
                backgroundColor: text.style?.backgroundColor ?? defaultTextStyle?.backgroundColor,
                fontSize: text.style?.fontSize ?? defaultTextStyle?.fontSize,
                fontWeight: text.style?.fontWeight ?? defaultTextStyle?.fontWeight,
                fontStyle: text.style?.fontStyle ?? defaultTextStyle?.fontStyle,
                letterSpacing: text.style?.letterSpacing ?? defaultTextStyle?.letterSpacing,
                wordSpacing: text.style?.wordSpacing ?? defaultTextStyle?.wordSpacing,
                textBaseline: text.style?.textBaseline ?? defaultTextStyle?.textBaseline,
                height: text.style?.height ?? defaultTextStyle?.height,
                leadingDistribution: text.style?.leadingDistribution ?? defaultTextStyle?.leadingDistribution,
                locale: text.style?.locale ?? defaultTextStyle?.locale,
                foreground: text.style?.foreground ?? defaultTextStyle?.foreground,
                background: text.style?.background ?? defaultTextStyle?.background,
                shadows: text.style?.shadows ?? defaultTextStyle?.shadows,
                fontFeatures: text.style?.fontFeatures ?? defaultTextStyle?.fontFeatures,
                decoration: text.style?.decoration ?? defaultTextStyle?.decoration,
                decorationColor: text.style?.decorationColor ?? defaultTextStyle?.decorationColor,
                decorationStyle: text.style?.decorationStyle ?? defaultTextStyle?.decorationStyle,
                decorationThickness: text.style?.decorationThickness ?? defaultTextStyle?.decorationThickness,
                debugLabel: text.style?.debugLabel ?? defaultTextStyle?.debugLabel,
                fontFamily: text.style?.fontFamily ?? defaultTextStyle?.fontFamily,
                fontFamilyFallback: text.style?.fontFamilyFallback ?? defaultTextStyle?.fontFamilyFallback,
                overflow: text.style?.overflow ?? defaultTextStyle?.overflow
			) ?? defaultTextStyle
		);
	}
}