import 'dart:async';
import 'dart:convert';
import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_recovery/Common/Widget/Button.dart';
import 'package:image_recovery/Common/Widget/custom_shape_bottom.dart';
import 'package:image_recovery/language/localization/app_translations.dart';
import "package:http/http.dart" as http;
import 'package:image_recovery/utils/navigations/navigation_datasource.dart';
import '../../routes.dart';
import 'dart:convert' as JSON;

class SplashScreenSample extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}
final getIt = GetIt.instance;
final _navigation = GetIt.instance.get<NavigationDataSource>();
class _SplashScreenState extends State<SplashScreenSample> {

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  @override
  void initState()  {
    super.initState();

  }
  Future<void> _loginGoogle() async {
    try {
     GoogleSignInAccount account= await _googleSignIn.signIn();
     account.authentication.then((googleKey){
       print(googleKey.accessToken);
       print(_googleSignIn.currentUser.displayName);
     }).catchError((err){
       print('inner error');
     });
    } catch (error) {
      print(error);
    }
  }

  Future<Null> _loginFaceBook() async {
    FacebookAuth abc = FacebookAuth.instance;
    final AccessToken result = await FacebookAuth.instance.login(loginBehavior:LoginBehavior.WEB_VIEW_ONLY);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body:  Container(
          margin: new EdgeInsets.only(
            top:  20
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                    'images/login.png',
                  fit: BoxFit.scaleDown,
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: new EdgeInsets.only(top: MediaQuery.of(context).size.height*0.35, left: 20, right: 20),
                  height: MediaQuery.of(context).size.height*0.28,
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
                  child: Card(
                    color: Color(0xff56AAE7),
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(15.0)),
                    child: Stack(
                      children: [
                        Container(
                          margin: new EdgeInsets.all(15),
                          child: Text(
                              AppTranslations.of(context).text('Login').toString(),
                            style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                        Align(
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width*0.8,
                                height: MediaQuery.of(context).size.height*0.06,
                                padding: new EdgeInsets.all(0),
                                child: Card(
                                    color: Colors.white,
                                    shape: new RoundedRectangleBorder(
                                        borderRadius: new BorderRadius.circular(8.0)),
                                  child:  TextField(
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: AppTranslations.of(context).text("Username").toString(),
                                      prefixIcon: Icon(Icons.person),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(padding: new EdgeInsets.all(10),),
                              Container(
                                width: MediaQuery.of(context).size.width*0.8,
                                height: MediaQuery.of(context).size.height*0.06,
                                child: Card(
                                    color: Colors.white,
                                    shape: new RoundedRectangleBorder(
                                        borderRadius: new BorderRadius.circular(8.0)),
                                  child: TextField(
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      prefixIcon: Icon(Icons.vpn_key),
                                      hintText: AppTranslations.of(context).text("Password").toString()
                                    ),
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            margin: new EdgeInsets.all(20),
                            child: GestureDetector(
                              onTap:()=> _navigation.pushNavigation(NamePage.forgotPasswordPage),
                              child: Text(
                                AppTranslations.of(context).text("ForgotPassword").toString(),
                                style: new TextStyle(color: Color(0xff0E3871)),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: new EdgeInsets.only(
                      top: MediaQuery.of(context).size.height*0.64,
                      left: 20,
                    right: 20
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            CircularCheckBox(
                                value: true,
                                materialTapTargetSize: MaterialTapTargetSize.padded,
                                onChanged: (bool x) {
                                }
                            ),
                            Text(
                                AppTranslations.of(context).text("RememberMe").toString()
                            ),
                          ],
                        ),
                        flex: 3,
                      ),
                      Expanded(
                        child: Padding(
                            padding: new EdgeInsets
                                    .only(
                                top: 5,
                                left: 5,
                                right: 5,
                                bottom: 3),
                            child:RaisedGradientButton(
                                height: 40,
                                width: 80,
                                child: Text(
                                  AppTranslations.of(context).text("Login").toString(),
                                  style: TextStyle(
                                      color:Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18
                                  ),
                                ),
                                onPressed: (){
                                  Routes.sailor.popUntil((context) {
                                    return false;
                                  });
                                  var params= {
                                    'page':1
                                  };
                                  _navigation.pushNavigation(NamePage.homePage, params: params);
                                }
                            )
                        ),
                        flex: 2,
                      ),
                    ],
                  ),
                  ),
              ),
              Align(
                alignment: Alignment.topCenter,
                  child: Container(
                    margin: new EdgeInsets.only(
                        right: 30,
                        top: MediaQuery.of(context).size.height*0.735
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          AppTranslations.of(context).text("ButtonSignup")
                        ),
                        GestureDetector(
                          onTap:() =>{
                            _navigation.pushNavigation(NamePage.registerPage)
                            },
                          child: Text(
                              AppTranslations.of(context).text("Signup"),
                            style: new TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        )
                      ],
                    ),
                  )
              ),
              Align(
                alignment: Alignment.topCenter,
                  child: Container(
                    margin: new EdgeInsets.only(
                      top: MediaQuery.of(context).size.height*0.79
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height:1.0,
                          width:MediaQuery.of(context).size.width/4,
                          color:Colors.grey,
                        ),
                        Padding(
                          padding: new EdgeInsets.only(left: 7),
                        ),
                        Text(
                          AppTranslations.of(context).text("SocialLogin").toString(),
                          style: new TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Padding(
                          padding: new EdgeInsets.only(left: 7),
                        ),
                        Container(
                          height:1.0,
                          width:MediaQuery.of(context).size.width/4,
                          color:Colors.grey,
                        ),
                      ],
                    ),
                  )
              ),
              Align(
                alignment: Alignment.topCenter,
                  child: Container(
                    margin: new EdgeInsets.only(
                      top: MediaQuery.of(context).size.height*0.82
                    ),
                    padding: new EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                            child: Container(
                                width:50,
                                height: 50,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image:AssetImage("images/facebook.jpg"),
                                        fit:BoxFit.cover
                                    ),
                                ),
                                ),
                            onTap:()=> _loginFaceBook()
                        ),
                        Padding(
                          padding: new EdgeInsets.only(left: 10),
                        ),
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          child: Container(
                              width:60,
                              height: 60,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image:AssetImage("images/google.png"),
                                      fit:BoxFit.cover
                                  ),
                              ),
                              ),
                          onTap:(){
                            _loginGoogle();
                          }),
                      ],
                    ),
                  )
              ),
              Align(
                alignment: Alignment.bottomRight,
                  child: BottomShape()
              ),
            ],
          ),
        ),
      ),
    );
  }
}