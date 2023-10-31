part of 'widgets.dart';

class MenuAppBar extends StatefulWidget implements PreferredSizeWidget
{
	final PageController pageController;
	final List<Widget> children;

	const MenuAppBar({Key? key, required this.pageController, required this.children}) : super(key: key);

	@override
	Size get preferredSize => const Size.fromHeight(56.0);

	@override
	State<StatefulWidget> createState() => _MenuAppBarState();
}

class _MenuAppBarState extends State<MenuAppBar> with SingleTickerProviderStateMixin
{
	final List<Widget> sliders = <Widget>[];
	late AnimationController _animationController;
	AnimationController get animationController => this._animationController;
	
	@override
	void initState()
	{
		super.initState();

		this._animationController = new AnimationController(
			value: widget.pageController.initialPage.toDouble(), // Starts at same page than pageController
			upperBound: widget.children.length.toDouble() - 1,
			vsync: this);
		widget.pageController.addListener(_onPageSwitch);
	}
	
	@override
	void dispose()
	{
		super.dispose();
		this.animationController.dispose();
	}
	
	void _onPageSwitch()
	{
		if(!widget.pageController.hasClients)
			throw Exception("Exception in MenuAppBar: no PageView is currently using the PageController...");

		this._animationController.value = widget.pageController.page!;
	}
	
	@override
	Widget build(BuildContext context)
	{
		return Stack(children: widget.children.asMap().entries.map(
			(child) => 
				SlideWidget(
					index: child.key.toDouble(),
					child: child.value,
					animation: this.animationController,
					direction: SliderDirection.rightToLeft,
				)
			).toList()
		);
	}
}