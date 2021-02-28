import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_recovery/config_service.dart';
import 'package:image_recovery/data/apis/laysothutu/laystt_datasource.dart';
import 'package:image_recovery/pages/home/events/HomeEvent.dart';
import 'package:image_recovery/pages/home/states/HomeState.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HomeBloc extends Bloc<HomeEvent, HomeState> {
  LaySTTDataSource dataSource = getIt.get<LaySTTDataSource>();
  HomeBloc() : super(HomeStateInitial());

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    try {
      if (event is HomeEventStart) {
        SharedPreferences prefs= await SharedPreferences.getInstance();
        String userInfor = await prefs.getString('UserInfo');
        if(userInfor==null)
          yield HomeStateFailure();
        Map user= json.decode(userInfor);
        try{
          Uint8List image = base64Decode(user['Picture']);
          yield HomeStateStart(event.page,image);
        }
        catch(e){
          yield HomeStateStart(event.page, null);
        }
      }
    } catch (exception) {
      yield HomeStateFailure();
    }
  }
}
