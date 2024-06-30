class Recipe {
  final String uri;
  final String label;
  final String image;
  final String source;
  final String url;
  final String shareAs;
  final double yield;
  final List<String> dietLabels;
  final List<String> healthLabels;
  final List<String> ingredientLines;
  final double calories;
  final double totalWeight;
  final double totalTime;

  Recipe({
    required this.uri,
    required this.label,
    required this.image,
    required this.source,
    required this.url,
    required this.shareAs,
    required this.yield,
    required this.dietLabels,
    required this.healthLabels,
    required this.ingredientLines,
    required this.calories,
    required this.totalWeight,
    required this.totalTime,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      uri: json['uri'],
      label: json['label'],
      image: json['image'],
      source: json['source'],
      url: json['url'],
      shareAs: json['shareAs'],
      yield: (json['yield'] as num).toDouble(),
      dietLabels: List<String>.from(json['dietLabels']),
      healthLabels: List<String>.from(json['healthLabels']),
      ingredientLines: List<String>.from(json['ingredientLines']),
      calories: (json['calories'] as num).toDouble(),
      totalWeight: (json['totalWeight'] as num).toDouble(),
      totalTime: (json['totalTime'] as num).toDouble(),
    );
  }
}
