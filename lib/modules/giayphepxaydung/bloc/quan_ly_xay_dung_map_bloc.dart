// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_recovery/data/apis/dashboards/dashboard_datasource.dart';
// import 'package:image_recovery/data/apis/laysothutu/laystt_datasource.dart';
// import 'package:image_recovery/data/apis/quanlyxaydung/qlxd_datasource.dart';
// import 'package:image_recovery/data/models/dashboard_models.dart';
// import 'package:image_recovery/modules/giayphepxaydung/event/quan_ly_xay_dung_map_event.dart';
// import 'package:image_recovery/modules/giayphepxaydung/event/search_view_event.dart';
// import 'package:image_recovery/modules/giayphepxaydung/state/quan_ly_xay_dung_map_state.dart';
// import 'package:image_recovery/pages/SoThuTu/Model/event/DetailImageEvent.dart';
// import 'package:image_recovery/pages/SoThuTu/Model/model/PostSTTResponse.dart';
// import 'package:image_recovery/pages/SoThuTu/Model/model/sothutu.dart';
// import 'package:image_recovery/pages/SoThuTu/Model/state/CropState.dart';
// import 'package:image_recovery/pages/home/events/dashboard_main_event.dart';
// import 'package:image_recovery/pages/home/states/dashboard_main_state.dart';
// import 'package:geolocator/geolocator.dart';
// import '../../../config_service.dart';
//
// class QLXDMapBloc extends Bloc<QLXDMapEvent, QLXDMapState> {
//   GiayPhepXayDungDataSource dataSource = getIt.get<GiayPhepXayDungDataSource>();
//   QLXDMapBloc() : super(QLXDMapStateInitial());
//   List<Phieu> datasSoThuTu;
//
//   @override
//   Stream<QLXDMapState> mapEventToState(QLXDMapEvent event) async* {
//     try {
//       if (event is QLXDMapEventStart) {
//         /// get user's location
//         Position position = await Geolocator()
//             .getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
// //          String lat= position.latitude.toString().replaceAll(',', '.');
// //          String lng= position.longitude.toString().replaceAll(',', '.');
// //          String bankinh='1000';
//         /// data sample
//         String lat = '10.912998';
//         String lng = '106.588425';
//         String bankinh = '1000';
//
//         /// call api to get data on map
//         var data = await dataSource.getGiayPhepXayDung(lat, lng, bankinh);
//         yield GetDataSuccess(data, true, null, null, null, null);
//       }
//       if (event is QLXDMapEventGetData) {
//         /// call api to get data on map
//         var data = await dataSource.getGiayPhepXayDung(
//             event.lat, event.lng, event.bankinh);
//         if (data != null) {
//           yield GetDataSuccess(data, false, null, null, null, null);
//         }
//       }
//       if (event is QLXDMapEventSelectedMarker) {
//         var data =
//             await dataSource.getGiayPhepXayDung(event.lat, event.lng, '10000');
//         if (data != null) {
//           yield GetDataSuccess(data, false, event.ID, null, null, null);
//         }
//       }
//       if (event is QLXDMapEventLongClick) {
//         if (event.location != null) {
//           var data = await dataSource.getGiayPhepXayDung(
//               event.location.latitude.toString(),
//               event.location.longitude.toString(),
//               '10000');
//           var location = await dataSource.getAddressFromLocation(
//               event.location.latitude.toString(),
//               event.location.longitude.toString());
//           if (data != null) {
//             yield GetDataSuccess(data, false, null, event.location, location, null);
//           }
//         } else {
//           /// get user's location
//           Position position = await Geolocator()
//               .getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
// //          String lat= position.latitude.toString().replaceAll(',', '.');
// //          String lng= position.longitude.toString().replaceAll(',', '.');
// //          String bankinh='1000';
//           /// data sample
//           String lat = '10.912998';
//           String lng = '106.588425';
//           String bankinh = '1000';
//           /// call api to get data on map
//           var data = await dataSource.getGiayPhepXayDung(lat, lng, bankinh);
//           print('don');
//           yield GetDataSuccess(data, false, null, event.location, null, null);
//         }
//       }
//       if(event is QLXDMapEventDownLoadFile)
//         {
//           /// get user's location
//           Position position = await Geolocator()
//               .getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
// //          String lat= position.latitude.toString().replaceAll(',', '.');
// //          String lng= position.longitude.toString().replaceAll(',', '.');
// //          String bankinh='1000';
//           /// data sample
//           String lat = '10.912998';
//           String lng = '106.588425';
//           String bankinh = '1000';
//           /// call api to get data on map
//           var data = await dataSource.getGiayPhepXayDung(lat, lng, bankinh);
//           var file = await dataSource.DownLoadFile(event.url);
//           print('don');
//           yield GetDataSuccess(data, false, null, null, null, file);
//         }
//     } catch (exception) {
//       yield GPXDMainStateFailure();
//     }
//   }
// }
