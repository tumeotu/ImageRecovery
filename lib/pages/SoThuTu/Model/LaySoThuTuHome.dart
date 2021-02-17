import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:image_recovery/constants.dart';
import 'package:image_recovery/modules/phananhtructuyen/widgets/progress_loading.dart';
import 'package:image_recovery/pages/SoThuTu/Model/bloc/LaySoThuTuBloc.dart';
import 'package:image_recovery/pages/SoThuTu/Model/event/LaySoThuTuEvent.dart';
import 'package:image_recovery/pages/SoThuTu/Model/model/sothutu.dart';
import 'package:image_recovery/pages/SoThuTu/Model/state/LaySoThuTuState.dart';
import 'package:image_recovery/widgets/appbar_custom.dart';

class LaySoThuTuHome extends StatefulWidget {
  @override
  _LaySoThuTuHomeState createState() => _LaySoThuTuHomeState();
}

class _LaySoThuTuHomeState extends State<LaySoThuTuHome> {
  String Usermame;
  String Password;
  Phieu SelectedPhieu;
  List<Phieu> datas;

  @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  void LaySoThuTu(int index) {
    print("CLICK");
    BlocProvider.of<LaySoThuTuBloc>(context)
      ..add(
          LayThuTuEventPost(datas[index].ten, datas[index].idx, "0356132121"));
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: _getCustomAppBar(),
        body: SafeArea(
          child: _getCustomBody(),
        ),
      ),
    );
  }
  _getCustomAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(heightNavigationBar),
      child: AppBarCustom(
        title: 'LẤY SỐ THỨ TỰ',
        startColor: navigationBarColorStart,
        endColor: navigationBarColorEnd,
        iconStart: Icons.arrow_back_ios,
      ),
    );
  }
  _getCustomBody() {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    return BlocListener<LaySoThuTuBloc, LaySoThuTuState>(
        listener: (context, state) {
      var TrangThai = '';
      var Message = '';
      if (state is LaySoThuTuMainStateFailure) {
        TrangThai = "Lỗi";
        Message = 'Xin thử lại';
      }
      if (state is LaySoThuTuPostSuccess) {
        if (state.response.isSuccess == true) {
          print("TRUE");
          TrangThai = "Lấy số thành công";
          Message = 'Cảm ơn Ông/Bà đã xử dụng dịch vụ lấy số online';
        } else {
          TrangThai = "Lấy số thất bại";
          Message = state.response.thongBao;
        }
      }
      showGeneralDialog(
          barrierColor: Colors.black.withOpacity(0.5),
          transitionBuilder: (context, a1, a2, widget) {
            final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
            return Transform(
              transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
              child: Opacity(
                opacity: a1.value,
                child: AlertDialog(
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0)),
                  content: Builder(
                    builder: (context) {
                      // Get available height and width of the build area of this widget. Make a choice depending on the size.
                      var height = MediaQuery.of(context).size.height;
                      var width = MediaQuery.of(context).size.width;
                      return Wrap(
                        children: [
                          new Column(
                            children: <Widget>[
                              new Text(TrangThai,
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                      color: Color(0xff079bd2))),
                              new Padding(padding: EdgeInsets.only(top: 10.0)),
                              Text(Message,
                                  style: const TextStyle(
                                      color: const Color(0xff768992),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "Roboto",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 13.0),
                                  textAlign: TextAlign.center),
                              new Padding(padding: EdgeInsets.only(top: 20.0)),
                              FlatButton(
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(8.0)),
                                color: Color(0xff079bd2),
                                onPressed: () => {Navigator.of(context).pop()},
                                padding: new EdgeInsets.only(
                                    left: 80, right: 80, top: 10, bottom: 10),
                                child: Text(
                                  'Đóng',
                                  style: new TextStyle(
                                      fontSize: 25, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            );
          },
          transitionDuration: Duration(milliseconds: 700),
          barrierDismissible: false,
          barrierLabel: '',
          context: context,
          pageBuilder: (context, animation1, animation2) {});
    }, child: BlocBuilder<LaySoThuTuBloc, LaySoThuTuState>(
      builder: (context, state) {
        var listPhieu = new List<Phieu>();
        if (state is LaySoThuTuMainStateInitial) {
          return ProgressLoading();
        }
        else if(state is LaySoThuTuPostSuccess){
          if (state.data != null) {
            datas = state.data;
            listPhieu = state.data;
          }
        }
        return SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: new EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 0, left: 10),
                    child: Text(
                      'Chú ý: mỗi cá nhân được lấy 1 số giao dịch trên'
                          ' ứng dụng trong một buổi, tại một quầy,'
                          ' trong giờ hành chính.',
                      style: new TextStyle(fontSize: 15, color: Colors.red),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height - 150,
                    child: AnimationLimiter(
                      child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, childAspectRatio: (0.4)/(itemWidth / itemHeight)),
                          controller:
                          new ScrollController(keepScrollOffset: false),
                          shrinkWrap: true,
                          itemCount: listPhieu.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (BuildContext context, int index) {
                            return AnimationConfiguration.staggeredGrid(
                              columnCount: 2,
                              position: index,
                              duration: Duration(milliseconds: 1000),
                              child: ScaleAnimation(
                                scale: 0.5,
                                child: FadeInAnimation(
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        left: 5, top: 10, right: 5, bottom: 0),
                                    height: double.infinity,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          topRight: Radius.circular(8),
                                          bottomLeft: Radius.circular(8),
                                          bottomRight: Radius.circular(8)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.04),
                                          spreadRadius: 0.05,
                                          blurRadius: 0,
                                          offset: Offset(
                                              0, 2), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Card(
                                      shape: new RoundedRectangleBorder(
                                          borderRadius: new BorderRadius.circular(8.0)),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 5, right: 5, top: 10),
                                            child: Text(
                                              datas[index].ten,
                                              style: new TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xff333b60)),
                                            ),
                                          ),
                                          Column(
                                            children: <Widget>[
                                              new Container(
                                                width: 100,
                                                alignment: Alignment.center,
                                                margin: const EdgeInsets.only(top: 10),
                                                padding: const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    border:
                                                    Border.all(color: Colors.grey),
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(
                                                            5.0) //         <--- border radius here
                                                    )),
                                                child: Text(
                                                  datas[index].sott.toString(),
                                                  style: new TextStyle(
                                                      fontSize: 25,
                                                      color: Color(0xff333b60),
                                                      fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                              new Padding(
                                                  padding: EdgeInsets.only(top: 10.0)),
                                              ConstrainedBox(
                                                constraints: const BoxConstraints(
                                                    minWidth: double.infinity),
                                                child: FlatButton(
                                                  shape: new RoundedRectangleBorder(
                                                      borderRadius:
                                                      new BorderRadius.circular(
                                                          8.0)),
                                                  color: Color(0xff079bd2),
                                                  onPressed: () => LaySoThuTu(index),
                                                  padding: new EdgeInsets.all(13),
                                                  child: Text(
                                                    'Lấy số',
                                                    style: new TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );

                          }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ));
  }
}
