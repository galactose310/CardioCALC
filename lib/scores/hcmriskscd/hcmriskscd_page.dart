import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/hcmriskscd_bloc.dart';
import 'view/hcmriskscd_view.dart';

class HcmRiskScdPage extends StatelessWidget
{
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