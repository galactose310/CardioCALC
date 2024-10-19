import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/correctedqt_bloc.dart';
import 'view/correctedqt_view.dart';

class CorrectedQTPage extends StatelessWidget
{
	/// Returns a BlocProvider that provides :
	/// 
	/// - BLoC logic for Corrected QT state management
	/// 
	/// - View page for Corrected QT implementation
	const CorrectedQTPage({Key? key}) : super(key: key);
	
	@override
	Widget build(BuildContext context)
	{
		return BlocProvider<CorrectedQTBloc>(
			create: (context) => CorrectedQTBloc(),
			child: const CorrectedQTView(),
		);
	}
}