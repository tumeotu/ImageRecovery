import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_recovery/config_service.dart';
import 'package:image_recovery/data/apis/laysothutu/laystt_datasource.dart';
import 'package:image_recovery/pages/DetectResult/event/DetectResultEvent.dart';
import 'package:image_recovery/pages/DetectResult/state/DetectResultState.dart';


class DetectViewBloc extends Bloc<DetectViewEvent, DetectViewState> {
  LaySTTDataSource dataSource = getIt.get<LaySTTDataSource>();
  DetectViewBloc() : super(DetectViewStateInitial());

  @override
  Stream<DetectViewState> mapEventToState(DetectViewEvent event) async* {
    try {
      if (event is DetectViewEventStart) {
        yield DetectViewStateStart(event.images);
      }
    } catch (exception) {
      yield DetectViewStateFailure();
    }
  }
}
