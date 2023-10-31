import 'package:cardiocalc/scores/canadiansyncope/model/canadiansyncope_score.dart';
import 'package:cardiocalc/services/applocalizations.dart';
import 'package:cardiocalc/views/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/canadiansyncope_bloc.dart';

class CanadianSyncopeView extends StatelessWidget
{
	const CanadianSyncopeView({Key? key}) : super(key: key);
		
	@override
	Widget build(BuildContext context)
	{
		var bloc = context.watch<CanadianSyncopeBloc>();
		
		return Column(
			children: [
				SwitchTile(
					title: AppLocalizations.of(context)!.vagalPredisposition,
					value: bloc.state.vagalPredisposition,
					onChanged: (value) => bloc.add(VagalPredispositionToggled(vagalPredisposition: value)),
					helper: AppLocalizations.of(context)!.canadianSyncopeHelperVagalPredisposition,
				),
				
				SwitchTile(
					title: AppLocalizations.of(context)!.cardiacHistory,
					value: bloc.state.cardiacHistory,
					onChanged: (value) => bloc.add(CardiacHistoryToggled(cardiacHistory: value)),
					helper: AppLocalizations.of(context)!.canadianSyncopeHelperCardiacHistory
				),
				
				SwitchTile(
					title: AppLocalizations.of(context)!.bpLT90orGT180,
					value: bloc.state.abnormalBP,
					onChanged: (value) => bloc.add(AbnormalBPToggled(abnormalBP: value)),
					helper: AppLocalizations.of(context)!.canadianSyncopeHelperAbnormalBP
				),
				
				SwitchTile(
					title: AppLocalizations.of(context)!.elevatedTroponine,
					value: bloc.state.troponin,
					onChanged: (value) => bloc.add(TroponinToggled(troponin: value)),
				),
				
				SwitchTile(
					title: AppLocalizations.of(context)!.abnormalQRSaxis,
					value: bloc.state.abnormalAxis,
					onChanged: (value) => bloc.add(AbnormalAxisToggled(abnormalAxis: value)),
					helper: AppLocalizations.of(context)!.canadianSyncopeHelperAbnormalAxis
				),
				
				SwitchTile(
					title: AppLocalizations.of(context)!.qrsOver130,
					value: bloc.state.largeQRS,
					onChanged: (value) => bloc.add(LargeQRSToggled(largeQRS: value)),
				),
				
				SwitchTile(
					title: AppLocalizations.of(context)!.qtOver480,
					value: bloc.state.longQT,
					onChanged: (value) => bloc.add(LongQTToggled(longQT: value)),
				),
				
				BlocBuilder<CanadianSyncopeBloc, CanadianSyncopeState>(
					builder:(BuildContext context, CanadianSyncopeState state)
					{
						return ListView(
							shrinkWrap: true,
							children: [
								ListTile(
									title: Text(
										"${AppLocalizations.of(context)!.diagnosisAtER} :",
										style: const TextStyle(fontWeight: FontWeight.bold)
									)
								),
								Padding(
									padding: const EdgeInsets.only(left: 16),
									child: Column(
										children: [
										RadioListTile<EmergencyDiagnosis>(
											value: EmergencyDiagnosis.cardiacSyncope,
											groupValue: state.diagnosis,
											title: Text(AppLocalizations.of(context)!.cardiacSyncope),
											onChanged: (value) => bloc.add(DiagnosisToggled(diagnosis: value!))
										),
										RadioListTile<EmergencyDiagnosis>(
											value: EmergencyDiagnosis.vasovagalSyncope,
											groupValue: state.diagnosis,
											title: Text(AppLocalizations.of(context)!.vasovagalSyncope),
											onChanged: (value) => bloc.add(DiagnosisToggled(diagnosis: value!))
										),
										RadioListTile<EmergencyDiagnosis>(
											value: EmergencyDiagnosis.other,
											groupValue: state.diagnosis,
											title: Text(AppLocalizations.of(context)!.otherDiagnosis),
											onChanged: (value) => bloc.add(DiagnosisToggled(diagnosis: value!))
										)
									])
								)
							],
						);
					},
				),
				
				const SizedBox(height: 16),
				const Divider(),
				const SizedBox(height: 16),
				
				BlocBuilder<CanadianSyncopeBloc, CanadianSyncopeState>(
					builder: (BuildContext context, CanadianSyncopeState state)
					{
						String riskLevel;
						
						switch(state.score.riskLevel)
						{
							case CanadianSyncopeRiskLevel.veryLow:
								riskLevel = AppLocalizations.of(context)!.canadianSyncopeRiskVeryLow;
								break;
							case CanadianSyncopeRiskLevel.low:
								riskLevel = AppLocalizations.of(context)!.canadianSyncopeRiskLow;
								break;
							
							case CanadianSyncopeRiskLevel.intermediate:
								riskLevel = AppLocalizations.of(context)!.canadianSyncopeRiskIntermediate;
								break;
							
							case CanadianSyncopeRiskLevel.high:
								riskLevel = AppLocalizations.of(context)!.canadianSyncopeRiskHigh;
								break;
							
							case CanadianSyncopeRiskLevel.veryHigh:
								riskLevel = AppLocalizations.of(context)!.canadianSyncopeRiskVeryHigh;
								break;
							default:
								riskLevel = AppLocalizations.of(context)!.fillAllFields;
								break;
						}
						
						return ResultCard(
							scoreName: AppLocalizations.of(context)!.canadianSyncopeTitle,
							result: state.score.score.toString(),
							message: "$riskLevel ${AppLocalizations.of(context)!.canadianSyncopeRiskEstimation} ${state.score.riskPercentage.toString()}%.",
						);
					}
				),
				
				const SizedBox(height: 16),
				const Divider(),
				const SizedBox(height: 16),
				
				DescriptionCard(
					description: AppLocalizations.of(context)!.canadianSyncopeDescription,
					adverts: [
						AppLocalizations.of(context)!.canadianSyncopeAdvertConditions,
						AppLocalizations.of(context)!.canadianSyncopeAdvertNotValidated
					],
					sources: [ AppLocalizations.of(context)!.canadianSyncopeSource ],
				)
			]
		);
	}
}