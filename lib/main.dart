import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:image_recovery/config_service.dart';
import 'package:image_recovery/pages/SplashScreen/SplashScreen.dart';
import 'package:image_recovery/pages/home/blocs/HomeBloc.dart';
import 'package:image_recovery/pages/home/events/HomeEvent.dart';
import 'package:image_recovery/pages/home/view/home_view.dart';
import 'package:image_recovery/pages/login/login_page.dart';
import 'package:image_recovery/routes.dart';
import 'package:image_recovery/utils/navigations/navigation_datasource.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'language/localization/app_translations_delegate.dart';
import 'language/localization/application.dart';
import 'utils/appsettings.dart';

Future<Null> main() async {
  Routes.createRoutes();
  GetIt.instance.registerSingletonAsync<ConfigService>(() async {
    final configService = ConfigService();
    await configService.init();
    return configService;
  });
  await AppSettings.innitAppSetting();
  runApp(new LocalisedApp());
}

class LocalisedApp extends StatefulWidget {
  @override
  LocalisedAppState createState() {
    return new LocalisedAppState();
  }
}

class LocalisedAppState extends State<LocalisedApp> {
  AppTranslationsDelegate _newLocaleDelegate;
  static final List<String> languagesList = application.supportedLanguages;
  static final List<String> languageCodesList =
      application.supportedLanguagesCodes;
  final Map<dynamic, dynamic> languagesMap = {
    languagesList[0]: languageCodesList[0],
    languagesList[1]: languageCodesList[1],
  };
  var page=0;
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _newLocaleDelegate = AppTranslationsDelegate(newLocale: null);
    application.onLocaleChanged = onLocaleChange;
    setLanguages();
  }
  Future<void> setLanguages() async {
    var prefs= await SharedPreferences.getInstance();
    try {
      setState(() {
        var languages = prefs.getInt('Languages');
        if(languages==0)
          {
            onLocaleChange(Locale(languagesMap["English"]));
          }
        else{
          onLocaleChange(Locale(languagesMap["Vietnamese"]));
        }
      });
    }
    catch(e){
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue,
        accentColor: Colors.blueAccent,
      ),
      navigatorKey: Routes.sailor.navigatorKey,
      // important
      onGenerateRoute: Routes.sailor.generator(),
      localizationsDelegates: [
        _newLocaleDelegate,
        //provides localised strings
        GlobalMaterialLocalizations.delegate,
        //provides RTL support
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale("en", ""),
        const Locale("es", ""),
      ],
      home: BlocProvider<HomeBloc>(
        create: (_) => HomeBloc()..add(HomeEventStart(page)),
        child: HomeScreen(),
      ),
    );
  }

  void onLocaleChange(Locale locale) {
    setState(() {
      _newLocaleDelegate = AppTranslationsDelegate(newLocale: locale);
    });
  }

  getHome() {
    final getIt = GetIt.instance;
    final _navigation = GetIt.instance.get<NavigationDataSource>();
    var params= {
      'page':1
    };
    _navigation.pushNavigation(NamePage.homePage, params: params);
  }
}
// MultiBlocProvider(
// providers: [
// BlocProvider<TabbedDashboardBloc>(
// create: (context) => TabbedDashboardBloc(),
// ),
// BlocProvider<DashboardBloc>(
// create: (context) =>
// DashboardBloc()..add(DashboardMainEventStart()),
// ),
// BlocProvider<DashboardTinTucBloc>(
// create: (context) => DashboardTinTucBloc(),
// ),
// BlocProvider<DashboardTinTucBlocList>(
// create: (context) => DashboardTinTucBlocList(),
// ),
// ],
// child: TabbedPageDashboard(),
// )