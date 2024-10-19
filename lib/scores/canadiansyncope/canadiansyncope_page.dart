/// Main page for CanadianSyncope
/// 
/// Wraps BLoC logic and View in a BlocProvider
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/canadiansyncope_bloc.dart';
import 'view/canadiansyncope_view.dart';


class CanadianSyncopePage extends StatelessWidget
{
	/// Returns a BlocProvider that provides :
	/// 
	/// - BLoC logic for CanadianSyncope state management
	/// 
	/// - View page for CanadianSyncopeScore implementation
	const CanadianSyncopePage({Key? key}) : super(key: key);
	
	@override
	Widget build(BuildContext context)
	{
		return BlocProvider<CanadianSyncopeBloc>(
			create: (context) => CanadianSyncopeBloc(),
			child: const CanadianSyncopeView(),
		);
	}
}