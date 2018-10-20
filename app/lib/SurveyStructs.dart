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
        'product': this.category,
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
  String uuid;
  String gender;
  int age;

  Survey({this.products, this.mood});

  Map<String, dynamic> toJson() =>
      {
        'uuid': this.uuid,
        'gender': this.gender,
        'age': json.encode(this.age),
        'products': json.encode(this.products),
        'mood': mood.feeling,
      };
}