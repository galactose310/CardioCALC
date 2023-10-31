part of '../widgets.dart';

class SwitchTile extends StatefulWidget
{
	final String title;
	final bool value;
	final ValueChanged<bool>? onChanged;
	final String? helper;
	
	const SwitchTile({Key? key, required this.title, required this.value, required this.onChanged, this.helper}) : super(key: key);

	@override
	State<StatefulWidget> createState() => _SwitchTileState();
}

class _SwitchTileState extends State<SwitchTile>
{
	// CAUTION : _isHelperVisible has to listen to the stream to get updated (cf. initState)
	bool _isHelperVisible = false;
	final StreamController<bool> _helperVisibilityController = new StreamController<bool>.broadcast();
	Stream<bool> get _helperVisibilityStream => this._helperVisibilityController.stream;
	Sink<bool> get _helperVisibilitySink => this._helperVisibilityController.sink;
	
	@override
	void initState() 
	{
		super.initState();
		this._helperVisibilityStream.listen((event) => this._isHelperVisible = event);
	}
	
	@override
	Widget build(BuildContext context)
	{
		List<Widget> rowChildren = <Widget>[];
		List<Widget> columnChildren = <Widget>[];
		
		rowChildren.add(Text(widget.title));
		
		if(widget.helper != null)
		{
			Helper helper = Helper(widget.helper!, visibilityController: this._helperVisibilityController);
			
			rowChildren.add(HelperButton(
				title: widget.title,
				helper: widget.helper!,
				onPressed: this.toggleHelper
			));
			
			columnChildren.add(helper);
		}
		
		columnChildren.insert(
			0,
			ListTile(
				title: Row(
					mainAxisAlignment: MainAxisAlignment.spaceBetween,
					children: rowChildren
				),
				trailing: Switch.adaptive(
					value: widget.value,
					onChanged: (newValue) => widget.onChanged!(newValue)
				)
			)
		);
		
		return Column(children: columnChildren);
	}
	
	void toggleHelper()
	{
		this._helperVisibilitySink.add(!this._isHelperVisible);
	}
	
	@override
	void dispose()
	{
		super.dispose();
		this._helperVisibilityController.close();
	}
}