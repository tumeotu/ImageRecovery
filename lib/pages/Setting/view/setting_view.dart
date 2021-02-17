import 'package:app_settings/app_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get_it/get_it.dart';
import 'package:image_recovery/language/localization/app_translations.dart';
import 'package:image_recovery/language/localization/application.dart';
import 'package:image_recovery/modules/phananhtructuyen/widgets/progress_loading.dart';
import 'package:image_recovery/pages/Setting/bloc/SettingBloc.dart';
import 'package:image_recovery/pages/Setting/state/SettingState.dart';
import 'package:image_recovery/utils/navigations/navigation_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../routes.dart';
class SettingHome extends StatefulWidget {
  final contextString;
  SettingHome({Key key, this.contextString}) : super(key: key);
  @override
  _SettingHomeState createState() => _SettingHomeState();
}
class _SettingHomeState extends State<SettingHome> {
  final _navigation = GetIt.instance.get<NavigationDataSource>();
  double height;
  SharedPreferences prefs;
  int languages=0;
  int login=0;
  static final List<String> languagesList = application.supportedLanguages;
  static final List<String> languageCodesList =
      application.supportedLanguagesCodes;

  final Map<dynamic, dynamic> languagesMap = {
    languagesList[0]: languageCodesList[0],
    languagesList[1]: languageCodesList[1],
  };
  void onLocaleChange(Locale locale) async {
    setState(() {
      AppTranslations.load(locale);
    });
  }
  @override
  void initState()  {
    super.initState();
    setLanguages();
    application.onLocaleChanged = onLocaleChange;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black12.withOpacity(0.1),//or set color with: Color(0xFF0000FF)
    ));
  }


  Future<void> setLanguages() async {
    prefs= await SharedPreferences.getInstance();
    try {
      setState(() {
        languages = prefs.getInt('Languages');
      });
    }
    catch(e){
      setState(() {
        languages = 0;
      });
    }

    try {
      setState(() {
        login = prefs.getInt('Login');
      });
    }
    catch(e){
      setState(() {
        login = 0;
      });
    }
  }
  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xff56AAE7), //or set color with: Color(0xFF0000FF)
    ));
    super.dispose();
  }


  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: _getCustomBody()
      ),
    );
  }

  _getCustomBody() {
    return BlocBuilder<SettingBloc, SettingState>(
      builder: (context, state) {
        if (state is SettingStateInitial) {
          return ProgressLoading();
        } 
        else if(state is SettingStateStart)
          {
            return getDefaulteView(state);
          }
        return Container();
      },
    );
  }

  getDefaulteView(SettingStateStart state) {
    height= MediaQuery.of(context).size.height-MediaQuery.of(context).padding.top;
    return Container(
        color: Colors.white,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: height*0.4,
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  'images/filter.webp',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: height*0.7,
                margin: new EdgeInsets.only(bottom: height*0.03),
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.width*0.14),
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.width*0.20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0)
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                                padding: new EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width*0.07,
                                    right: MediaQuery.of(context).size.width*0.07
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppTranslations.of(widget.contextString).text('General').toString(),
                                      style: new TextStyle(
                                          fontSize: 20,
                                          color: Colors.black54
                                      ),
                                    ),
                                    Container(
                                        padding: new EdgeInsets.only(
                                          left: MediaQuery.of(context).size.width*0.04,
                                          top: MediaQuery.of(context).size.width*0.04,
                                        ),
                                        child: Column(
                                          children: [
                                            GestureDetector(
                                              onTap:(){
                                                _navigation.pushNavigation(NamePage.accountPage);
                                              },
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.account_box,
                                                    size: 35,
                                                    color: Color(0xff56AAE7),
                                                  ),
                                                  SizedBox(width: 10,),
                                                  Text(
                                                    AppTranslations.of(widget.contextString).text('Account').toString(),
                                                    style: new TextStyle(
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Icon(
                                                    Icons.chevron_right,
                                                    size: 35,
                                                    color: Color(0xff56AAE7),
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 20),
                                            GestureDetector(
                                              behavior: HitTestBehavior.translucent,
                                              onTap: () async {
                                                //_navigation.popNavigation(context);
                                                var param= await _navigation.pushNavigation(NamePage.languagesPage);
                                                languages= param['page'];
                                                setState(() {
                                                  if(languages==0)
                                                  {
                                                    onLocaleChange(Locale(languagesMap["English"]));
                                                  }
                                                  else{
                                                    onLocaleChange(Locale(languagesMap["Vietnamese"]));
                                                  }
                                                });
                                              },
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.language,
                                                    size: 35,
                                                    color: Color(0xff56AAE7),
                                                  ),
                                                  SizedBox(width: 10,),
                                                  Text(
                                                    AppTranslations.of(widget.contextString).text("Languages"),
                                                    style: new TextStyle(
                                                        fontSize: 16
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Text(
                                                    languages==1?'Tiếng Việt':'English',
                                                    style: new TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.black54
                                                    ),
                                                  ),
                                                  Icon(
                                                    Icons.chevron_right,
                                                    size: 35,
                                                    color: Color(0xff56AAE7),
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 20,),
                                            GestureDetector(
                                              behavior: HitTestBehavior.translucent,
                                              onTap: (){
                                                _navigation.pushNavigation(NamePage.permissionsPage);
                                              },
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.enhanced_encryption,
                                                    size: 35,
                                                    color: Color(0xff56AAE7),
                                                  ),
                                                  SizedBox(width: 10,),
                                                  Text(
                                                    AppTranslations.of(widget.contextString).text('Permissions').toString(),
                                                    style: new TextStyle(
                                                        fontSize: 16
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Icon(
                                                    Icons.chevron_right,
                                                    size: 35,
                                                    color: Color(0xff56AAE7),
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 20,),
                                          ],
                                        )
                                    ),
                                    SizedBox(height: 10,),
                                  ],
                                )
                            ),
                            Container(
                                padding: new EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width*0.07,
                                    right: MediaQuery.of(context).size.width*0.07
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppTranslations.of(widget.contextString).text('About').toString(),
                                      style: new TextStyle(
                                          fontSize: 20,
                                          color: Colors.black54
                                      ),
                                    ),
                                    Container(
                                        padding: new EdgeInsets.only(
                                          left: MediaQuery.of(context).size.width*0.04,
                                          top: MediaQuery.of(context).size.width*0.04,
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.rate_review,
                                                  size: 35,
                                                  color: Color(0xff56AAE7),
                                                ),
                                                SizedBox(width: 10,),
                                                Text(
                                                  AppTranslations.of(widget.contextString).text('Rating').toString(),
                                                  style: new TextStyle(
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                Spacer(),
                                                Icon(
                                                  Icons.chevron_right,
                                                  size: 35,
                                                  color: Color(0xff56AAE7),
                                                )
                                              ],
                                            ),
                                            SizedBox(height: 20),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.contacts,
                                                  size: 35,
                                                  color: Color(0xff56AAE7),
                                                ),
                                                SizedBox(width: 10,),
                                                Text(
                                                  AppTranslations.of(widget.contextString).text('Contact').toString(),
                                                  style: new TextStyle(
                                                      fontSize: 16
                                                  ),
                                                ),
                                                Spacer(),
                                                Icon(
                                                  Icons.chevron_right,
                                                  size: 35,
                                                  color: Color(0xff56AAE7),
                                                )
                                              ],
                                            ),
                                            SizedBox(height: 20,),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.assignment,
                                                  size: 35,
                                                  color: Color(0xff56AAE7),
                                                ),
                                                SizedBox(width: 10,),
                                                Text(
                                                  AppTranslations.of(widget.contextString).text('TermsOfService'),
                                                  style: new TextStyle(
                                                      fontSize: 16
                                                  ),
                                                ),
                                                Spacer(),
                                                Icon(
                                                  Icons.chevron_right,
                                                  size: 35,
                                                  color: Color(0xff56AAE7),
                                                )
                                              ],
                                            ),
                                            SizedBox(height: 20,),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.security,
                                                  size: 35,
                                                  color: Color(0xff56AAE7),
                                                ),
                                                SizedBox(width: 10,),
                                                Text(
                                                  AppTranslations.of(widget.contextString).text('PrivacyPolicy'),
                                                  style: new TextStyle(
                                                      fontSize: 16
                                                  ),
                                                ),
                                                Spacer(),
                                                Icon(
                                                  Icons.chevron_right,
                                                  size: 35,
                                                  color: Color(0xff56AAE7),
                                                )
                                              ],
                                            ),
                                            SizedBox(height: 20,),
                                            _getViewLogInLogOut(),
                                            SizedBox(height: 20,),
                                          ],
                                        )
                                    ),
                                    SizedBox(height: 10,),
                                  ],
                                )
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        margin: new EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1),
                        width: MediaQuery.of(context).size.width*0.28,
                        height: MediaQuery.of(context).size.width*0.28,
                        child: Stack(
                            children:[
                              CircleAvatar(
                                  backgroundImage:AssetImage(
                                    "images/filter.webp",
                                  ),
                                  radius:MediaQuery.of(context).size.width*0.14
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: GestureDetector(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width/12,
                                    height: MediaQuery.of(context).size.width/12,
                                    decoration: BoxDecoration(
                                      color: Color(0xff56AAE7),
                                      borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width/8)),
                                    ),
                                    child: Icon(
                                        Icons.edit,
                                        size: 20,
                                        color: Colors.white
                                    ),
                                  ),
                                  onTap: ()=>{
                                    //_navigation.popNavigation(context)
                                  },
                                ),
                              ),
                            ]
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        )
    );
  }
  _getViewLogInLogOut() {
    if(login==1)
    {
      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: (){
          Routes.sailor.popUntil((context) {
            return false;
          });
          prefs.setInt('Login', 0);
          _navigation.pushNavigation(NamePage.loginPage);
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              FontAwesome.sign_out,
              size: 35,
              color: Color(0xff56AAE7),
            ),
            SizedBox(width: 10,),
            Text(
              AppTranslations.of(widget.contextString).text('Logout'),
              style: new TextStyle(
                  fontSize: 16
              ),
            ),
            Spacer(),
            Icon(
              Icons.chevron_right,
              size: 35,
              color: Color(0xff56AAE7),
            )
          ],
        ),
      );
    }
    else{
      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: (){
          Routes.sailor.popUntil((context) {
            return false;
          });
          _navigation.pushNavigation(NamePage.loginPage);
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              FontAwesome.sign_in,
              size: 35,
              color: Color(0xff56AAE7),
            ),
            SizedBox(width: 10,),
            Text(
              AppTranslations.of(widget.contextString).text('Login'),
              style: new TextStyle(
                  fontSize: 16
              ),
            ),
            Spacer(),
            Icon(
              Icons.chevron_right,
              size: 35,
              color: Color(0xff56AAE7),
            )
          ],
        ),
      );
    }
  }
}
