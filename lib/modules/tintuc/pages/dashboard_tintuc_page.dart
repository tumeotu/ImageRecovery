
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../../utils/navigations/navigation_datasource.dart';
import 'package:intl/intl.dart';
import '../../../constants.dart';
import '../../../routes.dart';
import '../../../utils/color_extends.dart';
import '../../../widgets/appbar_custom.dart';

import '../../tintuc/tintuc_imports.dart';
import 'search_view.dart';

final _navigation = GetIt.instance.get<NavigationDataSource>();

class DashboardTinTuc extends StatefulWidget {
  final List<String> list = List.generate(10, (index) => "Text $index");

  @override
  _DashboardTinTucState createState() => _DashboardTinTucState();
}

class _DashboardTinTucState extends State<DashboardTinTuc> {
  DashboardTinTucBloc _dashboardTinTucBloc;
  double deviceWidth, deviceHeight;
  final Color navigationBarColorStart = ColorExtends.fromHex('#4184d3');
  final Color navigationBarColorEnd = ColorExtends.fromHex('#4fc4dd');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dashboardTinTucBloc = BlocProvider.of(context);
    _dashboardTinTucBloc..add(DashboardTinTucEventListSlider());
  }

  @override
  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: _getCustomAppBar(),
      body: SafeArea(
        child: ListTinTuc(deviceWidth: deviceWidth, deviceHeight: deviceHeight),
      ),
    );
  }

  _getCustomAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(heightNavigationBar),
      child: AppBarCustom(
        title: "Tin tức",
        startColor: navigationBarColorStart,
        endColor: navigationBarColorEnd,
        iconEnd: ImageIcon(
          AssetImage("images/tintuc_timkiem_icon.png"),
        ),
        actionLightIcon: () {
          BlocProvider.of<DashboardTinTucBlocList>(context)
              .add(DashboardTinTucEventResetState());
          showSearch(
              context: context,
              delegate:
                  Search(BlocProvider.of<DashboardTinTucBlocList>(context)));
        },
      ),
    );
  }
}

class SliderWedget extends StatefulWidget {
  final deviceWidth;
  final deviceHeight;

  const SliderWedget({Key key, this.deviceWidth, this.deviceHeight})
      : super(key: key);

  @override
  _SliderWedgetState createState() =>
      _SliderWedgetState(deviceWidth, deviceHeight);
}

class _SliderWedgetState extends State<SliderWedget> {
  final deviceWidth;
  final deviceHeight;

  _SliderWedgetState(this.deviceWidth, this.deviceHeight);

  @override
  Widget build(BuildContext context) {
    List<TinTucCongAn_Lst_Result> listTT = new List<TinTucCongAn_Lst_Result>();

    return BlocBuilder<DashboardTinTucBloc, DashboardTinTucState>(
      builder: (context, state) {
        double _position = 0.0;
        if (state is DashboardTinTucStatePageChange) {
          _position = double.parse(state.index?.toString());
          listTT = state.listData;
        }
        return _getSlider(listTT, _position);
      },
    );
  }

  _getSlider(List<TinTucCongAn_Lst_Result> listTT, double _position) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 10),
          child: Text(
            'Tin mới hôm nay',
            style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
          ),
        ),
      ],
    );
  }

  _getItemSliderNews(
      {@required String srcImage,
      @required String title,
      @required String datetime}) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, right: 10, bottom: 8),
      child: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(1, 3))
        ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10))),
                  child: FadeInImage.assetNetwork(
                    placeholder: loadinggif,
                    image: srcImage,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ColorExtends.fromHex('#333b60')),
                    ),
                    Text(
                      datetime,
                      style: TextStyle(fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ListTinTuc extends StatefulWidget {
  final deviceWidth;
  final deviceHeight;

  const ListTinTuc({Key key, this.deviceWidth, this.deviceHeight})
      : super(key: key);

  @override
  _ListTinTucState createState() => _ListTinTucState(deviceWidth, deviceHeight);
}

class _ListTinTucState extends State<ListTinTuc> {
  final deviceWidth;
  final deviceHeight;

  final _scrollController = ScrollController();
  final _scrollThreadhold = 5.0;
  DashboardTinTucBlocList _dashboardTinTucBlocList;

  _ListTinTucState(this.deviceWidth, this.deviceHeight);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dashboardTinTucBlocList = BlocProvider.of(context);
    _dashboardTinTucBlocList.add(DashboardTinTucEventGetListData());
    _scrollController.addListener(() {
      final maxScrollExtent = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;
      if (maxScrollExtent - currentScroll <= _scrollThreadhold) {
        //scroll to the end of 1 page
        _dashboardTinTucBlocList.add(DashboardTinTucEventGetListData());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardTinTucBlocList, DashboardTinTucState>(
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
      if (state.listData == null || state.listData.isEmpty) {
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
            if (index == 0) {
              return SliderWedget(
                  deviceWidth: deviceWidth, deviceHeight: deviceHeight);
            } else {
              return GestureDetector(
                child: _getItemlistTinTuc(
                    srcImage:"",
                    title: state.listData[index - 1].tieuDe,
                    datetime: DateFormat("hh:mm dd-MM-yyyy ")
                        .format(state.listData[index - 1].ngayGioPostTin)),
                onTap: () {
                  _ontap(state.listData[index - 1]);
                },
              );
            }
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

  _ontap(TinTucCongAn_Lst_Result state) async {
    var result = await _navigation
        .pushNavigation<String>(NamePage.tintuc_chitiet, params: {
      'id': state.id,
    });
    print('result - $result');
//    Routes.sailor.navigate<bool>(NamePage.tintuc_chitiet.toString(), params: {
//      'id': state.id,
//    });
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
                Expanded(
                  child: Container(
                    child: Container(
                      constraints: BoxConstraints(minWidth: deviceWidth),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10))),
                      child: FadeInImage.assetNetwork(
                        placeholder: loadinggif,
                        image: srcImage,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
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
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
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
