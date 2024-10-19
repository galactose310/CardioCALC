/// The View used in BlocBuilder from PhhfGroupPage
import 'package:cardiocalc/services/applocalizations.dart';
import 'package:cardiocalc/views/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../model/phhfgroup_score.dart' show PhhfGroupInterpretation;
import '../phhfgroup_viewmodel.dart';

part 'widgets/animated_lvmass_form.dart';
part 'widgets/animated_result.dart';

abstract class PageView<T extends ChangeNotifier> extends StatelessWidget {
	final T viewmodel;
	
	const PageView(this.viewmodel, {super.key});
}

class PhhfGroupView extends PageView<PhhfGroupViewModel> {
	const PhhfGroupView(super.viewmodel, {super.key});

	@override
	Widget build(BuildContext context)
	{
		return Column(
			children: [
				ListenableBuilder(
					listenable: viewmodel,
					builder: (context, child) {
						return Column(children: [
							SwitchTile(
								title: AppLocalizations.of(context)!.diabetes,
								value: viewmodel.diabetes,
								onChanged: viewmodel.onDiabetesToggled
							),
							
							SwitchTile(
								title: AppLocalizations.of(context)!.atrialFibrillation,
								value: viewmodel.atrialFibrillation,
								onChanged: viewmodel.onAtrialFibrillationToggled
							),
							
							TextFieldTile(
								title: AppLocalizations.of(context)!.laSurface,
								unit: viewmodel.leftAtriumAreaUnit.name,
								isValid: viewmodel.leftAtriumArea?.isValid ?? true,
								isUnusual: viewmodel.leftAtriumArea?.isUnusual ?? false,
								onChanged: viewmodel.onLeftAtriumAreaChanged
							),
							
							TextFieldTile(
								title: AppLocalizations.of(context)!.rvSurface,
								unit: viewmodel.rightVentricleAreaUnit.name,
								isValid: viewmodel.rightVentricleArea?.isValid ?? true,
								isUnusual: viewmodel.rightVentricleArea?.isUnusual ?? false,
								onChanged: viewmodel.onRightVentricleAreaChanged
							),
							
							SwitchTile(
								title: AppLocalizations.of(context)!.lvMassIsKnown,
								value: viewmodel.lvmassIsKnown,
								onChanged: viewmodel.onLvMassIsKnownToggled
							)
						]);
					}
				),
				
				AnimatedLVMassForm(viewmodel),
				
				const SizedBox(height: 16),
				const Divider(),
				const SizedBox(height: 16),
				
				AnimatedResult(viewmodel),
				
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