// import 'dart:convert';
//
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_recovery/data/apis/dashboards/dashboard_datasource.dart';
// import 'package:image_recovery/data/apis/laysothutu/laystt_datasource.dart';
// import 'package:image_recovery/data/apis/quanlyxaydung/qlxd_datasource.dart';
// import 'package:image_recovery/data/models/dashboard_models.dart';
// import 'package:image_recovery/modules/giayphepxaydung/event/quan_ly_xay_dung_map_event.dart';
// import 'package:image_recovery/modules/giayphepxaydung/event/search_view_event.dart';
// import 'package:image_recovery/modules/giayphepxaydung/model/googlemap_response.dart';
// import 'package:image_recovery/modules/giayphepxaydung/state/quan_ly_xay_dung_map_state.dart';
// import 'package:image_recovery/modules/giayphepxaydung/state/search_view_state.dart';
// import 'package:image_recovery/pages/SoThuTu/Model/event/DetailImageEvent.dart';
// import 'package:image_recovery/pages/SoThuTu/Model/model/PostSTTResponse.dart';
// import 'package:image_recovery/pages/SoThuTu/Model/model/sothutu.dart';
// import 'package:image_recovery/pages/SoThuTu/Model/state/CropState.dart';
// import 'package:image_recovery/pages/home/events/dashboard_main_event.dart';
// import 'package:image_recovery/pages/home/states/dashboard_main_state.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../../config_service.dart';
//
// class SearchViewBloc extends Bloc<SearchViewEvent, SearchViewState> {
//   GiayPhepXayDungDataSource dataSource = getIt.get<GiayPhepXayDungDataSource>();
//
//   SearchViewBloc() : super(SearchViewStateInitial());
//   List<Phieu> datasSoThuTu;
//   final String HISTORY='HISTORY';
//
//   @override
//   Stream<SearchViewState> mapEventToState(SearchViewEvent event) async* {
//     try {
//       if (event is SearchViewEventStart) {
//         //yield GetDataSearchSuccess(null, false);
//       }
//       if (event is SearchViewEventGetDataHistory) {
//         SharedPreferences prefs = await SharedPreferences.getInstance();
//         String data = (prefs.getString(HISTORY)) ;
//         print(data.toString());
//         if(data!=null)
//         {
//           List<Results> posts =(json.decode(data) as List).map((i) =>
//               Results.fromJson(i)).toList();
//           final jsonResponse=jsonDecode(data);
//           var _History = new List<Results>();
//           jsonResponse.forEach((v) {
//             _History.add(new Results.fromJson(v));
//           });
//           yield GetDataSearchSuccess(_History, false);
//         }
//         else
//           yield GetDataSearchSuccess([], false);
//       }
//       if (event is SearchViewEventGetData) {
//         /// call api to get data on map
//         var data = await dataSource.SearchAddress(event.query);
//         yield GetDataSearchSuccess(data, true);
//       }
//     } catch (exception) {
//       yield SearchViewStateFailure();
//     }
//   }
// }
