part of '../widgets.dart';

class HelperButton extends StatelessWidget
{
	final String? title;
	final String helper;
	final Function() onPressed;
	
	const HelperButton({Key? key, this.title, required this.helper, required this.onPressed}) : super(key: key);
	
	@override
	Widget build(BuildContext context)
	{
		return IconButton(
			icon: const Icon(Icons.help),
			iconSize: 18,
			color: Theme.of(context).colorScheme.secondaryContainer,
			onPressed: this.onPressed,
		);
	}
}

class Helper extends StatelessWidget
{
	final String text;
	final bool isVisibleByDefault;
	final StreamController<bool> visibilityController;
	
	Stream<bool> get visibilityStream => visibilityController.stream;
	Sink<bool> get visibilitySink => visibilityController.sink;
	
	const Helper(this.text, {Key? key, required this.visibilityController, this.isVisibleByDefault = false}) : super(key: key);
	
	@override
	Widget build(BuildContext context)
	{
		return StreamBuilder<bool>(
			stream: this.visibilityStream,
			initialData: this.isVisibleByDefault,
			builder: (BuildContext context, AsyncSnapshot<bool> visibility)
			{
				return AnimatedSize(
					duration: const Duration(milliseconds: 200),
					child: !visibility.data! ? Container(height: 0) : Container(
						margin: const EdgeInsets.only(bottom: 8),
						child: ListTile(
							title: Text(
								this.text,
								textAlign: TextAlign.justify,
								style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Theme.of(context).colorScheme.onPrimary)
							),
							trailing: IconButton(
								icon: Icon(
									Icons.close,
									color: Theme.of(context).colorScheme.onPrimary,
								),
								onPressed: () => this.visibilitySink.add(false)
							)
						),
						decoration: ShapeDecoration(
							color: Theme.of(context).colorScheme.primary,
							shape: const MessageBorder(),
							shadows: [
								BoxShadow(color: Theme.of(context).colorScheme.shadow, blurRadius: 4.0, offset: const Offset(1, 1)),
							]
						),
					)
				);
			}
		);
	}
}

class MessageBorder extends ShapeBorder
{
	final bool usePadding;
	
	const MessageBorder({this.usePadding = true});
	
	@override
	EdgeInsetsGeometry get dimensions => const EdgeInsets.symmetric(vertical: 4, horizontal: 4);
	
	@override
	Path getInnerPath(Rect rect, {TextDirection? textDirection}) => Path();
	
	@override
	Path getOuterPath(Rect rect, {TextDirection? textDirection})
	{
		rect = Rect.fromPoints(rect.topLeft, rect.bottomRight - const Offset(0, 0));
		return Path()
		..addRRect(RRect.fromRectAndRadius(rect, const Radius.circular(4)))
		..moveTo(rect.topLeft.dx + 16, rect.topLeft.dy)
		..relativeLineTo(10, -10)
		..relativeLineTo(20, 20)
		..close();
	}
	
	@override
	void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}
	
	@override
	ShapeBorder scale(double t) => this;
}