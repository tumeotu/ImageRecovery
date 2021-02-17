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
// abstract class DownLoadState extends Equatable {
//   @override
//   // TODO: implement props
//   List<Object> get props => throw UnimplementedError();
// }
// class DownLoadStateFailure extends DownLoadState {
//   DownLoadStateFailure();
//   @override
//   // TODO: implement props
//   List<Object> get props => [];
// }
//
// class DownLoadStateInitial extends DownLoadState {
// }
// class DownLoadStateStart extends DownLoadState {
//   bool HasFile;
//   DownLoadStateStart(this.HasFile);
//   DownLoadStateStart copy(HasFile) {
//     return  DownLoadStateStart(HasFile);
//   }
//   @override
//   List<Object> get props => [this.HasFile,];
// }
//
// class DownLoadStateProgress extends DownLoadState {
//   String filePath;
//   double progress;
//   DownLoadStateProgress(this.progress, this.filePath);
//   DownLoadStateProgress copy(progress, filePath) {
//     return  DownLoadStateProgress(progress,filePath);
//   }
//   @override
//   // TODO: implement props
//   List<Object> get props => [this.progress, this.filePath];
// }
