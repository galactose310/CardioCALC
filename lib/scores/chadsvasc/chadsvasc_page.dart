/// Main page for ChadsVasc
/// 
/// Wraps BLoC logic and View in a BlocProvider
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/chadsvasc_bloc.dart';
import 'view/chadsvasc_view.dart';

class ChadsVascPage extends StatelessWidget
{
	/// Returns a BlocProvider that provides :
	/// 
	/// - BLoC logic for ChadsVasc state management
	/// 
	/// - View page for ChadsVasc implementation
	const ChadsVascPage({Key? key}) : super(key: key);
	
	@override
	Widget build(BuildContext context)
	{
		return BlocProvider<ChadsVascBloc>(
			create: (context) => ChadsVascBloc(),
			child: const ChadsVascView(),
		);
	}
}