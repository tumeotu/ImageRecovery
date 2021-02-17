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
import 'package:image_recovery/routes.dart';
import 'package:image_recovery/utils/navigations/navigation_datasource.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPasswordScreen> {
  final getIt = GetIt.instance;
  final _navigation = GetIt.instance.get<NavigationDataSource>();
  final String title='';
  DateTime selectedDate = DateTime.now();

  void onLocaleChange(Locale locale) async {
    setState(() {
      AppTranslations.load(locale);
    });
  }

  @override
  void initState()  {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xff56AAE7), //or set color with: Color(0xFF0000FF)
    ));
    return MaterialApp(
        home: Scaffold(
          body: Container(
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
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: new EdgeInsets.only(
                        top: MediaQuery.of(context).size.height*0.27),
                    width: MediaQuery.of(context).size.width-100,
                    height: 50,
                    child: Center(
                      child: Text(
                          'ImageRecovery',
                        style: new TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ),
                _getView(context),
                BottomShape()
              ],
            ),
          ),
        )
    );
  }

  _getFirstView(BuildContext context) {
    return Container(
      margin: new EdgeInsets.only(
          top: MediaQuery.of(context).size.height*0.38,
          left: 20,
          right: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
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
          Row(
              children: <Widget>[
                Padding(padding: new EdgeInsets.all(5),),
                Icon(Icons.star),
                Text(
                  AppTranslations.of(context)
                      .text("EnterYourEmail"),
                  style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                  ),
                )
              ]
          ),
          Padding(padding: new EdgeInsets.all(3),),
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
                  hintText: AppTranslations.of(context).text("Email").toString(),
                  prefixIcon: Icon(Icons.email),
                ),
              ),
            ),
          ),
          Padding(padding: new EdgeInsets.all(20),),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedGradientButton(
                  height: 40,
                  width: 120,
                  child: Text(
                    AppTranslations.of(context).text("Next").toString().toUpperCase(),
                    style: TextStyle(
                        color:Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                    ),
                  ),
                  onPressed: (){
                  }
              ),
            ],
          ),
          Padding(padding: new EdgeInsets.all(6),),
        ],
      ),
    );
  }

  _getSecondView(BuildContext context) {
    return Container(
      margin: new EdgeInsets.only(
          top: MediaQuery.of(context).size.height*0.38,
          left: 20,
          right: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
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
          Padding(padding: new EdgeInsets.all(3),),
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
                  hintText: AppTranslations.of(context).text("NewPassword").toString(),
                  prefixIcon: Icon(Icons.vpn_key),
                ),
              ),
            ),
          ),
          Padding(padding: new EdgeInsets.all(10),),
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
                  hintText: AppTranslations.of(context).text("ConfirmNewPassword").toString(),
                  prefixIcon: Icon(Icons.vpn_key),
                ),
              ),
            ),
          ),
          Padding(padding: new EdgeInsets.all(20),),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedGradientButton(
                  height: 40,
                  width: 120,
                  child: Text(
                    AppTranslations.of(context).text("Confirm").toString().toUpperCase(),
                    style: TextStyle(
                        color:Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                    ),
                  ),
                  onPressed: (){
                  }
              ),
            ],
          ),
          Padding(padding: new EdgeInsets.all(6),),
        ],
      ),
    );
  }

  _getView(BuildContext context) {
    if(true)
      return _getFirstView(context);
    return _getSecondView(context);
  }
}