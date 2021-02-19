class Cocktail {
  String id;
  String name;
  String altName;
  List<String> tags;
  String category;
  String alcoholic;
  String glass;
  String instructions;
  String thumbnailUrl;
  Map<String, String> ingredientsWithMeasurements;
  String dateModified;

  Cocktail({
    this.id,
    this.name,
    this.altName,
    this.tags,
    this.category,
    this.alcoholic,
    this.glass,
    this.instructions,
    this.thumbnailUrl,
    this.ingredientsWithMeasurements,
    this.dateModified,
  });

  factory Cocktail.fromJson(Map<String, dynamic> json) {
    Map<String, String> ingredientsMap = Map();
    for (int i = 1; i < 16; i++) {
      if (json['strIngredient$i'] == null) {
        break;
      }

      ingredientsMap[json['strIngredient$i']] = json['strMeasure$i']?.trim();
    }

    List<String> tags = json['strTags']?.split(',') ?? [];

    return Cocktail(
      id: json['idDrink'],
      name: json['strDrink'] ?? '',
      altName: json['strDrinkAlternate'] ?? '',
      tags: tags,
      category: json['strCategory'] ?? '',
      alcoholic: json['strAlcoholic'] ?? '',
      glass: json['strGlass'] ?? '',
      instructions: json['strInstructions'] ?? '',
      thumbnailUrl: json['strDrinkThumb'] ?? '',
      ingredientsWithMeasurements: ingredientsMap,
      dateModified: json['dateModified'] ?? '',
    );
  }
}
