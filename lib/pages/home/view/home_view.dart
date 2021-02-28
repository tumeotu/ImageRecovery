import 'dart:async';
import 'dart:ffi';
import 'dart:typed_data';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:image_recovery/language/localization/app_translations.dart';
import 'package:image_recovery/language/localization/application.dart';
import 'package:image_recovery/modules/phananhtructuyen/widgets/progress_loading.dart';
import 'package:image_recovery/pages/FilterHome/bloc/FilterHomeBloc.dart';
import 'package:image_recovery/pages/FilterHome/event/FilterHomeEvent.dart';
import 'package:image_recovery/pages/FilterHome/view/filter_home_view.dart';
import 'package:image_recovery/pages/HistoryRecover/bloc/HistoryRecoverBloc.dart';
import 'package:image_recovery/pages/HistoryRecover/event/HistoryRecoverEvent.dart';
import 'package:image_recovery/pages/HistoryRecover/view/history_recover.dart';
import 'package:image_recovery/pages/RecoverImageHome/bloc/RecoverImageHomeBloc.dart';
import 'package:image_recovery/pages/RecoverImageHome/event/RecoverImageHomeEvent.dart';
import 'package:image_recovery/pages/RecoverImageHome/view/recovery_image_home_view.dart';
import 'package:image_recovery/pages/Setting/bloc/SettingBloc.dart';
import 'package:image_recovery/pages/Setting/event/SettingEvent.dart';
import 'package:image_recovery/pages/Setting/view/setting_view.dart';
import 'package:image_recovery/pages/home/blocs/HomeBloc.dart';
import 'package:image_recovery/pages/home/model/bottomSheet.dart';
import 'package:image_recovery/pages/home/states/HomeState.dart';
import 'package:image_recovery/utils/navigations/navigation_datasource.dart';
import 'package:image_recovery/widgets/appbar_custom.dart';
import 'package:image_recovery/widgets/drawer.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../../constants.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}
final getIt = GetIt.instance;
final _navigation = GetIt.instance.get<NavigationDataSource>();
class _HomeScreenState extends State<HomeScreen>with RouteAware {

  final String title='';
  PageController _pageController;
  GlobalKey _bottomNavigationKey = GlobalKey();
  int index=0;
  Uint8List image;
  @override
  void initState(){
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xff56AAE7), //or set color with: Color(0xFF0000FF)
    ));
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.white,
          drawer: NavDrawer(
            contextPage: context,
            navigation: _navigation,
            image: image,
            setting: (){
              final CurvedNavigationBarState navBarState =
                  _bottomNavigationKey.currentState;
              navBarState.setPage(2);
            },
            filter: (){
              final CurvedNavigationBarState navBarState =
                  _bottomNavigationKey.currentState;
              navBarState.setPage(0);
            },
            recoverImage: (){
              final CurvedNavigationBarState navBarState =
                  _bottomNavigationKey.currentState;
              navBarState.setPage(1);
            },
          ),
          bottomNavigationBar: CurvedNavigationBar(
            key: _bottomNavigationKey,
            height: 55,
            backgroundColor: Colors.white,
            buttonBackgroundColor: Color(0xff56AAE7),
            index: index,
            animationDuration: const Duration(milliseconds: 400),
            color: Color(0xff56AAE7),
            items: <Widget>[
              Tab(
                icon: Icon(
                  Icons.filter_b_and_w,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.history,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.settings,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ],
            onTap: (index) {
              _pageController.animateToPage(index, duration: Duration(milliseconds: 20), curve: Curves.linear);
            },
          ),
          body: _getCustomBody()
        )
    );
  }

  _getCustomBody() {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeStateInitial) {
          return ProgressLoading();
        }
        else if(state is HomeStateStart)
        {
          image = state.image;
          _pageController = new PageController(initialPage:state.page);
          index= state.page;
          return getHomeView();
        }
        return Container();
      },
    );
  }

  getHomeView() {
    return PageView(
      onPageChanged: (index){
        final CurvedNavigationBarState navBarState =
            _bottomNavigationKey.currentState;
        navBarState.setPage(index);
      },
      controller: _pageController,
      children: [
        BlocProvider<RecoverImageHomeBloc>(
          create: (_) => RecoverImageHomeBloc()..add(RecoverImageHomeEventStart()),
          child: RecoverImageHomePage(
            contextString: context,
            pageController: _pageController,
          ),
        ),
        BlocProvider<HistoryRecoverBloc>(
          create: (_) => HistoryRecoverBloc()..add(HistoryRecoverEventStart(1,0, false, null, null)),
          child: HistoryRecoverPage(
            contextString: context,
            pageController: _pageController,
          ),
        ),
        BlocProvider<SettingBloc>(
          create: (_) => SettingBloc()..add(SettingEventStart()),
          child: SettingHome(
            contextString: context,
          ),
        ),
      ],
    );
  }
  _customAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(heightNavigationBar),
      child: AppBarCustom(
        title: AppTranslations.of(context).text('Account').toString(),
        startColor: navigationBarColorEnd,
        endColor: navigationBarColorStart,
        iconMenu: Icons.menu,
      ),
    );
  }

}

