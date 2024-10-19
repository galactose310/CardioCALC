import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/phhfgroup_bloc.dart';
import 'view/phhfgroup_view.dart';

class PhhfGroupPage extends StatelessWidget
{
	/// Returns a BlocProvider that provides :
	/// 
	/// - BLoC logic for PH-HFpEF Group state management
	/// 
	/// - View page for PH-HFpEF Group implementation
	const PhhfGroupPage({Key? key}) : super(key: key);
	
	@override
	Widget build(BuildContext context)
	{
		return BlocProvider<PhhfGroupBloc>(
			create: (context) => PhhfGroupBloc(lvMassIsKnown: true),
			child: const PhhfGroupView(),
		);
	}
}