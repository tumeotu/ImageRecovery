import 'package:equatable/equatable.dart';
import 'package:image_recovery/modules/phananhtructuyen/models/loaiphananh_danhmuc_model.dart';

abstract class PhanAnhHomeState extends Equatable {
  const PhanAnhHomeState();

  @override
  List<Object> get props => [];
}

class PhanAnhHomeStateInitiate extends PhanAnhHomeState {}

class PhanAnhHomeStateLoadSuccess extends PhanAnhHomeState {
  final List<LoaiPhanAnhDM> list;
  final int index;

  const PhanAnhHomeStateLoadSuccess({this.index, this.list = const []});

  @override
  List<Object> get props => [list, index];
}

class PhanAnhHomeStateLoadFailure extends PhanAnhHomeState {}
