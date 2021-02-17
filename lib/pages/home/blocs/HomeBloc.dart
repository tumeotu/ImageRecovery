import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_recovery/config_service.dart';
import 'package:image_recovery/data/apis/laysothutu/laystt_datasource.dart';
import 'package:image_recovery/pages/home/events/HomeEvent.dart';
import 'package:image_recovery/pages/home/states/HomeState.dart';


class HomeBloc extends Bloc<HomeEvent, HomeState> {
  LaySTTDataSource dataSource = getIt.get<LaySTTDataSource>();
  HomeBloc() : super(HomeStateInitial());

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    try {
      if (event is HomeEventStart) {
        yield HomeStateStart(event.page);
      }
    } catch (exception) {
      yield HomeStateFailure();
    }
  }
}
