import 'package:cardiocalc/services/applocalizations.dart';
import 'package:cardiocalc/views/themes/extensions/cardiocalc_colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPage extends StatefulWidget
{
	const InfoPage({Key? key}) : super(key: key);

	@override
	State<StatefulWidget> createState() => new _InfoPageState();
}

class _InfoPageState extends State<InfoPage>
{
	final TapGestureRecognizer _svgRepoTapRecognizer = new TapGestureRecognizer();
	
	@override
	void initState()
	{
		super.initState();
		this._svgRepoTapRecognizer.onTap = () => launchUrl(Uri.parse("http://www.svgrepo.com/"));
	}
	
	@override
	Widget build(BuildContext context)
	{
		return Scaffold(
			appBar: AppBar(
				title: Text(AppLocalizations.of(context)!.infoTitle),
			),
			body: Padding(
				padding: const EdgeInsets.all(16),
				child: Column(
					crossAxisAlignment: CrossAxisAlignment.start,
					children: [
						Text(
							AppLocalizations.of(context)!.infoSubtitle,
							style: Theme.of(context).textTheme.headline5
						),
						const SizedBox(height: 20),
						ListView(
							shrinkWrap: true,
							children: [
								InfoTile(
									leading: Image.asset("assets/icons/cardiocalc-about.png"),
									title: "CardioCALC",
									subtitle1: AppLocalizations.of(context)!.infoVersion,
									subtitle2: AppLocalizations.of(context)!.infoAuthor,
								),
								InfoTile(
									leading: SvgPicture.asset("assets/icons/svg-repo.svg"),
									title: AppLocalizations.of(context)!.infoIconsFrom,
									link: RichText(
										text: TextSpan(
											text: "www.svgrepo.com",
											style: Theme.of(context).textTheme.subtitle1?.copyWith(
												color: Theme.of(context).extension<CardioCalcColors>()!.hyperlinkColor,
												decoration: TextDecoration.underline
											),
											recognizer: this._svgRepoTapRecognizer
										),
									),
									subtitle1: AppLocalizations.of(context)!.infoSvgRepoLicense,
									isLast: true
								)
							]
						),
						const SizedBox(height: 40),
						SizedBox(
							width: double.infinity,
							child: ElevatedButton(
								child: Text(AppLocalizations.of(context)!.infoReadConditions.toUpperCase()),
								onPressed: () => null
							)
						),
						Row(
							mainAxisAlignment: MainAxisAlignment.center,
							children: [
								Text(
									AppLocalizations.of(context)!.infoAnyProblem,
									style: Theme.of(context).textTheme.subtitle1,
								),
								TextButton(
									child: Text(AppLocalizations.of(context)!.infoContactUs),
									style: TextButton.styleFrom(
										textStyle: Theme.of(context).textTheme.subtitle1?.copyWith(
											decoration: TextDecoration.underline
										),
										primary: Theme.of(context).extension<CardioCalcColors>()!.hyperlinkColor
									),
									onPressed: () => launchUrl(Uri(scheme: "mailto", path: "cardiocalc@outlook.com")),
								)
							]
						)
					]
				)
			)
		);
	}
	
	@override
	void dispose()
	{
		this._svgRepoTapRecognizer.dispose();
		super.dispose();
	}
}

class InfoTile extends StatelessWidget
{
	final Widget leading;
	final String title;
	final RichText? link;
	final String? subtitle1;
	final String? subtitle2;
	final bool isLast;
	
	const InfoTile({Key? key, required this.leading, required this.title, this.link, this.subtitle1, this.subtitle2, this.isLast = false}) : super(key: key);
	
	@override
	Widget build(BuildContext context)
	{
		List<Widget> rowChildren = <Widget>[];
		
		rowChildren.add(Text(
			this.title,
			style: Theme.of(context).textTheme.subtitle1?.merge(const TextStyle(fontSize: 19))
		));
		
		if(this.link != null)
			rowChildren.add(this.link!);
		
		if(this.subtitle1 != null)
			rowChildren.add(Text(this.subtitle1!, style: Theme.of(context).textTheme.subtitle1));
		
		if(this.subtitle2 != null)
			rowChildren.add(Text(this.subtitle2!, style: Theme.of(context).textTheme.subtitle1));
		
		double leadingWidth = 90;
		double colPadding = 20;
		double divPadding = 16;
		double indent = leadingWidth + colPadding;
		
		List<Widget> columnChildren = <Widget>[];
		
		columnChildren.add(
			Row(
				children: [
					SizedBox(child: leading, width: leadingWidth),
					Padding(
						padding: EdgeInsets.all(colPadding),
						child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: rowChildren)
					),
				],
			)
		);
		
		if(!this.isLast)
			columnChildren.add(
				Padding(
					padding: EdgeInsets.symmetric(vertical: divPadding),
					child: Divider(thickness: .8, height: 1, indent: indent)
				)
			);
		
		return Column(children: columnChildren);
	}
}