import 'dart:async';
import 'package:cardiocalc/views/mainpages/unknown_route.dart';
import 'package:flutter/material.dart';
import 'package:cardiocalc/services/applocalizations.dart';
import 'config.dart';
import 'routes.dart';
import 'providers/blocprovider.dart';
import 'providers/scorelist_provider.dart';
import 'blocs/scoresbloc.dart';
import 'views/widgets/widgets.dart';
import 'views/themes/memo.dart';

void main() => runApp(const CardioCALC());

class CardioCALC extends StatefulWidget
{
	const CardioCALC({Key? key}) : super(key: key);
	
	@override
	State<StatefulWidget> createState() => new _CardioCALCState();
}

class _CardioCALCState extends State<CardioCALC>
{
	late ScoreListProvider scoreListProvider;

	Future<bool> init(BuildContext context) async
	{
		await Config.init();
		
		this.scoreListProvider = await ScoreListProvider.init();
		this.scoreListProvider.setLocale(Config.localeShortname);
		
		return true;
	}
	
	@override
	Widget build(BuildContext context)
	{
		List<LocalizationsDelegate<dynamic>> localizationsDelegates = AppLocalizations.localizationsDelegates;
		List<Locale> supportedLocales = AppLocalizations.supportedLocales;
		
		return FutureBuilder(
			future: this.init(context),
			builder: (context, AsyncSnapshot<bool> init)
			{
				if (!init.hasData || !init.data!)
					return AppWaitingForData(
						localizationsDelegates: localizationsDelegates,
						supportedLocales: supportedLocales
					);
				
				return StreamBuilder(
					stream: Config.localeStream,
					initialData: Config.currentLocale,
					builder: (BuildContext context, AsyncSnapshot<Locale> stream)
					{
						return BlocProvider<ScoresBloc>(
							bloc: ScoresBloc(provider: this.scoreListProvider),
							child: MaterialApp(
								localizationsDelegates: localizationsDelegates,
								supportedLocales: supportedLocales,
								locale: stream.data,
								title: "CardioCALC",
								theme: MemoTheme.light,
								initialRoute: '/',
								routes: Routes.routes,
								onUnknownRoute: (RouteSettings settings) => MaterialPageRoute(
									builder: (BuildContext context) => const UnknownRoute()
								),
							)
						);
					}
				);
			}
		);
	}
	
	@override
	void dispose()
	{
		Config.dispose();
		super.dispose();
	}
}

// Renders an empty application while async data are not available
class AppWaitingForData extends StatelessWidget
{
	final List<LocalizationsDelegate<dynamic>> localizationsDelegates;
	final List<Locale> supportedLocales;
	
	const AppWaitingForData({
		Key? key,
		required this.localizationsDelegates,
		required this.supportedLocales,
	}) : super(key: key);
	
	@override
	Widget build(BuildContext context)
	{
		return MaterialApp(
			localizationsDelegates: this.localizationsDelegates,
			supportedLocales: this.supportedLocales,
			title: "CardioCALC",
			home: const Scaffold(
				body: SafeArea(
					child: WaitingForDataBody()
				)
			),
			theme: MemoTheme.light
		);
	}
}