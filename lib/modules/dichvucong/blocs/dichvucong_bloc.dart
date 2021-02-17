import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:image_recovery/modules/dichvucong/apis/dichvucong_datasource.dart';
import 'package:image_recovery/modules/dichvucong/blocs/dichvucong_event.dart';
import 'package:image_recovery/modules/dichvucong/blocs/dichvucong_state.dart';
import 'package:image_recovery/modules/dichvucong/models/dichvucong_model.dart';

class DichVuCongBloc_ThuTuc extends Bloc<DichVuCongEvent, DichVuCongState> {
  DichVuCongBloc_ThuTuc() : super(DichVuCongStateInitial());

  final NUMBER_OF_COMMENTS_PER_PAGE = 10;
  int finalIndexOfCurrentPage = 1;

  @override
  Stream<DichVuCongState> mapEventToState(DichVuCongEvent event) async* {
    try {
      if (event is DichVuCongEventGetDMThuTucReset) {
        yield DichVuCongStateInitial();
        finalIndexOfCurrentPage = 1;
      }
      if (event is DichVuCongEventGetDMThuTuc &&
          !(state is DichVuCongStateSuccessfulThuTuc &&
              (state as DichVuCongStateSuccessfulThuTuc).hasReachedEnd)) {
        if (state is DichVuCongStateInitial) {
          var data = await GetIt.instance<DichVuCongDataSource>()
              .DM_ThuTuc_LstByPhanLoai(
                  finalIndexOfCurrentPage, NUMBER_OF_COMMENTS_PER_PAGE,
                  maLinhVuc: event.maLinhVuc == "0" ? null : event.maLinhVuc,
                  keyWord: event.keySearch,
                  phanLoai: event.phanLoai);
          if (data!=null || data?.length < 10) {
            //change current state !
            yield DichVuCongStateSuccessfulThuTuc(
                listData: data, hasReachedEnd: true);
          } else {
            yield DichVuCongStateSuccessfulThuTuc(
                listData: new List<DVC_ThuTuc>(), hasReachedEnd: false);
          }

          finalIndexOfCurrentPage++;
        } else {
          if (state is DichVuCongStateSuccessfulThuTuc) {
            final currentState = state as DichVuCongStateSuccessfulThuTuc;
            var data = await GetIt.instance<DichVuCongDataSource>()
                .DM_ThuTuc_LstByPhanLoai(
                    finalIndexOfCurrentPage, NUMBER_OF_COMMENTS_PER_PAGE,
                    maLinhVuc: event.maLinhVuc == "0" ? null : event.maLinhVuc,
                    keyWord: event.keySearch,
                    phanLoai: event.phanLoai);
            if (data.isEmpty || data.length < 10) {
              //change current state !
              yield currentState.cloneWith(hasReachedEnd: true);
            } else {
              finalIndexOfCurrentPage++;
              //not empty, means "not reached end",
              yield DichVuCongStateSuccessfulThuTuc(
                  listData: currentState.listData + data, //merge 2 arrays
                  hasReachedEnd: false);
            }
          }
        }
      }
      if(event is DichVuCongEventThutucDetail){
        var data= await GetIt.instance<DichVuCongDataSource>().DM_ThuTuc_Detail(event.thuTucID);
        if(data!=null){
          yield(DichVuCongStateSuccessfulThuTuc_Detail(data));
        }
      }
    } catch (error) {
      print(error);
      yield DichVuCongStateFailure();
    }
  }
}

class DichVuCongBloc_LinhVuc extends Bloc<DichVuCongEvent, DichVuCongState> {
  DichVuCongBloc_LinhVuc() : super(null);
  int indexSelected=0;

  @override
  Stream<DichVuCongState> mapEventToState(DichVuCongEvent event) async* {
    if (event is DichVuCongEventGetDMLinhVuc) {
      var data = await GetIt.instance<DichVuCongDataSource>().DM_LinhVuc();
      yield DichVuCongStateSuccessfulLinhVuc(listData: data,index: indexSelected);
    }
    if (event is DichVuCongEventGetDMLinhVucSelectedItem) {
      indexSelected=event.index;
      yield DichVuCongStateSuccessfulLinhVucItemSelected(event.itemSelected,index: event.index);
    }
  }
}


