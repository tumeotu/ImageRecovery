import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../../utils/navigations/navigation_datasource.dart';
import 'package:intl/intl.dart';

import '../../../constants.dart';
import '../../../routes.dart';
import '../tintuc_imports.dart';


final _navigation= GetIt.instance.get<NavigationDataSource>();


class Search extends SearchDelegate {
  final DashboardTinTucBlocList contextBloc;
  List<String> recentList = [];
  String selectedResult = "";

  Search(this.contextBloc);

  @override ThemeData appBarTheme(BuildContext context) {
    // TODO: implement appBarTheme
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    assert(theme != null);
    return theme.copyWith(
    inputDecorationTheme: InputDecorationTheme(hintStyle: TextStyle(color: theme.primaryTextTheme.headline5.color)),
    textTheme: theme.textTheme.copyWith(
    headline5: theme.textTheme.headline5.copyWith(color: theme.primaryTextTheme.headline5.color),
    headline6: TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.normal,
      fontSize: 20
    ),
    )
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        this.contextBloc.add(DashboardTinTucEventResetState());
        this.contextBloc.add(DashboardTinTucEventGetListData());
//        Navigator.of(context).pop();
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {

    if (query.isNotEmpty&&checkRecentList(query)) recentList.add(query);
    print('buildResults: '+query);
    return ListTinTucViewSearch(
        keySearch: query, contextBlocl: this.contextBloc);
  }

  bool checkRecentList(String value)
  {
    for(var item in recentList){
      if(item==value){
        return false;
      }
    }
    return true;
  }


  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestionList = [];
    query.isEmpty
        ? suggestionList = recentList //In the true case
        : suggestionList.addAll(recentList?.where(
            // In the false case
            (element) => element.contains(query),
          ));

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            suggestionList[index],
          ),
          leading: query.isEmpty ? Icon(Icons.access_time) : SizedBox(),
          onTap: () {
            query = suggestionList[index];
            showResults(context);
          },
        );
      },
    );
  }
}

class ListTinTucViewSearch extends StatefulWidget {
  final keySearch;
  final Bloc<DashboardTinTucEvent, DashboardTinTucState> contextBlocl;

  const ListTinTucViewSearch({Key key, this.keySearch, this.contextBlocl})
      : super(key: key);

  @override
  _ListTinTucViewSearch createState() => _ListTinTucViewSearch();
}

class _ListTinTucViewSearch extends State<ListTinTucViewSearch> {
  final _scrollController = ScrollController();
  final _scrollThreadhold = 5.0;

  _ListTinTucViewSearch();

  double deviceWidth, deviceHeight;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('initState - ListTinTucViewSearch');
    widget.contextBlocl.add(DashboardTinTucEventResetState());

    widget.contextBlocl.add(DashboardTinTucEventGetListData(keysearch: widget.keySearch));
    _scrollController.addListener(() {
      final maxScrollExtent = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;
      if (maxScrollExtent - currentScroll <= _scrollThreadhold) {
        //scroll to the end of 1 page
        widget.contextBlocl.add(DashboardTinTucEventGetListData(keysearch: widget.keySearch));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;

    return BlocBuilder(
      cubit: widget.contextBlocl,
      builder: (context, state) {
        return _getListViewTinTuc(state);
      },
    );
  }

  _getListViewTinTuc(final state) {
    if (state is DashboardTinTucStateInitial) {
      return Center(child: CircularProgressIndicator());
    }
    if (state is DashboardTinTucStateFailure) {
      return Center(
        child: Text(
          'Cannot load comments from Server',
          style: TextStyle(fontSize: 22, color: Colors.red),
        ),
      );
    }
    if (state is DashboardTinTucStateSuccess) {
      if (state.listData.isEmpty) {
        return Center(child: Text('Không có dữ liệu !'));
      }
      return ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          if (index >= state.listData.length) {
            return Container(
              alignment: Alignment.center,
              child: Center(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(
                    strokeWidth: 1.5,
                  ),
                ),
              ),
            );
          } else {
            return GestureDetector(
              onTap: (){
                _navigation.pushNavigation(NamePage.tintuc_chitiet,params: {
                  'id': state.listData[index].id,
                });
//                Routes.sailor.navigate<bool>(NamePage.tintuc_chitiet.toString(), params: {
//                  'id': state.listData[index].id,
//                });
              },
              child: _getItemlistTinTuc(
                  srcImage:"",
                  title: state.listData[index].tieuDe,
                  datetime: DateFormat("hh:mm dd-MM-yyyy ").format(state.listData[index].ngayGioPostTin)),
            );
          }
        },
        itemCount: state.hasReachedEnd
            ? state.listData.length
            : state.listData.length + 1, //add more item
        controller: _scrollController,
      );
    } else {
      return Center(child: Text('Không có dữ liệu !'));
    }
  }

  _getItemlistTinTuc(
      {@required String srcImage,
      @required String title,
      @required String datetime}) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  height: deviceHeight * 0.15,
                  width: deviceWidth * 0.35,
                  child: Container(
                    constraints: BoxConstraints(minWidth: deviceWidth),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10))),
                    child: FadeInImage.assetNetwork(
                      placeholder:loadinggif,
                      image: srcImage,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 5),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            title,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Row(
                            children: [
                              Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 8, 8, 8),
                                  child: Icon(Icons.calendar_today,
                                      color: Colors.grey)),
                              Text(datetime),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: SizedBox(
                width: deviceWidth,
                height: 1,
                child: Container(
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }
}
