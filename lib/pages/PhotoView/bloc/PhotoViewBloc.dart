import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:image_recovery/config_service.dart';
import 'package:image_recovery/data/apis/detect/DetectDataSource.dart';
import 'package:image_recovery/data/apis/laysothutu/laystt_datasource.dart';
import 'package:image_recovery/pages/PhotoView/event/PhotoViewEvent.dart';
import 'package:image_recovery/pages/PhotoView/state/PhotoViewState.dart';
import 'package:image_recovery/utils/navigations/navigation_datasource.dart';

import '../../../routes.dart';


class PhotoViewBloc extends Bloc<PhotoViewEvent, PhotoViewState> {
  DetectDatasource dataSource = getIt.get<DetectDatasource>();
  PhotoViewBloc() : super(PhotoViewStateInitial());
  @override
  Stream<PhotoViewState> mapEventToState(PhotoViewEvent event) async* {
    try {
      if (event is PhotoViewEventStart) {
        yield PhotoViewStateStart(event.page,event.oldImage, event.newImage, false, false);
      }
      if (event is PhotoViewEventPost) {
        yield PhotoViewStateStart(event.page,event.oldImage, event.newImage, true, false);
        var data = await dataSource.recoveryImages(event.oldImage, event.newImage);
        if(data!=null){
          yield PhotoViewStateStart(event.page,event.oldImage, event.newImage, false, false);
          var param={
            'image': data
          };
          final _navigation = GetIt.instance.get<NavigationDataSource>();
          _navigation.pushNavigation(NamePage.detectViewPage, params: param);
        }
        else{
          yield PhotoViewStateStart(event.page,event.oldImage, event.newImage, true, true);
        }
      }
    } catch (exception) {
      yield PhotoViewStateFailure();
    }
  }
}
