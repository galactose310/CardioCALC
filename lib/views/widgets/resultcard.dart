part of 'widgets.dart';

class ResultCard extends StatelessWidget
{
	final String scoreName;	// Title
	final String result;	// Result to be displayed in the title
	final String message;	// Message to be displayed as "body" of the ResultCard
	
	static const int _titleAnimationDuration = 200;
	
	const ResultCard({Key? key, required this.scoreName, required this.result, required this.message}) : super(key: key);
	
	@override
	Widget build(BuildContext context)
	{
		return Card(
			color: Theme.of(context).colorScheme.tertiaryContainer,
			child: Padding(
				padding: const EdgeInsets.all(16),
				child: Column(
					crossAxisAlignment: CrossAxisAlignment.stretch,
					children: [
						// Title of the ResultCard
						Row(children: [
							Flexible(child: Padding(
								padding: const EdgeInsets.only(right: 5),
								child: _ResultCardTitlePart(text: "${this.scoreName} :"),
							)),
							AnimatedSwitcher(
								duration: const Duration(milliseconds: _titleAnimationDuration),
								child: _ResultCardTitlePart(
									key: ValueKey(this.result),
									text: this.result
								),
								transitionBuilder: (Widget child, Animation<double> animation) {
									return ScaleTransition(scale: animation, child: child);
								},
							)
						]),
						const SizedBox(height: 8),
						// Body of the ResultCard
						SlidingAnimatedSwitcher(
							child: RichText(
								key: ValueKey(this.message),
								textAlign: TextAlign.justify,
								text: TextSpan(
									style: Theme.of(context).textTheme.subtitle1?.copyWith(
										color: Theme.of(context).colorScheme.onTertiaryContainer
									),
									children: Markdown.parse(
										text: this.message
									)
								)
							)
						)
					]
				)
			)
		);
	}
}

class _ResultCardTitlePart extends StatelessWidget
{
	final String text;
	
	const _ResultCardTitlePart({Key? key, required this.text}) : super(key: key);
	
	@override
	Widget build(BuildContext context)
	{
		return Text(
			text,
			style: Theme.of(context).textTheme.headline6?.copyWith(
				color: Theme.of(context).colorScheme.onTertiaryContainer,
				fontWeight: FontWeight.bold
			)
		);
	}
}