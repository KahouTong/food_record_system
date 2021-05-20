import 'package:flutter/material.dart';
import 'package:food_record_system/foodDetails.dart';
import 'package:food_record_system/food_detail.dart';
import 'package:food_record_system/item_provider.dart';

class SummaryPage extends StatefulWidget {
  @override
  _SummaryPageState createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  Future<List<FoodItem>> foodItems = DBHelper().getColumn();
  DBHelper dbHelper;
  // bool _flag = true;
  //
  // void _onFlagChanged(bool flag){
  //   setState(() => _flag = flag);
  // }

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    refreshItemList();
  }

  refreshItemList() {
    setState(() {
      foodItems = dbHelper.getItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Summary Item")),
        body: FutureBuilder(
          future: foodItems,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return generateList(snapshot.data, context);
            }
            if (snapshot.data == null || snapshot.data.length == 0) {
              return Text('No Data Found');
            }
            return CircularProgressIndicator();
          },
        ),
      );
  }

  SingleChildScrollView generateList(List<FoodItem> foodItems, context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: DataTable(
          columns: [
            DataColumn(
              label: Text('Name',style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            ),
            DataColumn(
                label: Text('Expiry Date',style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
             DataColumn(
               label: Text('Delete',style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
             )
          ],
          rows: foodItems
              .map(
                (foodItem) => DataRow(
              cells: [
                DataCell(
                  Text(foodItem.foodName),
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DetailScreen(item: foodItem)));
                  },
                ),
                DataCell(
                  Text(foodItem.expiryDate),
                ),
                DataCell(
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.amber,),
                    onPressed: () {
                      DBHelper().delete(foodItem.id);
                      refreshItemList();
                      final snackBar = SnackBar(
                        content: Text('Deleted',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        action: SnackBarAction(
                          label: 'Close',
                          onPressed: () {
                            // do nothing but close the snack bar
                          },
                        ),
                      );
                      // Find the Scaffold in the widget tree and use
                      // it to show a SnackBar.
                      Scaffold.of(context).showSnackBar(snackBar);
                    },
                  ),
                ),
              ],
            ),
          )
              .toList(),
        ),
      ),
    );
  }
}
