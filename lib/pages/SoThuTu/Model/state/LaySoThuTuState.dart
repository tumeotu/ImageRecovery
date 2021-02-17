import 'package:equatable/equatable.dart';
import 'package:image_recovery/data/models/dashboard_models.dart';
import 'package:image_recovery/modules/tintuc/models/tintuc_models.dart';
import 'package:image_recovery/pages/SoThuTu/Model/model/PostSTTResponse.dart';
import 'package:image_recovery/pages/SoThuTu/Model/model/sothutu.dart';

abstract class LaySoThuTuState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class LaySoThuTuMainStateInitial extends LaySoThuTuState {
  List<Phieu> data;
  STTResponse response;
  LaySoThuTuMainStateInitial(this.data, this.response);
  LaySoThuTuMainStateInitial copy(data, response) => LaySoThuTuMainStateInitial(data ?? this.data,response);
  @override
  // TODO: implement props

  List<Object> get props => [this.data, this.response];
}

class LaySoThuTuMainStateFailure extends LaySoThuTuState {
  LaySoThuTuMainStateFailure();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LaySoThuTuPostState extends LaySoThuTuState {
  final STTResponse response;
  LaySoThuTuPostState(this.response);
  @override
  // TODO: implement props
  List<Object> get props => [this.response];
}

class LaySoThuTuPostSuccess extends LaySoThuTuState {
  List<Phieu> data;
  STTResponse response;
  LaySoThuTuPostSuccess(this.data, this.response);

  LaySoThuTuPostSuccess copy(data, response) => LaySoThuTuPostSuccess(data ?? this.data,response);

  @override
  // TODO: implement props
  List<Object> get props => [this.data, this.response];
}
