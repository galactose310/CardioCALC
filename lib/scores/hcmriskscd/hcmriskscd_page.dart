import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/hcmriskscd_bloc.dart';
import 'view/hcmriskscd_view.dart';

class HcmRiskScdPage extends StatelessWidget
{
	/// Returns a BlocProvider that provides :
	/// 
	/// - BLoC logic for HCM-Risk SCD state management
	/// 
	/// - View page for HCM Risk SCD implementation
	const HcmRiskScdPage({Key? key}) : super(key: key);
	
	@override
	Widget build(BuildContext context)
	{
		return BlocProvider<HcmRiskScdBloc>(
			create: (context) => HcmRiskScdBloc(),
			child: const HcmRiskScdView(),
		);
	}
}