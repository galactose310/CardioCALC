part of 'widgets.dart';

class FavoriteButton extends StatelessWidget
{
	final Score score;
	final Function()? onPressed;
	final Color isFavColor;
	final Color? notFavColor;
	final double size;
	
	const FavoriteButton({
		Key? key,
		required this.score,
		this.onPressed,
		this.isFavColor = Colors.amber,
		this.notFavColor,
		this.size = 45
	}) : super(key: key);
	
	@override
	Widget build(BuildContext context)
	{
		return SizedBox(
			width: this.size, height: this.size,
			child: LikeButton(
				size: size - 5 >= 0 ? size - 5 : 0,
				bubblesSize: 50,
				bubblesColor: const BubblesColor(
					dotPrimaryColor: Colors.blue,
					dotSecondaryColor: Colors.red,
					dotThirdColor: Colors.green,
				),
				animationDuration: const Duration(milliseconds: 750),
				isLiked: this.score.isFavorite,
				likeBuilder: (bool isLiked)
				{
					return Icon(
						Icons.star_rounded,
						color: isLiked ? this.isFavColor : this.notFavColor,
					);
				},
				onTap: (isLiked) async
				{
					if(this.onPressed != null) this.onPressed!();
					return !isLiked;
				},
			)
		);
	}
}