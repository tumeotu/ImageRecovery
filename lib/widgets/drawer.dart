import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_recovery/constants.dart';
import 'package:image_recovery/language/localization/app_translations.dart';
import 'package:image_recovery/routes.dart';

class NavDrawer extends StatelessWidget {
  final contextPage;
  final navigation;
  final VoidCallback setting;
  final VoidCallback filter;
  final VoidCallback recoverImage;
  const NavDrawer(
      {Key key,
        this.contextPage,
        this.navigation,
        this.setting,
        this.filter,
        this.recoverImage,
        })
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(contextPage).size.width*0.63,
        child: Drawer(
          child: Container(
            padding: new EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  navigationBarColorEnd,
                  navigationBarColorStart,
                ],
              ),
            ),
            child: ListView(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: CircleAvatar(
                        child:Image.asset(
                          "images/avatar.png",
                          fit: BoxFit.fill,
                        ),
                        radius: MediaQuery.of(context).size.height/15,
                      ),
                    ),
                    Padding(
                      padding: new EdgeInsets.all(5),
                    ),
                    Text(
                      AppTranslations.of(contextPage).text('Hi'),
                      style: new TextStyle(
                          fontSize: 20,
                        fontWeight: FontWeight.w600
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: new EdgeInsets.all(10),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: (){
                    Navigator.pop(context);
                    recoverImage();
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height*0.07,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 0.1,
                          blurRadius: 1,
                          offset: Offset(
                              0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Card(
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(15.0)),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 15,
                            right: 20
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: new Tab(
                                  icon: Icon(
                                    Icons.image,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Center(
                                child: Text(
                                  AppTranslations.of(contextPage).text("RecoverImage"),
                                  style: new TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: new EdgeInsets.all(7),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: (){
                    Navigator.pop(context);
                    filter();
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height*0.07,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 0.1,
                          blurRadius: 1,
                          offset: Offset(
                              0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Card(
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(15.0)),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 15,
                            right: 20
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: Icon(
                                    FontAwesome.file_photo_o
                                )
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Center(
                                child: Text(
                                  AppTranslations.of(contextPage).text("Filter"),
                                  style: new TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: new EdgeInsets.all(7),
                ),
                GestureDetector(
                  onTap: ()=>{
                    Navigator.pop(context),
                    navigation.pushNavigation(NamePage.accountPage)
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height*0.07,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 0.1,
                          blurRadius: 1,
                          offset: Offset(
                              0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Card(
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(15.0)),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 15,
                            right: 20
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: new Tab(
                                  icon: Icon(
                                    Icons.account_box,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Center(
                                child: Text(
                                  AppTranslations.of(contextPage).text("Account"),
                                  style: new TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: new EdgeInsets.all(7),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    Navigator.pop(context);
                    setting();
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height*0.07,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 0.1,
                          blurRadius: 1,
                          offset: Offset(
                              0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Card(
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(15.0)),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 15,
                            right: 20
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: new Tab(
                                  icon: Icon(
                                    Icons.settings,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Center(
                                child: Text(
                                  AppTranslations.of(contextPage).text("Setting"),
                                  style: new TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: new EdgeInsets.all(7),
                ),
                GestureDetector(
                  onTap: ()=>{

                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height*0.07,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 0.1,
                          blurRadius: 1,
                          offset: Offset(
                              0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Card(
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(15.0)),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 15,
                            right: 20
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: new Tab(
                                  icon: Icon(
                                      FontAwesome.sign_out
                                  )
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Center(
                                child: Text(
                                  AppTranslations.of(contextPage).text("Logout"),
                                  style: GoogleFonts.actor(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  )
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}