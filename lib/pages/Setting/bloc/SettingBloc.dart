import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_recovery/config_service.dart';
import 'package:image_recovery/data/apis/laysothutu/laystt_datasource.dart';
import 'package:image_recovery/pages/Setting/event/SettingEvent.dart';
import 'package:image_recovery/pages/Setting/state/SettingState.dart';


class SettingBloc extends Bloc<SettingEvent, SettingState> {
  LaySTTDataSource dataSource = getIt.get<LaySTTDataSource>();
  SettingBloc() : super(SettingStateStart());

  @override
  Stream<SettingState> mapEventToState(SettingEvent event) async* {
    try {
      if (event is SettingEventStart) {
        yield SettingStateStart();
      }
    } catch (exception) {
      yield SettingStateFailure();
    }
  }
}
