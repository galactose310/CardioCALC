import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class JsonReader
{
	String jsonFile;
	late String _loadedAsset;

	JsonReader(this.jsonFile);

	Future loadJsonAsset() async
	{
		this._loadedAsset = await rootBundle.loadString(this.jsonFile);
	}

	dynamic decode()
	{
		return json.decode(this._loadedAsset);
	}
}