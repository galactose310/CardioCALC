import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/hemorrhages_bloc.dart';
import 'view/hemorrhages_view.dart';

class HemorrhagesPage extends StatelessWidget
{
	/// Returns a BlocProvider that provides :
	/// 
	/// - BLoC logic for Hemorrhages state management
	/// 
	/// - View page for Hemorrhages implementation
	const HemorrhagesPage({Key? key}) : super(key: key);
	
	@override
	Widget build(BuildContext context)
	{
		return BlocProvider<HemorrhagesBloc>(
			create: (context) => HemorrhagesBloc(),
			child: const HemorrhagesView(),
		);
	}
}