import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:image_recovery/data/apis/logins/login_datasource.dart';
import 'package:image_recovery/data/models/user_models.dart';
import 'package:image_recovery/pages/login/states/login_state.dart';

class LoginCheckValueCubit extends Cubit<LoginState> {
  LoginCheckValueCubit() : super(LoginState());

  void nameChanged(String value) {
    bool check = true;
    // ignore: null_aware_before_operator
    if (value != null && value?.length > 1) {
      check = true;
      emit(state.copyWith(hoTen: value, isCheck: check));
    } else {
      check = false;
      emit(state.copyWith(hoTen: 'none', isCheck: check));
    }
  }

  void emailChanged(String value) {
    print('emailChanged');
    bool check = false;

    // ignore: null_aware_before_operator
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
        .hasMatch(value);
    if (emailValid) {
      print('emailChanged - true');
      check = true;
      emit(state.copyWith(email: value, isCheck: check));
    } else {
      check = false;
      emit(state.copyWith(email: 'none', isCheck: check));
      print('emailChanged - false');
    }
  }

  void soDienThoaiChanged(String value) {
    bool check = true;
    // ignore: null_aware_before_operator
    if (value != null && value?.length >= 10 && value?.length < 12) {
      check = true;
      emit(state.copyWith(soDienThoai: value, isCheck: check));
    } else {
      check = false;
      emit(state.copyWith(soDienThoai: 'none', isCheck: check));
    }
  }

  // ignore: non_constant_identifier_names
  Future CallApiRegister(DangKyUserParam modelParam) async {
   try{
     var dataCheckCode =
     await GetIt.instance<LoginDataSource>().RegisterUserCitizen(modelParam);
     print('CallApiRegister');
     emit(state.copyWith(isRegister: dataCheckCode)) ;
   }catch(error){
     emit(state.copyWith(isRegister: false)) ;
   }
  }
}
