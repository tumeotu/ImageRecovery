import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_recovery/data/apis/dashboards/dashboard_datasource.dart';
import 'package:image_recovery/data/apis/laysothutu/laystt_datasource.dart';
import 'package:image_recovery/data/models/dashboard_models.dart';
import 'package:image_recovery/pages/SoThuTu/Model/event/LaySoThuTuEvent.dart';
import 'package:image_recovery/pages/SoThuTu/Model/model/sothutu.dart';
import 'package:image_recovery/pages/SoThuTu/Model/state/LaySoThuTuState.dart';
import 'package:image_recovery/pages/home/events/dashboard_main_event.dart';
import 'package:image_recovery/pages/home/states/dashboard_main_state.dart';

import '../../../../config_service.dart';

class LaySoThuTuBloc extends Bloc<LaySoThuTuEvent, LaySoThuTuState> {
  LaySTTDataSource dataSource = getIt.get<LaySTTDataSource>();
  LaySoThuTuBloc() : super(LaySoThuTuMainStateInitial(null,null));
  List<Phieu> datasSoThuTu;

  @override
  Stream<LaySoThuTuState> mapEventToState(LaySoThuTuEvent event) async* {
    try {
      if (event is LayThuTuEventStart) {
          var dataMucDoHaiLong = await dataSource.getSoThuTu();
          print("GET");
          if (dataMucDoHaiLong != null && dataMucDoHaiLong.length > 0) {
            datasSoThuTu = dataMucDoHaiLong;
            print("GET");
            yield LaySoThuTuPostSuccess(datasSoThuTu, null);
          }
      }
      if(event is LayThuTuEventPost) {
        var sttRespon = await dataSource.postLaySoThuTu(
            event.tenQuay, event.idQuay, event.soDienThoai);
        var dataMucDoHaiLong = await dataSource.getSoThuTu();
        if (dataMucDoHaiLong != null && dataMucDoHaiLong.length > 0) {
          datasSoThuTu = dataMucDoHaiLong;
          //yield LaySoThuTuMainStateFailure();
          yield LaySoThuTuPostSuccess(datasSoThuTu,sttRespon);
        }
      }
    } catch (exception) {
      yield LaySoThuTuMainStateFailure();
    }
  }
}