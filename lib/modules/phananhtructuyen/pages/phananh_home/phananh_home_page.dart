import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_recovery/config_service.dart';
import 'package:image_recovery/modules/phananhtructuyen/apis/phananhtructuyen_datasource.dart';
import 'package:image_recovery/modules/phananhtructuyen/models/loaiphananh_danhmuc_model.dart';
import 'package:image_recovery/modules/phananhtructuyen/pages/diachi_danhmuc/diachi_danhmuc.dart';
import 'package:image_recovery/modules/phananhtructuyen/pages/linhvuc_hoso_danhmuc/linhvuc_hoso_danhmuc.dart';
import 'package:image_recovery/modules/phananhtructuyen/pages/phananh_home/phananh_home.dart';
import 'package:image_recovery/modules/phananhtructuyen/pages/phananhvipham/phananh_vipham.dart';
import 'package:image_recovery/modules/phananhtructuyen/widgets/media_phananh/media_phananh_bloc.dart';
import 'package:image_recovery/modules/phananhtructuyen/widgets/progress_loading.dart';
import 'package:image_recovery/utils/color_extends.dart';
import 'package:image_recovery/utils/navigations/navigation_datasource.dart';
import 'package:image_recovery/widgets/appbar_custom.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../../../constants.dart';

class PhanAnhHomePage extends StatefulWidget {
  PhanAnhHomePage({Key key}) : super(key: key);

  @override
  _PhanAnhHomePageState createState() {
    NavigationDataSource navigationDataSource =
        getIt.get<NavigationDataSource>();
    PhanAnhTrucTuyenDataSource phanAnhTrucTuyenDataSource =
        getIt.get<PhanAnhTrucTuyenDataSource>();
    ImagePicker imagePicker = ImagePicker();
    return _PhanAnhHomePageState(
        navigationDataSource: navigationDataSource,
        phanAnhTrucTuyenDataSource: phanAnhTrucTuyenDataSource,
        imagePicker: imagePicker);
  }
}

class _PhanAnhHomePageState extends State<PhanAnhHomePage>
    with TickerProviderStateMixin {
  final Color navigationBarColorStart = ColorExtends.fromHex('#4fc4dd');
  final Color navigationBarColorEnd = ColorExtends.fromHex('#4184d3');

  final PhanAnhTrucTuyenDataSource phanAnhTrucTuyenDataSource;
  final NavigationDataSource navigationDataSource;
  final ImagePicker imagePicker;
  AnimationController _animationController;

  _PhanAnhHomePageState(
      {this.navigationDataSource,
      this.phanAnhTrucTuyenDataSource,
      this.imagePicker,});

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3))
          ..addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(heightNavigationBar),
        child: AppBarCustom(
          title: PhanAnhHomeBloc().appTitle,
          startColor: navigationBarColorStart,
          endColor: navigationBarColorEnd,
          iconStart: Icons.arrow_back_ios,
        ),
      ),
      body: BlocBuilder<PhanAnhHomeBloc, PhanAnhHomeState>(
        // ignore: missing_return
        builder: (context, state) {
          if (state is PhanAnhHomeStateLoadSuccess) {
            var list = state.list;
            return Center(
              child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  var item = list.elementAt(index);

                  ///chưa sử dụng
//                      if (_animationController.isCompleted) {
//                        _animationController.reverse();
//                      } else {
//                        _animationController.forward();
//                      }
//                      BlocProvider.of<PhanAnhHomeBloc>(context).add(
//                          PhanAnhHomeEventSelectItem(
//                              item: item, index: index));
                  return PhanAnhItemWidget(
                    item: item,
                    index: index,
                    //animationController: _animationController,
                    showModalBottomSheetCallback: (loaiViPhamItem) {
                      _showModalBottomSheet(
                          homeContext: context,
                          loaiViPhamItem: loaiViPhamItem,
                          loaiPhanAnh: item);
                    },
                  );
                },
              ),
            );
          } else if (state is PhanAnhHomeStateInitiate) {
            return ProgressLoading();
          }
        },
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _showModalBottomSheet(
      {homeContext, LoaiViPham loaiViPhamItem, LoaiPhanAnhDM loaiPhanAnh}) {
    showMaterialModalBottomSheet(
      context: homeContext,
      backgroundColor: Colors.transparent,
      enableDrag: false,
      builder: (context, scrollController) {
        return MultiBlocProvider(
            providers: [
              BlocProvider<PhanAnhViPhamCubit>(
                  create: (_) => PhanAnhViPhamCubit(
                      dataSource: phanAnhTrucTuyenDataSource,
                      loaiPhanAnh: loaiPhanAnh,
                      loaiViPham: loaiViPhamItem)),
              BlocProvider(
                create: (_) => MediaPhanAnhCubit(
                    picker: imagePicker,
                    navigationDataSource: navigationDataSource),
              ),
              BlocProvider<DiaChiDanhMucBloc>(
                  create: (_) =>
                      DiaChiDanhMucBloc(dataSource: phanAnhTrucTuyenDataSource)
                        ..add(DiaChiDanhMucEventLoadInProgressPhuongXa())),
              BlocProvider<LinhVucHoSoDanhMucCubit>(
                  create: (_) => LinhVucHoSoDanhMucCubit(
                      dataSource: phanAnhTrucTuyenDataSource)
                    ..initData()),
            ],
            child: Container(
                height: MediaQuery.of(homeContext).size.height * 0.90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0)),
                  color: Colors.white,
                ),
                child: PhanAnhViPhamPage(
                  loaiViPhamItem: loaiViPhamItem,
                  isHoSo: loaiPhanAnh.maLoaiPhanAnh == "PAHS",
                )));
      },
    );
  }
}
