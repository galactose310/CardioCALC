part of 'widgets.dart';

class ScoreTile extends StatelessWidget
{
	final Score score;
	final Color? titleColor;
	final Color? subtitleColor;
	final Color? isFavColor;
	final Color? notFavColor;
	final Color? tileColor;
	
	final void Function()? onPressed;
	
	const ScoreTile({
		Key? key,
		required this.score,
		this.titleColor,
		this.subtitleColor,
		this.isFavColor = Colors.amber,
		this.notFavColor,
		this.tileColor,
		this.onPressed}) : super(key: key);
	
	@override
	Widget build(BuildContext context)
	{
		return ListTile(
			contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
			tileColor: this.tileColor,
			title: Text(this.score.name, style: TextStyle(color: this.titleColor)),
			subtitle: Text(this.score.detail, style: TextStyle(color: this.subtitleColor)),
			trailing: FavoriteButton(
				score: this.score,
				onPressed: this.onPressed,
			),
			onTap: () => Navigator.pushNamed(context, '/${this.score.label}', arguments: this.score),
		);
	}
}