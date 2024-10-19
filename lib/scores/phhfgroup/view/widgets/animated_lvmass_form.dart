part of '../phhfgroup_view.dart';

/// Builds a child form depending on the LV mass is known or not.
/// If not, show the complete form to compute LV mass index.
class AnimatedLVMassForm extends StatefulWidget {
	final PhhfGroupViewModel viewmodel;
	const AnimatedLVMassForm(this.viewmodel, {super.key});
	
	@override
	State<AnimatedLVMassForm> createState() => new AnimatedLVMassFormState();
}

class AnimatedLVMassFormState extends State<AnimatedLVMassForm> {
	// StatefulWidget is mandatory to correctly set and dispose those text controllers.
	// If not, user input disappears when switching between the forms.
	// In the same way, main child (TextFieldTile or Column): must have a defined ValueKey.
	final TextEditingController lvmassController = new TextEditingController();
	final TextEditingController septumController = new TextEditingController();
	final TextEditingController lvdiamController = new TextEditingController();
	final TextEditingController lvwallController = new TextEditingController();
	final TextEditingController heightController = new TextEditingController();
	final TextEditingController weightController = new TextEditingController();
	
	@override
	Widget build(BuildContext context) {
		PhhfGroupViewModel viewmodel = widget.viewmodel;
		
		lvmassController.addListener(() => viewmodel.onIndexedLvMassChanged(lvmassController.text));
		septumController.addListener(() => viewmodel.onSeptumChanged(septumController.text));
		lvdiamController.addListener(() => viewmodel.onLvDiamChanged(lvdiamController.text));
		lvwallController.addListener(() => viewmodel.onLvWallChanged(lvwallController.text));
		heightController.addListener(() => viewmodel.onHeightChanged(heightController.text));
		weightController.addListener(() => viewmodel.onWeightChanged(weightController.text));
		
		return ListenableBuilder(
			listenable: viewmodel,
			builder: (context, state) {
				Widget child;
				
				if(viewmodel.lvmassIsKnown) child = TextFieldTile(
					key: ValueKey(viewmodel.lvmassIsKnown),
					controller: lvmassController,
					title: AppLocalizations.of(context)!.lvMass,
					unit: viewmodel.indexedLvMassUnit.name,
					isValid: viewmodel.indexedLvMass?.isValid ?? true,
					textInputAction: TextInputAction.done
				);
				
				else child = Column(
					key: ValueKey(viewmodel.lvmassIsKnown),
					children: [
						TextFieldTile(
							title: AppLocalizations.of(context)!.septum,
							controller: septumController,
							unit: viewmodel.septumUnit.name,
							isValid: viewmodel.septum?.isValid ?? true,
							isUnusual: viewmodel.septum?.isUnusual ?? false
						),
						TextFieldTile(
							title: AppLocalizations.of(context)!.lvdiam,
							controller: lvdiamController,
							unit: viewmodel.lvdiamUnit.name,
							isValid: viewmodel.lvdiam?.isValid ?? true,
							isUnusual: viewmodel.lvdiam?.isUnusual ?? false
						),
						TextFieldTile(
							title: AppLocalizations.of(context)!.lvwall,
							controller: lvwallController,
							unit: viewmodel.lvwallUnit.name,
							isValid: viewmodel.lvwall?.isValid ?? true,
							isUnusual: viewmodel.lvwall?.isUnusual ?? false
						),
						TextFieldTile(
							title: AppLocalizations.of(context)!.height,
							controller: heightController,
							unit: viewmodel.heightUnit.name,
							isValid: viewmodel.height?.isValid ?? true,
							isUnusual: viewmodel.height?.isUnusual ?? false
						),
						TextFieldTile(
							title: AppLocalizations.of(context)!.weight,
							controller: weightController,
							unit: viewmodel.weightUnit.name,
							isValid: viewmodel.weight?.isValid ?? true,
							isUnusual: viewmodel.weight?.isUnusual ?? false,
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