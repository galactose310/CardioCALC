import 'package:cardiocalc/config.dart';
import 'package:cardiocalc/services/json.dart';
import 'package:cardiocalc/models/score.dart';

class ScoreListProvider
{
	// JSON file with categories and scores declaration
	final String _jsonFile = "lib/locale/scorelist.json";
	
	// Default locale to find in JSON files
	final String _defaultLocale = "en";
	
	// Parsed JSON file with all translated categories and scores
	final List<LocalizedScoreList> _localizedScoreList = [];
	
	// Provides a list of scores organized by category
	final List<Category> _categories = [];
	List<Category> get categories => this._categories;
	
	// Provides a list of scores (ordered by names)
	final List<Score> _scores = [];
	List<Score> get scores => this._scores;
	
	// Pattern Singleton with private constructor to force the use of init()
	static final ScoreListProvider _singleton = ScoreListProvider._internal();
	ScoreListProvider._internal();
	bool _initialized = false;
	
	// Get current instance or init() it and return
	static ScoreListProvider getInstance()
	{
		ScoreListProvider instance = _singleton;
		
		if(!instance._initialized)
			throw new Exception("Invalid call to ScoreListProvider.getInstance(): should call init() first.");
		
		return instance;
	}
	
	// Load JSON file (async) and get the instance of ScoreListProvider
	static Future<ScoreListProvider> init() async
	{
		ScoreListProvider instance = _singleton;
		// Return null if JSON can not be loaded (in Widget: will wait instead of Exception)
		
		try
		{
			await instance._loadFromJson();
		}
		on Exception
		{
			throw new Exception("Error in ScoreListProvider while loading Json file.");
		}
		
		Config.localeStream.listen((locale) => instance.setLocale(Config.localeShortname));
		
		instance._initialized = true;
		
		return instance;
	}
	
	// Build category and score lists from JSON file
	Future<void> _loadFromJson() async
	{
		JsonReader jsonReader = new JsonReader(this._jsonFile);
		await jsonReader.loadJsonAsset();
		
		this._localizedScoreList.addAll(jsonReader.decode().map((i) => new LocalizedScoreList.fromJson(i)).whereType<LocalizedScoreList>());
		
		/*
		this.categories.addAll(jsonReader.decode().map((i) => new Category.fromJson(i)).whereType<Category>());
		
		for (var cat in this.categories)
		{
			this.scores.addAll(cat.scores);
		}
		this.scores.sort();
		*/
	}
	
	void setLocale(String locale)
	{
		this.categories.clear();
		this.scores.clear();
		
		if(this._localizedScoreList.where((list) => list.locale == locale).isEmpty)
			locale = _defaultLocale;
		
		this.categories.addAll(this._localizedScoreList.firstWhere((list) => list.locale == locale).categories);
		
		for (var cat in this.categories)
		{
			this.scores.addAll(cat.scores);
		}
		this.scores.sort();
	}
}

class LocalizedScoreList
{
	String locale;
	List<Category> categories;
	
	LocalizedScoreList.fill({required this.locale, required this.categories});
	
	factory LocalizedScoreList.fromJson(Map<String, dynamic> parsedJson)
	{
		var list = parsedJson["categories"] as List;
		List<Category> categoriesList = list.map((i) => Category.fromJson(i)).toList();
		
		return LocalizedScoreList.fill(
			locale: parsedJson["locale"] as String,
			categories: categoriesList
		);
	}
}