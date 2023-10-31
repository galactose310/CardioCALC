import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cardiocalc/services/applocalizations.dart';
import 'package:cardiocalc/views/widgets/widgets.dart';

import '../bloc/chadsvasc_bloc.dart';

class ChadsVascView extends StatelessWidget
{
	const ChadsVascView({Key? key}) : super(key: key);
		
	@override
	Widget build(BuildContext context)
	{
		var bloc = context.watch<ChadsVascBloc>();
		
		return Column(
			children: [
				SwitchTile(
					title: AppLocalizations.of(context)!.heartFailure,
					value: bloc.state.heartFailure,
					onChanged: (value) => bloc.add(HeartFailureToggled(heartFailure: value)),
					helper: AppLocalizations.of(context)!.chadsVascHeartFailureHelper,
				),
				
				SwitchTile(
					title: AppLocalizations.of(context)!.hypertension,
					value: bloc.state.hypertension,
					onChanged: (value) => bloc.add(HypertensionToggled(hypertension: value)),
				),
				
				SwitchTile(
					title: AppLocalizations.of(context)!.ageOver65,
					value: bloc.state.ageOver65,
					onChanged: (value) => bloc.add(AgeOver65Toggled(ageOver65: value)),
				),
				
				SwitchTile(
					title: AppLocalizations.of(context)!.diabetes,
					value: bloc.state.diabetes,
					onChanged: (value) => bloc.add(DiabetesToggled(diabetes: value)),
				),
				
				SwitchTile(
					title: AppLocalizations.of(context)!.stroke,
					value: bloc.state.stroke,
					onChanged: (value) => bloc.add(StrokeToggled(stroke: value)),
				),
				
				SwitchTile(
					title: AppLocalizations.of(context)!.vascularDisease,
					value: bloc.state.vascularDisease,
					onChanged: (value) => bloc.add(VascularDiseaseToggled(vascularDisease: value)),
					helper: AppLocalizations.of(context)!.chadsVascVascularDiseaseHelper,
				),
				
				SwitchTile(
					title: AppLocalizations.of(context)!.ageOver75,
					value: bloc.state.ageOver75,
					onChanged: (value) => bloc.add(AgeOver75Toggled(ageOver75: value)),
				),
				
				SwitchTile(
					title: AppLocalizations.of(context)!.female,
					value: bloc.state.female,
					onChanged: (value) => bloc.add(FemaleSexToggled(female: value)),
				),
				
				const SizedBox(height: 16),
				const Divider(),
				const SizedBox(height: 16),
				
				BlocBuilder<ChadsVascBloc, ChadsVascState>(
					builder: (BuildContext context, ChadsVascState state)
					{
						return ResultCard(
							scoreName: AppLocalizations.of(context)!.chadsVascTitle,
							result: state.score.result.toString(),
							message: "${AppLocalizations.of(context)!.chadsVascInterpretation} ${state.score.risk.toString()}%.",
						);
					}
				),
				
				const SizedBox(height: 16),
				const Divider(),
				const SizedBox(height: 16),
				
				DescriptionCard(
					description: AppLocalizations.of(context)!.chadsVascDescription,
					sources: [
						AppLocalizations.of(context)!.chadsVascSource,
						AppLocalizations.of(context)!.chadsVascRiskStratificationSource,
						AppLocalizations.of(context)!.chadsVascGuidelinesSource
					],
				)
			]
		);
	}
}