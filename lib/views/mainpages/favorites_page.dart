import 'package:flutter/material.dart';
import 'package:cardiocalc/providers/blocprovider.dart';
import 'package:cardiocalc/blocs/scoresbloc.dart';
import 'package:cardiocalc/views/widgets/widgets.dart';
import 'package:cardiocalc/models/score.dart';
import 'package:cardiocalc/services/applocalizations.dart';

class FavoritesPageAppBar extends StatelessWidget
{
	const FavoritesPageAppBar({Key? key}) : super(key: key);
	
	@override
	Widget build(BuildContext context)
	{
		return AppBar(
			leading: const Icon(Icons.favorite_border),
			title: Text(AppLocalizations.of(context)!.favoritesPageTitle)
		);
	}
}

class FavoritesListPageBody extends StatefulWidget
{
	const FavoritesListPageBody({Key? key}) : super(key: key);

	@override
	State<StatefulWidget> createState() => new _FavoritesListPageBodyState();
}

class _FavoritesListPageBodyState extends State<FavoritesListPageBody>
{
	late ScoresBloc bloc;
	final GlobalKey<AnimatedListState> animatedListKey = new GlobalKey<AnimatedListState>();
	final List<Score> _favoriteItems = <Score>[];
	
	@override
	void initState()
	{
		super.initState();
		this.bloc = BlocProvider.of<ScoresBloc>(context);
	}
	
	void resetList()
	{
		// Use temporary var to avoid Exception on ConcurrentModificationError
		List<Score> tmp = <Score>[];
		tmp.addAll(this._favoriteItems);
		
		for(Score favorite in tmp)
		{
			if(this._favoriteItems.contains(favorite))
				this.removeItem(item: favorite);
		}
		
		for(Score favorite in this.bloc.favoritesManager.favorites)
		{
			this.addItem(favorite);
		}
	}
	
	void addItem(Score item)
	{
		this._favoriteItems.add(item);
		this.animatedListKey.currentState?.insertItem(this._favoriteItems.indexOf(item));
	}
	
	void removeItem({required Score item, Duration duration = const Duration(milliseconds: 0)})
	{
		this.animatedListKey.currentState?.removeItem(
			this._favoriteItems.indexOf(item),
			(context, animation) => FavoriteSlidingTile(
				animation: animation,
				score: item,
			),
			duration: duration
		);
		
		this._favoriteItems.remove(item);
	}
	
	@override
	Widget build(BuildContext context)
	{
		return StreamBuilder(
			stream: this.bloc.animatedListEventStream,
			initialData: ScoreEvent.Load,
			builder: (BuildContext context, AsyncSnapshot<ScoreEvent?> event)
			{
				if(this.bloc.favoritesManager.favorites.isEmpty)
				{
					return Container(
						constraints: const BoxConstraints.expand(),
						color: Theme.of(context).colorScheme.background,
						child: Column(
							mainAxisAlignment: MainAxisAlignment.center,
							children: [
								Icon(Icons.search_rounded, size: 120, color: Theme.of(context).textTheme.bodyText2?.color),
								const SizedBox(height: 50,),
								Text(
									AppLocalizations.of(context)!.favoritesPageNoFavorite,
									style: Theme.of(context).textTheme.bodyText2
								)
							],
						)
					);
				}
				
				this.resetList();
				
				return AnimatedList(
					key: this.animatedListKey,
					initialItemCount: this._favoriteItems.length,
					itemBuilder: (BuildContext context, int index, Animation<double> animation)
					{
						return FavoriteSlidingTile(
							animation: animation,
							score: this._favoriteItems[index],
							onPressed: ()
							{
								Score score = this._favoriteItems[index];
								this.removeItem(item: score, duration: const Duration(milliseconds: 200));
								
								this._favoriteItems.isEmpty
									? this.bloc.toggle(score: score, event: ScoreEvent.Unfav)
									: this.bloc.toggle(score: score, event: ScoreEvent.Unfav, notifier: ScoreNotifier.AnimatedList);
							}
						);
					}
				);
			}
		);
	}
}