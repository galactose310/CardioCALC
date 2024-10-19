import 'package:cardiocalc/interfaces/favoritable.dart';
import 'package:cardiocalc/extensions/string.dart';

class Score implements Comparable<Score>, Favoritable {
	@override
	String label;
	@override
	bool isFavorite;
	
	String name;
	String detail;
	
	Score({required this.label, required this.name, required this.detail, this.isFavorite = false});
	
	factory Score.fromJson(Map<String, dynamic> parsedJson) {
		return Score(
			label: parsedJson["label"] as String,
			name: parsedJson["name"] as String,
			detail: parsedJson["detail"] as String
		);
	}
	
	@override
	int compareTo(Score other) => this.name.removeDiacritics().toLowerCase().compareTo(other.name.removeDiacritics().toLowerCase());
}

class Category implements Comparable<Category> {
	String label;
	String name;
	List<Score> scores = [];
	
	Category({required this.label, required this.name});
	
	Category.fill({required this.label, required this.name, required this.scores});
	
	factory Category.fromJson(Map<String, dynamic> parsedJson) {
		var list = parsedJson["scores"] as List;
		List<Score> scoreList = list.map((i) => Score.fromJson(i)).toList();
		
		return Category.fill(
			label: parsedJson["label"] as String,
			name: parsedJson["name"] as String,
			scores: scoreList
		);
	}
	
	@override
	int compareTo(Category other) =>
		this.name.removeDiacritics().toLowerCase().compareTo(other.name.removeDiacritics().toLowerCase());
}