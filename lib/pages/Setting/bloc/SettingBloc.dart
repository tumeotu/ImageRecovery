import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_recovery/config_service.dart';
import 'package:image_recovery/data/apis/laysothutu/laystt_datasource.dart';
import 'package:image_recovery/pages/Setting/event/SettingEvent.dart';
import 'package:image_recovery/pages/Setting/state/SettingState.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SettingBloc extends Bloc<SettingEvent, SettingState> {
  LaySTTDataSource dataSource = getIt.get<LaySTTDataSource>();
  SettingBloc() : super(SettingStateInitial());
  @override
  Stream<SettingState> mapEventToState(SettingEvent event) async* {
    try {
      if (event is SettingEventStart) {
        SharedPreferences prefs= await SharedPreferences.getInstance();
        String userInfor = await prefs.getString('UserInfo');
        if(userInfor==null)
          yield SettingStateFailure();
        Map user= json.decode(userInfor);
        try{
          Uint8List image = base64Decode(user['Picture']);
          yield SettingStateStart(image);
        }
        catch(e){
          yield SettingStateStart(null);
        }

      }
    } catch (exception) {
      yield SettingStateFailure();
    }
  }
}
