part of '../phhfgroup_view.dart';

class AnimatedResult extends StatelessWidget
{
	const AnimatedResult({Key? key}) : super(key: key);
	
	static const String _invalidResultText = "";
	
	@override
	Widget build(BuildContext context)
	{
		String resultDetail;
		
		return BlocBuilder<PhhfGroupBloc, PhhfGroupState>(
			builder: (context, state)
			{
				if(!state.isValid || state.interpretation == null) resultDetail = AppLocalizations.of(context)!.fillAllFields;
				
				else
				{
					switch(state.interpretation!)
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
					result: (state.isValid && state.result != null) ? state.result.toString() : _invalidResultText,
					message: resultDetail
				);
				
				/*
				return ResultCard(
					title: Row(
						children: [
							ResultCardTitlePart(text: AppLocalizations.of(context)!.phhfGroupTitle),
							AnimatedSwitcher(
								duration: const Duration(milliseconds: _titleAnimationDuration),
								child: mainResultWidget,
								transitionBuilder: (Widget child, Animation<double> animation)
								{
									return ScaleTransition(scale: animation, child: child);
								},
							)
						]
					),
					content: SlidingAnimatedSwitcher(
						child: RichText(
							key: ValueKey(resultDetail),
							textAlign: TextAlign.justify,
							text: TextSpan(
								style: Theme.of(context).textTheme.subtitle1?.copyWith(
									color: Theme.of(context).colorScheme.onTertiaryContainer
								),
								children: Markdown.parse(
									text: state.isValid ? resultDetail : AppLocalizations.of(context)!.fillAllFields
								)
							)
						)
					)
				);
				*/
			}
		);
	}
}