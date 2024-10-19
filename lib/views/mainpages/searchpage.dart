import 'package:flutter/material.dart';
import 'package:cardiocalc/providers/blocprovider.dart';
import 'package:cardiocalc/blocs/scoresbloc.dart';
import 'package:cardiocalc/views/widgets/widgets.dart';
import 'package:cardiocalc/models/score.dart';
import 'package:cardiocalc/extensions/string.dart';
import 'package:cardiocalc/services/applocalizations.dart';

class SearchPage extends StatefulWidget
{
	const SearchPage({Key? key}) : super(key: key);
	
	@override
	State<StatefulWidget> createState() => new _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with SingleTickerProviderStateMixin
{
 	final TextEditingController _searchController = new TextEditingController();
	
 	bool isSearching = false;
 	String searchString = "";
	
	@override
	void initState()
	{
		super.initState();
		this._searchController.addListener(onSearch);
	}
	
	void onSearch()
	{
		this.isSearching = this._searchController.text.isNotEmpty;
		this.searchString = this._searchController.text.removeDiacritics().toLowerCase();
		this.setState(() { });
	}
	
	@override
	void dispose()
	{
		this._searchController.dispose();
		super.dispose();
	}
	
	@override
	Widget build(BuildContext context)
	{
		ScoresBloc bloc = BlocProvider.of<ScoresBloc>(context);
		
		return Scaffold(
			backgroundColor: Theme.of(context).colorScheme.background,
			appBar: AppBar(
 				title: TextField(
					autofocus: true,
					style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
					cursorColor: Theme.of(context).colorScheme.onPrimary,
					cursorWidth: 1.5,
 					controller: this._searchController,
 					textAlignVertical: TextAlignVertical.center,
 					decoration: InputDecoration(
						isDense: true, // Dense form, force padding
						contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
						filled: true, // To set fillColor as background color
						fillColor: Theme.of(context).colorScheme.primaryContainer,
 						hintText: AppLocalizations.of(context)!.searchPageHintText,
 						hintStyle: TextStyle(color: Theme.of(context).colorScheme.onPrimary.withOpacity(.5)),
						enabledBorder: OutlineInputBorder(
							borderSide: BorderSide(color: Theme.of(context).colorScheme.primaryContainer),
							borderRadius: BorderRadius.circular(36)
						),
						focusedBorder: OutlineInputBorder(
							borderSide: BorderSide(color: Theme.of(context).colorScheme.primaryContainer),
							borderRadius: BorderRadius.circular(36)
						),
 					),
 				),
 				actions: [
 					IconButton(
 						icon: Icon(
 							Icons.clear_rounded,
 							color: Theme.of(context).colorScheme.onPrimary.withOpacity(this._searchController.text.isEmpty ? .5 : 1)
 						),
 						onPressed: this._searchController.text.isEmpty ? null : this._searchController.clear,
 					),
 					const SizedBox(width: 15)
 				],
 			),
			body: StreamBuilder(
				stream: bloc.scoreEventStream,
				initialData: ScoreEvent.Load,
				builder: (BuildContext context, AsyncSnapshot<ScoreEvent> event)
				{
					List<Score> list = bloc.scores.where(
						(score) =>
							score.name.removeDiacritics().toLowerCase().contains(this.searchString) || 
							score.detail.removeDiacritics().toLowerCase().contains(this.searchString)
						).toList();
					
					if(list.isEmpty) return Container(
						constraints: const BoxConstraints.expand(),
                    	color: Theme.of(context).colorScheme.background,
						child: Column(
							mainAxisAlignment: MainAxisAlignment.center,
							children: [
								Icon(Icons.search_rounded, size: 120, color: Theme.of(context).textTheme.bodyText2?.color),
								const SizedBox(height: 50,),
								Text(
									AppLocalizations.of(context)!.searchPageNoElementFound,
									style: Theme.of(context).textTheme.bodyText2
								),
							],
						)
					);
					
					return ListView.separated(
						itemBuilder: (BuildContext context, int index)
						{
							return ScoreTile(
								score: list[index],
								onPressed: () => bloc.toggle(score: list[index], event: ScoreEvent.Toggle));
						},
						separatorBuilder: (BuildContext context, int index) => const Divider(height: 1),
						itemCount: list.length
					);
				}
			)
		);
	}
}