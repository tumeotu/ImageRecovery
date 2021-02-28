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
import 'package:image_recovery/pages/EditAccount/blocs/edit_account_bloc.dart';
import 'package:image_recovery/pages/EditAccount/events/edit_account_event.dart';
import 'package:image_recovery/pages/EditAccount/states/edit_account_state.dart';
import 'package:image_recovery/pages/Register/blocs/register_bloc.dart';
import 'package:image_recovery/pages/Register/events/register_event.dart';
import 'package:image_recovery/pages/Register/states/register_state.dart';
import 'package:image_recovery/routes.dart';
import 'package:image_recovery/utils/navigations/navigation_datasource.dart';
import 'package:image_recovery/widgets/color_loader.dart';

class EditAccountScreen extends StatefulWidget {
  @override
  _EditAccountScreenState createState() => _EditAccountScreenState();
}
final getIt = GetIt.instance;
final _navigation = GetIt.instance.get<NavigationDataSource>();
class _EditAccountScreenState extends State<EditAccountScreen> {
  double height=0.0;
  TextEditingController nameControler=TextEditingController();
  TextEditingController phoneControler=TextEditingController();
  TextEditingController addressControler=TextEditingController();
  TextEditingController emailControler=TextEditingController();
  TextEditingController passwordControler=TextEditingController();
  int isnew=0;
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
    return BlocBuilder<EditAccountBloc, EditAccountState>(
      builder: (context, state) {
        if(state is EditAccountStateFailure){
          return Container();
        }
        if(state is EditAccountStateInitial){
          if(!state.isRegister){
            if(isnew<2){
              nameControler = TextEditingController(text: state.Name);
              phoneControler = TextEditingController(text: state.Phone);
              addressControler = TextEditingController(text: state.Address);
              this.isnew++;
            }
            return getBodyView(state);
          }
          else{
            nameControler = TextEditingController(text: state.Name);
            phoneControler = TextEditingController(text: state.Phone);
            addressControler = TextEditingController(text: state.Address);
            return getBodyViewRegister(state);
          }
        }
        else{
          return Container();
        }
      },
    );
  }

  getBodyView(EditAccountStateInitial state) {
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
                  top: MediaQuery.of(context).size.height*0.33,
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
                          hintText: AppTranslations.of(context).text("Name").toString(),
                          prefixIcon: Icon(Icons.person),
                        ),
                      ),
                    ),
                  ),
                  Padding(padding: new EdgeInsets.all(10),),
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
                            prefixIcon: Icon(Icons.phone),
                            hintText: AppTranslations.of(context).text("Phone").toString()
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
                        controller: addressControler,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: AppTranslations.of(context).text("Address").toString(),
                          prefixIcon: Icon(Icons.map),
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
                            if(nameControler.value.text.toString()==""||
                                phoneControler.value.text.toString()==""||
                                addressControler.value.text.toString()=="")
                            {
                              BlocProvider.of<EditAccountBloc>(context)
                                ..add(EditAccountEventEdit(true,
                                    nameControler.value.text.toString(),
                                    phoneControler.value.text.toString(),
                                    state.Email,
                                    addressControler.value.text.toString(),
                                    context));
                            }
                            else{
                              BlocProvider.of<EditAccountBloc>(context)
                                ..add(EditAccountEventEdit(false,
                                    nameControler.value.text.toString(),
                                    phoneControler.value.text.toString().trim(),
                                    state.Email,
                                    addressControler.value.text.toString(),
                                    context));
                            }
                          }
                      ),
                    ],
                  ),
                  Padding(padding: new EdgeInsets.all(10),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        child: Text(
                          "Đổi mật khẩu",
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 18,
                            fontWeight: FontWeight.w400
                          ),
                        ),
                        onTap: (){
                          _navigation.pushNavigation(NamePage.changePasswordPage);
                        },
                      ),
                    ],
                  ),
                  Padding(padding: new EdgeInsets.all(10),),
                ],
              ),
            ),
            BottomShape()
          ],
        ),
      ),
    );
  }

  getBodyViewRegister(EditAccountStateInitial state) {
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
                    Padding(padding: new EdgeInsets.all(10),),
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
                              BlocProvider.of<EditAccountBloc>(context)
                                ..add(EditAccountEventStart(false,false,
                                state.Name,state.Phone, state.Email,state.Address,""));

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