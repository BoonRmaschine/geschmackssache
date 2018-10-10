import 'dart:convert';

List<String> categoryList = [
  "Bier, Wein, Spirituosen",
  "Limonaden und andere zuckerhaltige Getränke",
  "Wasser und Säfte",
  "Koffeinhaltige Getränke",
  "Eisprodukte",
  "Schokolade und Süßprodukte",
  "Knabberein, wie Chips und Nüsse",
  "Milchprodukte, wie Joghurt und Käse",
  "Brot- und Backwaren",
  "Fleisch/Wurst",
  "Fertigmahlzeiten",
  "Obst/Gemüse",
];

List<String> moodList = [
  "nicht gekauft",
  "glücklich",
  "traurig",
  "gestresst",
  "allgemein gut",
  "verliebt",
  "krank",
  "müde/abgespannt",
];

class Product {
  bool state;
  String category;

  Product(this.state, this.category);

  Map<String, dynamic> toJson() =>
      {
        'product': json.encode(this.category),
        'state': json.encode(this.state),
      };
}

class Mood {
  bool state;
  String feeling;

  Mood(this.state, this.feeling);
}

class Survey{
  List<Product> products;
  Mood mood;

  Survey({this.products, this.mood});

  Map<String, dynamic> toJson() =>
      {
        'products': json.encode(this.products),
        'mood': mood.feeling,
      };
}