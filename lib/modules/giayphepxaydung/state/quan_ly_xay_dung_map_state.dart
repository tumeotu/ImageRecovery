// import 'dart:collection';
//
// import 'package:equatable/equatable.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:image_recovery/data/models/dashboard_models.dart';
// import 'package:image_recovery/modules/giayphepxaydung/model/giayphepxaydung.dart';
// import 'package:image_recovery/modules/giayphepxaydung/model/googlemap_response.dart';
// import 'package:image_recovery/modules/giayphepxaydung/model/phananhxaydungkp.dart';
// import 'package:image_recovery/modules/tintuc/models/tintuc_models.dart';
// import 'package:image_recovery/pages/SoThuTu/Model/model/PostSTTResponse.dart';
// import 'package:image_recovery/pages/SoThuTu/Model/model/sothutu.dart';
//
// abstract class QLXDMapState extends Equatable {
//   @override
//   // TODO: implement props
//   List<Object> get props => throw UnimplementedError();
// }
// class GPXDMainStateFailure extends QLXDMapState {
//   GPXDMainStateFailure();
//   @override
//   // TODO: implement props
//   List<Object> get props => [];
// }
//
// class QLXDMapStateInitial extends QLXDMapState {
// }
//
// class GetDataSuccess extends QLXDMapState {
//   bool IsStart;
//   GiayPhepXayDung response;
//   MarkerId SelectecMarker;
//   LatLng location;
//   Results results;
//   String FilePath;
//   GetDataSuccess(this.response, this.IsStart,this.SelectecMarker, this.location, this.results, this.FilePath);
//   GetDataSuccess copy(response, IsStart,SelectecMarker, location,results,FilePath) {
//     HashSet<GiayPhepXayDung> list= new HashSet();
//     list.union(Set.from(this.response.thongTinGiayPheps));
//     list.union(Set.from(response.thongTinGiayPheps));
//     response.thongTinGiayPheps = list.toList();
//     HashSet<PhanAnhXayDungKPs> listpa= new HashSet();
//     listpa.union(Set.from(this.response.phanAnhXayDungKPs));
//     listpa.union(Set.from(response.phanAnhXayDungKPs));
//     response.phanAnhXayDungKPs = listpa.toList();
//     return  GetDataSuccess(response,IsStart,SelectecMarker, location, results,FilePath);
//   }
//   @override
//   // TODO: implement props
//   List<Object> get props => [this.response, this.IsStart, this.SelectecMarker, this.location, this.results, this.FilePath];
// }
