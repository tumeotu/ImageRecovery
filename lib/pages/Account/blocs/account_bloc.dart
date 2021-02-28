import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:image_recovery/data/apis/logins/login_datasource.dart';
import 'package:image_recovery/pages/Account/events/account_event.dart';
import 'package:image_recovery/pages/Account/states/account_state.dart';
import 'package:image_recovery/pages/login/events/login_event.dart';
import 'package:image_recovery/pages/login/states/login_state.dart';
import 'package:image_recovery/routes.dart';
import 'package:image_recovery/utils/navigations/navigation_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc() : super(AccountStateInitial());

  @override
  Stream<AccountState> mapEventToState(AccountEvent event) async* {
    // TODO: implement mapEventToState
    if(event is AccountEventStart){
      SharedPreferences prefs= await SharedPreferences.getInstance();
      String userInfor = await prefs.getString('UserInfo');
      if(userInfor==null)
        yield AccountStateFailure();
      Map user= json.decode(userInfor);
      if(event.Changing){
        yield AccountStateStart(user, true, false);
        SharedPreferences prefs= await SharedPreferences.getInstance();
        String Token = await prefs.getString('Token');

        var dataUser = await GetIt.instance<LoginDataSource>()
            .change_avatar(Token,event.image);
        if(dataUser!=null){
          SharedPreferences prefs= await SharedPreferences.getInstance();
          await prefs.setString('UserInfo',json.encode(dataUser.toJson()));
          yield AccountStateStart(dataUser.toJson(), false, false);
        }
        else{
          yield AccountStateStart(user, true, true);
        }
      }
      else{
        yield AccountStateStart(user, false, false);
      }
    }
    else{
      yield AccountStateFailure();
    }
  }

}
