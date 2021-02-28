import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get_it/get_it.dart';
import 'package:image_recovery/Common/Widget/Button.dart';
import 'package:image_recovery/Common/Widget/custom_shape_bottom.dart';
import 'package:image_recovery/Common/Widget/custom_shape_top.dart';
import 'package:image_recovery/language/localization/app_translations.dart';
import 'package:image_recovery/modules/phananhtructuyen/widgets/progress_loading.dart';
import 'package:image_recovery/pages/Account/blocs/account_bloc.dart';
import 'package:image_recovery/pages/Account/events/account_event.dart';
import 'package:image_recovery/pages/Account/states/account_state.dart';
import 'package:image_recovery/pages/home/model/bottomSheet.dart';
import 'package:image_recovery/routes.dart';
import 'package:image_recovery/utils/navigations/navigation_datasource.dart';
import 'package:image_recovery/widgets/color_loader.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

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


  Uint8List image;

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
          body: _getCustomBody()
        )
    );
  }
  _getCustomBody() {
    return BlocBuilder<AccountBloc, AccountState>(
      builder: (context, state) {
        if(state is AccountStateFailure){
          return Container();
        }
        if(state is AccountStateInitial){
          return ProgressLoading();
        }
        if(state is AccountStateStart){
          try{
            this.image = base64Decode(state.userInfor['Picture']);
          }
          catch(e){

          }
          if(state.isChanging){
            return getBodyViewChangeAvatar(state);
          }
          else{
            return getBodyView(state);
          }
        }
        else{
          return Container();
        }
      },
    );
  }

  getBodyView(AccountStateStart state) {
    return Container(
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
                _navigation.popNavigation(context),
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
                    Stack(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            width: MediaQuery.of(context).size.width*0.26,
                            height: MediaQuery.of(context).size.width*0.26,
                            child: Stack(
                                children:[
                                  CircleAvatar(
                                      backgroundImage:this.image==null?AssetImage(
                                        "images/filter.webp",
                                      ):
                                      MemoryImage(
                                        this.image
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
                                        showCupertinoModalBottomSheet(
                                          expand: true,
                                          context: context,
                                          backgroundColor: Colors.transparent,
                                          builder: (contextc, scroll) => ModalInsideModal(
                                            multi: false,
                                            isAvatarEdit: true,
                                            methodChange: (image){
                                              BlocProvider.of<AccountBloc>(context)
                                                ..add(AccountEventStart(true,image));
                                            },
                                          ))
                                      },
                                    ),
                                  ),
                                ]
                            ),
                          ),
                        ),
                      ],
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
                top: MediaQuery.of(context).size.height*0.35,
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Name',
                          style: new TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          state.userInfor["Name"]==null?"":state.userInfor["Name"],
                          style: new TextStyle(
                              fontSize: 18,
                              color: Colors.grey
                          ),
                        )
                      ],
                    )
                ),
                Padding(
                  padding: new EdgeInsets.only(top: 5, bottom: 15),
                  child: Container(
                    height:1.0,
                    width:MediaQuery.of(context).size.width,
                    color:Colors.grey,
                  ),
                ),
                Container(
                    width: MediaQuery.of(context).size.width*0.9,
                    height: MediaQuery.of(context).size.height*0.06,
                    padding: new EdgeInsets.all(0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Phone',
                          style: new TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          state.userInfor["Numberphone"]==null?"":state.userInfor["Numberphone"],
                          style: new TextStyle(
                              fontSize: 18,
                              color: Colors.grey
                          ),
                        )
                      ],
                    )
                ),
                Padding(
                  padding: new EdgeInsets.only(top: 5, bottom: 15),
                  child: Container(
                    height:1.0,
                    width:MediaQuery.of(context).size.width,
                    color:Colors.grey,
                  ),
                ),
                Container(
                    width: MediaQuery.of(context).size.width*0.9,
                    height: MediaQuery.of(context).size.height*0.06,
                    padding: new EdgeInsets.all(0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Email',
                          style: new TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          state.userInfor["Email"]==null?"":state.userInfor["Email"],
                          style: new TextStyle(
                              fontSize: 18,
                              color: Colors.grey
                          ),
                        )
                      ],
                    )
                ),
                Padding(
                  padding: new EdgeInsets.only(top: 5, bottom: 15),
                  child: Container(
                    height:1.0,
                    width:MediaQuery.of(context).size.width,
                    color:Colors.grey,
                  ),
                ),
                Container(
                    width: MediaQuery.of(context).size.width*0.9,
                    height: MediaQuery.of(context).size.height*0.06,
                    padding: new EdgeInsets.all(0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Address',
                          style: new TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width*0.7,
                            child: Text(
                                state.userInfor["Address"]==null?"":state.userInfor["Address"],
                                style: new TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey
                                ),
                                textAlign: TextAlign.right
                            )
                        ),

                      ],
                    )
                ),
                Padding(
                  padding: new EdgeInsets.only(top: 5, bottom: 15),
                  child: Container(
                    height:1.0,
                    width:MediaQuery.of(context).size.width,
                    color:Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          BottomShape()
        ],
      ),
    );
  }

  getBodyViewChangeAvatar(AccountStateStart state){
   var height= MediaQuery.of(context).size.height;
    return Container(
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
                _navigation.popNavigation(context),
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
                    Stack(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            width: MediaQuery.of(context).size.width*0.26,
                            height: MediaQuery.of(context).size.width*0.26,
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
                                        showCupertinoModalBottomSheet(
                                            expand: true,
                                            context: context,
                                            backgroundColor: Colors.transparent,
                                            builder: (context, scroll) => ModalInsideModal(
                                              multi: false,
                                              isAvatarEdit: true,
                                              methodChange: (image){
                                                Uint8List Image = image;
                                                String a="";
                                              },
                                            ))
                                      },
                                    ),
                                  ),
                                ]
                            ),
                          ),
                        ),
                      ],
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
                top: MediaQuery.of(context).size.height*0.35,
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Name',
                          style: new TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          state.userInfor["Name"]==null?"":state.userInfor["Name"],
                          style: new TextStyle(
                              fontSize: 18,
                              color: Colors.grey
                          ),
                        )
                      ],
                    )
                ),
                Padding(
                  padding: new EdgeInsets.only(top: 5, bottom: 15),
                  child: Container(
                    height:1.0,
                    width:MediaQuery.of(context).size.width,
                    color:Colors.grey,
                  ),
                ),
                Container(
                    width: MediaQuery.of(context).size.width*0.9,
                    height: MediaQuery.of(context).size.height*0.06,
                    padding: new EdgeInsets.all(0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Phone',
                          style: new TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          state.userInfor["Numberphone"]==null?"":state.userInfor["Numberphone"],
                          style: new TextStyle(
                              fontSize: 18,
                              color: Colors.grey
                          ),
                        )
                      ],
                    )
                ),
                Padding(
                  padding: new EdgeInsets.only(top: 5, bottom: 15),
                  child: Container(
                    height:1.0,
                    width:MediaQuery.of(context).size.width,
                    color:Colors.grey,
                  ),
                ),
                Container(
                    width: MediaQuery.of(context).size.width*0.9,
                    height: MediaQuery.of(context).size.height*0.06,
                    padding: new EdgeInsets.all(0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Email',
                          style: new TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          state.userInfor["Email"]==null?"":state.userInfor["Email"],
                          style: new TextStyle(
                              fontSize: 18,
                              color: Colors.grey
                          ),
                        )
                      ],
                    )
                ),
                Padding(
                  padding: new EdgeInsets.only(top: 5, bottom: 15),
                  child: Container(
                    height:1.0,
                    width:MediaQuery.of(context).size.width,
                    color:Colors.grey,
                  ),
                ),
                Container(
                    width: MediaQuery.of(context).size.width*0.9,
                    height: MediaQuery.of(context).size.height*0.06,
                    padding: new EdgeInsets.all(0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Address',
                          style: new TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width*0.7,
                            child: Text(
                                state.userInfor["Address"]==null?"":state.userInfor["Address"],
                                style: new TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey
                                ),
                                textAlign: TextAlign.right
                            )
                        ),

                      ],
                    )
                ),
                Padding(
                  padding: new EdgeInsets.only(top: 5, bottom: 15),
                  child: Container(
                    height:1.0,
                    width:MediaQuery.of(context).size.width,
                    color:Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          BottomShape(),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: height,
              color: Colors.grey.withOpacity(0.8),
              child: Center(
                child: Container(
                  height: height*0.25,
                  width: MediaQuery.of(context).size.width*0.8,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                              state.isFailure?"Đã xảy ra lỗi\n Vui lòng thử lại!"
                                  : "Đang khôi đăng nhập\n Vui lòng chờ trong giây lát!",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w600
                              ),
                              textAlign: TextAlign.center
                          ),
                        ),
                        Container(
                          height: height*0.1,
                          width: height*0.1,
                          child: state.isFailure?
                          Icon(
                            FontAwesome.frown_o,
                            size: 35,
                            color: Color(0xff56AAE7),
                          )
                              : Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: ColorLoader3(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 0),
                          child: !state.isFailure ? Container()
                              :  RaisedGradientButton(
                              height: 40,
                              width: 160,
                              child: Text(
                                state.isFailure?AppTranslations.of(context).text("OK").toString()
                                    : AppTranslations.of(context).text("Cancel").toString(),
                                style: TextStyle(
                                    color:Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18
                                ),
                              ),
                              onPressed: () async {
                                BlocProvider.of<AccountBloc>(context)
                                  ..add(AccountEventStart(false,this.image));

                              }
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

}