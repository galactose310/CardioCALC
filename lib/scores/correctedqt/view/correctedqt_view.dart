import 'package:cardiocalc/models/formulas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cardiocalc/services/applocalizations.dart';
import 'package:cardiocalc/views/widgets/widgets.dart';

import '../bloc/correctedqt_bloc.dart';

class CorrectedQTView extends StatelessWidget
{
	static const String _invalidResultText = "";
	
	const CorrectedQTView({Key? key}) : super(key: key);
		
	@override
	Widget build(BuildContext context)
	{
		CorrectedQTBloc bloc = context.watch<CorrectedQTBloc>();
		
		return Column(
			children: [
				
				BlocBuilder<CorrectedQTBloc, CorrectedQTState>(
					builder: (BuildContext context,CorrectedQTState state)
					{
						String unit;
						
						switch(state.qtIntervalUnit)
						{
							case IntervalUnit.ms:
								unit = "ms";
								break;
							case IntervalUnit.mm25:
								unit = "mm/25";
								break;
							case IntervalUnit.mm50:
								unit = "mm/50";
								break;
						}
						
						return Column(
							children: [
								TextFieldTile(
									title: AppLocalizations.of(context)!.measuredQT,
									unit: unit,
									onChanged: (value) => bloc.add(QtIntervalChanged(qtinterval: value))
								),
								ListTile(
									trailing: DropdownButton<IntervalUnit>(
										value: state.qtIntervalUnit,
										items: const [
											DropdownMenuItem<IntervalUnit>(
												value: IntervalUnit.ms,
												child: Text("ms")
											),
											DropdownMenuItem<IntervalUnit>(
												value: IntervalUnit.mm25,
												child: Text("mm - 25/s")
											),
											DropdownMenuItem<IntervalUnit>(
												value: IntervalUnit.mm50,
												child: Text("mm - 50/s")
											)
										],
										onChanged: (value) => bloc.add(QtIntervalUnitChanged(qtIntervalUnit: value!))
									)
								)
							]
						);
					}
				),
				
				TextFieldTile(
					title: AppLocalizations.of(context)!.heartRate,
					unit: "bpm",
					onChanged: (value) => bloc.add(HeartRateChanged(heartRate: value))
				),
				
				SwitchTile(
					title: AppLocalizations.of(context)!.wideQRS,
					value: bloc.state.wideQRS,
					onChanged: (value) => bloc.add(WideQRSToggled(wideQRS: value))
				),
				
				TextFieldTile(
					title: AppLocalizations.of(context)!.qrsDuration,
					unit: "ms",
					onChanged: (value) => bloc.add(QrsIntervalChanged(qrsinterval: value))
				),
				
				ListTile(
					title: Text(
						"${AppLocalizations.of(context)!.gender} :",
						style: const TextStyle(fontWeight: FontWeight.bold)
					)
				),
				Padding(
					padding: const EdgeInsets.only(left: 16),
					child: Column(
						children: [
							RadioListTile<bool>(
								title: Text(AppLocalizations.of(context)!.man),
								value: false,
								groupValue: bloc.state.female,
								onChanged: (value) => bloc.add(FemaleToggled(female: value!))
							),
							RadioListTile<bool>(
								title: Text(AppLocalizations.of(context)!.woman),
								value: true,
								groupValue: bloc.state.female,
								onChanged: (value) => bloc.add(FemaleToggled(female: value!))
							)
						]
					)
				),
				
				const SizedBox(height: 16),
				const Divider(),
				const SizedBox(height: 16),
				
				BlocBuilder<CorrectedQTBloc, CorrectedQTState>(
					builder: (BuildContext context, CorrectedQTState state)
					{
						return ResultCard(
							scoreName: AppLocalizations.of(context)!.correctedQTTitle,
							result: state.isValid ? state.score!.result.toString() : _invalidResultText,
							message: state.isValid ? AppLocalizations.of(context)!.correctedQTInterpretation : AppLocalizations.of(context)!.fillAllFields,
						);
					}
				),
				
				const SizedBox(height: 16),
				const Divider(),
				const SizedBox(height: 16),
				
				DescriptionCard(
					description: AppLocalizations.of(context)!.correctedQTDescription,
					sources: [
						AppLocalizations.of(context)!.correctedQTSource,
						AppLocalizations.of(context)!.correctedQTWideQRSSource,
						AppLocalizations.of(context)!.correctedQTGuidelinesSource
					],
				)
			]
		);
	}
}