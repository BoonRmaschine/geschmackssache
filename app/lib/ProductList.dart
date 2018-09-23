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

class Product {
  bool isExpanded;
  String category;
  int mood; //Rating from 0-10
  Product(this.isExpanded, this.category, this.mood);
}

class ProductsState extends State<Products> {
  List<Product> _products = <Product>[Product(false, categoryList[0], 5)];

  void _addProduct() {
    List<Product> newProducts = this._products;
    newProducts.add(Product(false, categoryList[0], 5));
    setState(() {
      this._products = newProducts;
    });
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
                          Text(product.mood.toString()),
                          IconButton(
                            icon: new Icon(Icons.delete),
                            tooltip: 'Delete this item',
                            onPressed: () { setState(() { }); },
                          )

                        ],
                      )
                    ],
                  ),
                );
              }).toList(),
            ),
            RaisedButton(
              color: Theme.of(context).primaryColor,
              onPressed: _addProduct,
              child: Text(
                "Produkt hinzufügen",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
