import 'package:equatable/equatable.dart';
import 'package:image_recovery/data/models/dashboard_models.dart';
import 'package:image_recovery/modules/tintuc/models/tintuc_models.dart';

abstract class DashboardMainState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class DashboardMainStateInitial extends DashboardMainState {}

class DashboardMainStateFailure extends DashboardMainState {}

class DashboardMainStateSuccess extends DashboardMainState {
  final MucDoHaiLong mucDoHaiLong;
  final List<MucDoHaiLong> datas_MDHL;
  final ThongKeHoSo_Tong thongKeHoSo_Tong;
  final List<TinTucCongAn_Lst_Result> lstTinTuc_SuKien;
  final List<ThongKeHoSo_List> lstThongKeHS;

  DashboardMainStateSuccess(
      {this.mucDoHaiLong,
      this.datas_MDHL,
      this.thongKeHoSo_Tong,
      this.lstTinTuc_SuKien,
      this.lstThongKeHS});

  DashboardMainStateSuccess cloneWith(
      {mucDoHaiLong, thongKeHoSo_Tong, lstTinTuc_SuKien}) {
    return DashboardMainStateSuccess(
        mucDoHaiLong: mucDoHaiLong ?? this.mucDoHaiLong,
        thongKeHoSo_Tong: thongKeHoSo_Tong ?? this.thongKeHoSo_Tong,
        lstTinTuc_SuKien: lstTinTuc_SuKien ?? this.lstTinTuc_SuKien);
  }

  @override
  // TODO: implement props
  List<Object> get props =>
      [mucDoHaiLong, datas_MDHL, thongKeHoSo_Tong, lstTinTuc_SuKien];
}
