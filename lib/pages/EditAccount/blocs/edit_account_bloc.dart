import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:image_recovery/data/apis/logins/login_datasource.dart';
import 'package:image_recovery/data/models/user_models.dart';
import 'package:image_recovery/pages/EditAccount/events/edit_account_event.dart';
import 'package:image_recovery/pages/EditAccount/states/edit_account_state.dart';
import 'package:image_recovery/pages/Register/events/register_event.dart';
import 'package:image_recovery/pages/Register/states/register_state.dart';
import 'package:image_recovery/pages/login/events/login_event.dart';
import 'package:image_recovery/pages/login/states/login_state.dart';
import 'package:image_recovery/routes.dart';
import 'package:image_recovery/utils/navigations/navigation_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditAccountBloc extends Bloc<EditAccountEvent, EditAccountState> {
  EditAccountBloc() : super(EditAccountStateInitial(false, false,"","","",""));
  final _navigation = GetIt.instance.get<NavigationDataSource>();

  @override
  Stream<EditAccountState> mapEventToState(EditAccountEvent event) async* {
    // TODO: implement mapEventToState
    if(event is EditAccountEventStart){
      SharedPreferences prefs= await SharedPreferences.getInstance();
      String userInfor = await prefs.getString('UserInfo');
      if(userInfor==null)
        yield EditAccountStateFailure();
      Map user= json.decode(userInfor);
      yield EditAccountStateInitial(false, false,user["Name"],user["Numberphone"],user["Email"],user["Address"]);
    }
    else if (event is EditAccountEventEdit) {
      if(event.isFailure==false) {
        yield EditAccountStateInitial(true, false,event.Name,event.Phone,event.Email,event.Address);
        DangKyUserParam param = new DangKyUserParam(Name: event.Name,
            Email: event.Email, Phone: event.Phone,Address: event.Address, Password: '');
        SharedPreferences prefs= await SharedPreferences.getInstance();
        String Token = await prefs.getString('Token');
        var dataUser = await GetIt.instance<LoginDataSource>()
            .edit_account(param,Token);
        if(dataUser!=null){
          SharedPreferences prefs= await SharedPreferences.getInstance();
          await prefs.setString('UserInfo',json.encode(dataUser.toJson()));
          _navigation.popNavigation(event.context);
          var params={
            "page":0
          };
          _navigation.pushNavigation(NamePage.accountPage);
        }
        else{
          yield EditAccountStateInitial(true, true,event.Name,event.Phone,event.Email,event.Address);
        }
      }
      else{
        yield EditAccountStateInitial(true, true,event.Name,event.Phone,event.Email,event.Address);
      }
    }
    else{
      yield EditAccountStateFailure();
    }

  }

}
