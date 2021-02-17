import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:image_recovery/modules/dichvucong/blocs/dichvucong_bloc.dart';
import 'package:image_recovery/modules/dichvucong/blocs/dichvucong_event.dart';
import 'package:image_recovery/modules/dichvucong/blocs/dichvucong_state.dart';
import 'package:image_recovery/modules/dichvucong/models/dichvucong_model.dart';
import 'package:image_recovery/routes.dart';
import 'package:image_recovery/utils/color_extends.dart';
import 'package:image_recovery/utils/navigations/navigation_datasource.dart';

class DichVuCongTTHCThuTuc extends StatefulWidget {
  final String keyword;
  final String maLinhVuc;

  const DichVuCongTTHCThuTuc({Key key, this.maLinhVuc, this.keyword})
      : super(key: key);

  @override
  _DichVuCongTTHCThuTucState createState() => _DichVuCongTTHCThuTucState();
}

class _DichVuCongTTHCThuTucState extends State<DichVuCongTTHCThuTuc> {
  final _scrollController = ScrollController();
  final _scrollThreadhold = 5.0;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      final maxScrollExtent = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;
      if (maxScrollExtent - currentScroll <= _scrollThreadhold) {
        //scroll to the end of 1 page
        print("_scrollController");
        BlocProvider.of<DichVuCongBloc_ThuTuc>(context)
          ..add(DichVuCongEventGetDMThuTuc(
              maLinhVuc: widget.maLinhVuc, keySearch: widget.keyword));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<DVC_ThuTuc> lstData = [];

    return BlocBuilder<DichVuCongBloc_ThuTuc, DichVuCongState>(
      builder: (context, state) {
        if (state is DichVuCongStateInitial) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is DichVuCongStateFailure) {
          return Center(
            child: Text(
              'Cannot load comments from Server',
              style: TextStyle(fontSize: 22, color: Colors.red),
            ),
          );
        }
        if (state is DichVuCongStateSuccessfulThuTuc &&
            state.listData.length > 0) {
          lstData = state.listData;
          for (var item in lstData) {
            print(item);
          }
          return Container(
            padding: EdgeInsets.only(top: 10),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
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
                  return BuilderItem(lstData[index]);
                }
              },
              itemCount: state.hasReachedEnd
                  ? state.listData.length
                  : state.listData.length + 1, //add more item
              controller: _scrollController,
            ),
          );
        } else {
          return Center(child: Text('Không có dữ liệu !'));
        }
      },
    );
  }

  Widget BuilderItem(DVC_ThuTuc data) {
    return Container(
      margin: EdgeInsets.only(bottom: 15, left: 15, right: 15),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
                color: Colors.grey[300],
                blurRadius: 5,
                spreadRadius: 1,
                offset: Offset(1.0, 3.0))
          ]),
      child: GestureDetector(
        onTap: () {
          GetIt.instance<NavigationDataSource>().pushNavigation(
              NamePage.dichvucong_tthc_chitiet_page,
              params: {"thuTucID": data.thuTucID.toString(),
              "linhVucID":data.linhVucID.toString()});
        },
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.tenThuTuc,
                    style: TextStyle(
                        color: ColorExtends.fromHex("#303444"),
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        data.tenLinhVuc,
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
//                      SizedBox(
//                        width: 10,
//                      ),
//                      Text(
//                        "Mức độ ${data.thuTuThuTuc}",
//                        style:
//                            TextStyle(color: ColorExtends.fromHex("#079bd2")),
//                      )
                    ],
                  )
                ],
              ),
            ),
            Icon(
              Icons.navigate_next,
              color: Colors.grey[500],
            )
          ],
        ),
      ),
    );
  }
}
