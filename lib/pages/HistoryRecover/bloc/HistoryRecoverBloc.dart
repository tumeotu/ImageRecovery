import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get_it/get_it.dart';
import 'package:image_recovery/config_service.dart';
import 'package:image_recovery/data/apis/history_recover/HistoryDataSource.dart';
import 'package:image_recovery/pages/HistoryRecover/event/HistoryRecoverEvent.dart';
import 'package:image_recovery/pages/HistoryRecover/state/HistoryRecoverState.dart';
import 'package:image_recovery/routes.dart';
import 'package:image_recovery/utils/navigations/navigation_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryRecoverBloc extends Bloc<HistoryRecoverEvent, HistoryRecoverState> {
  HistoryRecoveryDatasource dataSource = getIt.get<HistoryRecoveryDatasource>();
  HistoryRecoverBloc() : super(HistoryRecoverStateInitial());

  @override
  Stream<HistoryRecoverState> mapEventToState(HistoryRecoverEvent event) async* {
    try {
      if (event is HistoryRecoverEventStart) {
        String Token="ImageRcovery";
        var prefs= await SharedPreferences.getInstance();
        try {
          Token = prefs.getString('Token');
          if(Token!=null){
            var connectivityResult = await (Connectivity().checkConnectivity());
            if (connectivityResult != ConnectivityResult.none) {
              if(event.isGetDetail==false){
                var data = await dataSource.historyRecoverImages(event.page, Token);
                if(data!=null)
                  yield HistoryRecoverStateStart(data, false, false);
                else
                  yield HistoryRecoverStateFailure();
              }
              else{
                yield HistoryRecoverStateStart(null, true, false);
                var data = await dataSource.historyRecoverDetailImages(event.ID, Token);
                if(data!=null)
                {
                  var param={
                    'image': data
                  };
                  yield HistoryRecoverStateStart(event.images,false, false);
                  final _navigation = GetIt.instance.get<NavigationDataSource>();
                  _navigation.pushNavigation(NamePage.photoViewPage, params: param);
                }
                else
                  yield HistoryRecoverStateFailure();
              }
            }
            else
              yield HistoryRecoverStateMustConnectInterNet();
          }
          else{
            yield HistoryRecoverStateMustLogin();
          }
        }
        catch(e){
          yield HistoryRecoverStateMustLogin();
        }
      }
    } catch (exception) {
      print(exception.toString());
      yield HistoryRecoverStateFailure();
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
