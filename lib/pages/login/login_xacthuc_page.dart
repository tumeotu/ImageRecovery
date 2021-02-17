import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:image_recovery/data/models/user_models.dart';
import 'package:image_recovery/pages/login/blocs/login_bloc.dart';
import 'package:image_recovery/pages/login/events/login_event.dart';
import 'package:image_recovery/routes.dart';
import 'package:image_recovery/utils/appsettings.dart';
import 'package:image_recovery/utils/color_extends.dart';
import 'package:image_recovery/utils/navigations/navigation_datasource.dart';
import 'package:sailor/sailor.dart';

import '../../constants.dart';
import 'states/login_state.dart';

class LoginXacThucPage extends StatefulWidget {
  @override
  _LoginXacThucPageState createState() => _LoginXacThucPageState();
}

class _LoginXacThucPageState extends State<LoginXacThucPage> {
  double deviceWidth, deviceHeight;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;

    print('login_xacthuc_page');

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              height: deviceHeight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image(
                    image: AssetImage(logo_hocmon),
                    height: deviceHeight / 14,
                    width: deviceWidth / 7.2,
                  ),
                  SizedBox(
                    height: deviceHeight / 38,
                  ),
                  Text(
                    'XÁC THỰC SỐ ĐIỆN THOẠI',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: deviceHeight / 46,
                  ),
                  Text(
                    'Bạn cần dung mã OTP được gửi đến số điện thoại đã đăng ký. '
                    'Có thể sẽ mất một khoảng thời gian để nhận được mã OTP Mã sẽ có hiệu lực trong 2 phút.'
                    ' Vui lòng kiểm tra tin nhắn và hoàn tất xác thực.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: deviceHeight / 46,
                  ),
                  CountTimerWidget(),
//
                  Otp(
                    deviceHeight: deviceHeight / 1.7,
                    deviceWidght: deviceWidth,
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                GetIt.instance<NavigationDataSource>().popNavigation(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 30,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Otp extends StatefulWidget {
  final double deviceHeight, deviceWidght;

  const Otp({Key key, this.deviceHeight, this.deviceWidght}) : super(key: key);

  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  int _currentDigit;
  int _firstDigit;
  int _secondDigit;
  int _thirdDigit;
  int _fourthDigit;
  int _thursDigit;
  int _friDigit;
  UserCitizenLoginResult _userName;
  String speciesCode;

  @override
  Widget build(BuildContext context) {
    _userName = Sailor.param<UserCitizenLoginResult>(context, 'userModel');
    speciesCode= Sailor.param<String>(context, "registerUserCitizen");
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginStateSuccessfulCheckCode) {
          if(state.isCheckCode){
            print(state);
            AppSettings.setUserName(_userName.userName);
            AppSettings.setSDT(_userName.soDT);
            AppSettings.setHoTen(_userName.hoTen);
            AppSettings.setEmail(_userName.email);
            GetIt.instance<NavigationDataSource>().pushMainAndRemoveAllNavigation(context);
          }
        }
      },
      child: Container(
        width: widget.deviceWidght,
        height: widget.deviceHeight,
        child: _getInputPart,
      ),
    );

//    return Container(
//      width: widget.deviceWidght,
//      height: widget.deviceHeight,
//      child: _getInputPart,
//    );
  }

  /// Returns "OTP" input part
  get _getInputPart {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        _getInputField,
//        Padding(
//          padding: EdgeInsets.only(top: 20),
//          child:_getResendButton,
//        ),
        SizedBox(
          height: widget.deviceHeight / 14.8,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Ông/Bà chưa nhận được mã?',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'GỬI LẠI MÃ',
              style: TextStyle(
                  fontSize: 16, color: ColorExtends.fromHex("#079bd2")),
            ),
          ],
        ),
        SizedBox(
          height: widget.deviceHeight / 6.4,
        ),
        _getOtpKeyboard
      ],
    );
  }

  /// Return "OTP" input field
  get _getInputField {
    return Container(
      height: widget.deviceHeight / 12.45,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _otpTextField(_firstDigit),
          _otpTextField(_secondDigit),
          _otpTextField(_thirdDigit),
          _otpTextField(_fourthDigit),
          _otpTextField(_thursDigit),
          _otpTextField(_friDigit),
        ],
      ),
    );
  }

  /// Returns "Otp custom text field"
  Widget _otpTextField(int digit) {
    return (digit == null)
        ? Container(
            height: widget.deviceHeight / 32,
            width: widget.deviceWidght / 25.7,
            decoration: BoxDecoration(
                color: ColorExtends.fromHex('#9fabb1'),
                borderRadius: BorderRadius.circular(40)),
          )
        : Container(
            alignment: Alignment.center,
            child: new Text(
              digit != null ? digit.toString() : "",
              style: new TextStyle(
                fontSize: 30.0,
                color: Colors.black,
              ),
//      decoration: BoxDecoration(
////            color: Colors.grey.withOpacity(0.4),
//          border: Border(
//              bottom: BorderSide(
//                width: 2.0,
//                color: Colors.black,
//              ))),
            ),
          );
  }

  /// Returns "Resend" button
//  get _getResendButton {
//    return new InkWell(
//      child: new Container(
//        height: 32,
//        width: 120,
//        decoration: BoxDecoration(
//            color: Colors.black,
//            shape: BoxShape.rectangle,
//            borderRadius: BorderRadius.circular(32)),
//        alignment: Alignment.center,
//        child: new Text(
//          "Resend OTP",
//          style:
//              new TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//        ),
//      ),
//      onTap: () {
//        // Resend you OTP via API or anything
//      },
//    );
//  }

  /// Current digit
  void _setCurrentDigit(int i) {
    setState(() {
      _currentDigit = i;
      if (_firstDigit == null) {
        _firstDigit = _currentDigit;
      } else if (_secondDigit == null) {
        _secondDigit = _currentDigit;
      } else if (_thirdDigit == null) {
        _thirdDigit = _currentDigit;
      } else if (_fourthDigit == null) {
        _fourthDigit = _currentDigit;
      } else if (_thursDigit == null) {
        _thursDigit = _currentDigit;
      } else if (_friDigit == null) {
        _friDigit = _currentDigit;

        var otp = _firstDigit.toString() +
            _secondDigit.toString() +
            _thirdDigit.toString() +
            _fourthDigit.toString() +
            _thursDigit.toString() +
            _friDigit.toString();
        // Verify your otp by here. API call

        if(speciesCode!=''){
          BlocProvider.of<LoginBloc>(context)
            ..add(LoginEventCheckCodeRegister(_userName.userName, otp));
          print('${_userName.userName} and $otp');
        }
        else{
          BlocProvider.of<LoginBloc>(context)
            ..add(LoginEventCheckCodeUser(_userName.userName, otp));
          print('${_userName.userName} and $otp');
        }

      }
    });
  }

  /// Returns "Otp" keyboard
  get _getOtpKeyboard {
    return new Container(
        height: widget.deviceHeight / 1.65,
        decoration: BoxDecoration(
          color: ColorExtends.fromHex("#d1d5db"),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: new Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _otpKeyboardInputButton(
                    label: "1",
                    onPressed: () {
                      _setCurrentDigit(1);
                    }),
                _otpKeyboardInputButton(
                    label: "2",
                    onPressed: () {
                      _setCurrentDigit(2);
                    }),
                _otpKeyboardInputButton(
                    label: "3",
                    onPressed: () {
                      _setCurrentDigit(3);
                    }),
              ],
            ),
            SizedBox(
              height: widget.deviceHeight / 70.0,
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _otpKeyboardInputButton(
                    label: "4",
                    onPressed: () {
                      _setCurrentDigit(4);
                    }),
                _otpKeyboardInputButton(
                    label: "5",
                    onPressed: () {
                      _setCurrentDigit(5);
                    }),
                _otpKeyboardInputButton(
                    label: "6",
                    onPressed: () {
                      _setCurrentDigit(6);
                    }),
              ],
            ),
            SizedBox(
              height: widget.deviceHeight / 70.0,
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _otpKeyboardInputButton(
                    label: "7",
                    onPressed: () {
                      _setCurrentDigit(7);
                    }),
                _otpKeyboardInputButton(
                    label: "8",
                    onPressed: () {
                      _setCurrentDigit(8);
                    }),
                _otpKeyboardInputButton(
                    label: "9",
                    onPressed: () {
                      _setCurrentDigit(9);
                    }),
              ],
            ),
            SizedBox(
              height: widget.deviceHeight / 70.0,
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new SizedBox(
                  height: widget.deviceHeight / 10.5,
                  width: widget.deviceWidght / 3 - 10,
                ),
                _otpKeyboardInputButton(
                    label: "0",
                    onPressed: () {
                      _setCurrentDigit(0);
                    }),
                _otpKeyboardActionButton(
                    label: new Icon(
                      Icons.backspace,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        if (_friDigit != null) {
                          _friDigit = null;
                        } else if (_thursDigit != null) {
                          _thursDigit = null;
                        } else if (_fourthDigit != null) {
                          _fourthDigit = null;
                        } else if (_thirdDigit != null) {
                          _thirdDigit = null;
                        } else if (_secondDigit != null) {
                          _secondDigit = null;
                        } else if (_firstDigit != null) {
                          _firstDigit = null;
                        }
                      });
                    }),
              ],
            ),
          ],
        ));
  }

  // Returns "Otp keyboard input Button"
  Widget _otpKeyboardInputButton({String label, VoidCallback onPressed}) {
    return new Material(
      color: Colors.transparent,
      child: new InkWell(
        onTap: onPressed,
        borderRadius: new BorderRadius.circular(40.0),
        child: new Container(
          height: widget.deviceHeight / 10.0,
          width: widget.deviceWidght / 3 - 10,
          decoration: new BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
              borderRadius: BorderRadius.circular(10.0)),
          child: new Center(
            child: new Text(
              label,
              style: new TextStyle(
                fontSize: 30.0,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Returns "Otp keyboard action Button"
  _otpKeyboardActionButton({Widget label, VoidCallback onPressed}) {
    return new InkWell(
      onTap: onPressed,
      borderRadius: new BorderRadius.circular(40.0),
      child: new Container(
        height: widget.deviceHeight / 10.5,
        width: widget.deviceWidght / 3 - 10,
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: new Center(
          child: label,
        ),
      ),
    );
  }
}

class CountTimerWidget extends StatefulWidget {
  @override
  _CountTimerWidgetState createState() => _CountTimerWidgetState();
}

class _CountTimerWidgetState extends State<CountTimerWidget> {
  Timer _timer;
  int _minute = 1;
  int _seconds = 60;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_seconds < 1) {
            if (_minute >= 1 && _minute > 0) {
              _minute = 0;
              _seconds = 60;
            } else
              timer.cancel();
          } else {
            _seconds = _seconds - 1;
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
    print('startTimer');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        '0$_minute : ${_seconds >= 10 ? _seconds : '0' + _seconds.toString()}',
        textAlign: TextAlign.start,
        style: TextStyle(color: ColorExtends.fromHex('#0d3178'), fontSize: 18),
      ),
    );
  }
}
