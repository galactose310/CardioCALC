import 'dart:core';
import 'package:cardiocalc/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class Favoritable
{
	late String label;
	late bool isFavorite;
}

class Favorites<T extends Favoritable>
{
	// Set of Favoritable that can be read by other classes
	final List<T> _favorites = <T>[];
	List<T> get favorites => this._favorites;
	
	// Favorites configuration
	final String _key = "favorites"; // string id in Flutter SharedPreferences
	final SharedPreferences _prefs = Config.preferences;
	
	// To verify if an instance already exist and init() has been called
	// Note : no singleton with generics...
	static bool _initialized = false;
	
	// Async call to SharedPreferences
	void init(Iterable<T> items)
	{
		if(Favorites._initialized)
			this.reset(items);
		
		else
		{
			this._fetchFavorites(items);
			Favorites._initialized = true;
		}
	}
	
	// Reset favorites with a new Iterable items
	void reset(Iterable<T> items)
	{
		this._favorites.clear();
		Favorites._initialized = false;
		this.init(items);
	}
	
	void toggle(T item)
	{
		if(!Favorites._initialized)
			throw Exception("Invalid call to Favorites.toggle(): call Favorites.init() first.");
		
		if(this.contains(item)) this._remove(item);
		else this._add(item);
	}

	bool contains(T item)
	{
		return this._favorites.contains(item);
	}

	void _add(T item)
	{
		item.isFavorite = true;
		this._favorites.add(item);
		this._favorites.sort();
		this._saveFavorites();
	}

	void _remove(T item)
	{
		item.isFavorite = false;
		this._favorites.remove(item);
		this._saveFavorites();
	}

	Future<bool> _saveFavorites()
	{
		return _prefs.setStringList(this._key, this._favorites.map((fav) => fav.label).toList());
	}

	void _fetchFavorites(Iterable<T> items)
	{
		List<String> favList = _prefs.getStringList(this._key) ?? new List<String>.empty();
		
		for(T item in items)
			if(favList.contains(item.label)) { this._add(item); }
	}
}