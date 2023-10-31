import 'package:cardiocalc/config.dart';
import 'package:flutter/material.dart';
import 'package:cardiocalc/services/applocalizations.dart';
import 'package:cardiocalc/models/locales.dart';
import 'homepage.dart' as homepage;

class SettingsPage extends StatefulWidget
{
	const SettingsPage({Key? key}) : super(key: key);
	
	@override
	State<StatefulWidget> createState() => new _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>
{
	// Fields to be configured
	late Locale _locale;
	homepage.Page? _homepage;
	
	void setLocale(Locale? locale)
	{
    	Config.setLocale(locale);
		this.setState(() => this._locale = Config.currentLocale);
	}
	
	void setHomepage(homepage.Page? homepage)
	{
		Config.setHomePage(homepage.toString());
		this.setState(() => this._homepage = homepage);
	}
	
	// To reset SharedPreferences
	void clearPreferences(BuildContext context)
	{
		Config.clear();
		this.setState(() => this.didChangeDependencies());
	}
	
	// Initializes fields and can be called to restore them to default
	@override
	void didChangeDependencies()
	{
		super.didChangeDependencies();
		
		this._locale = Config.currentLocale;
		
		this._homepage = homepage.Page.values.firstWhere(
			(e) => e.toString() == Config.homepage,
			orElse: () => homepage.Page.ScoreListPage
		);
	}
	
	@override
	Widget build(BuildContext context)
	{
		List<Locale> supportedLocales = AppLocalizations.supportedLocales;
		
		return Scaffold(
			appBar: AppBar(title: Text(AppLocalizations.of(context)!.settingsTitle)),
			body: Padding(
				padding: const EdgeInsets.all(16),
				child: Column(
					mainAxisAlignment: MainAxisAlignment.start,
					crossAxisAlignment: CrossAxisAlignment.start,
					children: [
						Text(
							AppLocalizations.of(context)!.settingsSubtitleLanguage,
							style: Theme.of(context).textTheme.headline6,
						),
						ListView.builder(
							shrinkWrap: true,
							itemCount: supportedLocales.length,
							itemBuilder: (BuildContext context, int index)
							{
								return RadioListTile<Locale>(
									value: supportedLocales[index],
									groupValue: _locale,
									title: Text(LocalesList.getNameOfLocale(supportedLocales[index])),
									onChanged: (Locale? value) => this.setLocale(value)
								);
							}
						),
						const SizedBox(height: 10),
						const Divider(),
						const SizedBox(height: 10),
						Text(
							AppLocalizations.of(context)!.settingsMainPage,
							style: Theme.of(context).textTheme.headline6
						),
						ListView(
							shrinkWrap: true,
							children: [
								RadioListTile<homepage.Page>(
									value: homepage.Page.ScoreListPage,
									groupValue: this._homepage,
									title: Text(AppLocalizations.of(context)!.settingsScoreListPage),
									onChanged: (homepage.Page? value) => this.setHomepage(value)
								),
								RadioListTile<homepage.Page>(
									value: homepage.Page.FavoritesListPage,
									groupValue: this._homepage,
									title: Text(AppLocalizations.of(context)!.settingsFavoritesListPage),
									onChanged: (homepage.Page? value) => this.setHomepage(value)
								),
							],
						),
						const SizedBox(height: 10),
						const Divider(),
						const SizedBox(height: 10),
						SizedBox(
							width: double.infinity,
							child: ElevatedButton(
								child: Text(AppLocalizations.of(context)!.restoreSettings.toUpperCase()),
								onPressed: () => this.clearPreferences(context),
							)
						)
					]
				)
			)
		);
	}
	
	@override
	void dispose()
	{
		super.dispose();
	}
}