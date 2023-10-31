part of 'widgets.dart';

class FavoriteSlidingTile extends StatelessWidget
{
	final Animation<double> animation;
	final Score score;
	final void Function()? onPressed;
	
	// Properties for ScoreTile widget
	final Color? titleColor;
	final Color? subtitleColor;
	final Color? isFavColor;
	final Color? notFavColor;
	final Color? tileColor;
	
	const FavoriteSlidingTile({
		Key? key,
		required this.animation,
		required this.score,
		this.titleColor,
		this.subtitleColor,
		this.isFavColor,
		this.notFavColor,
		this.tileColor,
		this.onPressed}) : super(key: key);
	
	@override
	Widget build(BuildContext context)
	{
		var curved = new CurvedAnimation(parent: this.animation, curve: const Interval(.5, 1));

		return SizeTransition(
			sizeFactor: CurvedAnimation(parent: this.animation, curve: const Interval(0, .5)),
			child: SlideTransition(
				position: Tween(begin: const Offset(1, 0), end: const Offset(0, 0)).animate(curved),
				child: Column(children: [
					ScoreTile(
						score: this.score,
						titleColor: this.titleColor,
						subtitleColor: this.subtitleColor,
						isFavColor: this.isFavColor ?? Colors.amber,
						notFavColor: this.notFavColor,
						tileColor: this.tileColor,
						onPressed: this.onPressed
					),
					const Divider(height: 1)
				])
			)
		);
	}
}