import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart' as applocalizations;

class AppLocalizations
{
	static List<Locale> get supportedLocales => applocalizations.AppLocalizations.supportedLocales;
	static List<LocalizationsDelegate<dynamic>> get localizationsDelegates => applocalizations.AppLocalizations.localizationsDelegates;
	
	static applocalizations.AppLocalizations? of(BuildContext context) => applocalizations.AppLocalizations.of(context);
}