import 'package:flutter/material.dart';
import 'package:food_record_system/food_detail.dart';
import 'package:food_record_system/item_provider.dart';

class ItemFormPage extends StatefulWidget {
  @override
  _ItemFormPageState createState() => _ItemFormPageState();
}

class _ItemFormPageState extends State<ItemFormPage> {
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  Future<List<FoodItem>> foodItems;
  String _foodName;
  String _foodType;
  String _description;
  String _expiryDate;
  String _dateRecord;
  DBHelper dbHelper;
  final _foodNameController = TextEditingController();
  final _secondController = TextEditingController();
  final _thirdController = TextEditingController();
  final _fourthController = TextEditingController();
  final _fifthController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

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

  Widget _foodNames() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Food Name'),
      validator: (String value){
        if(value.isEmpty){
          return 'Food Name is Required';
        }
        return null;
      },
      onSaved: (String value){
        _foodName = value;
      },
      controller: _foodNameController,
    );
  }

  Widget _foodTypes() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Food Type'),
      validator: (String value){
        if(value.isEmpty){
          return 'Food Type is Required';
        }
        return null;
      },
      onSaved: (String value){
        _foodType = value;
      },
      controller: _secondController,
    );
  }

  Widget _descriptions() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Food Description'),
      onSaved: (String value){
        _description = value;
      },
      controller: _thirdController,
    );
  }

  Widget _expiryDates() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Food Expiry Date'),
      validator: (String value){
        if(value.isEmpty){
          return 'Expiry Date is Required';
        }
        return null;
      },
      onSaved: (String value){
        _expiryDate = value;
      },
      controller: _fourthController,
    );
  }

  Widget _dateRecords() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Today Date'),
      validator: (String value){
        if(value.isEmpty){
          return 'Date for today is Required';
        }
        return null;
      },
      onSaved: (String value){
        _dateRecord = value;
      },
      controller: _fifthController,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
          appBar: AppBar(title: Text("Food Item Detail Form")),
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(24),
              child: Form(
                key: _formStateKey,
                autovalidateMode: AutovalidateMode.always,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _foodNames(),
                    _foodTypes(),
                    _descriptions(),
                    _expiryDates(),
                    _dateRecords(),
                    SizedBox(height: 100),
                    ElevatedButton(
                      child: Text(
                        ('ADD'),
                      ),
                      onPressed: (){
                          if(_formStateKey.currentState.validate()){
                            _formStateKey.currentState.save();
                            dbHelper.add(FoodItem(null, _foodName, _foodType, _description, _expiryDate, _dateRecord));
                            _scaffoldKey.currentState.showSnackBar(
                                new SnackBar(
                                    content: new Text('Data Added',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
                                )
                            );
                          }
                        _foodNameController.text = '';
                        _secondController.text = '';
                        _thirdController.text = '';
                        _fourthController.text = '';
                        _fifthController.text = '';
                        refreshItemList();
                      },
                    ),
                    ElevatedButton(
                      child: Text(
                        ('CLEAR'),
                      ),
                      onPressed: () {
                        _foodNameController.text = '';
                        _secondController.text = '';
                        _thirdController.text = '';
                        _fourthController.text = '';
                        _fifthController.text = '';
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
  }
}