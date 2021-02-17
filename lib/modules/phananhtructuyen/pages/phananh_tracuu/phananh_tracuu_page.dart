import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_recovery/constants.dart';
import 'package:image_recovery/modules/phananhtructuyen/models/loaiphananh_danhmuc_model.dart';
import 'package:image_recovery/modules/phananhtructuyen/models/phananh_tracuu_model.dart';
import 'package:image_recovery/modules/phananhtructuyen/pages/phananh_tracuu/phananh_tracuu.dart';
import 'package:image_recovery/modules/phananhtructuyen/widgets/progress_loading.dart';
import 'package:image_recovery/modules/phananhtructuyen/widgets/widget.dart';
import 'package:image_recovery/pages/loading_page.dart';
import 'package:image_recovery/widgets/appbar_custom.dart';

class PhanAnhTraCuuPage extends StatefulWidget {
  @override
  PhanAnhTraCuuPageState createState() => PhanAnhTraCuuPageState();
}

class PhanAnhTraCuuPageState extends State<PhanAnhTraCuuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(heightNavigationBar),
          child: AppBarCustom(
            title: "TRA CỨU VI PHẠM ĐÃ XỬ LÝ",
            startColor: navigationBarColorStart,
            endColor: navigationBarColorEnd,
            iconStart: Icons.arrow_back_ios,
            iconEnd: Icon(Icons.filter_list),
          ),
        ),
        body: _ListTraCuu());
  }
}

class _ListTraCuu extends StatefulWidget {
  @override
  _ListTraCuuState createState() => _ListTraCuuState();
}

class _ListTraCuuState extends State<_ListTraCuu> {
  final _scrollController = ScrollController();
  final _scrollThreadhold = 5.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      final maxScrollExtent = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;
      if (maxScrollExtent - currentScroll <= _scrollThreadhold) {
        //scroll to the end of 1 page
        BlocProvider.of<PhanAnhTraCuuBloc>(context)
          ..add(PhanAnhTraCuuEventGetListDataFilter());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<LoaiPhanAnhDM> loaiPhanAnhDMs;
    List<PhanAnhTraCuuResult> phanAnhTraCuus;
    int loaiPhanAnhID;
    bool isLoading = false;
    return BlocBuilder<PhanAnhTraCuuBloc, PhanAnhTraCuuState>(
      builder: (context, state) {
        if (state is PhanAnhTraCuuStateInitial) {
          return ProgressLoading();
        } else if (state is PhanAnhTraCuuStateSuccess) {
          loaiPhanAnhDMs = state.loaiPhanAnhDMs;
          phanAnhTraCuus = state.phanAnhTraCuus;
          isLoading = state.isLoading;
          loaiPhanAnhID = state.loaiPhanAnhID;
        }
        return Stack(
          children: [
            ListView.builder(
                controller: _scrollController,
                itemCount:
                    (phanAnhTraCuus != null) ? phanAnhTraCuus.length + 1 : 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 10.0),
                      child: _LoaiPhanAnhDMWidget(
                          loaiPhanAnhDMs: loaiPhanAnhDMs,
                          loaiPhanAnhID: loaiPhanAnhID),
                    );
                  } else {
                    var item = phanAnhTraCuus?.elementAt(index - 1);
                    if (item != null) {
                      return Container(
                          margin: EdgeInsets.only(bottom: 10.0),
                          child: PhanAnhItemTraCuuWidget(
                            phanAnhItem: phanAnhTraCuus.elementAt(index - 1),
                          ));
                    } else {
                      return Container();
                    }
                  }
                }),
            Visibility(
              visible: (isLoading == true) ? true : false,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 30,
                  color: Colors.green,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: 15,
                          height: 15,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.0,
                            backgroundColor: Colors.white,
                            semanticsLabel: "ss",
                          )),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        "Đang tải dữ liệu",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}

class _LoaiPhanAnhDMWidget extends StatelessWidget {
  final List<LoaiPhanAnhDM> loaiPhanAnhDMs;
  final int loaiPhanAnhID;

  const _LoaiPhanAnhDMWidget({this.loaiPhanAnhDMs, this.loaiPhanAnhID});

  @override
  Widget build(BuildContext context) {
    if (loaiPhanAnhDMs == null) {
      return Container();
    }

    return Container(
      height: 60.0,
      color: const Color(0xffffffff),
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
      child: ListView.builder(
          itemCount: loaiPhanAnhDMs.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () => BlocProvider.of<PhanAnhTraCuuBloc>(context)
                ..add(PhanAnhTraCuuEventGetListDataFilter(
                    pageIndex: 1,
                    isClear: true,
                    loaiPhanAnhID:
                        loaiPhanAnhDMs.elementAt(index).loaiPhanAnhID)),
              child: Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(18)),
                    border: Border.all(
                        color: (loaiPhanAnhID ==
                                loaiPhanAnhDMs.elementAt(index).loaiPhanAnhID)
                            ? Color(0xff1f274a)
                            : Colors.transparent,
                        width: 1),
                    color: const Color(0xffffffff)),
                child: Text(
                  loaiPhanAnhDMs.elementAt(index).tenLoaiPhanAnh,
                  style: TextStyle(
                    color: const Color(0xff1f274a),
                    fontSize: 16.0,
                  ),
                ),
              ),
            );
          }),
    );
  }
}
