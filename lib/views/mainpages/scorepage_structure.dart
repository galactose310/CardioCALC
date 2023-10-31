import 'package:flutter/material.dart';
import 'package:cardiocalc/blocs/scoresbloc.dart';
import 'package:cardiocalc/providers/blocprovider.dart';
import 'package:cardiocalc/models/score.dart';
import 'package:cardiocalc/views/widgets/widgets.dart';

class ScorePage extends StatelessWidget
{
	final Widget body;
	
	const ScorePage({Key? key, required this.body}) : super(key: key);
	
	@override
	Widget build(BuildContext context)
	{
		final ScoresBloc bloc = BlocProvider.of<ScoresBloc>(context);
		final Score score = (ModalRoute.of(context)!.settings.arguments as Score?)
			?? new Score(label: "unknownScore", name: "Unknown Score", detail: "Error: score has not been implemented.");
		
		return SafeArea(
			top: false,
			child: Scaffold(
				appBar: AppBar(
					title: Text(score.name),
					actions: [
						FavoriteButton(
							score: score,
							onPressed: () => bloc.toggle(score: score, event: ScoreEvent.Toggle)
						)
					],
				),
				body: SingleChildScrollView(
					child: Padding(
						padding: const EdgeInsets.all(16),
						child: this.body
					)
				)
			)
		);
	}
}