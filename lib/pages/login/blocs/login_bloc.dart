import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:image_recovery/data/apis/logins/login_datasource.dart';
import 'package:image_recovery/pages/login/events/login_event.dart';
import 'package:image_recovery/pages/login/states/login_state.dart';
import 'package:image_recovery/routes.dart';
import 'package:image_recovery/utils/navigations/navigation_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginStateInitial(false, false,"",""));
  final _navigation = GetIt.instance.get<NavigationDataSource>();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    // TODO: implement mapEventToState
    if(event is LoginEventStart){
      yield LoginStateInitial(false, false,"","");
    }
    else if (event is LoginEventSignInUser) {
      yield LoginStateInitial(true, false,"","");
      var dataUser = await GetIt.instance<LoginDataSource>()
          .login(event.userName, event.password);
      if(dataUser!=null){
        SharedPreferences prefs= await SharedPreferences.getInstance();
        await prefs.setInt('Login', 1);
        await prefs.setString('Token',dataUser.token);
        _navigation.popNavigation(event.context);
        var params={
          "page":0
        };
        _navigation.pushNavigation(NamePage.homePage, params: params);
      }
      else{
        yield LoginStateInitial(true, true,"","");
      }
    }
    else if (event is LoginEventSinginFacebook) {
      yield LoginStateInitial(true, false,"","");

      var dataUser = await GetIt.instance<LoginDataSource>()
          .login_facebook(event.accessToken, event.userID);
      if(dataUser!=null){
        SharedPreferences prefs= await SharedPreferences.getInstance();
        await prefs.setInt('Login', 1);
        await prefs.setString('Token',dataUser.token);
        _navigation.popNavigation(event.context);
        var params={
          "page":0
        };
        _navigation.pushNavigation(NamePage.homePage, params: params);
      }
      else{
        yield LoginStateInitial(true, true,"","");
      }
    }
    else if (event is LoginEventSinginGoogle) {
      yield LoginStateInitial(true, false,"","");
      var dataUser = await GetIt.instance<LoginDataSource>()
          .login_google(event.accessToken);
      if(dataUser!=null){
        SharedPreferences prefs= await SharedPreferences.getInstance();
        await prefs.setInt('Login', 1);
        await prefs.setString('Token',dataUser.token);
        _navigation.popNavigation(event.context);
        var params={
          "page":0
        };
        _navigation.pushNavigation(NamePage.homePage, params: params);
      }
      else{
        yield LoginStateInitial(true, true,"","");
      }
    }
    else{
      yield LoginStateFailure();
    }

  }

}
