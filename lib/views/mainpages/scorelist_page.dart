import 'package:flutter/material.dart';
import 'package:cardiocalc/services/applocalizations.dart';
import 'package:cardiocalc/providers/blocprovider.dart';
import 'package:cardiocalc/blocs/scoresbloc.dart';
import 'package:cardiocalc/views/widgets/widgets.dart';
import 'package:cardiocalc/models/score.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

class ScoreListPageAppBar extends StatelessWidget
{
	const ScoreListPageAppBar({Key? key}) : super(key: key);
	
	@override
	Widget build(BuildContext context)
	{
		return AppBar(
			leading: Container(
				margin: const EdgeInsets.all(10),
				decoration: BoxDecoration(
					border: Border.all(
						color: Theme.of(context).colorScheme.primaryContainer,
						width: .5
					),
					borderRadius: BorderRadius.circular(50),
				),
				child: ClipOval(child: Image.asset("assets/icons/cardiocalc-icon.png"))
			),
			title: const Text("CardioCALC"),
			actions: [
				IconButton(
					icon: const Icon(Icons.info_outline_rounded),
					tooltip: AppLocalizations.of(context)!.infoTitle,
					onPressed: () => Navigator.pushNamed(context, '/info'),
				),
				IconButton(
					icon: const Icon(Icons.settings_outlined),
					tooltip: AppLocalizations.of(context)!.settingsTitle,
					onPressed: () => Navigator.pushNamed(context, '/settings').then((value)
					{
						ScoresBloc bloc = BlocProvider.of<ScoresBloc>(context);
						bloc.scoreEventSink.add(ScoreEvent.Refresh);
					}),
				),
			],
		);
	}
}

class ScoreListPageBody extends StatelessWidget
{
	const ScoreListPageBody({Key? key}) : super(key: key);
	
	@override
	Widget build(BuildContext context)
	{
		ScoresBloc bloc = BlocProvider.of<ScoresBloc>(context);
		
		return StreamBuilder(
			stream: bloc.scoreEventStream,
			initialData: ScoreEvent.Load,
			builder: (BuildContext context, AsyncSnapshot<ScoreEvent> event)
			{
				List<Widget> _slivers = [];
				
				for (Category category in bloc.categories)
				{
					_slivers.add(
						SliverStickyHeader(
							header: HeaderTile(
								category: category,
								headerColor: Theme.of(context).colorScheme.tertiary,
								headerTextColor: Theme.of(context).colorScheme.onTertiary,
								iconColor: Theme.of(context).colorScheme.secondary,
								separatorColor: Theme.of(context).dividerColor,
							),
							sliver: SliverList(
								delegate: SliverChildBuilderDelegate(
									(BuildContext context, int i)
									{
										final int itemIndex = i ~/ 2;
										
										if (!i.isEven) return const Divider(height: 1);
										
										else return ScoreTile(
											score: category.scores[itemIndex],
											onPressed: () => bloc.toggle(score: category.scores[itemIndex], event: ScoreEvent.Toggle),
										);
									},
									childCount: category.scores.length * 2 - 1
								),
							)
						)
					);
				}
				
				return CustomScrollView(
					slivers: _slivers
				);
			}
		);
	}
}