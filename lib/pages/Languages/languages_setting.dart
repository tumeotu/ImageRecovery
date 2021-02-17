import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:image_recovery/Common/Widget/custom_shape_bottom.dart';
import 'package:image_recovery/Common/Widget/custom_shape_top.dart';
import 'package:image_recovery/language/localization/app_translations.dart';
import 'package:image_recovery/language/localization/app_translations_delegate.dart';
import 'package:image_recovery/language/localization/application.dart';
import 'package:image_recovery/routes.dart';
import 'package:image_recovery/utils/navigations/navigation_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguagesSettingScreen extends StatefulWidget {
  @override
  _LanguagesSettingScreenState createState() => _LanguagesSettingScreenState();
}

class _LanguagesSettingScreenState extends State<LanguagesSettingScreen> {
  SharedPreferences prefs;
  final getIt = GetIt.instance;
  int languages=0;
  final _navigation = GetIt.instance.get<NavigationDataSource>();
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
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Container(
            color: Colors.grey.withOpacity(0.5),
            margin: new EdgeInsets.only(
                top: MediaQuery.of(context).padding.top
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap:(){
                    var params= {
                      'page':2
                    };
                    _navigation.popNavigation(context, params: params);
                    // var params= {
                    //   'page':2
                    // };
                    // _navigation.pushNavigation(NamePage.homePage, params: params);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    padding: new EdgeInsets.all(15),
                    child: Row(
                      children: [
                        Icon(
                          Icons.arrow_back,
                          size: 35,
                          color: Color(0xff56AAE7),
                        ),
                        SizedBox(width: 10,),
                        Text(
                            'Chọn ngôn ngữ',
                          style: new TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () async {
                            await prefs.setInt('Languages', languages);
                            setState(() {
                              if(languages==0)
                              {
                                onLocaleChange(Locale(languagesMap["English"]));
                              }
                              else{
                                onLocaleChange(Locale(languagesMap["Vietnamese"]));
                              }
                              var params= {
                                'page':languages
                              };
                              _navigation.popNavigation(context, params: params);
                            });
                          },
                          child: Icon(
                            Icons.check,
                            size: 30,
                            color: Color(0xff56AAE7),
                          ),
                        ),
                        SizedBox(width: 10,)
                      ],
                    )
                  ),
                ),
                SizedBox(height: 1,),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      languages=0;
                    });
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height*0.06,
                    color: Colors.white,
                    padding: new EdgeInsets.only(
                      left: MediaQuery.of(context).size.width*0.1,
                      right: MediaQuery.of(context).size.width*0.1
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check,
                          color: languages==0?Colors.blue:Colors.transparent,
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width*0.04,),
                        Text(
                            'English',
                          style: TextStyle(
                            fontSize: 18
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
                SizedBox(height: 1,),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      languages=1;
                    });
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height*0.06,
                    color: Colors.white,
                    padding: new EdgeInsets.only(
                        left: MediaQuery.of(context).size.width*0.1,
                        right: MediaQuery.of(context).size.width*0.1
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check,
                          color: languages==1?Colors.blue:Colors.transparent,
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width*0.04,),
                        Text(
                          'Tiếng Việt',
                          style: TextStyle(
                              fontSize: 18
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}