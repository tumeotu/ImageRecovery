import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../tintuc_imports.dart';

class DashboardTinTucBloc
    extends Bloc<DashboardTinTucEvent, DashboardTinTucState> {
  DashboardTinTucBloc() : super(DashboardTinTucStateInitial());
  TinTucDataSource tinTucSource = GetIt.instance.get<TinTucDataSource>();

  List<TinTucCongAn_Lst_Result> listData;

  @override
  Stream<DashboardTinTucState> mapEventToState(
      DashboardTinTucEvent event) async* {
    try {
      if (event is DashboardTinTucEventListSlider) {
        var data_TinTuc =
            await tinTucSource.getTinTucSuKien(null, null, null, '1', '5');
        if (data_TinTuc?.length > 0) {
          listData = data_TinTuc;
        }
      }
      if (event is DashboardTinTucEventPageChange) {
        yield DashboardTinTucStatePageChange(
            listData: this.listData, index: event.index);
      }
    } catch (Exc) {
      print(Exc);
      yield DashboardTinTucStateFailure();
    }
  }
}

class DashboardTinTucBlocList
    extends Bloc<DashboardTinTucEvent, DashboardTinTucState> {
  DashboardTinTucBlocList() : super(DashboardTinTucStateInitial());
  TinTucDataSource dataSource = GetIt.instance.get<TinTucDataSource>();
  final NUMBER_OF_COMMENTS_PER_PAGE = '5';
  int finalIndexOfCurrentPage = 1;

  @override
  Stream<DashboardTinTucState> mapEventToState(
      DashboardTinTucEvent event) async* {
    try {
      if (event is DashboardTinTucEventResetState) {
        yield DashboardTinTucStateInitial();
        finalIndexOfCurrentPage = 1;
      }
      if (event is DashboardTinTucEventGetListData &&
          !(state is DashboardTinTucStateSuccess &&
              (state as DashboardTinTucStateSuccess).hasReachedEnd)) {
        print(state);
        if (state is DashboardTinTucStateInitial) {
          var data = await dataSource.getTinTucSuKien(null, null,
              event.keysearch, finalIndexOfCurrentPage.toString(), NUMBER_OF_COMMENTS_PER_PAGE);
          yield DashboardTinTucStateSuccess(
              listData: data, hasReachedEnd: false);
          finalIndexOfCurrentPage++;
        } else if (state is DashboardTinTucStateSuccess) {
          final currentState = state as DashboardTinTucStateSuccess;
          var data = await dataSource.getTinTucSuKien(
              null,
              null,
              event.keysearch,
              finalIndexOfCurrentPage.toString(),
              NUMBER_OF_COMMENTS_PER_PAGE);
          if (data.isEmpty || data.length < 10) {
            //change current state !
            yield currentState.cloneWith(hasReachedEnd: true);
          } else {
            finalIndexOfCurrentPage++;
            //not empty, means "not reached end",
            yield DashboardTinTucStateSuccess(
                listData: currentState.listData + data, //merge 2 arrays
                hasReachedEnd: false);
          }
        }
      }
    } catch (Exc) {
      print(Exc);
      yield DashboardTinTucStateFailure();
    }
  }
}

class TinTucChiTietBloc extends Bloc<DashboardTinTucEvent,DashboardTinTucState>{
  TinTucDataSource dataSource = GetIt.instance.get<TinTucDataSource>();
  TinTucChiTietBloc():super(null);
  @override
  Stream<DashboardTinTucState> mapEventToState(DashboardTinTucEvent event)async* {
      if(event is DashboardTinTucEventChitietState){
        var data = await dataSource.getTinTucChiTiet(event.tintuc_id);
        var dataList = await dataSource.getTinTucSuKien(null, null,null,'1', '5');
        yield DashboardTinTucChiTietStateSuccess(data,dataList);
      }
  }

}
