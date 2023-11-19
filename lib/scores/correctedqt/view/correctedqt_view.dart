import 'package:cardiocalc/models/formulas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cardiocalc/services/applocalizations.dart';
import 'package:cardiocalc/views/widgets/widgets.dart';

import '../bloc/correctedqt_bloc.dart';

class CorrectedQTView extends StatefulWidget
{
	const CorrectedQTView({Key? key}) : super(key: key);
	
	@override
	State<CorrectedQTView> createState() => new CorrectedQTViewState();
}

class CorrectedQTViewState extends State<CorrectedQTView>
{
	static const String _invalidResultText = "";
	
	final TextEditingController qtintervalController = new TextEditingController();
	final TextEditingController rrintervalController = new TextEditingController();
	final TextEditingController heartrateController = new TextEditingController();
	final TextEditingController qrsintervalController = new TextEditingController();
	
	@override
	Widget build(BuildContext context)
	{
		CorrectedQTBloc bloc = context.read<CorrectedQTBloc>();
		
		qtintervalController.addListener(() => bloc.add(QtIntervalChanged(qtinterval: qtintervalController.text)));
		rrintervalController.addListener(() => bloc.add(RrIntervalChanged(rrinterval: rrintervalController.text)));
		heartrateController.addListener(() => bloc.add(HeartRateChanged(heartRate: heartrateController.text)));
		qrsintervalController.addListener(() => bloc.add(QrsIntervalChanged(qrsinterval: qrsintervalController.text)));
		
		return BlocBuilder<CorrectedQTBloc, CorrectedQTState>(
			builder: (BuildContext context, CorrectedQTState state)
			{
				String qtIntervalUnit;
				
				switch(state.qtIntervalUnit)
				{
					case IntervalUnit.ms:
						qtIntervalUnit = "ms";
						break;
					case IntervalUnit.mm25:
						qtIntervalUnit = "mm/25";
						break;
					case IntervalUnit.mm50:
						qtIntervalUnit = "mm/50";
					break;
				}
				
				String rrIntervalUnit;
				
				switch(state.rrIntervalUnit)
				{
					case IntervalUnit.ms:
						rrIntervalUnit = "ms";
						break;
					case IntervalUnit.mm25:
						rrIntervalUnit = "mm/25";
						break;
					case IntervalUnit.mm50:
						rrIntervalUnit = "mm/50";
						break;
				}
				
				String qrsIntervalUnit;
				
				switch(state.qrsIntervalUnit)
				{
					case IntervalUnit.ms:
						qrsIntervalUnit = "ms";
						break;
					case IntervalUnit.mm25:
						qrsIntervalUnit = "mm/25";
						break;
					case IntervalUnit.mm50:
						qrsIntervalUnit = "mm/50";
						break;
				}
				
				Widget hrOrIntervalSwitcher;
				
				if(state.method == CorrectionMethod.heartRate) hrOrIntervalSwitcher = TextFieldTile(
					title: AppLocalizations.of(context)!.heartRate,
					unit: "bpm",
					controller: heartrateController,
					textInputAction: TextInputAction.done
				);
				
				else hrOrIntervalSwitcher = Column(
					children: [
						TextFieldTile(
							title: AppLocalizations.of(context)!.rrInterval,
							unit: rrIntervalUnit,
							controller: rrintervalController,
							textInputAction: TextInputAction.done
						),
						ListTile(
							trailing: DropdownButton<IntervalUnit>(
								value: state.rrIntervalUnit,
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
								onChanged: (value) => bloc.add(RrIntervalUnitChanged(rrIntervalUnit: value!))
							)
						)
					]
				);
				
				Widget wideQrsSwitcher;
				Widget sizedBox = const SizedBox(height: 16);
				
				if(state.wideQRS) wideQrsSwitcher = Column(children: [
					TextFieldTile(
						title: AppLocalizations.of(context)!.qrsDuration,
						unit: qrsIntervalUnit,
						controller: qrsintervalController,
						textInputAction: TextInputAction.done
					),
					ListTile(
						trailing: DropdownButton<IntervalUnit>(
							value: state.qrsIntervalUnit,
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
							onChanged: (value) => bloc.add(QrsIntervalUnitChanged(qrsIntervalUnit: value!))
						)
					),
					SegmentedButtonTile<bool>(
						//title: "${AppLocalizations.of(context)!.gender} :",
						//titleBold: true,
						segments: <ButtonSegment<bool>>[
							ButtonSegment(
								value: false,
								label: Text(AppLocalizations.of(context)!.man),
							),
							ButtonSegment(
								value: true,
								label: Text(AppLocalizations.of(context)!.woman)
							)
						],
						selected: {bloc.state.female},
						onSelectionChanged: (femaleBool) => bloc.add(FemaleToggled(female: femaleBool.single)),
					),
					
					sizedBox,
				]);
				
				else wideQrsSwitcher = sizedBox;
				
				List<Widget> children = [];
				
				children.addAll([
					TextFieldTile(
						title: AppLocalizations.of(context)!.measuredQT,
						unit: qtIntervalUnit,
						controller: qtintervalController,
						textInputAction: TextInputAction.done
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
					),
					SegmentedButtonTile<CorrectionMethod>(
						segments: <ButtonSegment<CorrectionMethod>>[
							ButtonSegment<CorrectionMethod>(
								value: CorrectionMethod.heartRate,
								label: Text(AppLocalizations.of(context)!.heartRateAbrev)
							),
							ButtonSegment<CorrectionMethod>(
								value: CorrectionMethod.rrInterval,
								label: Text(AppLocalizations.of(context)!.interval)
							)
						],
						selected: {bloc.state.method},
						onSelectionChanged: (Set<CorrectionMethod> newMethod) => bloc.add(CorrectionMethodChanged(method: newMethod.single)),
					),
					SlidingAnimatedSwitcher(
						axis: Axis.vertical,
						child: hrOrIntervalSwitcher
					),
					SwitchTile(
						title: AppLocalizations.of(context)!.wideQRS,
						value: bloc.state.wideQRS,
						onChanged: (value) => bloc.add(WideQRSToggled(wideQRS: value))
					),
					SlidingAnimatedSwitcher(
						axis: Axis.vertical,
						child: wideQrsSwitcher,
					),
					const Divider(),
					const SizedBox(height: 16),
					ResultCard(
						scoreName: AppLocalizations.of(context)!.correctedQTTitle,
						result: state.isValid ? "${state.score!.result.toString()} ms" : _invalidResultText,
						message: state.isValid ? AppLocalizations.of(context)!.correctedQTInterpretation : AppLocalizations.of(context)!.fillAllFields,
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
				]);
				
				return Column(children: children);
			}
		);
	}
	
	@override
	void dispose()
	{
		super.dispose();
		this.heartrateController.dispose();
		this.qtintervalController.dispose();
		this.rrintervalController.dispose();
		this.qrsintervalController.dispose();
	}
	
	
	
	/*
	
				DO NOT DELETE UNTIL RESOLVED
				SAVE TO FIX TEXTEDITINGCONTROLLER AND BLOCBUILDER ISSUE
	
	
	@override
	Widget build(BuildContext context)
	{
		CorrectedQTBloc bloc = context.read<CorrectedQTBloc>();
		
		TextEditingController qtintervalController = new TextEditingController();
		TextEditingController rrintervalController = new TextEditingController();
		TextEditingController heartrateController = new TextEditingController();
		TextEditingController qrsintervalController = new TextEditingController();
		
		qtintervalController.addListener(() => bloc.add(QtIntervalChanged(qtinterval: qtintervalController.text)));
		rrintervalController.addListener(() => bloc.add(RrIntervalChanged(rrinterval: rrintervalController.text)));
		heartrateController.addListener(() => bloc.add(HeartRateChanged(heartRate: heartrateController.text)));
		qrsintervalController.addListener(() => bloc.add(QrsIntervalChanged(qrsinterval: qrsintervalController.text)));
		
		return Column(
			children: [
				
				BlocBuilder<CorrectedQTBloc, CorrectedQTState>(
					builder: (BuildContext context, CorrectedQTState state)
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
									controller: qtintervalController,
									textInputAction: TextInputAction.done
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
				
				SegmentedButtonTile<CorrectionMethod>(
					segments: const <ButtonSegment<CorrectionMethod>>[
						ButtonSegment<CorrectionMethod>(
							value: CorrectionMethod.heartRate,
							label: Text("Fréq. cardiaque")
						),
						ButtonSegment<CorrectionMethod>(
							value: CorrectionMethod.rrInterval,
							label: Text("Intervalle")
						)
					],
					selected: {bloc.state.method},
					onSelectionChanged: (Set<CorrectionMethod> newMethod) => bloc.add(CorrectionMethodChanged(method: newMethod.single)),
				),
				
				BlocBuilder<CorrectedQTBloc, CorrectedQTState>(
					builder: (BuildContext context, CorrectedQTState state)
					{
						Widget child;
						String unit;
						
						switch(state.rrIntervalUnit)
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
						
						if(state.method == CorrectionMethod.heartRate) child = TextFieldTile(
							title: AppLocalizations.of(context)!.heartRate,
							unit: "bpm",
							controller: heartrateController,
							textInputAction: TextInputAction.done
						);
						
						else child = Column(
							children: [
								TextFieldTile(
									title: AppLocalizations.of(context)!.rrInterval,
									unit: unit,
									controller: rrintervalController,
									textInputAction: TextInputAction.done
								),
								ListTile(
									trailing: DropdownButton<IntervalUnit>(
										value: state.rrIntervalUnit,
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
										onChanged: (value) => bloc.add(RrIntervalUnitChanged(rrIntervalUnit: value!))
									)
								)
							]
						);
						
						return SlidingAnimatedSwitcher(
							axis: Axis.vertical,
							child: child
						);
					}
				),
				
				SwitchTile(
					title: AppLocalizations.of(context)!.wideQRS,
					value: bloc.state.wideQRS,
					onChanged: (value) => bloc.add(WideQRSToggled(wideQRS: value))
				),
				
				BlocBuilder<CorrectedQTBloc, CorrectedQTState>(
					builder: (BuildContext context, CorrectedQTState state)
					{
						Widget child;
						Widget sizedBox = const SizedBox(height: 16);
						
						if(state.wideQRS) child = Column(children: [
							TextFieldTile(
								title: AppLocalizations.of(context)!.qrsDuration,
								unit: "ms",
								controller: qrsintervalController,
								textInputAction: TextInputAction.done
							),
							
							SegmentedButtonTile<bool>(
								//title: "${AppLocalizations.of(context)!.gender} :",
								//titleBold: true,
								segments: <ButtonSegment<bool>>[
									ButtonSegment(
										value: false,
										label: Text(AppLocalizations.of(context)!.man),
									),
									ButtonSegment(
										value: true,
										label: Text(AppLocalizations.of(context)!.woman)
									)
								],
								selected: {bloc.state.female},
								onSelectionChanged: (femaleBool) => bloc.add(FemaleToggled(female: femaleBool.single)),
							),
							
							sizedBox,
						]);
						
						else child = sizedBox;
						
						return SlidingAnimatedSwitcher(
							axis: Axis.vertical,
							child: child,
						);
					},
				),
				
				const Divider(),
				const SizedBox(height: 16),
				
				BlocBuilder<CorrectedQTBloc, CorrectedQTState>(
					builder: (BuildContext context, CorrectedQTState state)
					{
						return ResultCard(
							scoreName: AppLocalizations.of(context)!.correctedQTTitle,
							result: state.isValid ? "${state.score!.result.toString()} ms" : _invalidResultText,
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
	*/
}