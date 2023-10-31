import 'dart:async';
//import 'dart:io';
import 'package:universal_io/io.dart';
import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Config
{
	static const String localePreferencesKey = "locale";
	static const String homepagePreferencesKey = "homepage";
	
	static late SharedPreferences preferences;
	
	static late Locale currentLocale;
	static Locale get systemLocale => Locale(Intl.shortLocale(Platform.localeName));
	static String get localeShortname => Intl.shortLocale(currentLocale.languageCode);
	
	static final StreamController<Locale> _localeController = new StreamController<Locale>.broadcast();
	static Stream<Locale> get localeStream => _localeController.stream;
	static Sink<Locale> get localeSink => _localeController.sink;
	
	static late String? homepage;
	
	static bool _initialized = false;
	
	
	/// Initializes Configuration with SharedPreferences
	/// Must be called before using static Config properties
	static Future<void> init() async
	{
		if(_initialized) return;
		
		preferences = await SharedPreferences.getInstance();
		currentLocale = _getPreferredLocale();
		homepage = _getHomepage();
		
		_initialized = true;
	}
	
	static _getPreferredLocale()
	{
		if (preferences.containsKey(localePreferencesKey) && preferences.get(localePreferencesKey) is String)
		return Locale(preferences.getString(localePreferencesKey)!);
		
		else return systemLocale;
	}
	
	static setLocale(Locale? locale)
	{
		currentLocale = locale ?? systemLocale;
		preferences.setString(localePreferencesKey, currentLocale.languageCode);
		localeSink.add(currentLocale);
	}
	
	static String? _getHomepage()
	{
		if(preferences.containsKey(homepagePreferencesKey) && preferences.get(homepagePreferencesKey) is String)
			return preferences.getString(Config.homepagePreferencesKey);
			
		else return null;
	}
	
	static void setHomePage(String newHomepage)
	{
		homepage = newHomepage;
		preferences.setString(homepagePreferencesKey, homepage!);
	}
	
	static void clear()
	{
		setLocale(systemLocale);
		homepage = null;
		preferences.remove(homepagePreferencesKey);
		preferences.remove(localePreferencesKey);
	}
	
	static dispose()
	{
		_localeController.close();
	}
}