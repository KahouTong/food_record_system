import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_record_system/food_detail.dart';

class DetailScreen extends StatelessWidget {
  // Declare a field that holds the object.
  final FoodItem item;

  // In the constructor, require a object.
  DetailScreen({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
        children: <Widget>[
          Text(item.id.toString(),style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text(item.foodName,style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text(item.foodType,style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text(item.description,style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text(item.expiryDate,style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text(item.dateRecord,style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ]),
      ),
    );
  }
}