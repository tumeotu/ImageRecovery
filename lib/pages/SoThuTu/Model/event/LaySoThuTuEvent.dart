import 'package:equatable/equatable.dart';

abstract class LaySoThuTuEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LayThuTuEventStart extends LaySoThuTuEvent{}
class LayThuTuEventPost extends LaySoThuTuEvent{
  final int tenQuay;
  final String idQuay;
  final String soDienThoai;
  LayThuTuEventPost(this.idQuay, this.tenQuay, this.soDienThoai);
}