import 'dart:async';
import 'package:cardiocalc/providers/blocprovider.dart';
import 'package:cardiocalc/providers/scorelist_provider.dart';
import 'package:cardiocalc/models/favorites.dart';
import 'package:cardiocalc/models/score.dart';


enum ScoreEvent
{
	Load, // ignore: constant_identifier_names
	Refresh, // ignore: constant_identifier_names
	Fav, // ignore: constant_identifier_names
	Unfav, // ignore: constant_identifier_names
	Toggle // ignore: constant_identifier_names
}

enum ScoreNotifier
{
	ListView, // ignore: constant_identifier_names
	AnimatedList, // ignore: constant_identifier_names
	RandomWidget // ignore: constant_identifier_names
}

class ScoresBloc extends BlocBase
{
	// To trigger Event
	final StreamController<ScoreEvent> _scoreEventController = new StreamController<ScoreEvent>.broadcast();
	Stream<ScoreEvent> get scoreEventStream => this._scoreEventController.stream;
	Sink<ScoreEvent> get scoreEventSink => this._scoreEventController.sink;
	
	// To trigger Event specifically on AnimatedList
	final StreamController<ScoreEvent> _animatedListEventController = new StreamController<ScoreEvent>.broadcast();
	Stream<ScoreEvent> get animatedListEventStream => this._animatedListEventController.stream;
	Sink<ScoreEvent> get animatedListEventSink => this._animatedListEventController.sink;
	
	// Properties to access lists of scores and Favorites manager (Favorites<T> class)
	final List<Category> categories = <Category>[];
	final List<Score> scores = <Score>[];
	late final Favorites<Score> favoritesManager;
	
	ScoresBloc({required ScoreListProvider provider})//, required String locale})
	{
		this.categories.addAll(provider.categories);
		this.scores.addAll(provider.scores);
		
		this.favoritesManager = new Favorites<Score>();
		this.favoritesManager.init(this.scores);
	}
	
	// Toggle a score status and update all the streams
	void toggle({required Score score, required ScoreEvent event, ScoreNotifier notifier = ScoreNotifier.RandomWidget})
	{
		this.favoritesManager.toggle(score);
		this.scoreEventSink.add(event);
		if(notifier != ScoreNotifier.AnimatedList) this.animatedListEventSink.add(event);
	}
	
	@override
	void dispose()
	{
		this._scoreEventController.close();
		this._animatedListEventController.close();
	}
}