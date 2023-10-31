import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cardiocalc/services/applocalizations.dart';
import 'package:cardiocalc/views/widgets/widgets.dart';

import '../bloc/hasbled_bloc.dart';

class HasBledView extends StatelessWidget
{
	const HasBledView({Key? key}) : super(key: key);
		
	@override
	Widget build(BuildContext context)
	{
		var bloc = context.watch<HasBledBloc>();
		
		return Column(
			children: [
				SwitchTile(
					title: AppLocalizations.of(context)!.hypertension,
					value: bloc.state.hypertension,
					onChanged: (value) => bloc.add(HypertensionToggled(hypertension: value)),
					helper: AppLocalizations.of(context)!.hasBledHypertensionHelper
				),
				
				SwitchTile(
					title: AppLocalizations.of(context)!.renalFailure,
					value: bloc.state.renalFailure,
					onChanged: (value) => bloc.add(RenalFailureToggled(renalFailure: value)),
					helper: AppLocalizations.of(context)!.hasBledRenalFailureHelper
				),
				
				SwitchTile(
					title: AppLocalizations.of(context)!.hepaticFailure,
					value: bloc.state.hepaticFailure,
					onChanged: (value) => bloc.add(HepaticFailureToggled(hepaticFailure: value)),
					helper: AppLocalizations.of(context)!.hasBledHepaticFailureHelper
				),
				
				SwitchTile(
					title: AppLocalizations.of(context)!.hemorrhagicStroke,
					value: bloc.state.stroke,
					onChanged: (value) => bloc.add(StrokeToggled(stroke: value))
				),
				
				SwitchTile(
					title: AppLocalizations.of(context)!.majorBleeding,
					value: bloc.state.bleeding,
					onChanged: (value) => bloc.add(BleedingToggled(bleeding: value)),
					helper: AppLocalizations.of(context)!.hasBledMajorBleedingHelper
				),
				
				SwitchTile(
					title: AppLocalizations.of(context)!.labileINR,
					value: bloc.state.labileINR,
					onChanged: (value) => bloc.add(LabileInrToggled(labileINR: value))
				),
				
				SwitchTile(
					title: AppLocalizations.of(context)!.ageOver65,
					value: bloc.state.ageOver65,
					onChanged: (value) => bloc.add(AgeOver65Toggled(ageOver65: value))
				),
				
				SwitchTile(
					title: AppLocalizations.of(context)!.antiplateletOrNsai,
					value: bloc.state.drugs,
					onChanged: (value) => bloc.add(DrugsToggled(drugs: value))
				),
				
				SwitchTile(
					title: AppLocalizations.of(context)!.alcohol,
					value: bloc.state.alcohol,
					onChanged: (value) => bloc.add(AlcoholToggled(alcohol: value)),
					helper: AppLocalizations.of(context)!.hasBledAlcoholHelper
				),
				
				const SizedBox(height: 16),
				const Divider(),
				const SizedBox(height: 16),
				
				BlocBuilder<HasBledBloc, HasBledState>(
					builder: (BuildContext context, HasBledState state)
					{
						return ResultCard(
							scoreName: AppLocalizations.of(context)!.hasBledTitle,
							result: state.score.result.toString(),
							message: "${AppLocalizations.of(context)!.hasBledInterpretation}${state.score.risk}%.",
						);
					}
				),
				
				const SizedBox(height: 16),
				const Divider(),
				const SizedBox(height: 16),
				
				DescriptionCard(
					description: AppLocalizations.of(context)!.hasBledDescription,
					sources: [
						AppLocalizations.of(context)!.hasBledSource,
						AppLocalizations.of(context)!.hasBledRiskStratificationSource
				],
				)
			]
		);
	}
}