import 'dart:async';
import 'package:extended_image/extended_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_recovery/config_service.dart';
import 'package:image_recovery/data/apis/laysothutu/laystt_datasource.dart';
import 'package:image_recovery/pages/Crop/event/CropEvent.dart';
import 'package:image_recovery/pages/Crop/state/CropState.dart';


class CropBloc extends Bloc<CropEvent, CropState> {
  LaySTTDataSource dataSource = getIt.get<LaySTTDataSource>();
  CropBloc() : super(CropMainStateInitial());

  @override
  Stream<CropState> mapEventToState(CropEvent event) async* {
    try {
      if (event is CropEventStart) {
        yield CropStateStart(event.image, CropAspectRatios.custom,event.flip, event.rotate);
      }
    } catch (exception) {
      yield CropMainStateFailure();
    }
  }
}
