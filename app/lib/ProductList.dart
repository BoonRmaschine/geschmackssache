import 'package:flutter/material.dart';

class Products extends StatefulWidget {
  ProductsState createState() => ProductsState();
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
  bool isExpanded;
  String category;
  String mood;
  Product(this.isExpanded, this.category, this.mood);
}

class ProductsState extends State<Products> {
  List<Product> _products = categoryList.map((category){
    return new Product(false, category, moodList[0]);
  }).toList();

  void _send(){

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sag uns, was du heute gekauft hast"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ExpansionPanelList(
              expansionCallback: (index, isExpanded) {
                setState(() {
                  this._products[index].isExpanded =
                      !this._products[index].isExpanded;
                });
              },
              children: _products.map((Product product) {
                return new ExpansionPanel(
                  headerBuilder: (context, isExpanded) {
                    return Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(product.category),
                        ),
                      ],
                    );
                  },
                  isExpanded: product.isExpanded,
                  body: Row(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: DropdownButton(
                              items: moodList.map((mood) {
                                return new DropdownMenuItem(
                                  child: Text(mood),
                                  value: mood,
                                );
                              }).toList(),
                              onChanged: (newMood) {
                                product.mood = newMood;
                                setState(() {
                                });
                              },
                              value: product.mood,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              }).toList(),
            ),
            RaisedButton(
              color: Theme.of(context).primaryColor,
              onPressed: this._send,
              child: Text(
                "Abschicken",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
