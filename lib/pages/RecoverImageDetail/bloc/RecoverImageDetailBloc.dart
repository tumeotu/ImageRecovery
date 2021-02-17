import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get_it/get_it.dart';
import 'package:image_recovery/config_service.dart';
import 'package:image_recovery/data/apis/laysothutu/laystt_datasource.dart';
import 'package:image_recovery/data/apis/recovery/RecoveryDataSource.dart';
import 'package:image_recovery/pages/DetectResult/Model/ImageResultDetect.dart';
import 'package:image_recovery/pages/RecoverImageDetail/event/RecoverImageDetailEvent.dart';
import 'package:image_recovery/pages/RecoverImageDetail/state/RecoverImageDetailState.dart';
import 'package:image_recovery/pages/home/model/ModelImage.dart';
import 'package:image_recovery/routes.dart';
import 'package:image_recovery/utils/navigations/navigation_datasource.dart';


class RecoverImageDetailBloc extends Bloc<RecoverImageDetailEvent, RecoverImageDetailState> {
  RecoveryDatasource dataSource = getIt.get<RecoveryDatasource>();
  RecoverImageDetailBloc() : super(RecoverImageDetailStateInitial());

  @override
  Stream<RecoverImageDetailState> mapEventToState(RecoverImageDetailEvent event) async* {
    try {
      if (event is RecoverImageDetailEventStart) {
        for(int i=0;i< event.image.length;i++) {
          event.image[i].image = await testCompressFile(event.image[i].file);
        }
        yield RecoverImageDetailStateStart(event.image, false, false, false);
      }
      if (event is RecoverImageDetailEventPost) {
        if(event.isRecover)
          {
            List<ModelImage> images = new List<ModelImage>();
            for(int i=0;i< event.image.length;i++)
            {
              images.add(new ModelImage(null, event.image[i].OldImage));
            }
            //yield RecoverImageDetailStateInitial();
            yield RecoverImageDetailStateStart(images, true, false,false);
            var data = await dataSource.recoveryImages(event.image);
            if(data!=null)
              {
                var param={
                  'image': data
                };
                final _navigation = GetIt.instance.get<NavigationDataSource>();
                _navigation.popNavigation(event.context);
                _navigation.pushNavigation(NamePage.resultImageRecoverPage, params: param);
              }
            else{
              yield RecoverImageDetailStateStart(images, true, false, true);
            }
          }
        else{
          List<ModelImage> images = new List<ModelImage>();
          for(int i=0;i< event.image.length;i++)
          {
            images.add(new ModelImage(null, event.image[i].OldImage));
          }
          yield RecoverImageDetailStateStart(images, false, true,false);
        }
      }
    } catch (exception) {
      print(exception.toString());
      yield RecoverImageDetailStateFailure();
    }
  }

  Future<Uint8List> testCompressFile(File file) async {
    var result = await FlutterImageCompress.compressWithFile(
      file.absolute.path,
      minWidth: 1920,
      minHeight: 1080,
      quality: 100,
      rotate: 0,
    );
    return result;
  }
  Future<void> abc() {
    double i=0;
    while(i<1000000)
      {
        i=i+0.001;
      }
  }
}
