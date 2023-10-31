import 'package:cardiocalc/services/applocalizations.dart';
import 'package:flutter/material.dart';

class UnknownRoute extends StatelessWidget
{
	const UnknownRoute({Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context)
	{
		return Scaffold(
			appBar: AppBar(title: Text(AppLocalizations.of(context)!.pageNotFoundTitle)),
			body: Container(
				constraints: const BoxConstraints.expand(),
				color: Theme.of(context).colorScheme.background,
				child: Column(
					mainAxisAlignment: MainAxisAlignment.center,
					children: [
						Icon(Icons.web_asset_off, size: 120, color: Theme.of(context).textTheme.bodyText2?.color),
						const SizedBox(height: 50,),
						Text(
							AppLocalizations.of(context)!.pageNotFound,
							style: Theme.of(context).textTheme.bodyText2),
					],
				)
			)
		);
	}
}