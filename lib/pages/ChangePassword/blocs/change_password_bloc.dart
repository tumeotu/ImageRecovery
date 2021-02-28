import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:image_recovery/data/apis/logins/login_datasource.dart';
import 'package:image_recovery/data/models/user_models.dart';
import 'package:image_recovery/pages/ChangePassword/events/change_password_event.dart';
import 'package:image_recovery/pages/ChangePassword/states/change_password_state.dart';
import 'package:image_recovery/pages/Register/events/register_event.dart';
import 'package:image_recovery/pages/Register/states/register_state.dart';
import 'package:image_recovery/routes.dart';
import 'package:image_recovery/utils/navigations/navigation_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePasswordBloc extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  ChangePasswordBloc() : super(ChangePasswordStateInitial());
  final _navigation = GetIt.instance.get<NavigationDataSource>();

  @override
  Stream<ChangePasswordState> mapEventToState(ChangePasswordEvent event) async* {
    // TODO: implement mapEventToState
    if(event is ChangePasswordEventStart){
      if(event.isChanging){
        if(event.isFailure){
          yield ChangePasswordStateStart(true, true,event.oldPassword, event.newPassword, event.error);
        }else{
          SharedPreferences prefs= await SharedPreferences.getInstance();
          yield ChangePasswordStateStart(true, false,event.oldPassword,event.newPassword, event.error);
          String token = await prefs.getString("Token");
          var dataUser = await GetIt.instance<LoginDataSource>()
              .change_password(token,event.oldPassword, event.newPassword);
          if(dataUser!=null){
            _navigation.popNavigation(event.context);
          }
          else{
            yield ChangePasswordStateStart(true, true,event.oldPassword, event.newPassword, event.error);
          }
        }
      }
      else
        yield ChangePasswordStateStart(false, false,event.oldPassword,event.newPassword, event.error);
    }
    else{
      yield ChangePasswordStateFailure();
    }

  }

}
