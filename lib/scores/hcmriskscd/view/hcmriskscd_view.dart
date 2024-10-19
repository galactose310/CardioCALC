/// The View used in BlocBuilder from HcmRiskScdPage
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cardiocalc/services/applocalizations.dart';
import 'package:cardiocalc/views/widgets/widgets.dart';

import '../bloc/hcmriskscd_bloc.dart';
import '../model/hcmriskscd_score.dart';

class HcmRiskScdView extends StatelessWidget
{
	/// The View used in BlocBuilder from HcmRiskScdPage
	const HcmRiskScdView({Key? key}) : super(key: key);
		
	@override
	Widget build(BuildContext context)
	{
		HcmRiskScdBloc bloc = context.watch<HcmRiskScdBloc>();
		
		return Column(
			children: [
				
				SliderTile(
					title: AppLocalizations.of(context)!.age,
					value: bloc.state.age.toDouble(),
					min: HcmRiskScdScore.MIN_AGE.toDouble(),
					max: HcmRiskScdScore.MAX_AGE.toDouble(),
					onChanged: (value) => bloc.add(AgeChanged(age: value.toInt()))
				),
				
				SliderTile(
					title: AppLocalizations.of(context)!.lvThickness,
					value: bloc.state.lvThickness.toDouble(),
					min: HcmRiskScdScore.MIN_LV_THICKNESS.toDouble(),
					max: HcmRiskScdScore.MAX_LV_THICKNESS.toDouble(),
					onChanged: (value) => bloc.add(LvThicknessChanged(lvThickness: value.toInt()))
				),
				
				SliderTile(
					title: AppLocalizations.of(context)!.ladiam,
					value: bloc.state.ladiam.toDouble(),
					min: HcmRiskScdScore.MIN_LA_DIAM.toDouble(),
					max: HcmRiskScdScore.MAX_LA_DIAM.toDouble(),
					onChanged: (value) => bloc.add(LaDiamChanged(ladiam: value.toInt()))
				),
				
				SliderTile(
					title: AppLocalizations.of(context)!.lvGradient,
					value: bloc.state.lvGradient.toDouble(),
					min: HcmRiskScdScore.MIN_LV_GRADIENT.toDouble(),
					max: HcmRiskScdScore.MAX_LV_GRADIENT.toDouble(),
					onChanged: (value) => bloc.add(LvGradientChanged(lvGradient: value.toInt()))
				),
				
				SwitchTile(
					title: AppLocalizations.of(context)!.familySuddenDeath,
					value: bloc.state.familySuddenDeath,
					onChanged: (value) => bloc.add(FamilySuddenDeathToggled(familySuddenDeath: value))
				),
				
				SwitchTile(
					title: AppLocalizations.of(context)!.unsustainedVT,
					value: bloc.state.nsvt,
					onChanged: (value) => bloc.add(NSVTToggled(nsvt: value))
				),
				
				SwitchTile(
					title: AppLocalizations.of(context)!.unexplainedSyncope,
					value: bloc.state.syncope,
					onChanged: (value) => bloc.add(SyncopeToggled(syncope: value))
				),
				
				const SizedBox(height: 16),
				const Divider(),
				const SizedBox(height: 16),
				
				BlocBuilder<HcmRiskScdBloc, HcmRiskScdState>(
					builder: (BuildContext context, HcmRiskScdState state)
					{
						String interpretation;
						
						switch(state.score.riskStratification)
						{
							case HcmRiskLevel.low:
								interpretation = AppLocalizations.of(context)!.hcmRiskScdInterpretationLowRisk;
								break;
							case HcmRiskLevel.intermediate:
								interpretation = AppLocalizations.of(context)!.hcmRiskScdInterpretationIntermediateRisk;
								break;
							case HcmRiskLevel.high:
								interpretation = AppLocalizations.of(context)!.hcmRiskScdInterpretationHighRisk;
								break;
						}
						
						return ResultCard(
							scoreName: AppLocalizations.of(context)!.hcmRiskScdResultTitle,
							result: "${state.score.result.toString()}%",
							message: interpretation,
						);
					}
				),
				
				const SizedBox(height: 16),
				const Divider(),
				const SizedBox(height: 16),
				
				DescriptionCard(
					description: AppLocalizations.of(context)!.hcmRiskScdDescription,
					adverts: [
						AppLocalizations.of(context)!.hcmRiskScdAdvert,
					],
					sources: [
						AppLocalizations.of(context)!.hcmRiskScdSource,
						AppLocalizations.of(context)!.hcmRiskScdGuidelinesSource
					],
				)
			]
		);
	}
}