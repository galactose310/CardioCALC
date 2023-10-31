part of 'widgets.dart';

class SlidingAnimatedSwitcher extends StatelessWidget
{
	final Widget child;
	final bool hideOutWidget;
	final Axis axis;
	final Duration resizeDuration;
	final Duration switcherDuration;
	final Curve switchInCurve;
	final Curve switchOutCurve;
	final int outAcceleration;
	final int inAcceleration;
	
	const SlidingAnimatedSwitcher({
		Key? key,
		required this.child,
		this.hideOutWidget = true,
		this.axis = Axis.horizontal,
		this.resizeDuration = const Duration(milliseconds: 300),
		this.switcherDuration = const Duration(milliseconds: 700),
		this.switchInCurve = Curves.easeOutCirc,
		this.switchOutCurve = Curves.linear,
		this.outAcceleration = 2,
		this.inAcceleration = 1
	}) : super(key: key);
	
	@override
	Widget build(BuildContext context)
	{
		double inOffset = (this.inAcceleration == 0) ? 1 : this.inAcceleration.toDouble();
		double outOffset = (this.outAcceleration == 0) ? 1 : this.outAcceleration.toDouble();
		
		return AnimatedSize(
			duration: resizeDuration,
			curve: Curves.easeOut,
			child: AnimatedSwitcher(
				duration: this.switcherDuration,
				switchInCurve: this.switchInCurve,
				switchOutCurve: this.switchOutCurve,
				transitionBuilder: (child, animation)
				{
					late Animation<Offset> inAnimation;
					late Animation<Offset> outAnimation;
					
					switch(this.axis)
					{
						case Axis.vertical:
							inAnimation = Tween<Offset>(begin: Offset(0, -inOffset), end: const Offset(0, 0)).animate(animation);
							outAnimation = Tween<Offset>(begin: Offset(0, outOffset), end: const Offset(0, 0)).animate(animation);
							break;
						
						case Axis.horizontal:
						default:
							inAnimation = Tween<Offset>(begin: Offset(-inOffset/10, 0), end: const Offset(0, 0)).animate(animation);
							outAnimation = Tween<Offset>(begin: Offset(outOffset, 0), end: const Offset(0, 0)).animate(animation);
							break;
					}
					
					return ClipRect(
						child: SlideTransition(
							position: child.key == this.child.key ? inAnimation : outAnimation,
							child: child
						)
					);
				},
				layoutBuilder: this.hideOutWidget
					? (currentChild, previousChildren) => currentChild ?? previousChildren.last
					: AnimatedSwitcher.defaultLayoutBuilder,
				child: this.child
			)
		);
	}
}