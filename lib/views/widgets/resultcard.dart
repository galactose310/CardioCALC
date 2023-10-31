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
							_ResultCardTitlePart(text: "${this.scoreName} : "),
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

/*
class ResultCard extends StatelessWidget
{
	final Widget title;
	final Widget content;
	
	const ResultCard({Key? key, required this.title, required this.content}) : super(key: key);
	
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
						_ResultCardTitle(title: this.title),
						const SizedBox(height: 8),
						_ResultCardContent(content: this.content)
					]
				)
			)
		);
	}
}

class _ResultCardTitle extends StatelessWidget
{
	final Widget title;

	const _ResultCardTitle({Key? key, required this.title}) : super(key: key);
	
	@override
	Widget build(BuildContext context)
	{
		if(this.title is Text)
		{
			return TextStyleModifier(
				text: this.title as Text,
				defaultTextStyle: Theme.of(context).textTheme.headline6?.copyWith(
					color: Theme.of(context).colorScheme.onTertiaryContainer,
					fontWeight: FontWeight.bold,
				),
			);
		}
		
		else return this.title;
	}
}

class _ResultCardContent extends StatelessWidget
{
	final Widget content;

	const _ResultCardContent({Key? key, required this.content}) : super(key: key);
	
	@override
	Widget build(BuildContext context)
	{
		if(this.content is Text)
		{
			return TextStyleModifier(
				text: this.content as Text,
				defaultTextStyle: Theme.of(context).textTheme.subtitle1?.copyWith(
					color: Theme.of(context).colorScheme.onTertiaryContainer
				),
			);
		}
		
		else return this.content;
	}
}

class ResultCardTitlePart extends StatelessWidget
{
	final String text;
	
	const ResultCardTitlePart({Key? key, required this.text}) : super(key: key);
	
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
*/