import 'SurveyStructs.dart';
import 'MoodList.dart';

import 'package:flutter/material.dart';

class ProductSelection extends StatefulWidget {
  ProductsSelectionState createState() => ProductsSelectionState();
}

class ProductsSelectionState extends State<ProductSelection> {
  List<Product> _products = categoryList.map((category) {
    return new Product(false, category);
  }).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(""),
        ),
        body: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  "Sag uns, was du heute gekauft hast.",
                  style: TextStyle(fontSize: 18.0, fontStyle: FontStyle.normal),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
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
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 45.0),
                child: RaisedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MoodSelection(
                                  surveyState: Survey(products: this._products),
                                )));
                  },
                  child: Text("Weiter"),
                ),
              ),
            ),
          ],
        ));
  }
}
