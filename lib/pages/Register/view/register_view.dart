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
import 'package:image_recovery/pages/Register/blocs/register_bloc.dart';
import 'package:image_recovery/pages/Register/events/register_event.dart';
import 'package:image_recovery/pages/Register/states/register_state.dart';
import 'package:image_recovery/utils/navigations/navigation_datasource.dart';
import 'package:image_recovery/widgets/color_loader.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}
final getIt = GetIt.instance;
final _navigation = GetIt.instance.get<NavigationDataSource>();
class _RegisterScreenState extends State<RegisterScreen> {
  double height=0.0;
  TextEditingController nameControler=TextEditingController();
  TextEditingController phoneControler=TextEditingController();
  TextEditingController addressControler=TextEditingController();
  TextEditingController emailControler=TextEditingController();
  TextEditingController passwordControler=TextEditingController();

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
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        if(state is RegisterStateFailure){
          return Container();
        }
        if(state is RegisterStateInitial){
          if(!state.isRegister)
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

  getBodyView(RegisterStateInitial state) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
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
            Container(
              margin: new EdgeInsets.only(
                  top: MediaQuery.of(context).size.height*0.24,
                  left: 20,
                  right: 20),
              width: double.infinity,
              decoration: BoxDecoration(
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
                  Container(
                    width: MediaQuery.of(context).size.width*0.9,
                    height: MediaQuery.of(context).size.height*0.06,
                    padding: new EdgeInsets.all(0),
                    child: Card(
                      color: Colors.white,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(8.0),
                      ),
                      child:  TextField(
                        controller: nameControler,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: state.Name==''?null:state.Name,
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
                        keyboardType: TextInputType.phone,
                        controller: phoneControler,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: state.Phone==''?null:state.Phone,
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
                        controller: addressControler,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: state.Address==''?null:state.Address,
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
                        keyboardType: TextInputType.emailAddress,
                        controller: emailControler,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.email),
                            labelText: state.Email==''?null:state.Email,
                            hintText: AppTranslations.of(context).text("Email").toString()
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
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        controller: passwordControler,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: state.Password==''?null:state.Password,
                          hintText: AppTranslations.of(context).text("Password").toString(),
                          prefixIcon: Icon(Icons.vpn_key),
                        ),
                      ),
                    ),
                  ),
                  Padding(padding: new EdgeInsets.all(10),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RaisedGradientButton(
                          height: 40,
                          width: 120,
                          child: Text(
                            AppTranslations.of(context).text("Signup").toString().toUpperCase(),
                            style: TextStyle(
                                color:Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18
                            ),
                          ),
                          onPressed: (){
                            if(nameControler.value.text.toString()==""||
                                phoneControler.value.text.toString()==""||
                                emailControler.value.text.toString()==""||
                                addressControler.value.text.toString()==""||
                                passwordControler.value.text.toString()=="")
                            {
                              BlocProvider.of<RegisterBloc>(context)
                                ..add(RegisterEventRegister(true,
                                    nameControler.value.text.toString(),
                                    phoneControler.value.text.toString(),
                                    emailControler.value.text.toString(),
                                    addressControler.value.text.toString(),
                                    passwordControler.value.text.toString(),
                                    context));
                            }
                            else if(isEmail(emailControler.value.text.toString().trim())==false)
                            {
                              BlocProvider.of<RegisterBloc>(context)
                                ..add(RegisterEventRegister(true,
                                    nameControler.value.text.toString(),
                                    phoneControler.value.text.toString(),
                                    emailControler.value.text.toString(),
                                    addressControler.value.text.toString(),
                                    passwordControler.value.text.toString(),
                                    context));
                            }
                            else{
                              BlocProvider.of<RegisterBloc>(context)
                                ..add(RegisterEventRegister(false,
                                    nameControler.value.text.toString(),
                                    phoneControler.value.text.toString().trim(),
                                    emailControler.value.text.toString().trim(),
                                    addressControler.value.text.toString(),
                                    passwordControler.value.text.toString(),
                                    context));
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
      ),
    );
  }

  getBodyViewRegister(RegisterStateInitial state) {
    height=MediaQuery.of(context).size.height-MediaQuery.of(context).padding.top;
    return Stack(
      children: [
        Container(
          color: Colors.white,
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
              Container(
                margin: new EdgeInsets.only(
                    top: MediaQuery.of(context).size.height*0.24,
                    left: 20,
                    right: 20),
                width: double.infinity,
                decoration: BoxDecoration(
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
                    Container(
                      width: MediaQuery.of(context).size.width*0.9,
                      height: MediaQuery.of(context).size.height*0.06,
                      padding: new EdgeInsets.all(0),
                      child: Card(
                        color: Colors.white,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(8.0),
                        ),
                        child:  TextField(
                          controller: nameControler,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: state.Name==''?null:state.Name,
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
                          keyboardType: TextInputType.phone,
                          controller: phoneControler,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: state.Phone==''?null:state.Phone,
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
                          controller: addressControler,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: state.Address==''?null:state.Address,
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
                          keyboardType: TextInputType.emailAddress,
                          controller: emailControler,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.email),
                              labelText: state.Email==''?null:state.Email,
                              hintText: AppTranslations.of(context).text("Email").toString()
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
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          controller: passwordControler,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: state.Password==''?null:state.Password,
                            hintText: AppTranslations.of(context).text("Password").toString(),
                            prefixIcon: Icon(Icons.vpn_key),
                          ),
                        ),
                      ),
                    ),
                    Padding(padding: new EdgeInsets.all(10),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        RaisedGradientButton(
                            height: 40,
                            width: 120,
                            child: Text(
                              AppTranslations.of(context).text("Signup").toString().toUpperCase(),
                              style: TextStyle(
                                  color:Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                              ),
                            ),
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
                              BlocProvider.of<RegisterBloc>(context)
                                ..add(RegisterEventStart(false,false,
                                state.Name,state.Phone, state.Email,state.Address,state.Password));

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