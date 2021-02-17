import 'dart:async';
import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:image_recovery/Common/Widget/Button.dart';
import 'package:image_recovery/Common/Widget/custom_shape_bottom.dart';
import 'package:image_recovery/Common/Widget/custom_shape_top.dart';
import 'package:image_recovery/language/localization/app_translations.dart';
import 'package:image_recovery/language/localization/application.dart';
import 'package:image_recovery/utils/navigations/navigation_datasource.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}
final getIt = GetIt.instance;
final _navigation = GetIt.instance.get<NavigationDataSource>();
class _RegisterScreenState extends State<RegisterScreen> {

  final String title='';
  static final List<String> languagesList = application.supportedLanguages;
  static final List<String> languageCodesList =
      application.supportedLanguagesCodes;

  final Map<dynamic, dynamic> languagesMap = {
    languagesList[0]: languageCodesList[0],
    languagesList[1]: languageCodesList[1],
  };
  List<String> _dropdownItems = new List();

  String _dropdownValue = "Nam";
  void onLocaleChange(Locale locale) async {
    setState(() {
      AppTranslations.load(locale);
    });
  }

  @override
  void initState()  {
    super.initState();
    _dropdownItems.add("Nam");
    _dropdownItems.add("Nữ");
    application.onLocaleChanged = onLocaleChange;
    onLocaleChange(Locale(languagesMap["Vietnamese"]));
  }
  DateTime selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xff56AAE7), //or set color with: Color(0xFF0000FF)
    ));
    return MaterialApp(
      home: Container(
        color: Colors.white,
        margin: new EdgeInsets.only(
            top: MediaQuery.of(context).padding.top
        ),
        child: Stack(
          children: [
            TopShape(),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: new EdgeInsets.only(
                    top: MediaQuery.of(context).size.height*0.12),
                width: 50,
                height: 50,
                child: Image.asset('images/logo.png'),
              ),
            ),
            GestureDetector(
              child: Container(
                width: MediaQuery.of(context).size.width/9,
                height: MediaQuery.of(context).size.width/9,
                margin: new EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width/8)),
                ),
                child: Icon(
                  Icons.arrow_back,
                  size: 30,
                  color: Color(0xff56AAE7),
                ),
              ),
              onTap: ()=>{
                _navigation.popNavigation(context)
              },
            ),
            Container(
              margin: new EdgeInsets.only(
                  top: MediaQuery.of(context).size.height*0.24,
                  left: 20,
                  right: 20),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.04),
                    spreadRadius: 0.05,
                    blurRadius: 0,
                    offset: Offset(
                        0, 2), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width*0.9,
                    height: MediaQuery.of(context).size.height*0.06,
                    padding: new EdgeInsets.all(0),
                    child: Card(
                      color: Colors.white,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(8.0)),
                      child:  TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: AppTranslations.of(context).text("Name").toString(),
                          prefixIcon: Icon(Icons.person),
                        ),
                      ),
                    ),
                  ),
                  Padding(padding: new EdgeInsets.all(6),),
                  Container(
                    width: MediaQuery.of(context).size.width*0.9,
                    height: MediaQuery.of(context).size.height*0.06,
                    child: Card(
                      color: Colors.white,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(8.0)),
                      child: TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.phone),
                            hintText: AppTranslations.of(context).text("Phone").toString()
                        ),
                      ),
                    ),
                  ),
                  Padding(padding: new EdgeInsets.all(6),),
                  Container(
                    width: MediaQuery.of(context).size.width*0.9,
                    height: MediaQuery.of(context).size.height*0.06,
                    padding: new EdgeInsets.all(0),
                    child: Card(
                      color: Colors.white,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(8.0)),
                      child:  TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: AppTranslations.of(context).text("DOB").toString(),
                          prefixIcon: Icon(Icons.date_range),
                          suffixIcon: IconButton(
                            onPressed: ()=>_selectDate(context),
                            icon: Icon(Icons.add_box),
                          ),
                        )
                      ),
                    ),
                  ),
                  Padding(padding: new EdgeInsets.all(6),),
                  Container(
                    width: MediaQuery.of(context).size.width*0.9,
                    height: MediaQuery.of(context).size.height*0.06,
                    child: Card(
                      color: Colors.white,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(8.0)),
                      child: PopupMenuButton(
                        onSelected: (c) {},
                        child: Container(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 10,
                                child: TextField(
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: AppTranslations.of(context).text("DOB").toString(),
                                      prefixIcon: Icon(Icons.date_range),

                                    )
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                  child: Icon(Icons.arrow_drop_down)
                              )
                            ],
                          ),
                        ),
                        itemBuilder: (context) => ["nam", "nữ"]
                            .map((c) => PopupMenuItem(value: c, child: Text(c)))
                            .toList(),
                      ),
                    ),
                  ),
                  Padding(padding: new EdgeInsets.all(6),),
                  Container(
                    width: MediaQuery.of(context).size.width*0.9,
                    height: MediaQuery.of(context).size.height*0.06,
                    padding: new EdgeInsets.all(0),
                    child: Card(
                      color: Colors.white,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(8.0)),
                      child:  TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: AppTranslations.of(context).text("Address").toString(),
                          prefixIcon: Icon(Icons.map),
                        ),
                      ),
                    ),
                  ),
                  Padding(padding: new EdgeInsets.all(6),),
                  Container(
                    width: MediaQuery.of(context).size.width*0.9,
                    height: MediaQuery.of(context).size.height*0.06,
                    child: Card(
                      color: Colors.white,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(8.0)),
                      child: TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.email),
                            hintText: AppTranslations.of(context).text("Email").toString()
                        ),
                      ),
                    ),
                  ),
                  Padding(padding: new EdgeInsets.all(6),),
                  Container(
                    width: MediaQuery.of(context).size.width*0.9,
                    height: MediaQuery.of(context).size.height*0.06,
                    padding: new EdgeInsets.all(0),
                    child: Card(
                      color: Colors.white,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(8.0)),
                      child:  TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: AppTranslations.of(context).text("Password").toString(),
                          prefixIcon: Icon(Icons.vpn_key),
                        ),
                      ),
                    ),
                  ),
                  Padding(padding: new EdgeInsets.all(10),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RaisedGradientButton(
                          height: 40,
                          width: 120,
                          child: Text(
                            AppTranslations.of(context).text("Signup").toString().toUpperCase(),
                            style: TextStyle(
                                color:Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18
                            ),
                          ),
                          onPressed: (){
                            onLocaleChange(Locale(languagesMap["Vietnamese"]));
                          }
                      ),
                    ],
                  ),
                  Padding(padding: new EdgeInsets.all(6),),
                ],
              ),
            ),
            BottomShape()
          ],
        ),
      )
    );
  }
}