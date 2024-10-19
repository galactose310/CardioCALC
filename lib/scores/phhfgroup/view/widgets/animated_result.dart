part of '../phhfgroup_view.dart';

/// PhhfGroup result card with animation.
/// Also sets the text for score interpretation.
class AnimatedResult extends PageView<PhhfGroupViewModel> {
	const AnimatedResult(super.viewmodel, {super.key});
	
	static const String _invalidResultText = '';
	
	@override
	Widget build(BuildContext context)
	{
		String resultDetail;
		
		return ListenableBuilder(
			listenable: viewmodel,
			builder: (context, child)
			{
				if(!viewmodel.isReadyToCalculate)
					resultDetail = AppLocalizations.of(context)!.fillAllFields;
				
				else
				{
					switch(viewmodel.scoreInterpretation!)
					{
						case PhhfGroupInterpretation.precapillary:
							resultDetail = AppLocalizations.of(context)!.phhfGroupInterpretationPrecapillary;
							break;
						
						case PhhfGroupInterpretation.intermediate:
							resultDetail = AppLocalizations.of(context)!.phhfGroupInterpretationIntermediate;
							break;
						
						case PhhfGroupInterpretation.postacapillary:
							resultDetail = AppLocalizations.of(context)!.phhfGroupInterpretationPostcapillary;
							break;
					}
				}
				
				return ResultCard(
					scoreName: AppLocalizations.of(context)!.phhfGroupTitle,
					result: viewmodel.isReadyToCalculate ? viewmodel.score!.result.toString() : _invalidResultText,
					message: resultDetail
				);
			}
		);
	}
}