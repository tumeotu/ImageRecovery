import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_recovery/config_service.dart';
import 'package:image_recovery/data/apis/laysothutu/laystt_datasource.dart';
import 'package:image_recovery/pages/Edit/event/EditEvent.dart';
import 'package:image_recovery/pages/Edit/state/EditState.dart';


class EditBloc extends Bloc<EditEvent, EditState> {
  LaySTTDataSource dataSource = getIt.get<LaySTTDataSource>();
  EditBloc() : super(EditMainStateInitial());

  @override
  Stream<EditState> mapEventToState(EditEvent event) async* {
    try {
      if (event is EditEventStart) {
        yield EditMainStateStart(event.image);
      }
    } catch (exception) {
      yield EditMainStateFailure();
    }
  }
}
