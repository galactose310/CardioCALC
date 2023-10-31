import 'package:flutter/material.dart';

abstract class BlocBase
{
	void dispose();
}

class BlocProvider<T extends BlocBase> extends StatefulWidget
{
	final T bloc;
	final Widget child;
	
	const BlocProvider({Key? key, required this.bloc, required this.child}) : super(key: key);
	
	@override
	_BlocProviderState<T> createState() => new _BlocProviderState<T>();
	
	static T of<T extends BlocBase>(BuildContext context)
	{
		BlocProvider<T>? provider = context.findAncestorWidgetOfExactType<BlocProvider<T>>();
		
		if(provider == null)
			throw Exception("Exception in BlocProvider: no provider found...");
		
		return provider.bloc;
	}
}

class _BlocProviderState<T> extends State<BlocProvider<BlocBase>>
{
	@override
	void dispose()
	{
		widget.bloc.dispose();
		super.dispose();
	}
	
	@override
	Widget build(BuildContext context) => widget.child;
}