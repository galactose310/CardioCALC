import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cardiocalc/services/applocalizations.dart';
import 'package:cardiocalc/views/widgets/widgets.dart';

import '../bloc/ventriculartachycardia_bloc.dart';

class VentricularTachycardiaView extends StatelessWidget
{
	const VentricularTachycardiaView({Key? key}) : super(key: key);
		
	@override
	Widget build(BuildContext context)
	{
		VentricularTachycardiaBloc bloc = context.watch<VentricularTachycardiaBloc>();
		
		return Column(
			children: [
				SwitchTile(
					title: "Your form here",
					value: bloc.state.var1,
					onChanged: (value) => bloc.add(YourEvent(var1: value)),
				),
				
				const SizedBox(height: 16),
				const Divider(),
				const SizedBox(height: 16),
				
				BlocBuilder<VentricularTachycardiaBloc, VentricularTachycardiaState>(
					builder: (BuildContext context, VentricularTachycardiaState state)
					{
						return ResultCard(
							scoreName: AppLocalizations.of(context)!.ventricularTachycardiaTitle,
							result: state.score.result.toString(),
							message: "",
						);
					}
				),
				
				const SizedBox(height: 16),
				const Divider(),
				const SizedBox(height: 16),
				
				/*
				DescriptionCard(
					description: AppLocalizations.of(context)!.ventricularTachycardiaDescription,
					adverts: [
						AppLocalizations.of(context)!.ventricularTachycardiaAdvert,
					],
					sources: [
						AppLocalizations.of(context)!.ventricularTachycardiaSource
					],
				)
				*/
			]
		);
	}
}