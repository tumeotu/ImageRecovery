import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_recovery/modules/phananhtructuyen/apis/phananhtructuyen_datasource.dart';
import 'package:image_recovery/modules/phananhtructuyen/models/linhvuc_hoso_danhmuc_model.dart';
import 'package:image_recovery/modules/phananhtructuyen/pages/linhvuc_hoso_danhmuc/linhvuc_hoso_danhmuc.dart';

class LinhVucHoSoDanhMucCubit extends Cubit<LinhVucHoSoDanhMucState> {
  final PhanAnhTrucTuyenDataSource dataSource;

  LinhVucHoSoDanhMucCubit({this.dataSource})
      : super(LinhVucHoSoDanhMucStateInitiate());

  void initData() async {
    emit(LinhVucHoSoDanhMucStateLoading());

    List<LinhVucHoSoModel> data = await dataSource.danhMucLinhVucHoSoGetAll();
    if (data != null) {
      emit(LinhVucHoSoDanhMucStateSuccess(linhVucs: data));
    } else {
      emit(LinhVucHoSoDanhMucStateFailure());
    }
  }

  void linhVucSelection({List<LinhVucHoSoModel> linhVucs, int index}) {
    emit(LinhVucHoSoDanhMucStateSuccess(linhVucs: linhVucs, index: index));
  }
}
