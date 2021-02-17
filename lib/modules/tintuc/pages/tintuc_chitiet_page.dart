import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:image_recovery/utils/color_extends.dart';
import 'package:image_recovery/utils/navigations/navigation_datasource.dart';
import 'package:intl/intl.dart';
import '../../../routes.dart';
import '../../../widgets/appbar_custom.dart';
import 'package:sailor/sailor.dart';

import '../../../constants.dart';
import '../tintuc_imports.dart';

final _navigation= GetIt.instance.get<NavigationDataSource>();


class TinTucChiTietPage extends StatefulWidget {
  @override
  _TinTucChiTietPageState createState() => _TinTucChiTietPageState();
}

class _TinTucChiTietPageState extends State<TinTucChiTietPage> {
  double deviceWidth, deviceHeight;
  int countNumber=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;
    final id = Sailor.param<int>(context, 'id');
    countNumber=Sailor.param<int>(context, 'countNumber');
    print(countNumber);

    BlocProvider.of<TinTucChiTietBloc>(context)
        .add(DashboardTinTucEventChitietState(id));

    return BlocBuilder<TinTucChiTietBloc, DashboardTinTucState>(
      builder: (context, state) {
        print('Tin Tuc - Chi tiết view');

        if (state is DashboardTinTucChiTietStateSuccess) {
          return Scaffold(
            appBar: _getCustomAppBar(state.chitiet.tieuDe),
            body: SingleChildScrollView(
              child: Container(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: FadeInImage.assetNetwork(
                          height: 250,
                          placeholder: loadinggif,
                          image:state.chitiet.hinhDaiDien,
                        ),
                      ),
                      Text(
                        state.chitiet.tieuDe,

                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                        textAlign: TextAlign.justify,
                      ),
                      Text(DateFormat("hh:mm dd-MM-yyyy ")
                          .format(state.chitiet.ngayGioPostTin)),
                      _getNews(state.listData == null
                          ? new List<TinTucCongAn_Lst_Result>()
                          : state.listData)
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        return Scaffold(
          appBar: _getCustomAppBar(''),
          body: Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }

  _getCustomAppBar(String title) {
    return PreferredSize(
      preferredSize: Size.fromHeight(heightNavigationBar),
      child: AppBarCustom(
        title: title,
        startColor: navigationBarColorStart,
        endColor: navigationBarColorEnd,
        iconStart: Icons.arrow_back_ios,
        iconCancel: countNumber>=1? Icons.clear:null,
        actionCancel: () {
          if(countNumber>=1){
            while(countNumber>=0){
              _navigation.popNavigation(context);
              countNumber--;
            }
          }
        },
      ),
    );
  }

  ///Tin tức
  _getNews(List<TinTucCongAn_Lst_Result> data) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Tin tức liên quan',
            style: TextStyle(
                color: ColorExtends.fromHex('#333b60'),
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          Container(
            height: data.length > 0 ? deviceHeight * 0.35 : 0,
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: (){
                    Routes.sailor.navigate<bool>(NamePage.tintuc_chitiet.toString(), params: {
                      'id': data[index].id,'countNumber': countNumber+1,
                    });
                  },
                  child: _getItemNews(
                      title: data[index].tieuDe,
                      datetime: data[index].ngayGioPostTin.toString(),
                      srcImage:data[index].hinhDaiDien),
                );
              },
              scrollDirection: Axis.horizontal,
            ),
          )
        ],
      ),
    );
  }

  _getItemNews(
      {@required String srcImage,
      @required String title,
      @required String datetime}) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, right: 10, bottom: 8),
      child: Container(
        width: 200,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(1, 3))
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              flex: 1,
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
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
