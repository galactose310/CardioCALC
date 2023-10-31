import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/hasbled_bloc.dart';
import 'view/hasbled_view.dart';

class HasBledPage extends StatelessWidget
{
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