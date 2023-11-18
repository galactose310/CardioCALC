import 'package:cardiocalc/views/themes/extensions/cardiocalc_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MemoTheme
{
	static SystemUiOverlayStyle statusBarStyle = SystemUiOverlayStyle.light.copyWith(
		statusBarColor: const Color(0xff3e416e),
	);
	
	static ColorScheme get colorScheme
	{
		// Saving colors :
		//Color get bottomBarIconActive => const Color(0xff66bb6a);
		
		/*
			Note : onPrimary, onSecondary, onXXXX...
			primary: backround ; onPrimary: for what is in the foreground (titles, icons)
		*/
		return const ColorScheme.light(
			primary: Color(0xff3e416e),
			onPrimary: Colors.white,
			primaryContainer: Color(0xff313457), // Color(0xFF2E3152),
			onPrimaryContainer: Colors.white,
			secondary: Color(0xffef5466),
			onSecondary: Colors.white,
			secondaryContainer: Colors.blueAccent,
			onSecondaryContainer: Colors.white,
			tertiary: Color(0xfff0f4fd), // ScoreList slivers headers background
			onTertiary: Color(0xff7a89b9), // ScoreList slivers headers titles
			tertiaryContainer: Color(0xffd9e8fb), // ResultCard background
			onTertiaryContainer: Color(0xff6a77aa), // ResultCard text
			background: Color(0xfff0f4fd), // Mainly for HomePage (=> FavList) and SearchPage background, and Helper tiles
			onBackground: Color(0xaa666666),
			surface: Colors.white,
			shadow: Colors.grey
		);
	}
	
	static ThemeData get light
	{
		// Set system statusBar's (above appBar) color
		//SystemChrome.setSystemUIOverlayStyle(statusBarStyle);
		
		return ThemeData(
			
			// General theme and colors
			colorScheme: colorScheme,
			primaryColor: colorScheme.primary,
			
			extensions: const <ThemeExtension<dynamic>>[
				CardioCalcColors(
					hyperlinkColor: Color(0xff669fee)
				)
			],
			
			// Theme for AppBar and StatusBar
			appBarTheme: AppBarTheme(
				systemOverlayStyle: statusBarStyle,
			),
			
			// Change color of bottom navigation bar buttons
			bottomNavigationBarTheme: const BottomNavigationBarThemeData(
				selectedItemColor: Color(0xff96bbef),
				unselectedItemColor:  Color(0xff9e9e9e),
			),
			
			listTileTheme: ListTileThemeData(
				tileColor: MemoTheme.colorScheme.surface,
				//textColor: const Color(0xff555555), ==> Use textTheme.subtitle1 & textTheme.caption instead
				iconColor: const Color(0xffdbe8f7) // Default color if not favorite
			),
			
			inputDecorationTheme: const InputDecorationTheme(
				border: UnderlineInputBorder(),
				//focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xff96bbef)))
			),
			
			scaffoldBackgroundColor: Colors.white,
			
			dividerColor: const Color(0xffdbe8f7),
			
			elevatedButtonTheme: ElevatedButtonThemeData(
				style: ElevatedButton.styleFrom(
					primary: const Color(0xff62d76c) //colorScheme.secondary //const Color(0xff96bbef) //0xFF7BA8E6)
				)
			),
			
			switchTheme: SwitchThemeData(
				thumbColor: MaterialStateProperty.resolveWith(
					(states)
					{
						if(states.contains(MaterialState.selected)) return const Color(0xff62d76c);
						else return const Color(0xfff9f9f9);
					}
				),
				trackColor: MaterialStateProperty.resolveWith(
					(states)
					{
						if(states.contains(MaterialState.selected)) return const Color(0xffd7f5d9);
						else return const Color(0xffe9e9e9);
					}
				),
			),
			
			sliderTheme: SliderThemeData(
				thumbColor: colorScheme.onTertiary,
				activeTrackColor: colorScheme.onTertiary.withOpacity(.5),
				inactiveTrackColor: const Color(0xffe9e9e9)
			),
			
			segmentedButtonTheme: SegmentedButtonThemeData(
				style: ButtonStyle(
					//padding: MaterialStateProperty.all(const EdgeInsets.only(top: 18, bottom: 18, left: 10, right: 20)),
					//padding: MaterialStateProperty.all(const EdgeInsets.only(top: 18, bottom: 18, left: 10, right: 20)),
					backgroundColor: MaterialStateProperty.resolveWith<Color>(
						(states)
						{
							if(states.contains(MaterialState.selected)) return colorScheme.primary;
							else return const Color(0xfff9f9f9);
						}
					),
				),
			),
			
			/*
			radioTheme: RadioThemeData(
				fillColor: MaterialStateProperty.resolveWith(
					(states)
					{
						if(states.contains(MaterialState.selected)) return colorScheme.onTertiary;
						else return const Color(0xff666666);
					}
				)
			),
			*/
			
			chipTheme: ChipThemeData(
				backgroundColor: colorScheme.onTertiary,
				labelStyle: TextStyle(
					color: colorScheme.onPrimary,
					fontWeight: FontWeight.w500
				),
			),
			
			cardTheme: const CardTheme(
				color: Color(0xfff8f8f8)
			),
			
			textTheme: const TextTheme(
				// ScoreList ListTile (ScoreTile) title
				subtitle1: TextStyle(color: Color(0xff666666)),
				// ScoreList ListTile (ScoreTile) subTitle
				caption: TextStyle(color: Color(0xaa666666)),
				// Basic "long" text as in Description Card
				bodyText1: TextStyle(color: Color(0xff666666), fontWeight: FontWeight.normal),
				// Empty content (ie no favorite found)
				bodyText2: TextStyle(color: Color(0xffbbbbbb)),
				// Body page title like in InfoPage
				headline5: TextStyle(color: Color(0xff666666), fontWeight: FontWeight.w500),
				// For hyperlink (can use color and decoration only in spans) ; based on subtitle1 style
				// subtitle2: TextStyle(color: Color(0xff669fee)), //Color(0xff96bbef)
			)
		);
	}
}