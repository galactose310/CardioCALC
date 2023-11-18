part of '../widgets.dart';

class SegmentedButtonTile<T> extends StatelessWidget
{
	final String? title;
	final bool titleBold;
	final List<ButtonSegment<T>> segments;
	final Set<T> selected;
	final void Function(Set<T>)? onSelectionChanged;
	final bool multiSelectionEnabled;
	final bool emptySelectionAllowed;
	final ButtonStyle? style;
	final bool showSelectedIcon;
	final Widget? selectedIcon;
	
	const SegmentedButtonTile({
		Key? key,
		required this.segments,
		required this.selected,
		this.title,
		this.titleBold = false,
		this.onSelectionChanged,
		this.multiSelectionEnabled = false,
		this.emptySelectionAllowed = false,
		this.style,
		this.showSelectedIcon = true,
		this.selectedIcon
	}) : super(key: key);
	
	@override
	Widget build(BuildContext context)
	{
		ListTile segmentedButtonTile = ListTile(
			title: SegmentedButton<T>(
				segments: this.segments,
				selected: this.selected,
				onSelectionChanged: this.onSelectionChanged,
				multiSelectionEnabled: this.multiSelectionEnabled,
				emptySelectionAllowed: this.emptySelectionAllowed,
				style: this.style,
				showSelectedIcon: this.showSelectedIcon,
				selectedIcon: this.selectedIcon
			),
			minVerticalPadding: 15,
		);
		
		if(this.title != null)
		{
			ListTile titleTile =
				this.titleBold
					? ListTile(title: Text(this.title!, style: const TextStyle(fontWeight: FontWeight.bold)))
					: ListTile(title: Text(this.title!));
			
			return Column(children: [ titleTile, segmentedButtonTile ]);
		}
		
		else return segmentedButtonTile;
	}
}