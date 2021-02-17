import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_recovery/modules/phananhtructuyen/apis/phananhtructuyen_datasource.dart';
import 'package:image_recovery/modules/phananhtructuyen/models/duong_danhmuc_model.dart';
import 'package:image_recovery/modules/phananhtructuyen/models/phuongxa_danhmuc_model.dart';
import 'package:image_recovery/modules/phananhtructuyen/pages/diachi_danhmuc/diachi_danhmuc.dart';

class DiaChiDanhMucBloc extends Bloc<DiaChiDanhMucEvent, DiaChiDanhMucState> {
  final PhanAnhTrucTuyenDataSource dataSource;

  DiaChiDanhMucBloc({this.dataSource}) : super(DiaChiDanhMucStateInitiate());

  @override
  void dispose() {}

  @override
  Stream<DiaChiDanhMucState> mapEventToState(DiaChiDanhMucEvent event) async* {
    ///LoadInProgress load PhuongXa
    if (event is DiaChiDanhMucEventLoadInProgressPhuongXa) {
      yield* _fetchAPIPhuongXa();
    }

    ///Selected phường xã và load dm đường
    if (event is DiaChiDanhMucEventLoadSelectedPhuongXa) {
      yield* _fetchAPIDuong(event.phuongXas, event.index);
    }

    ///Selected đường
    if (event is DiaChiDanhMucEventLoadSelectedDuong) {
      var currentState = state;
      if (currentState is DiaChiDanhMucStateDuongDMSuccess) {
        yield currentState.cloneWith(
            duongs: event.duongs,
            phuongXas: event.phuongXas,
            indexPhuongXa: event.indexPhuongXa,
            indexDuong: event.indexDuong);
      } else {
        yield DiaChiDanhMucStateDuongDMSuccess(
            duongs: event.duongs,
            phuongXas: event.phuongXas,
            indexPhuongXa: event.indexPhuongXa,
            indexDuong: event.indexDuong);
      }
      //yield DiaChiDanhMucStateSelectedDuong(event.itemSelected);
    }
  }

  Stream<DiaChiDanhMucState> _fetchAPIDuong(
      List<PhuongXaDanhMucModel> phuongXas, int index) async* {
    var item = phuongXas.elementAt(index);
    yield DiaChiDanhMucStateDuongDMLoading(phuongXas: phuongXas, index: index);
    List<DuongDanhMucModel> data =
        await dataSource.danhMucDuongGetAll(item.maPhuongXa);
    if (data != null) {
      yield DiaChiDanhMucStateDuongDMSuccess(
          duongs: data,
          phuongXas: phuongXas,
          indexPhuongXa: index,
          indexDuong: null);
    } else {
      yield DiaChiDanhMucStateDuongDMFailure(
          phuongXas: phuongXas, index: index);
    }
  }

  Stream<DiaChiDanhMucState> _fetchAPIPhuongXa() async* {
    yield DiaChiDanhMucStatePhuongXaDMLoading();
    List<PhuongXaDanhMucModel> data = await dataSource.danhMucPhuongGetAll();
    if (data != null) {
      yield DiaChiDanhMucStatePhuongXaDMSuccess(phuongXas: data);
    } else {
      yield DiaChiDanhMucStatePhuongXaDMFailure();
    }
  }

}
