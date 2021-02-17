import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_recovery/constants.dart';
import 'package:image_recovery/modules/phananhtructuyen/models/phananh_tracuu_model.dart';
import 'package:image_recovery/widgets/widget.dart';
import 'package:intl/intl.dart';

class PhanAnhItemTraCuuWidget extends StatefulWidget {
  final PhanAnhTraCuuResult phanAnhItem;

  const PhanAnhItemTraCuuWidget({this.phanAnhItem});

  @override
  PhanAnhItemTraCuuWidgetState createState() => PhanAnhItemTraCuuWidgetState();
}

class PhanAnhItemTraCuuWidgetState extends State<PhanAnhItemTraCuuWidget> {
  PhanAnhTraCuuResult phanAnhItem;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    phanAnhItem = widget.phanAnhItem;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffffffff),
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _NoiDungPhanAnh(this.phanAnhItem),
          _NoiDungXuLy(this.phanAnhItem)
        ],
      ),
    );
  }
}

class _NoiDungPhanAnh extends StatelessWidget {
  final PhanAnhTraCuuResult phanAnhItem;

  const _NoiDungPhanAnh(this.phanAnhItem);

  @override
  Widget build(BuildContext context) {
    var widthScreen = MediaQuery.of(context).size.width;
    Widget imagePhanAnh;
    String imageUrl =  phanAnhItem.urL1;
    String typeImagePhanAnh = phanAnhItem.urL1.split('.').last;
    if (typeImagePhanAnh != "mp4") {
      imagePhanAnh = FadeInImage.assetNetwork(
        placeholder: loadinggif,
        image: imageUrl,
        height: 150,
        width: widthScreen - 20,
        fit: BoxFit.fill,
      );
    } else {
      imagePhanAnh = Image(
          height: (widthScreen - 20),
          width: widthScreen - 20,
          image: AssetImage(video_default_image),
          fit: BoxFit.fitHeight);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          phanAnhItem.tenLoaiPhanAnh,
          style: TextStyle(color: Color(0xffec4033), fontSize: 18),
        ),
        Text(
          DateFormat("HH:mm - dd-MM-yyyy").format(phanAnhItem.thoiGianPhanAnh),
          style: TextStyle(color: Color(0xff9fabb1), fontSize: 15),
        ),
        SizedBox(
          height: 10,
        ),
        imagePhanAnh,
        SizedBox(
          height: 10,
        ),
        Text(phanAnhItem.viTri,
            style: TextStyle(color: Color(0xff0d3178), fontSize: 15)),
        SizedBox(
          height: 10,
        ),
        ExpandableText(phanAnhItem.noiDungPhanAnh,
            trimLines: 3,
            textStyle: TextStyle(color: Color(0xff303444), fontSize: 15)),
      ],
    );
  }
}

class _NoiDungXuLy extends StatelessWidget {
  final PhanAnhTraCuuResult phanAnhItem;

  const _NoiDungXuLy(this.phanAnhItem);

  @override
  Widget build(BuildContext context) {
    var widthScreen = MediaQuery.of(context).size.width;
    Widget bienBanWidget, quyetDinhWidget, xuLyWidget;

    //check xử lý
    if (this.phanAnhItem.noiDungBaoCaoSauXL.isNotEmpty) {
      xuLyWidget = Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Text(phanAnhItem.tenNguoiBaoCao,
                        style: TextStyle(
                            color: Color(0xff1f274a), fontSize: 18.0))),
                SizedBox(
                  width: 5.0,
                ),
                Transform.rotate(
                  angle: 40 * pi / 180,
                  child: Transform(
                      alignment: Alignment.bottomCenter,
                      transform: Matrix4.rotationY(pi),
                      child: Icon(
                        Icons.attach_file,
                        color: Color(0xff9fabb1),
                        size: 25,
                      )),
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            ExpandableText(phanAnhItem.noiDungBaoCaoSauXL,
                trimLines: 3,
                textStyle: TextStyle(color: Color(0xff303444), fontSize: 15.0)),
          ],
        ),
      );
    } else {
      xuLyWidget = Container();
    }

    // check biên bản
    if (this.phanAnhItem.sobb.isNotEmpty) {
      bienBanWidget = Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (this.phanAnhItem.noiDungBaoCaoSauXL.isNotEmpty) ? Divider() : Container(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Số biên bản: ${phanAnhItem.sobb}",
                      style:
                          TextStyle(color: Color(0xff1f274a), fontSize: 18.0),
                    ),
                    Text(
                      DateFormat("dd-MM-yyyy").format(phanAnhItem.ngayLapBB),
                      style:
                          TextStyle(color: Color(0xff9fabb1), fontSize: 15.0),
                    ),
                  ],
                )),
                SizedBox(
                  width: 5.0,
                ),
                Transform.rotate(
                  angle: 40 * pi / 180,
                  child: Transform(
                      alignment: Alignment.bottomCenter,
                      transform: Matrix4.rotationY(pi),
                      child: Icon(
                        Icons.attach_file,
                        color: Color(0xff9fabb1),
                        size: 25,
                      )),
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            ExpandableText(phanAnhItem.noiDungXLBB,
                trimLines: 3,
                textStyle: TextStyle(color: Color(0xff303444), fontSize: 15.0)),
          ],
        ),
      );
    } else {
      bienBanWidget = Container();
    }

    //check quyết định
    if (this.phanAnhItem.soqd.isNotEmpty) {
      quyetDinhWidget = Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (this.phanAnhItem.sobb.isNotEmpty || this.phanAnhItem.noiDungBaoCaoSauXL.isNotEmpty) ? Divider() : Container(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Số quyết định: ${phanAnhItem.soqd}",
                        style: TextStyle(
                            color: Color(0xff1f274a), fontSize: 18.0)),
                    Text(
                      DateFormat("dd-MM-yyyy").format(phanAnhItem.ngayLapQD),
                      style:
                          TextStyle(color: Color(0xff9fabb1), fontSize: 15.0),
                    ),
                  ],
                )),
                SizedBox(
                  width: 5.0,
                ),
                Transform.rotate(
                  angle: 40 * pi / 180,
                  child: Transform(
                      alignment: Alignment.bottomCenter,
                      transform: Matrix4.rotationY(pi),
                      child: Icon(
                        Icons.attach_file,
                        color: Color(0xff9fabb1),
                        size: 25,
                      )),
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            ExpandableText(phanAnhItem.noiDungXLQD,
                trimLines: 3,
                textStyle: TextStyle(color: Color(0xff303444), fontSize: 15.0)),
          ],
        ),
      );
    } else {
      quyetDinhWidget = Container();
    }

    if (this.phanAnhItem.noiDungBaoCaoSauXL.isEmpty &&
        this.phanAnhItem.sobb.isEmpty &&
        this.phanAnhItem.soqd.isEmpty) {
      return Container();
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            width: widthScreen - 20,
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(2)),
                border: Border.all(color: const Color(0xffccd5d8), width: 1),
                color: const Color(0xffffffff)),
            child: Column(
              children: [xuLyWidget, bienBanWidget, quyetDinhWidget],
            ),
          ),
        ],
      );
    }
  }
}
