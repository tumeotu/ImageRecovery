import 'package:equatable/equatable.dart';
import 'package:image_recovery/modules/phananhtructuyen/models/loaiphananh_danhmuc_model.dart';
import 'package:image_recovery/modules/phananhtructuyen/models/phananh_tracuu_model.dart';

abstract class PhanAnhTraCuuState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class PhanAnhTraCuuStateInitial extends PhanAnhTraCuuState {}

class PhanAnhTraCuuStateFailure extends PhanAnhTraCuuState {}

class PhanAnhTraCuuStateSuccess extends PhanAnhTraCuuState {
  final List<PhanAnhTraCuuResult> phanAnhTraCuus;
  final List<LoaiPhanAnhDM> loaiPhanAnhDMs;
  final bool hasReachedEnd;

  final int loaiPhanAnhID;
  final int pageIndex;
  final bool isLoading;

  PhanAnhTraCuuStateSuccess(
      {this.phanAnhTraCuus,
      this.loaiPhanAnhDMs,
      this.hasReachedEnd,
      this.pageIndex,
      this.isLoading,
      this.loaiPhanAnhID});

  @override
  List<Object> get props => [
        this.phanAnhTraCuus,
        this.loaiPhanAnhDMs,
        this.hasReachedEnd,
        this.pageIndex,
        this.isLoading,
    this.loaiPhanAnhID
        ];

  PhanAnhTraCuuStateSuccess cloneWith(
      {List<PhanAnhTraCuuResult> phanAnhTraCuus,
      List<LoaiPhanAnhDM> loaiPhanAnhDMs,
      bool hasReachedEnd,
      int pageIndex,
      bool isLoading,
      int loaiPhanAnhID}) {
    return PhanAnhTraCuuStateSuccess(
      phanAnhTraCuus: phanAnhTraCuus ?? this.phanAnhTraCuus,
      loaiPhanAnhDMs: loaiPhanAnhDMs ?? this.loaiPhanAnhDMs,
      hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
      pageIndex: pageIndex ?? this.pageIndex,
      isLoading: isLoading ?? this.isLoading,
      loaiPhanAnhID: loaiPhanAnhID ?? this.loaiPhanAnhID,
    );
  }
}
