import 'package:cardiocalc/config.dart';
import 'package:flutter/material.dart';
import 'package:cardiocalc/views/widgets/widgets.dart';
import 'package:cardiocalc/services/applocalizations.dart';
import 'scorelist_page.dart';
import 'favorites_page.dart';

// Page enumeration to use with PageController
enum Page
{
	ScoreListPage, // ignore: constant_identifier_names
	FavoritesListPage // ignore: constant_identifier_names
}

class HomePage extends StatefulWidget
{
	const HomePage({Key? key}) : super(key: key);

	@override
	State<StatefulWidget> createState() => new _HomePageState();	
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin
{
	// Controller for PageView widget
	late PageController _pageController;
	late String homepagePreferencesKey = Config.homepagePreferencesKey;
	
	@override
	void initState()
	{
		super.initState();
		
		this._pageController = new PageController(initialPage: getInitialHomePage());
	}
	
	int getInitialHomePage()
	{
		Page homePage = Page.values.firstWhere(
			(e) => e.toString() == Config.homepage,
			orElse: () => Page.ScoreListPage
		);
		
		switch (homePage)
		{
			case Page.ScoreListPage:
				return 0;
			case Page.FavoritesListPage:
				return 1;
			default:
				return 0;
		}
	}
	
	@override
	void dispose()
	{
		this._pageController.dispose();
		super.dispose();
	}
	
	@override
	Widget build(BuildContext context)
	{
		return Scaffold(
			backgroundColor: Theme.of(context).colorScheme.background,
			appBar: MenuAppBar(
				pageController: this._pageController,
				children: const [
					ScoreListPageAppBar(),
					FavoritesPageAppBar()
				],
			),
			body: PageView(
				controller: this._pageController,
				children: [
					ScoreListPageBody(),
					FavoritesListPageBody(),
				],
			),
			bottomNavigationBar: BottomBar(pageController: this._pageController),
			floatingActionButton: FloatingActionButton(
				onPressed: () => Navigator.pushNamed(context, '/search'),
				tooltip: AppLocalizations.of(context)!.homePageTooltipSearchpage,
				child: const Icon(Icons.search),
			),
			floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
			//extendBody: true
		);
	}
}

class BottomBar extends StatefulWidget
{
	final PageController pageController;

	const BottomBar({Key? key, required this.pageController}) : super(key: key);

	@override
	State<StatefulWidget> createState() => _BottomBarState();//pageController: this.pageController);
} 

class _BottomBarState extends State<BottomBar>
{
	bool isOnScoreList = true;
	bool isOnFavList = false;

	@override
	initState()
	{
		widget.pageController.addListener(() => _onPageSwitch());
		
		switch(widget.pageController.initialPage)
		{
			case 0:
				isOnScoreList = true;
				isOnFavList = false;
				break;
				
			case 1:
				isOnScoreList = false;
				isOnFavList = true;
				break;
				
			default:
				isOnScoreList = true;
				isOnFavList = false;
				break;
		}
		
		super.initState();
	}

	@override
	Widget build(BuildContext context)
	{
		return BottomAppBar(
			shape: const CircularNotchedRectangle(),
			child: new Row(
				mainAxisSize: MainAxisSize.max,
				mainAxisAlignment: MainAxisAlignment.spaceAround,
				children: [
					IconButton(
						icon: const Icon(Icons.menu_rounded),
						tooltip: AppLocalizations.of(context)!.homePageTooltipMainMenu,
						onPressed: () => _switchToPage(Page.ScoreListPage),
						padding: EdgeInsets.zero,
						color: isOnScoreList
								? Theme.of(context).bottomNavigationBarTheme.selectedItemColor
								: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor
					),
					IconButton(
						icon: const Icon(Icons.star_outline_rounded),
						tooltip: AppLocalizations.of(context)!.homePageTooltipFavoritesMenu,
						onPressed: () => _switchToPage(Page.FavoritesListPage),
						padding: EdgeInsets.zero,
						color: isOnFavList
								? Theme.of(context).bottomNavigationBarTheme.selectedItemColor
								: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor
					),
				],
			),
		);
	}
	
	void _switchToPage(Page page) =>
		widget.pageController.animateToPage(page.index, duration: const Duration(milliseconds: 400), curve: Curves.ease);


	void _onPageSwitch()
	{
		this.setState(
			() {
				if(!widget.pageController.hasClients)
					throw Exception("Exception in BottomBar: no PageView is currently using the PageController...");

				this.isOnScoreList = widget.pageController.page! <= 0.5;
				this.isOnFavList = widget.pageController.page! > 0.5;
			}
		);
	}
}