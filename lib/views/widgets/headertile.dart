part of 'widgets.dart';

class HeaderTile extends StatelessWidget
{
	final Category category;
	final Color? headerColor;
	final Color? separatorColor;
	final Color? iconColor;
	final Color? headerTextColor;

	const HeaderTile({
		Key? key,
		required this.category,
		this.headerColor,
		this.separatorColor,
		this.iconColor,
		this.headerTextColor}) : super(key: key);
	
	@override
	Widget build(BuildContext context)
	{
		return Container(
			decoration: BoxDecoration(
				color: this.headerColor,
				border: Border.symmetric(
					horizontal: BorderSide(color: this.separatorColor ?? Theme.of(context).dividerTheme.color ?? Theme.of(context).dividerColor))
			),
			//color: headerColor,
			child: Row(
				children: [
					Padding(
						padding: const EdgeInsets.all(14),
						child: SvgPicture.asset("assets/icons/${category.label}.svg", color: this.iconColor,
						height: 26),
					),
					Text(
						category.name.toUpperCase(),
						style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: this.headerTextColor)
					)
				],
			),
		);
	}
}