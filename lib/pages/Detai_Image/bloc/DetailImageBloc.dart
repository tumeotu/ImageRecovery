import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_recovery/config_service.dart';
import 'package:image_recovery/data/apis/laysothutu/laystt_datasource.dart';
import 'package:image_recovery/pages/Detai_Image/event/DetailImageEvent.dart';
import 'package:image_recovery/pages/Detai_Image/state/DetailImageState.dart';


class DetailImageBloc extends Bloc<DetailImageEvent,DetailImageState> {
  LaySTTDataSource dataSource = getIt.get<LaySTTDataSource>();
  DetailImageBloc() : super(DetailImageMainStateInitial());

  @override
  Stream<DetailImageState> mapEventToState(DetailImageEvent event) async* {
    try {
      if (event is DetailImageEventStart) {
        yield DetailImageMainStateStart(event.image);
      }
    } catch (exception) {
      yield DetailImageMainStateFailure();
    }
  }
}
