import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:image_recovery/modules/dichvucong/blocs/dichvucong_bloc.dart';
import 'package:image_recovery/modules/dichvucong/pages/dichvucong_tthc_page.dart';
import 'package:image_recovery/modules/phananhtructuyen/apis/phananhtructuyen_datasource.dart';
import 'package:image_recovery/modules/phananhtructuyen/pages/phananh_home/phananh_home.dart';
import 'package:image_recovery/modules/phananhtructuyen/pages/phananh_home/phananh_home_page.dart';
import 'package:image_recovery/modules/phananhtructuyen/pages/phananh_tracuu/phananh_tracuu.dart';
import 'package:image_recovery/modules/phananhtructuyen/phananhtructuyen.dart';
import 'package:image_recovery/pages/Account/view/account_edit_view.dart';
import 'package:image_recovery/pages/Account/view/account_view.dart';
import 'package:image_recovery/pages/Crop/bloc/CropBloc.dart';
import 'package:image_recovery/pages/Crop/event/CropEvent.dart';
import 'package:image_recovery/pages/Crop/view/crop_view.dart';
import 'package:image_recovery/pages/CustomFilter/bloc/CustomFilterBloc.dart';
import 'package:image_recovery/pages/CustomFilter/event/CustomFilterEvent.dart';
import 'package:image_recovery/pages/CustomFilter/view/custom_filter_view.dart';
import 'package:image_recovery/pages/Detai_Image/bloc/DetailImageBloc.dart';
import 'package:image_recovery/pages/Detai_Image/event/DetailImageEvent.dart';
import 'package:image_recovery/pages/Detai_Image/view/detail_image_view.dart';
import 'package:image_recovery/pages/DetectResult/Model/ImageResultDetect.dart';
import 'package:image_recovery/pages/DetectResult/bloc/DetectResultBloc.dart';
import 'package:image_recovery/pages/DetectResult/event/DetectResultEvent.dart';
import 'package:image_recovery/pages/DetectResult/view/detect_result_view.dart';
import 'package:image_recovery/pages/Edit/bloc/EditBloc.dart';
import 'package:image_recovery/pages/Edit/event/EditEvent.dart';
import 'package:image_recovery/pages/Edit/view/edit_view.dart';
import 'package:image_recovery/pages/Filter/bloc/FilterBloc.dart';
import 'package:image_recovery/pages/Filter/event/FilterEvent.dart';
import 'package:image_recovery/pages/Filter/model/matrix.dart';
import 'package:image_recovery/pages/Filter/view/filter_view.dart';
import 'package:image_recovery/pages/ForgotPassword/view/forgot_password_view.dart';
import 'package:image_recovery/pages/Languages/languages_setting.dart';
import 'package:image_recovery/pages/Permission/permission_setting.dart';
import 'package:image_recovery/pages/PhotoView/bloc/PhotoViewBloc.dart';
import 'package:image_recovery/pages/PhotoView/event/PhotoViewEvent.dart';
import 'package:image_recovery/pages/PhotoView/view/photo_view_view.dart';
import 'package:image_recovery/pages/RecoverImageDetail/bloc/RecoverImageDetailBloc.dart';
import 'package:image_recovery/pages/RecoverImageDetail/event/RecoverImageDetailEvent.dart';
import 'package:image_recovery/pages/RecoverImageDetail/view/recovery_image_detail_view.dart';
import 'package:image_recovery/pages/RecoverImageResult/bloc/RecoverImageResultlBloc.dart';
import 'package:image_recovery/pages/RecoverImageResult/event/RecoverImageResultlEvent.dart';
import 'package:image_recovery/pages/RecoverImageResult/model/ImageResult.dart';
import 'package:image_recovery/pages/RecoverImageResult/view/recovery_image_result_view.dart';
import 'package:image_recovery/pages/Register/view/register_account_view.dart';
import 'package:image_recovery/pages/SoThuTu/Model/bloc/LaySoThuTuBloc.dart';
import 'package:image_recovery/pages/SoThuTu/Model/event/LaySoThuTuEvent.dart';
import 'package:image_recovery/pages/home/blocs/HomeBloc.dart';
import 'package:image_recovery/pages/home/events/HomeEvent.dart';
import 'package:image_recovery/pages/home/model/ModelImage.dart';
import 'package:image_recovery/pages/home/view/home_view.dart';
import 'package:image_recovery/pages/login/blocs/login_bloc.dart';
import 'package:image_recovery/pages/login/events/login_event.dart';
import 'package:image_recovery/utils/navigations/navigation_datasource.dart';
import 'package:image_recovery/widgets/medias/camera_widget.dart';
import 'package:image_recovery/widgets/medias/media.dart';
import 'package:image_recovery/widgets/medias/videoplayer_widget.dart';
import 'package:sailor/sailor.dart';
import 'data/models/user_models.dart';
import 'modules/dichvucong/pages/dichvucong_tthc_chitiet_page.dart';
import 'modules/tintuc/tintuc_imports.dart';
import 'pages/SoThuTu/Model/LaySoThuTuHome.dart';
import 'pages/login/view/login_page.dart';

class Routes {
  static final sailor = Sailor();
  static List<CameraDescription> cameras;
  static void createRoutes() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      cameras = await availableCameras();
    } on CameraException catch (e) {
      //logError(e.code, e.description);
    }

    ///phananhtructuyen/phananh_home/
    sailor
      ..addRoute(SailorRoute(
          name: NamePage.phanAnhHomePage.toString(),
          builder: (context, args, params) {
            return BlocProvider(
                create: (_) {
                  PhanAnhTrucTuyenDataSource dataSource =
                      GetIt.instance.get<PhanAnhTrucTuyenDataSource>();
                  NavigationDataSource navigationDataSource =
                      GetIt.instance<NavigationDataSource>();
                  return PhanAnhHomeBloc(
                      dataSource: dataSource,
                      navigationDataSource: navigationDataSource)
                    ..add(PhanAnhHomeEventLoadInProgress());
                },
                child: PhanAnhHomePage());
          },
          params: [
            SailorParam<String>(
              name: 'videoPath',
              defaultValue: "",
            ),
          ]))

      ///lay so tu
      ..addRoute(SailorRoute(
          name: NamePage.laySoThuTuHomePage.toString(),
          builder: (context, args, params) {
            return BlocProvider<LaySoThuTuBloc>(
              create: (_) => LaySoThuTuBloc()..add(LayThuTuEventStart()),
              child: LaySoThuTuHome(),
            );
          }))

      ///tintuc_chitiet
      ..addRoute(SailorRoute(
        name: NamePage.tintuc_chitiet.toString(),
        builder: (context, args, params) {
          return BlocProvider<TinTucChiTietBloc>(
            create: (_) => TinTucChiTietBloc(),
            child: TinTucChiTietPage(),
          );
        },
        params: [
          SailorParam<int>(
            name: 'id',
            defaultValue: 0,
          ),
          SailorParam<int>(
            name: 'countNumber',
            defaultValue: 0,
          ),
        ],
      ))

      ///camera_widget
      ..addRoute(SailorRoute(
        name: NamePage.camera_widget.toString(),
        builder: (context, args, params) {
          return CameraWidget(cameras);
        },
//            params: [
//              SailorParam<String>(
//                name: 'pathVideo',
//                defaultValue: "",
//              )
//            ]
      ))


      ///photoviewer_widget
      ..addRoute(SailorRoute(
          name: NamePage.photoviewer_widget.toString(),
          builder: (context, args, params) {
            String pathFile = params.param("pathFile");
            String urlFile = params.param("urlFile");
            return PhotoViewerWidget(pathFile: pathFile, urlFile: urlFile);
          },
          params: [
            SailorParam<String>(
              name: 'pathFile',
              defaultValue: "",
            ),
            SailorParam<String>(
              name: 'urlFile',
              defaultValue: "",
            ),
          ]))

      ///loginPage
      ..addRoute(SailorRoute(
          name: NamePage.loginPage.toString(),
          builder: (context, args, params) {
            return BlocProvider<LoginBloc>(
              create: (_) => LoginBloc()..add(LoginEventStart(false, false,"","")),
              child: LoginPage(),
            );
          },
          params: []))

      ///registerPage
      ..addRoute(SailorRoute(
          name: NamePage.registerPage.toString(),
          builder: (context, args, params) {
            return RegisterScreen();
          }))

      ///ForgotPasswordPage
      ..addRoute(SailorRoute(
          name: NamePage.forgotPasswordPage.toString(),
          builder: (context, args, params) {
            return ForgotPasswordScreen();
          }))
    ///HomePage
      ..addRoute(SailorRoute(
          name: NamePage.homePage.toString(),
        builder: (context, args, params) {
          final page= params.param<int>('page');
          return BlocProvider<HomeBloc>(
            create: (_) => HomeBloc()..add(HomeEventStart(page)),
            child: HomeScreen(),
          );
        },
        params: [
          SailorParam<int>(
            name: 'page',
            defaultValue: 1,
          ),
        ]))
    ///AccountPage
      ..addRoute(SailorRoute(
          name: NamePage.accountPage.toString(),
          builder: (context, args, params) {
            return AccountScreen();
          }))
    ///AccountPage
      ..addRoute(SailorRoute(
          name: NamePage.editAccountPage.toString(),
          builder: (context, args, params) {
            return EditAccountScreen();
          }))

      /// filter page
      ..addRoute(SailorRoute(
          name: NamePage.filterPage.toString(),
          builder: (context, args, params) {
            final image= params.param<Uint8List>('image');
            return MultiBlocProvider(
              providers: [
                BlocProvider<FilterBloc>(
                  create: (context) => FilterBloc()..add(FilterEventStart(null,MatrixColor.instance.filters[0])),
                ),
              ],
              child: FilterHome(),
            );
          },
          params: [
            SailorParam<Uint8List>(
              name: 'image',
              defaultValue: null,
            ),
          ]))
    /// custom filter page
      ..addRoute(SailorRoute(
          name: NamePage.customFilterPage.toString(),
          builder: (context, args, params) {
            final image= params.param<Uint8List>('image');
            return MultiBlocProvider(
              providers: [
                BlocProvider<CustomFilterBloc>(
                  create: (context) => CustomFilterBloc()..add(CustomFilterEventStart(null,1,0,1)),
                ),
              ],
              child: CustomFilterHome(),
            );
          },
          params: [
            SailorParam<Uint8List>(
              name: 'image',
              defaultValue: null,
            ),
          ]))

    /// edit page
    ..addRoute(SailorRoute(
        name: NamePage.editPage.toString(),
        builder: (context, args, params) {
          final image= params.param<Uint8List>('image');
          return BlocProvider<EditBloc>(
            create: (_) => EditBloc()..add(EditEventStart(image)),
            child: EditHome(),
          );
        },
        params: [
          SailorParam<Uint8List>(
            name: 'image',
            defaultValue: null,
          ),
        ]))
    /// detail image page
    ..addRoute(SailorRoute(
        name: NamePage.detailImagePage.toString(),
        builder: (context, args, params) {
          final image= params.param<Uint8List>('image');
          return BlocProvider<DetailImageBloc>(
            create: (_) => DetailImageBloc()..add(DetailImageEventStart(image)),
            child: DetailImageHome(),
          );
        },
        params: [
          SailorParam<Uint8List>(
            name: 'image',
            defaultValue: null,
          ),
        ]))
    /// detail image recover
    ..addRoute(SailorRoute(
        name: NamePage.detailImageRecoverPage.toString(),
        builder: (context, args, params) {
          final image= params.param<List<ModelImage>>('image');
          return BlocProvider<RecoverImageDetailBloc>(
            create: (_) => RecoverImageDetailBloc()..add(RecoverImageDetailEventStart(image)),
            child: RecoverImageDetailPage(),
          );
        },
        params: [
          SailorParam<List<ModelImage>>(
            name: 'image',
            defaultValue: null,
          ),
        ]))

    /// result image recover
    ..addRoute(SailorRoute(
        name: NamePage.resultImageRecoverPage.toString(),
        builder: (context, args, params) {
          final image= params.param<List<ImageResult>>('image');
          return BlocProvider<RecoverImageResultBloc>(
            create: (_) => RecoverImageResultBloc()..add(RecoverImageResultEventStart(image)),
            child: RecoverImageResultPage(),
          );
        },
        params: [
          SailorParam<List<ImageResult>>(
            name: 'image',
            defaultValue: null,
          ),
        ]))

    /// photo view recover
      ..addRoute(SailorRoute(
          name: NamePage.photoViewPage.toString(),
          builder: (context, args, params) {
            final image= params.param<ImageResult>('image');
            return BlocProvider<PhotoViewBloc>(
              create: (_) => PhotoViewBloc()..add(
                  PhotoViewEventStart(
                      0,
                      image.OldImage,
                      image.NewImage)),
              child: PhotoViewHome(),
            );
          },
          params: [
            SailorParam<ImageResult>(
              name: 'image',
              defaultValue: null,
            ),
          ]))

    /// detect view recover
      ..addRoute(SailorRoute(
          name: NamePage.detectViewPage.toString(),
          builder: (context, args, params) {
            final image= params.param<List<ImageResultDetect>>('image');
            return BlocProvider<DetectViewBloc>(
              create: (_) => DetectViewBloc()..add(
                  DetectViewEventStart(image)),
              child: DetectViewHome(),
            );
          },
          params: [
            SailorParam<List<ImageResultDetect>>(
              name: 'image',
              defaultValue: null,
            ),
          ]))


    /// crop page
    ..addRoute(SailorRoute(
        name: NamePage.cropPage.toString(),
        builder: (context, args, params) {
          final image= params.param<Uint8List>('image');
          return BlocProvider<CropBloc>(
            create: (_) => CropBloc()..add(CropEventStart(null, true, true, null)),
            child: CropHome(),
          );
        },
        params: [
          SailorParam<Uint8List>(
            name: 'image',
            defaultValue: null,
          ),
        ]))
    ///LanguagesPage
      ..addRoute(SailorRoute(
          name: NamePage.languagesPage.toString(),
          builder: (context, args, params) {
            return LanguagesSettingScreen();
          }))
    ///permissionsPage
      ..addRoute(SailorRoute(
          name: NamePage.permissionsPage.toString(),
          builder: (context, args, params) {
            return PermissionSettingScreen();
          }))

      // /// quan ly xay dung page
      // ..addRoute(SailorRoute(
      //     name: NamePage.search_view_page.toString(),
      //     builder: (context, args, params) {
      //       return BlocProvider<SearchViewBloc>(
      //         create: (_) => SearchViewBloc()..add(SearchViewEventStart()),
      //         child: SearchViewHome(),
      //       );
      //     },
      //     params: [
      //       SailorParam<Results>(
      //         name: 'AddressSearch',
      //         defaultValue: null,
      //       ),
      //     ]))

      ..addRoute(SailorRoute(
          name: NamePage.phananh_tracuu.toString(),
          builder: (context, args, params) {
            return BlocProvider<PhanAnhTraCuuBloc>(
              create: (_) => PhanAnhTraCuuBloc(
                  phanAnhTrucTuyenDataSource:
                  GetIt.instance.get<PhanAnhTrucTuyenDataSource>())
                ..add(PhanAnhTraCuuEventGetListData()),
              child: PhanAnhTraCuuPage(),
            );
          },
          params: [
            SailorParam<List<LoaiPhanAnhDM>>(
              name: 'loaiPhanAnhs',
              defaultValue: null,
            ),
          ]))
      ..addRoute(SailorRoute(
          name: NamePage.dichvucong_tthc_page.toString(),
          builder: (context, args, params) {
            return MultiBlocProvider(
              providers: [
                BlocProvider<DichVuCongBloc_LinhVuc>(
                  create: (context) => DichVuCongBloc_LinhVuc(),
                ),
                BlocProvider<DichVuCongBloc_ThuTuc>(
                  create: (context) => DichVuCongBloc_ThuTuc(),
                ),
              ],
              child: DichVuCongTTHCPage(),
            );
          }))
      ..addRoute(SailorRoute(
          name: NamePage.dichvucong_tthc_chitiet_page.toString(),
          builder: (context, args, params) {
            return BlocProvider<DichVuCongBloc_ThuTuc>(
              create: (context)=>DichVuCongBloc_ThuTuc(),
              child: DichVuCongChiTietPage(),
            );
          },
          params: [
            SailorParam<String>(
              name: 'thuTucID',
              defaultValue: '',
            ),
            SailorParam<String>(
              name: 'linhVucID',
              defaultValue: '',
            ),
          ]));
  }
}

enum NamePage {
  loginPage,
  registerPage,
  forgotPasswordPage,
  homePage,
  accountPage,
  editAccountPage,
  filterPage,
  customFilterPage,
  editPage,
  detailImagePage,
  cropPage,
  textPage,
  emojiPage,
  languagesPage,
  permissionsPage,
  detailImageRecoverPage,
  resultImageRecoverPage,
  photoViewPage,
  detectViewPage,

  accuracyPage,
  phanAnhHomePage,
  tintuc_chitiet,
  camera_widget,
  videoplayer_widget,
  photoviewer_widget,
  laySoThuTuHomePage,
  phananh_tracuu,
  qlxd_map_page,
  dichvucong_tthc_page,
  dichvucong_tthc_chitiet_page,
  search_view_page,
}
