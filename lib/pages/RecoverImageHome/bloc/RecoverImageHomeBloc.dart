import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_recovery/config_service.dart';
import 'package:image_recovery/data/apis/laysothutu/laystt_datasource.dart';
import 'package:image_recovery/pages/Filter/event/FilterEvent.dart';
import 'package:image_recovery/pages/FilterHome/event/FilterHomeEvent.dart';
import 'package:image_recovery/pages/FilterHome/state/FilterHomeState.dart';
import 'package:image_recovery/pages/RecoverImageHome/event/RecoverImageHomeEvent.dart';
import 'package:image_recovery/pages/RecoverImageHome/state/RecoverImageHomeState.dart';

class RecoverImageHomeBloc extends Bloc<RecoverImageHomeEvent, RecoverImageHomeState> {
  LaySTTDataSource dataSource = getIt.get<LaySTTDataSource>();
  RecoverImageHomeBloc() : super(RecoverImageHomeStateStart());

  @override
  Stream<RecoverImageHomeState> mapEventToState(RecoverImageHomeEvent event) async* {
    try {
      if (event is FilterEventStart) {
        yield RecoverImageHomeStateStart();
      }
    } catch (exception) {
      yield RecoverImageHomeStateFailure();
    }
  }
}
