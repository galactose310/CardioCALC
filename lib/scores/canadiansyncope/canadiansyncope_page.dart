import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/canadiansyncope_bloc.dart';
import 'view/canadiansyncope_view.dart';

class CanadianSyncopePage extends StatelessWidget
{
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