part of '../widgets.dart';

class SliderTile extends StatelessWidget
{
	final String title;
	final double value;
	final double? min;
	final double? max;
	final ValueChanged<double>? onChanged;
	
	const SliderTile({
		Key? key,
		required this.title,
		required this.value,
		required this.onChanged,
		this.min,
		this.max
	}) : super(key: key);
	
	@override
	Widget build(BuildContext context)
	{
		return ListTile(
			title: Text(
				this.title,
				style: Theme.of(context).textTheme.subtitle1,
				textAlign: TextAlign.left,
			),
			subtitle: Padding(
				padding: const EdgeInsets.only(right: 8),
				child: Row(
				children: [
					Expanded(
						child: Slider.adaptive(
							label: '${this.value}',
							value: this.value,
							min: this.min ?? 0.0,
							max: this.max ?? 1.0,
							onChanged: this.onChanged
						)
					),
					Chip(
						label: Container(
							alignment: Alignment.center,
							child: Text(
								this.value.round().toString(),
								overflow: TextOverflow.visible,
								textAlign: TextAlign.center,
							),
							width: 20
						)
					)
				]
			)
		));
	}
}