import 'package:image_recovery/modules/phananhtructuyen/apis/phananhtructuyen_datasource.dart';
import 'package:image_recovery/modules/phananhtructuyen/models/loaiphananh_danhmuc_model.dart';
import 'package:image_recovery/modules/phananhtructuyen/pages/phananh_home/phananh_home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_recovery/routes.dart';
import 'package:image_recovery/utils/navigations/navigation_datasource.dart';
import '../../../../constants.dart';

class PhanAnhHomeBloc extends Bloc<PhanAnhHomeEvent, PhanAnhHomeState> {
  String get appTitle => "PHẢN ÁNH, KIẾN NGHỊ";
  final PhanAnhTrucTuyenDataSource dataSource;
  final NavigationDataSource navigationDataSource;

  PhanAnhHomeBloc({this.dataSource, this.navigationDataSource})
      : super(PhanAnhHomeStateInitiate());

  @override
  void dispose() {}

  @override
  Stream<PhanAnhHomeState> mapEventToState(PhanAnhHomeEvent event) async* {
    if (event is PhanAnhHomeEventLoadInProgress) {
      yield* _fetchAPI();
    }
    if (event is PhanAnhHomeEventSelectItem) {
      if (event.item.loaiPhanAnhID == 0) {
        this.navigationDataSource.pushNavigation(NamePage.phananh_tracuu);
      } else {
        var _animationController = event.animationController;
        List<LoaiPhanAnhDM> list =
            (state as PhanAnhHomeStateLoadSuccess).list.map((item) {
          if (item.loaiPhanAnhID == event.item.loaiPhanAnhID) {
            var isSelected = item.isSelected != null ? !item.isSelected : true;
            item = event.item.itemSelectChanged(isSelected);
          } else {
            item = item.itemSelectChanged(false);
          }
          return item;
        }).toList();

        if (_animationController.isCompleted) {
          _animationController.reverse();
        } else {
          _animationController.forward();
        }

        yield PhanAnhHomeStateLoadSuccess(list: list, index: event.index);
      }
    }
  }

  Stream<PhanAnhHomeState> _fetchAPI() async* {
    List<LoaiPhanAnhDM> data = await dataSource.loaiPhanAnhDoThiGetAll();
    if (data != null) {
      data.add(LoaiPhanAnhDM(
          loaiPhanAnhID: 0,
          maLoaiPhanAnh: "tracuu",
          tenLoaiPhanAnh:
              "Tra cứu các phản ánh đã được xử lý trong địa bàn huyện Hóc Môn TP.HCM",
          moTa: "",
          imagePhanAnh: tracuuphananh_phananh_image));
      yield PhanAnhHomeStateLoadSuccess(list: data);
    } else {
      yield PhanAnhHomeStateLoadFailure();
    }
  }
}
