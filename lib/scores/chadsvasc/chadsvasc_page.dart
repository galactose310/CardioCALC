import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/chadsvasc_bloc.dart';
import 'view/chadsvasc_view.dart';

class ChadsVascPage extends StatelessWidget
{
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