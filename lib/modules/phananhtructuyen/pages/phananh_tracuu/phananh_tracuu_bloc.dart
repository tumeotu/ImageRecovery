import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_recovery/modules/phananhtructuyen/apis/phananhtructuyen_datasource.dart';
import 'package:image_recovery/modules/phananhtructuyen/models/phananh_tracuu_model.dart';
import 'package:image_recovery/modules/phananhtructuyen/pages/phananh_tracuu/phananh_tracuu.dart';

class PhanAnhTraCuuBloc extends Bloc<PhanAnhTraCuuEvent, PhanAnhTraCuuState> {
  final PhanAnhTrucTuyenDataSource phanAnhTrucTuyenDataSource;

  PhanAnhTraCuuBloc({this.phanAnhTrucTuyenDataSource})
      : super(PhanAnhTraCuuStateInitial());

  @override
  Stream<PhanAnhTraCuuState> mapEventToState(PhanAnhTraCuuEvent event) async* {
    if (event is PhanAnhTraCuuEventGetListData) {
      yield* _loaiPhanAnhDoThiGetAll();

      yield* _traCuuPhanAnh(
          pageIndex: 1, pageSize: 5, loaiPhanAnhID: 1, phanAnhs: []);
    } else if (event is PhanAnhTraCuuEventGetListDataFilter) {
      if (state is PhanAnhTraCuuStateSuccess) {
        var stateSuccess = state as PhanAnhTraCuuStateSuccess;
        yield* _traCuuPhanAnh(
            pageIndex: (event.pageIndex == null)
                ? stateSuccess.pageIndex + 1
                : event.pageIndex,
            loaiPhanAnhID: event.loaiPhanAnhID,
            pageSize: 5,
            phanAnhs: (event.isClear) ? [] : stateSuccess.phanAnhTraCuus);
      }
    } else if (event is PhanAnhTraCuuEventSearchByLoaiPhanAnh) {}
  }

  Stream<PhanAnhTraCuuState> _loaiPhanAnhDoThiGetAll() async* {
    var loaiPhanAnhDoThi =
        await this.phanAnhTrucTuyenDataSource.loaiPhanAnhDoThiGetAll();
    yield PhanAnhTraCuuStateSuccess(loaiPhanAnhDMs: loaiPhanAnhDoThi);
  }

  Stream<PhanAnhTraCuuState> _traCuuPhanAnh(
      {int pageIndex,
      int pageSize,
      int loaiPhanAnhID,
      List<PhanAnhTraCuuResult> phanAnhs}) async* {
    if (pageIndex > 1) {
      yield (state as PhanAnhTraCuuStateSuccess)
          .cloneWith(phanAnhTraCuus: phanAnhs, isLoading: true);
    } else {
      yield (state as PhanAnhTraCuuStateSuccess)
          .cloneWith(phanAnhTraCuus: phanAnhs, hasReachedEnd: false);
    }
    var traCuuPhanAnh = await this.phanAnhTrucTuyenDataSource.traCuuPhanAnh(
        PhanAnhTraCuuParam(pageIndex: pageIndex, pageSize: pageSize));

    if (traCuuPhanAnh != null && traCuuPhanAnh.length >= 5) {}

    yield (state as PhanAnhTraCuuStateSuccess).cloneWith(
        phanAnhTraCuus: phanAnhs + traCuuPhanAnh,
        pageIndex: pageIndex,
        loaiPhanAnhID: loaiPhanAnhID,
        isLoading: false);
  }
}
