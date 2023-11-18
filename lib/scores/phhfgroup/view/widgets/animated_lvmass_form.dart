part of '../phhfgroup_view.dart';

class AnimatedLVMassForm extends StatefulWidget
{
	const AnimatedLVMassForm({Key? key}) : super(key: key);
	
	@override
	State<AnimatedLVMassForm> createState() => new AnimatedLVMassFormState();
}

class AnimatedLVMassFormState extends State<AnimatedLVMassForm>
{
	final TextEditingController lvmassController = new TextEditingController();
	final TextEditingController septumController = new TextEditingController();
	final TextEditingController lvdiamController = new TextEditingController();
	final TextEditingController lvwallController = new TextEditingController();
	final TextEditingController heightController = new TextEditingController();
	final TextEditingController weightController = new TextEditingController();
	
	@override
	Widget build(BuildContext context)
	{
		var bloc = context.read<PhhfGroupBloc>();
		
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
	
	@override
	void dispose()
	{
		super.dispose();
		this.heightController.dispose();
		this.lvdiamController.dispose();
		this.lvmassController.dispose();
		this.lvwallController.dispose();
		this.septumController.dispose();
		this.weightController.dispose();
	}
}