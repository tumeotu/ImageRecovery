import 'package:get_it/get_it.dart';
import 'package:image_recovery/data/apis/dashboards/dashboard_datasource.dart';
import 'package:image_recovery/data/apis/dashboards/dashboard_response.dart';
import 'package:image_recovery/data/apis/detect/DetectDataSource.dart';
import 'package:image_recovery/data/apis/detect/DetectResponse.dart';
import 'package:image_recovery/data/apis/history_recover/HistoryDataSource.dart';
import 'package:image_recovery/data/apis/laysothutu/laystt_datasource.dart';
import 'package:image_recovery/data/apis/laysothutu/laystt_response.dart';
import 'package:image_recovery/data/apis/logins/login_response.dart';
import 'package:image_recovery/data/apis/quanlyxaydung/qlxd_datasource.dart';
import 'package:image_recovery/data/apis/quanlyxaydung/qlxd_response.dart';
import 'package:image_recovery/data/apis/recovery/RecoveryDataSource.dart';
import 'package:image_recovery/data/apis/recovery/RecoveryResponse.dart';
import 'package:image_recovery/modules/dichvucong/apis/dichvucong_datasource.dart';
import 'package:image_recovery/modules/dichvucong/apis/dichvucong_response.dart';
import 'package:image_recovery/modules/phananhtructuyen/phananhtructuyen.dart';
import 'package:image_recovery/utils/navigations/navigation_datasource.dart';
import 'package:image_recovery/utils/navigations/navigation_response.dart';
import 'package:image_recovery/utils/networks/network_datasource.dart';
import 'package:image_recovery/utils/networks/network_response.dart';
import 'data/apis/history_recover/HistoryResponse.dart';
import 'data/apis/logins/login_datasource.dart';
import 'modules/tintuc/tintuc_imports.dart';

final getIt = GetIt.instance;
class ConfigService {
  ConfigService() {
    //init();
  }

  Future init() async {
    // do your async initialisation...
    getIt.registerSingleton<NetworkDataSource>(NetworkResponse());
    getIt.registerSingleton<NavigationDataSource>(NavigationResponse(),
        signalsReady: true);
    getIt.registerSingleton<DashboardDataSource>(DashboardResponce(),
        signalsReady: true);
    getIt.registerSingleton<TinTucDataSource>(TinTucResponce(),
        signalsReady: true);
    getIt.registerSingleton<LoginDataSource>(LoginResponse(),
        signalsReady: true);
    getIt.registerSingleton<LaySTTDataSource>(LaySTTResponse(),
        signalsReady: true);
    getIt.registerSingleton<RecoveryDatasource>(RecoveryResponse(),
        signalsReady: true);
    getIt.registerSingleton<HistoryRecoveryDatasource>(HistoryRecoveryResponse(),
        signalsReady: true);
    getIt.registerSingleton<DetectDatasource>(DetectResponse(),
        signalsReady: true);
    getIt.registerSingleton<GiayPhepXayDungDataSource>(GiayPhepXayDungResponse(),
        signalsReady: true);
    getIt.registerSingleton<PhanAnhTrucTuyenDataSource>(
        PhanAnhTrucTuyenResponse(),
        signalsReady: true);
    getIt.registerSingleton<DichVuCongDataSource>(
        DichVuCongResponse(),
        signalsReady: true);

    //getIt.signalReady(this);
  }
}
