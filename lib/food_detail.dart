//import 'package:flutter/foundation.dart';

class FoodItem{
 int id;
 String foodName;
 String foodType;
 String description;
 String expiryDate;
 String dateRecord;

  FoodItem(
   this.id,
   this.foodName,
   this.foodType,
   this.description,
   this.expiryDate,
   this.dateRecord,
  );

  Map<String, dynamic> toMap(){
   var map = <String, dynamic>{
   'id': id,
   'foodName': foodName,
   'foodType': foodType,
   'description': description,
   'expiryDate': expiryDate,
   'dateRecord': dateRecord,
   };
   return map;
  }

  FoodItem.fromMap(Map<String, dynamic>map){
   id = map['id'];
   foodName = map['foodName'];
   foodType = map['foodType'];
   description = map['description'];
   expiryDate = map['expiryDate'];
   dateRecord = map['dateRecord'];
  }
}