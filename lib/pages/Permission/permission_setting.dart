import 'package:app_settings/app_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get_it/get_it.dart';
import 'package:image_recovery/Common/Widget/custom_shape_bottom.dart';
import 'package:image_recovery/Common/Widget/custom_shape_top.dart';
import 'package:image_recovery/language/localization/app_translations.dart';
import 'package:image_recovery/language/localization/app_translations_delegate.dart';
import 'package:image_recovery/language/localization/application.dart';
import 'package:image_recovery/routes.dart';
import 'package:image_recovery/utils/navigations/navigation_datasource.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PermissionSettingScreen extends StatefulWidget {
  @override
  _PermissionSettingScreenState createState() => _PermissionSettingScreenState();
}

class _PermissionSettingScreenState extends State<PermissionSettingScreen> with WidgetsBindingObserver{
  SharedPreferences prefs;
  final getIt = GetIt.instance;
  final _navigation = GetIt.instance.get<NavigationDataSource>();
  bool camera= true;
  bool gallery= true;
  @override
  void initState()  {
    checkPermission();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if(state == AppLifecycleState.resumed){
      checkPermission();
    }
  }
  Future<void> checkPermission()
  async {
    var statusCamera = await Permission.camera.status;
    if (statusCamera.isUndetermined) {
      setState(() {
        camera= false;
      });
    }
    if(statusCamera.isDenied) {
      setState(() {
        camera= false;
      });
    }
    var statusGallery = await Permission.storage.status;
    if (statusGallery.isPermanentlyDenied) {
      setState(() {
        gallery= false;
      });
    }
    if(statusGallery.isDenied) {
      setState(() {
        gallery= false;
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
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  padding: new EdgeInsets.all(15),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap:(){
                          _navigation.popNavigation(context);
                          var params= {
                            'page':2
                          };
                          _navigation.pushNavigation(NamePage.homePage, params: params);
                        },
                        child: Icon(
                          Icons.arrow_back,
                          size: 35,
                          color: Color(0xff56AAE7),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Text(
                          'Cài đặt hệ thống',
                        style: new TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                    ],
                  )
                ),
                SizedBox(height: 1,),
                Container(
                  height: MediaQuery.of(context).size.height*0.06,
                  color: Colors.white,
                  padding: new EdgeInsets.only(
                    left: MediaQuery.of(context).size.width*0.02,
                    right: MediaQuery.of(context).size.width*0.02
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: MediaQuery.of(context).size.width*0.02,),
                      Text(
                          'Cho phép ImageRecovery truy cập Thư viện ảnh',
                        style: TextStyle(
                          fontSize: 14
                        ),
                      ),
                      Spacer(),
                      Switch(
                        value: gallery,
                        onChanged: (value){
                          AppSettings.openAppSettings();
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 1,),
                Container(
                  height: MediaQuery.of(context).size.height*0.06,
                  color: Colors.white,
                  padding: new EdgeInsets.only(
                      left: MediaQuery.of(context).size.width*0.02,
                      right: MediaQuery.of(context).size.width*0.02
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: MediaQuery.of(context).size.width*0.02,),
                      Text(
                        'Cho phép ImageRecovery truy cập Camera',
                        style: TextStyle(
                            fontSize: 14
                        ),
                      ),
                      Spacer(),
                      Switch(
                        value: camera,
                        onChanged: (value){
                          AppSettings.openAppSettings();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}