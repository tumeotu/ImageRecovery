import 'package:equatable/equatable.dart';
import 'package:image_recovery/modules/dichvucong/models/dichvucong_model.dart';

class DichVuCongEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class DichVuCongEventGetDMLinhVuc extends DichVuCongEvent {}

class DichVuCongEventGetDMLinhVucSelectedItem extends DichVuCongEvent {
  final DVC_LinhVuc itemSelected;
  final int index;

  DichVuCongEventGetDMLinhVucSelectedItem(this.itemSelected, this.index);
}

class DichVuCongEventGetDMThuTucReset extends DichVuCongEvent {}

class DichVuCongEventGetDMThuTuc extends DichVuCongEvent {
  final String keySearch;
  final String maLinhVuc;
  final int phanLoai;

  DichVuCongEventGetDMThuTuc(
      {this.keySearch, this.maLinhVuc, this.phanLoai = 1});

  @override
  // TODO: implement props
  List<Object> get props => [this.keySearch, this.maLinhVuc, this.phanLoai];
}

class DichVuCongEventThutucDetail extends DichVuCongEvent {
  final String thuTucID;

  DichVuCongEventThutucDetail({this.thuTucID});

  @override
  // TODO: implement props
  List<Object> get props => [this.thuTucID];
}
