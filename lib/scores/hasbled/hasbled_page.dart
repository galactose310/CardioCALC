/// Main page for HasBled
/// 
/// Wraps BLoC logic and View in a BlocProvider
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/hasbled_bloc.dart';
import 'view/hasbled_view.dart';

class HasBledPage extends StatelessWidget
{
	/// Returns a BlocProvider that provides :
	/// 
	/// - BLoC logic for HasBled state management
	/// 
	/// - View page for HasBled implementation
	const HasBledPage({Key? key}) : super(key: key);
	
	@override
	Widget build(BuildContext context)
	{
		return BlocProvider<HasBledBloc>(
			create: (context) => HasBledBloc(),
			child: const HasBledView(),
		);
	}
}