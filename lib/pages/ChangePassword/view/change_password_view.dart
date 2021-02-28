import 'dart:async';
import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get_it/get_it.dart';
import 'package:image_recovery/Common/Widget/Button.dart';
import 'package:image_recovery/Common/Widget/custom_shape_bottom.dart';
import 'package:image_recovery/Common/Widget/custom_shape_top.dart';
import 'package:image_recovery/language/localization/app_translations.dart';
import 'package:image_recovery/language/localization/application.dart';
import 'package:image_recovery/pages/ChangePassword/blocs/change_password_bloc.dart';
import 'package:image_recovery/pages/ChangePassword/events/change_password_event.dart';
import 'package:image_recovery/pages/ChangePassword/states/change_password_state.dart';
import 'package:image_recovery/pages/Register/blocs/register_bloc.dart';
import 'package:image_recovery/pages/Register/events/register_event.dart';
import 'package:image_recovery/pages/Register/states/register_state.dart';
import 'package:image_recovery/utils/navigations/navigation_datasource.dart';
import 'package:image_recovery/widgets/color_loader.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}
final getIt = GetIt.instance;
final _navigation = GetIt.instance.get<NavigationDataSource>();
class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  double height=0.0;
  TextEditingController oldControler=TextEditingController();
  TextEditingController newControler=TextEditingController();
  TextEditingController newConfirmControler=TextEditingController();

  @override
  void initState()  {
    super.initState();
  }
  DateTime selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: SafeArea(
            child: _getCustomBody(),
          )),
    );
  }

  _getCustomBody() {
    return BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
      builder: (context, state) {
        if(state is ChangePasswordStateFailure){
          return Container();
        }
        if(state is ChangePasswordStateStart){
          if(!state.isChanging)
            return getBodyView(state);
          else
            return getBodyViewRegister(state);
        }
        else{
          return Container();
        }
      },
    );
  }

  getBodyView(ChangePasswordStateStart state) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          TopShape(),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: new EdgeInsets.only(
                  top: MediaQuery.of(context).size.height*0.12),
              width: 50,
              height: 50,
              child: Image.asset('images/logo.png'),
            ),
          ),
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
              margin: new EdgeInsets.only(
                  top: MediaQuery.of(context).size.height*0.27),
              width: MediaQuery.of(context).size.width-100,
              height: 50,
              child: Center(
                child: Text(
                  'ImageRecovery',
                  style: new TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: new EdgeInsets.only(
                top: MediaQuery.of(context).size.height*0.37,
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
                      controller: oldControler,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: AppTranslations.of(context).text("OldPassword").toString(),
                        prefixIcon: Icon(Icons.vpn_key),
                      ),
                    ),
                  ),
                ),
                Padding(padding: new EdgeInsets.all(10),),
                Container(
                  width: MediaQuery.of(context).size.width*0.9,
                  height: MediaQuery.of(context).size.height*0.06,
                  padding: new EdgeInsets.all(0),
                  child: Card(
                    color: Colors.white,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(8.0)),
                    child:  TextField(
                      controller: newControler,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: AppTranslations.of(context).text("NewPassword").toString(),
                        prefixIcon: Icon(Icons.vpn_key),
                      ),
                    ),
                  ),
                ),
                Padding(padding: new EdgeInsets.all(10),),
                Container(
                  width: MediaQuery.of(context).size.width*0.9,
                  height: MediaQuery.of(context).size.height*0.06,
                  padding: new EdgeInsets.all(0),
                  child: Card(
                    color: Colors.white,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(8.0)),
                    child:  TextField(
                      controller: newConfirmControler,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: AppTranslations.of(context).text("ConfirmNewPassword").toString(),
                        prefixIcon: Icon(Icons.vpn_key),
                      ),
                    ),
                  ),
                ),
                Padding(padding: new EdgeInsets.all(20),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RaisedGradientButton(
                        height: 40,
                        width: 120,
                        child: Text(
                          AppTranslations.of(context).text("Confirm").toString().toUpperCase(),
                          style: TextStyle(
                              color:Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18
                          ),
                        ),
                        onPressed: (){
                          if(oldControler.value.text.toString()==""||
                            newControler.value.text.toString()==""||
                            newConfirmControler.value.text.toString()==""){
                            BlocProvider.of<ChangePasswordBloc>(context)
                              ..add(ChangePasswordEventStart(true,true,
                                  oldControler.value.text.toString(),
                                  newControler.value.text.toString(),
                                  context,"Fail"));
                          }else if(newControler.value.text.toString()!=
                              newConfirmControler.value.text.toString()){
                            BlocProvider.of<ChangePasswordBloc>(context)
                              ..add(ChangePasswordEventStart(true,true,
                                  oldControler.value.text.toString(),
                                  newControler.value.text.toString(),
                                  context,"ConfirmNewPasswordFailure"));
                          }else{
                            BlocProvider.of<ChangePasswordBloc>(context)
                              ..add(ChangePasswordEventStart(true,false,
                                  oldControler.value.text.toString(),
                                  newControler.value.text.toString(),
                                  context,"Fail"));
                          }
                        }
                    ),
                  ],
                ),
                Padding(padding: new EdgeInsets.all(6),),
              ],
            ),
          ),
          BottomShape()
        ],
      ),
    );
  }

  getBodyViewRegister(ChangePasswordStateStart state) {
    height=MediaQuery.of(context).size.height-MediaQuery.of(context).padding.top;
    return Stack(
      children: [
        Container(
          margin: new EdgeInsets.only(
              top: MediaQuery.of(context).size.height*0.38,
              left: 20,
              right: 20),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(padding: new EdgeInsets.all(3),),
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
                      hintText: AppTranslations.of(context).text("OldPassword").toString(),
                      prefixIcon: Icon(Icons.vpn_key),
                    ),
                  ),
                ),
              ),
              Padding(padding: new EdgeInsets.all(3),),
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
                      hintText: AppTranslations.of(context).text("NewPassword").toString(),
                      prefixIcon: Icon(Icons.vpn_key),
                    ),
                  ),
                ),
              ),
              Padding(padding: new EdgeInsets.all(10),),
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
                      hintText: AppTranslations.of(context).text("ConfirmNewPassword").toString(),
                      prefixIcon: Icon(Icons.vpn_key),
                    ),
                  ),
                ),
              ),
              Padding(padding: new EdgeInsets.all(20),),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedGradientButton(
                      height: 40,
                      width: 120,
                      child: Text(
                        AppTranslations.of(context).text("Confirm").toString().toUpperCase(),
                        style: TextStyle(
                            color:Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18
                        ),
                      ),
                      onPressed: (){
                      }
                  ),
                ],
              ),
              Padding(padding: new EdgeInsets.all(6),),
            ],
          ),
        ),
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
                            state.isFailure?AppTranslations.of(context).text(state.error).toString()
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
                              BlocProvider.of<ChangePasswordBloc>(context)
                                ..add(ChangePasswordEventStart(
                                  false,false,
                                  oldControler.value.text.toString(),
                                  oldControler.value.text.toString(),
                                  context,""
                                ));

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
    );
  }

  bool isEmail(String string) {
    // Null or empty string is invalid
    if (string == null || string.isEmpty) {
      return true;
    }

    const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(string)) {
      return false;
    }
    return true;
  }
}