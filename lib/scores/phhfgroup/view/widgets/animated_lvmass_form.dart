part of '../phhfgroup_view.dart';

class AnimatedLVMassForm extends StatelessWidget
{
	const AnimatedLVMassForm({Key? key}) : super(key: key);
	
	@override
	Widget build(BuildContext context)
	{
		var bloc = context.read<PhhfGroupBloc>();
		
		TextEditingController lvmassController = new TextEditingController();
		TextEditingController septumController = new TextEditingController();
		TextEditingController lvdiamController = new TextEditingController();
		TextEditingController lvwallController = new TextEditingController();
		TextEditingController heightController = new TextEditingController();
		TextEditingController weightController = new TextEditingController();
		
		lvmassController.addListener(() => bloc.add(LVMassChanged(lvmass: lvmassController.text)));
		septumController.addListener(() => bloc.add(SeptumChanged(septum: septumController.text)));
		lvdiamController.addListener(() => bloc.add(LVDiamChanged(lvdiam: lvdiamController.text)));
		lvwallController.addListener(() => bloc.add(LVWallChanged(lvwall: lvwallController.text)));
		heightController.addListener(() => bloc.add(HeightChanged(height: heightController.text)));
		weightController.addListener(() => bloc.add(WeightChanged(weight: weightController.text)));
		
		return BlocBuilder<PhhfGroupBloc, PhhfGroupState>(
			builder: (context, state)
			{
				Widget child;
				
				if(state.lvmassIsKnown) child = TextFieldTile(
					key: ValueKey(state.lvmassIsKnown),
					controller: lvmassController,
					title: AppLocalizations.of(context)!.lvMass,
					unit: "g/m²",
					textInputAction: TextInputAction.done
				);
				
				else child = Column(
					key: ValueKey(state.lvmassIsKnown),
					children: [
						TextFieldTile(
							title: AppLocalizations.of(context)!.septum,
							controller: septumController,
							unit: "mm",
						),
						TextFieldTile(
							title: AppLocalizations.of(context)!.lvdiam,
							controller: lvdiamController,
							unit: "mm",
						),
						TextFieldTile(
							title: AppLocalizations.of(context)!.lvwall,
							controller: lvwallController,
							unit: "mm",
						),
						TextFieldTile(
							title: AppLocalizations.of(context)!.height,
							controller: heightController,
							unit: "cm",
						),
						TextFieldTile(
							title: AppLocalizations.of(context)!.weight,
							controller: weightController,
							unit: "kg",
							textInputAction: TextInputAction.done,
						)
					]
				);
				
				return SlidingAnimatedSwitcher(
					axis: Axis.vertical,
					child: child
				);
			}
		);
	}
}