import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:image_recovery/Common/Widget/Button.dart';
import 'package:image_recovery/Common/Widget/custom_shape_bottom.dart';
import 'package:image_recovery/Common/Widget/custom_shape_top.dart';
import 'package:image_recovery/language/localization/app_translations.dart';
import 'package:image_recovery/language/localization/application.dart';
import 'package:image_recovery/utils/navigations/navigation_datasource.dart';

class EditAccountTempScreen extends StatefulWidget {
  @override
  _EditAccountScreenState createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountTempScreen> {
  final getIt = GetIt.instance;
  final _navigation = GetIt.instance.get<NavigationDataSource>();
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
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: MediaQuery.of(context).size.width*0.28,
                    height: MediaQuery.of(context).size.width*0.28,
                    margin: new EdgeInsets.only(
                        top: MediaQuery.of(context).size.height*0.14
                    ),
                    child: Stack(
                      children:[
                        CircleAvatar(
                            child:Image.asset(
                              "images/avatar.png",
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
                Container(
                  margin: new EdgeInsets.only(
                      top: MediaQuery.of(context).size.height*0.3,
                      left: 20,
                      right: 20),
                  width: double.infinity,
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
                                  onPressed: ()=>{},
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
                      Padding(padding: new EdgeInsets.all(10),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RaisedGradientButton(
                              height: 40,
                              width: MediaQuery.of(context).size.width-40,
                              child: Text(
                                AppTranslations.of(context).text("Confirm").toString().toUpperCase(),
                                style: TextStyle(
                                    color:Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                ),
                              ),
                              onPressed: (){
                              }
                          ),
                        ],
                      ),
                      Padding(padding: new EdgeInsets.all(10),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Đổi mật khẩu',
                            style: new TextStyle(
                              fontSize: 16,
                              color: Colors.blue
                            ),
                          )
                        ],
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