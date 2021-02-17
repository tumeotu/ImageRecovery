import 'package:equatable/equatable.dart';
import 'package:image_recovery/data/models/user_models.dart';

class LoginState extends Equatable {

  LoginState({
    this.email = '',
    this.hoTen = '',
    this.soDienThoai = '',
    this.ischeck=true,
    this.isRegister
  });

  final String email;
  final String hoTen;
  final String soDienThoai;
  final bool ischeck;
  final bool isRegister;

  @override
  List<Object> get props => [email, hoTen, soDienThoai,this.ischeck,this.isRegister];

  LoginState copyWith({
    String email,
    String hoTen,
    String soDienThoai,
    bool isCheck,
    bool isRegister
  }) {
    return LoginState(
      email: email ?? this.email,
      hoTen: hoTen ?? this.hoTen,
      soDienThoai: soDienThoai ?? this.soDienThoai,
      ischeck: isCheck ?? this.ischeck,
      isRegister: isRegister?? this.isRegister
    );
  }
}


class LoginStateSuccessful extends LoginState {
  final UserCitizenLoginResult modelUserCitizen;

  LoginStateSuccessful(this.modelUserCitizen);

  @override
  // TODO: implement props
  List<Object> get props => [this.modelUserCitizen];
}

class LoginStateSuccessfulCheckCode extends LoginState {
  final bool isCheckCode;

  LoginStateSuccessfulCheckCode(this.isCheckCode);

  @override
  // TODO: implement props
  List<Object> get props => [this.isCheckCode];
}

class LoginStateFailureRegister extends LoginState {
  final String error;

  LoginStateFailureRegister(this.error);

  @override
  // TODO: implement props
  List<Object> get props => [this.error];
}
