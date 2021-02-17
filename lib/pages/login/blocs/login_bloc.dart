import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:image_recovery/data/apis/logins/login_datasource.dart';
import 'package:image_recovery/data/models/user_models.dart';
import 'package:image_recovery/pages/login/events/login_event.dart';
import 'package:image_recovery/pages/login/states/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(null);

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    // TODO: implement mapEventToState
    if (event is LoginEventSignInUser) {
      var dataUserCitizen = await GetIt.instance<LoginDataSource>()
          .loginUserCitizen(event.userName);
      yield LoginStateSuccessful(dataUserCitizen);
      print('LoginEventSignInUser');
    }
    if(event is LoginEventCheckCodeUser){
      var dataCheckCode=await GetIt.instance<LoginDataSource>().checkCodeByUserLogin(event.userName, event.code);
      yield LoginStateSuccessfulCheckCode(dataCheckCode);
      print('LoginEventCheckCodeUser');
    }
    if(event is LoginEventCheckCodeRegister){
      var dataCheckCode=await GetIt.instance<LoginDataSource>().CheckCodeRegisterUserCitizen(event.userName, event.code);
      yield LoginStateSuccessfulCheckCode(dataCheckCode);
      print('LoginEventCheckCodeRegister');
    }
    if(event is LoginEvenRegisterUserCitizen){
      var dataCheckCode=await GetIt.instance<LoginDataSource>().RegisterUserCitizen(event.modelParam);
      yield LoginStateSuccessfulCheckCode(dataCheckCode);
      print('LoginEvenRegisterUserCitizen');
    }

  }

}
