/// The View used in BlocBuilder from HemorrhagesPage
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cardiocalc/services/applocalizations.dart';
import 'package:cardiocalc/views/widgets/widgets.dart';

import '../bloc/hemorrhages_bloc.dart';

class HemorrhagesView extends StatelessWidget
{
	/// The View used in BlocBuilder from HemorrhagesPage
	const HemorrhagesView({Key? key}) : super(key: key);
		
	@override
	Widget build(BuildContext context)
	{
		HemorrhagesBloc bloc = context.watch<HemorrhagesBloc>();
		
		return Column(
			children: [
				SwitchTile(
					title: AppLocalizations.of(context)!.renalOrHepaticDisease,
					value: bloc.state.renalOrLiver,
					onChanged: (value) => bloc.add(RenalOrLiverToggled(renalOrLiver: value))
				),
				
				SwitchTile(
					title: AppLocalizations.of(context)!.alcohol,
					value: bloc.state.alcohol,
					onChanged: (value) => bloc.add(AlcoholToggled(alcohol: value))
				),
				
				SwitchTile(
					title: AppLocalizations.of(context)!.activeCancer,
					value: bloc.state.cancer,
					onChanged: (value) => bloc.add(CancerToggled(cancer: value))
				),
				
				SwitchTile(
					title: AppLocalizations.of(context)!.ageOver75,
					value: bloc.state.ageOver75,
					onChanged: (value) => bloc.add(AgeOver75Toggled(ageOver75: value))
				),
				
				 SwitchTile(
					title: AppLocalizations.of(context)!.thrombopeniaOrPlateletDysfunction,
					value: bloc.state.thrombopenia,
					onChanged: (value) => bloc.add(ThrombopeniaToggled(thrombopenia: value)),
					helper: AppLocalizations.of(context)!.hemorrhagesThrombopeniaHelper
				 ),
				 
				 SwitchTile(
					title: AppLocalizations.of(context)!.historyOfBleeding,
					value: bloc.state.bleeding,
					onChanged: (value) => bloc.add(BleedingToggled(bleeding: value))
				 ),
				 
				 SwitchTile(
					title: AppLocalizations.of(context)!.uncontrolledHypertension,
					value: bloc.state.hypertension,
					onChanged: (value) => bloc.add(HypertensionToggled(hypertension: value))
				 ),
				 
				 SwitchTile(
					title: AppLocalizations.of(context)!.anemia,
					value: bloc.state.anemia,
					onChanged: (value) => bloc.add(AnemiaToggled(anemia: value))
				 ),
				 
				 SwitchTile(
					title: AppLocalizations.of(context)!.geneticFactors,
					value: bloc.state.genetics,
					onChanged: (value) => bloc.add(GeneticsToggled(genetics: value)),
					helper: AppLocalizations.of(context)!.hemorrhagesGeneticsHelper
				 ),
				 
				 SwitchTile(
					title: AppLocalizations.of(context)!.riskOfFalls,
					value: bloc.state.fallrisk,
					onChanged: (value) => bloc.add(FallRiskToggled(fallrisk: value)),
					helper: AppLocalizations.of(context)!.hemorrhagesFallriskHelper
				 ),
				 
				 SwitchTile(
					title: AppLocalizations.of(context)!.historyOfStroke,
					value: bloc.state.stroke,
					onChanged: (value) => bloc.add(StrokeToggled(stroke: value))
				 ),
				
				const SizedBox(height: 16),
				const Divider(),
				const SizedBox(height: 16),
				
				BlocBuilder<HemorrhagesBloc, HemorrhagesState>(
					builder: (BuildContext context, HemorrhagesState state)
					{
						return ResultCard(
							scoreName: AppLocalizations.of(context)!.hemorrhagesTitle,
							result: state.score.result.toString(),
							message: "${AppLocalizations.of(context)!.hemorrhagesInterpretation}${state.score.risk}%.",
						);
					}
				),
				
				const SizedBox(height: 16),
				const Divider(),
				const SizedBox(height: 16),
				
				DescriptionCard(
					description: AppLocalizations.of(context)!.hemorrhagesDescription,
					sources: [
						AppLocalizations.of(context)!.hemorrhagesSource,
						AppLocalizations.of(context)!.hemorrhagesValidationSource
					],
				)
			]
		);
	}
}