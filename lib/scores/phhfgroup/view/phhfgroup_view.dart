import 'package:cardiocalc/scores/phhfgroup/bloc/phhfgroup_bloc.dart';
import 'package:cardiocalc/services/applocalizations.dart';
import 'package:cardiocalc/views/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/phhfgroup_interpretation.dart';

part 'widgets/animated_lvmass_form.dart';
part 'widgets/animated_result.dart';

class PhhfGroupView extends StatelessWidget
{
	const PhhfGroupView({Key? key}) : super(key: key);
		
	@override
	Widget build(BuildContext context)
	{
		var bloc = context.watch<PhhfGroupBloc>();
		
		return Column(
			children: [
				SwitchTile(
					title: AppLocalizations.of(context)!.diabetes,
					value: bloc.state.diabetes,
					onChanged: (value) => bloc.add(DiabetesToggled(diabetes: value))
				),
				
				SwitchTile(
					title: AppLocalizations.of(context)!.atrialFibrillation,
					value: bloc.state.atrialFibrillation,
					onChanged: (value) => bloc.add(AtrialFibrillationToggled(atrialFibrillation: value)),
				),
				
				TextFieldTile(
					title: AppLocalizations.of(context)!.laSurface,
					unit: "cm²",
					onChanged: (value) => bloc.add(LeftAtriumAreaChanged(leftAtriumArea: value))
				),
				
				TextFieldTile(
					title: AppLocalizations.of(context)!.rvSurface,
					unit: "cm²",
					onChanged: (value) => bloc.add(RightVentricleAreaChanged(rightVentricleArea: value)),
				),
				
				SwitchTile(
					title: AppLocalizations.of(context)!.lvMassIsKnown,
					value: context.read<PhhfGroupBloc>().state.lvmassIsKnown,
					onChanged: (value) => bloc.add(LvMassKnowledgeToggled(lvmassIsKnown: value))
				),
				
				const AnimatedLVMassForm(),
				
				const SizedBox(height: 16),
				const Divider(),
				const SizedBox(height: 16),
				
				const AnimatedResult(),
				
				const SizedBox(height: 16),
				const Divider(),
				const SizedBox(height: 16),
				
				DescriptionCard(
					description: AppLocalizations.of(context)!.phhfGroupDescription,
					adverts: [ AppLocalizations.of(context)!.phhfGroupAdvert ],
					sources: [ AppLocalizations.of(context)!.phhfGroupSource ],
				)
			]
		);
	}
}