part of 'widgets.dart';

enum SliderDirection
{
	leftToRight,
	rightToLeft,
	bottomToTop,
	topToBottom
}

class SlideWidget extends StatelessWidget
{
	final Widget child;
	final Animation<double> animation;
	final double index;
	final SliderDirection direction;
	
	late final Tween<Offset> _tween;
	Tween<Offset> get tween => this._tween;
	
	SlideWidget({Key? key, required this.child, required this.animation, this.index = 0, this.direction = SliderDirection.leftToRight}) : super(key: key)
	{
		switch(this.direction)
		{
			case SliderDirection.leftToRight:
				this._tween = new Tween<Offset>(
					begin: Offset(this.index, 0),
					end: Offset(this.index + 1, 0)
				);
				break;
			
			case SliderDirection.rightToLeft:
				this._tween = new Tween<Offset>(
					begin: Offset(this.index, 0),
					end: Offset(this.index - 1, 0)
				);
				break;
			
			case SliderDirection.bottomToTop:
				this._tween = new Tween<Offset>(
					begin: Offset(0, this.index),
					end: Offset(0, this.index - 1)
				);
				break;
			
			case SliderDirection.topToBottom:
				this._tween = new Tween<Offset>(
					begin: Offset(this.index, 0),
					end: Offset(this.index + 1, 0)
				);
				break;
			
			default:
				this._tween = new Tween<Offset>(
					begin: Offset(this.index, 0),
					end: Offset(this.index + 1, 0)
				);
				break;
		}
	}
	
	@override
	Widget build(BuildContext context)
	{
		return SlideTransition(
			position: this.tween.animate(this.animation),
			child: this.child
		);
	}
}