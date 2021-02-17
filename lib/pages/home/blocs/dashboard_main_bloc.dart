import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_recovery/data/apis/dashboards/dashboard_datasource.dart';
import 'package:image_recovery/data/models/dashboard_models.dart';
import 'package:image_recovery/pages/home/events/dashboard_main_event.dart';
import 'package:image_recovery/pages/home/states/dashboard_main_state.dart';

import '../../../config_service.dart';
import '../../../modules/tintuc/tintuc_imports.dart';

class DashboardBloc extends Bloc<DashboardMainEvent, DashboardMainState> {
  DashboardDataSource dataSource = getIt.get<DashboardDataSource>();
  TinTucDataSource tinTucSource = getIt.get<TinTucDataSource>();

  DashboardBloc() : super(DashboardMainStateInitial());


  MucDoHaiLong dataMDHL;
  List<MucDoHaiLong> datasMDHL = new List<MucDoHaiLong>();
  ThongKeHoSo_Tong dataTKHS;
  List<TinTucCongAn_Lst_Result> lstTinTuc = new List<
      TinTucCongAn_Lst_Result>();

  @override
  Stream<DashboardMainState> mapEventToState(DashboardMainEvent event) async* {
    try {

      if (event is DashboardMainEventStart) {
        if (state is DashboardMainStateInitial) {
          var dataMucDoHaiLong = await dataSource.getMucDoHaiLong();
          if (dataMucDoHaiLong != null && dataMucDoHaiLong.length > 0) {
            datasMDHL = dataMucDoHaiLong;
            for (var item in dataMucDoHaiLong) {
              if (item.isTong) {
                dataMDHL = item;
                break;
              }
            }
          }
          var dataThongkehs = await dataSource.getHoSoDaXuLy();
          if (dataThongkehs != null) {
            dataTKHS = dataThongkehs;
          }
          if (dataMDHL != null || dataTKHS != null)
            yield DashboardMainStateSuccess(
                mucDoHaiLong: dataMDHL,
                datas_MDHL: datasMDHL,
                thongKeHoSo_Tong: dataTKHS,
                lstTinTuc_SuKien: new List<TinTucCongAn_Lst_Result>());

          var dataTinTuc =
          await tinTucSource.getTinTucSuKien(null, null, null, '1', '5');

          if (dataTinTuc != null && dataTinTuc.length > 0 ||
              dataMDHL != null ||
              dataTKHS != null) {
            lstTinTuc = dataTinTuc;
            yield (state as DashboardMainStateSuccess).cloneWith(
                mucDoHaiLong: dataMDHL,
                thongKeHoSo_Tong: dataTKHS,
                lstTinTuc_SuKien: dataTinTuc);
            //yield DashboardMainStateSuccess(mucDoHaiLong: data_MDHL,thongKeHoSo_Tong: data_TKHS,lstTinTuc_SuKien: data_TinTuc);
          }
        }
      }
      if (event is DashboardMainEventThongKeList) {
        var dataThongKeLst = await dataSource.thongKeHoSoDaXuLy_List(event.loaiTK);
        if(dataThongKeLst!=null ){
          yield DashboardMainStateSuccess(datas_MDHL: datasMDHL,
              lstTinTuc_SuKien: lstTinTuc,
              thongKeHoSo_Tong: dataTKHS,
              mucDoHaiLong: dataMDHL,
              lstThongKeHS: dataThongKeLst);
        }

      }
    } catch (exception) {
      yield DashboardMainStateFailure();
    }
  }
}
