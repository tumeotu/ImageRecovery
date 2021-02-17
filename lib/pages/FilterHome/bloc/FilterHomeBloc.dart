import 'dart:async';
import 'dart:typed_data';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_recovery/config_service.dart';
import 'package:image_recovery/data/apis/dashboards/dashboard_datasource.dart';
import 'package:image_recovery/data/apis/laysothutu/laystt_datasource.dart';
import 'package:image_recovery/data/models/dashboard_models.dart';
import 'package:image_recovery/pages/Filter/event/FilterEvent.dart';
import 'package:image_recovery/pages/Filter/state/FilterState.dart';
import 'package:image_recovery/pages/FilterHome/event/FilterHomeEvent.dart';
import 'package:image_recovery/pages/FilterHome/state/FilterHomeState.dart';
import 'package:image_recovery/pages/SoThuTu/Model/event/LaySoThuTuEvent.dart';
import 'package:image_recovery/pages/SoThuTu/Model/model/sothutu.dart';
import 'package:image_recovery/pages/SoThuTu/Model/state/LaySoThuTuState.dart';
import 'package:image_recovery/pages/home/events/dashboard_main_event.dart';
import 'package:image_recovery/pages/home/states/dashboard_main_state.dart';


class FilterHomeBloc extends Bloc<FilterHomeEvent, FilterHomeState> {
  LaySTTDataSource dataSource = getIt.get<LaySTTDataSource>();
  FilterHomeBloc() : super(FilterHomeStateStart());

  @override
  Stream<FilterHomeState> mapEventToState(FilterHomeEvent event) async* {
    try {
      if (event is FilterEventStart) {
        yield FilterHomeStateStart();
      }
    } catch (exception) {
      yield FilterHomeStateFailure();
    }
  }
}
