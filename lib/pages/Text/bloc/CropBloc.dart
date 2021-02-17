import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_recovery/config_service.dart';
import 'package:image_recovery/data/apis/laysothutu/laystt_datasource.dart';
import 'package:image_recovery/pages/Text/event/CropEvent.dart';
import 'package:image_recovery/pages/Text/state/CropState.dart';


class TextBloc extends Bloc<TextEvent, TextState> {
  LaySTTDataSource dataSource = getIt.get<LaySTTDataSource>();
  TextBloc() : super(TextMainStateInitial());

  @override
  Stream<TextState> mapEventToState(TextEvent event) async* {
    try {
      if (event is TextEventStart) {
        yield TextStateStart(event.color, event.size);
      }
    } catch (exception) {
      yield TextMainStateFailure();
    }
  }
}
