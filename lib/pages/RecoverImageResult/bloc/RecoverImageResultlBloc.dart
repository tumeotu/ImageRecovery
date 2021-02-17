import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_recovery/config_service.dart';
import 'package:image_recovery/data/apis/laysothutu/laystt_datasource.dart';
import 'package:image_recovery/pages/RecoverImageResult/event/RecoverImageResultlEvent.dart';
import 'package:image_recovery/pages/RecoverImageResult/state/RecoverImageResultState.dart';


class RecoverImageResultBloc extends Bloc<RecoverImageResultEvent, RecoverImageResultState> {
  LaySTTDataSource dataSource = getIt.get<LaySTTDataSource>();
  RecoverImageResultBloc() : super(RecoverImageResultStateInitial());

  @override
  Stream<RecoverImageResultState> mapEventToState(RecoverImageResultEvent event) async* {
    try {
      if (event is RecoverImageResultEventStart) {
        yield RecoverImageResultStateStart(event.image);
      }
    } catch (exception) {
      print(exception.toString());
      yield RecoverImageResultStateFailure();
    }
  }
}
