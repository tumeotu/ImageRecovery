import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:image_recovery/Common/Widget/custom_shape_bottom.dart';
import 'package:image_recovery/Common/Widget/custom_shape_top.dart';
import 'package:image_recovery/language/localization/app_translations.dart';
import 'package:image_recovery/routes.dart';
import 'package:image_recovery/utils/navigations/navigation_datasource.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}
final getIt = GetIt.instance;
final _navigation = GetIt.instance.get<NavigationDataSource>();
class _AccountScreenState extends State<AccountScreen> {


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
      debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Container(
            color: Colors.white,
            margin: new EdgeInsets.only(
                top: MediaQuery.of(context).padding.top
            ),
            child: Stack(
              children: [
                TopShape(),
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
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    child: Container(
                      width: MediaQuery.of(context).size.width/9,
                      height: MediaQuery.of(context).size.width/9,
                      margin: new EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width/8)),
                      ),
                      child: Icon(
                        Icons.edit,
                        size: 25,
                        color: Color(0xff56AAE7),
                      ),
                    ),
                    onTap: ()=>{
                      _navigation.pushNavigation(NamePage.editAccountPage)
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: MediaQuery.of(context).size.width*0.8,
                    height: MediaQuery.of(context).size.width*0.28,
                    margin: new EdgeInsets.only(
                      top: MediaQuery.of(context).size.height*0.15
                    ),
                    child: Card(
                        color: Colors.white,
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(
                                MediaQuery.of(context).size.width*0.13
                            )
                        ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                              child:Image.asset(
                                "images/avatar.png",
                              ),
                              radius:MediaQuery.of(context).size.width*0.13
                          ),
                          Padding(
                            padding: new EdgeInsets.all(10),
                          ),
                          Text(
                            AppTranslations.of(context).text('Hi'),
                            style: new TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: new EdgeInsets.only(
                      top: MediaQuery.of(context).size.height*0.33,
                      left: 50,
                      right: 20),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width*0.9,
                        height: MediaQuery.of(context).size.height*0.06,
                        padding: new EdgeInsets.all(0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.person,
                              size: 30,
                            ),
                            Padding(
                              padding: new EdgeInsets.all(6),
                            ),
                            Text(
                                'Trương Văn Tú',
                              style: new TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                              ),
                            )
                          ],
                        )
                      ),
                      Padding(padding: new EdgeInsets.all(6),),
                      Container(
                          width: MediaQuery.of(context).size.width*0.9,
                          height: MediaQuery.of(context).size.height*0.06,
                          padding: new EdgeInsets.all(0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.phone,
                                size: 30,
                              ),
                              Padding(
                                padding: new EdgeInsets.all(6),
                              ),
                              Text(
                                '0978966563',
                                style: new TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                ),
                              )
                            ],
                          )
                      ),
                      Padding(padding: new EdgeInsets.all(6),),
                      Container(
                          width: MediaQuery.of(context).size.width*0.9,
                          height: MediaQuery.of(context).size.height*0.06,
                          padding: new EdgeInsets.all(0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.date_range,
                                size: 30,
                              ),
                              Padding(
                                padding: new EdgeInsets.all(6),
                              ),
                              Text(
                                '21/05/1999',
                                style: new TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                ),
                              )
                            ],
                          )
                      ),
                      Padding(padding: new EdgeInsets.all(6),),
                      Container(
                          width: MediaQuery.of(context).size.width*0.9,
                          height: MediaQuery.of(context).size.height*0.06,
                          padding: new EdgeInsets.all(0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.people,
                                size: 30,
                              ),
                              Padding(
                                padding: new EdgeInsets.all(6),
                              ),
                              Text(
                                'Nam',
                                style: new TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                ),
                              )
                            ],
                          )
                      ),
                      Padding(padding: new EdgeInsets.all(6),),
                      Container(
                          width: MediaQuery.of(context).size.width*0.9,
                          height: MediaQuery.of(context).size.height*0.06,
                          padding: new EdgeInsets.all(0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.email,
                                size: 30,
                              ),
                              Padding(
                                padding: new EdgeInsets.all(6),
                              ),
                              Text(
                                'tumeotl@gmail.com',
                                style: new TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                ),
                              )
                            ],
                          )
                      ),
                      Padding(padding: new EdgeInsets.all(10),),
                      Container(
                          width: MediaQuery.of(context).size.width*0.9,
                          height: MediaQuery.of(context).size.height*0.1,
                          padding: new EdgeInsets.all(0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.map,
                                size: 30,
                              ),
                              Padding(
                                padding: new EdgeInsets.all(6),
                              ),
                              Flexible(
                                child: Text("167 Lương Nhữ Học phường 11 quận 5 TP.HCM",
                                    maxLines: 4,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      fontSize: 18
                                    )
                                ),
                              ),
                            ],
                          )
                      ),
                    ],
                  ),
                ),
                BottomShape()
              ],
            ),
          ),
        )
    );
  }
}