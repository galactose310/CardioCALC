import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/ventriculartachycardia_bloc.dart';
import 'view/ventriculartachycardia_view.dart';

class VentricularTachycardiaPage extends StatelessWidget
{
	const VentricularTachycardiaPage({Key? key}) : super(key: key);
	
	@override
	Widget build(BuildContext context)
	{
		return BlocProvider<VentricularTachycardiaBloc>(
			create: (context) => VentricularTachycardiaBloc(),
			child: const VentricularTachycardiaView(),
		);
	}
}