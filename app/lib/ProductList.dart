import 'package:flutter/material.dart';

class ProductSelection extends StatefulWidget {
  ProductsSelectionState createState() => ProductsSelectionState();
}

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
  "Fertigmalzeiten",
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
}

class Mood {
  String mood;

  Mood(this.mood);
}

class ProductsSelectionState extends State<ProductSelection> {
  List<Product> _products = categoryList.map((category) {
    return new Product(false, category);
  }).toList();

  void _send() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Sag uns, was du heute gekauft hast"),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: this._products.map((product) {
                  return new CheckboxListTile(
                    title: Text(product.category),
                    value: product.state,
                    onChanged: (bool value) {
                      setState(() {
                        product.state = value;
                      });
                    },
                  );
                }).toList(),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: RaisedButton(
                  onPressed: null,
                  child: Text("Weiter"),
                ),
              ),
            ),
          ],
        ));
  }
}
