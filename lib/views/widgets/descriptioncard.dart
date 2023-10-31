part of 'widgets.dart';

class DescriptionCard extends StatelessWidget
{
	final String? description;
	final List<String>? adverts;
	final List<String>? sources;
	
	const DescriptionCard({Key? key, this.description, this.adverts, this.sources}) : super(key: key);
	
	@override
	Widget build(BuildContext context)
	{
		List<Widget> children = [];
		
		if(this.description != null)
		{
			children.addAll(
				[
					Text(
						AppLocalizations.of(context)!.description.toUpperCase(),
						style: Theme.of(context).textTheme.subtitle1?.copyWith(fontWeight: FontWeight.bold)
					),
					
					Divider(color: Theme.of(context).colorScheme.secondary),
					
					RichText(
						textAlign: TextAlign.justify,
						text: TextSpan(
							style: Theme.of(context).textTheme.bodyText1,
							children: Markdown.parse(
								text: this.description!,
								hyperlinkTextColor: Theme.of(context).extension<CardioCalcColors>()!.hyperlinkColor
							)
						)
					),
				]
			);
		}
		
		if(this.adverts != null && this.adverts!.isNotEmpty)
		{
			for(String advert in this.adverts!)
			{
				if(children.isNotEmpty) children.add(const SizedBox(height: 16));
				
				children.addAll(
					[
						Text(
							AppLocalizations.of(context)!.advert.toUpperCase(),
							style: Theme.of(context).textTheme.subtitle1?.copyWith(fontWeight: FontWeight.bold)
						),
						Divider(color: Theme.of(context).colorScheme.secondary),
						RichText(
							textAlign: TextAlign.justify,
							text: TextSpan(
								style: Theme.of(context).textTheme.bodyText1,
								children: Markdown.parse(
									text: advert,
									hyperlinkTextColor: Theme.of(context).extension<CardioCalcColors>()!.hyperlinkColor
								)
							)
						)
					]
				);
			}
		}
		
		if(this.sources != null && this.sources!.isNotEmpty)
		{
			for(String source in this.sources!)
			{
				if(children.isNotEmpty) children.add(const SizedBox(height: 16));
				
				children.add(
					RichText(
						textAlign: TextAlign.justify,
						text: TextSpan(
							style: Theme.of(context).textTheme.caption?.copyWith(color: Theme.of(context).textTheme.bodyText1?.color),
							children: Markdown.parse(
								text: source,
								hyperlinkTextColor: Theme.of(context).extension<CardioCalcColors>()?.hyperlinkColor
							)
						)
					)
				);
			}
		}
		
		return Card(
			child: Padding(
				padding: const EdgeInsets.all(8),
				child: Column(
					crossAxisAlignment: CrossAxisAlignment.start,
					children: children
				)
			)
		);
	}
}