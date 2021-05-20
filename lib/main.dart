import 'package:flutter/material.dart';
import 'package:food_record_system/addItem.dart';
import 'package:food_record_system/summary_page.dart';
import 'package:flutter/foundation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final appTitle = 'Food Record System';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
        title: appTitle,
        home: MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {

      return Scaffold(
        appBar: AppBar(title: Text(title)),
        body: Center(child: Text('Welcome to Food Record App',style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold))),
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text('Navigation', style: TextStyle(fontSize: 36, color: Colors.white, fontWeight: FontWeight.bold)),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/minibg.jpg"),
                      fit: BoxFit.fitWidth,
                      //alignment: Alignment.topLeft
                  ),
                ),
              ),
              ListTile(
                title: Text('Summary',style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SummaryPage()),
                  );
                },
              ),
              ListTile(
                title: Text('Add Record',style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ItemFormPage()),
                  );
                },
              ),
            ],
          ),
        ),
    );
  }
}



