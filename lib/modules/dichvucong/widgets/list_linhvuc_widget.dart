import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_recovery/modules/dichvucong/blocs/dichvucong_bloc.dart';
import 'package:image_recovery/modules/dichvucong/blocs/dichvucong_event.dart';
import 'package:image_recovery/modules/dichvucong/blocs/dichvucong_state.dart';
import 'package:image_recovery/modules/dichvucong/models/dichvucong_model.dart';
import 'package:image_recovery/utils/color_extends.dart';

class DichVuCongTTHCLinhVuc extends StatefulWidget {
  final String keyword;

  const DichVuCongTTHCLinhVuc(
      {Key key, this.keyword})
      : super(key: key);

  @override
  _DichVuCongTTHCLinhVucState createState() => _DichVuCongTTHCLinhVucState();
}

class _DichVuCongTTHCLinhVucState extends State<DichVuCongTTHCLinhVuc> {
  List<DVC_LinhVuc> lstData = [];
  DVC_LinhVuc selectedDVCLinhVuc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<DichVuCongBloc_LinhVuc>(context)..add(DichVuCongEventGetDMLinhVuc());
    lstData = [];
    lstData.add(new DVC_LinhVuc(
        linhVucID: 0,
        tenLinhVuc: "Tất cả lĩnh vực",
        maLinhVuc: "0",
        tenLVRutGon: "TCLV"));
    selectedDVCLinhVuc = lstData[0];
    BlocProvider.of<DichVuCongBloc_ThuTuc>(context)
      ..add(DichVuCongEventGetDMThuTuc(
          maLinhVuc: selectedDVCLinhVuc.maLinhVuc,
          keySearch: widget.keyword));
  }

  @override
  Widget build(BuildContext context) {
    print('DichVuCongTTHCLinhVuc');

    return BlocBuilder<DichVuCongBloc_LinhVuc,DichVuCongState>(
      builder: (context, state) {
        if (state is DichVuCongStateSuccessfulLinhVuc) {
//          if(lstData.length>1)
//            {
//              lstData=[];
//              lstData.add(new DVC_LinhVuc(
//                  linhVucID: 0,
//                  tenLinhVuc: "Tất cả lĩnh vực",
//                  maLinhVuc: "0",
//                  tenLVRutGon: "TCLV"));
//            }

          if (lstData.length <= 1) lstData.addAll(state.listData);
        }
        if (state is DichVuCongStateSuccessfulLinhVucItemSelected) {
          selectedDVCLinhVuc = state.itemSelected;
          BlocProvider.of<DichVuCongBloc_ThuTuc>(context)..add(DichVuCongEventGetDMThuTucReset());
          print(selectedDVCLinhVuc.tenLinhVuc);
          BlocProvider.of<DichVuCongBloc_ThuTuc>(context)
            ..add(DichVuCongEventGetDMThuTuc(
                maLinhVuc: selectedDVCLinhVuc.maLinhVuc,
                keySearch: widget.keyword));
        }

        return Container(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: DanhMucLinhVuc(lstData)),
          ),
        );
      },
    );
  }

  List<Widget> DanhMucLinhVuc(List<DVC_LinhVuc> datas) {
    List<Widget> lstWidget = [];
    for (var item in datas) {
      lstWidget.add(BuilderWidget(item));
    }
    return lstWidget;
  }

  Widget BuilderWidget(DVC_LinhVuc data) {
    return GestureDetector(
      onTap: () {
//        setState(() {
//          selected = data;
//          print (selected.tenLinhVuc);
//
//        });
        int _index=lstData.indexOf(data);
        BlocProvider.of<DichVuCongBloc_LinhVuc>(context)..add(DichVuCongEventGetDMLinhVucSelectedItem(data,_index));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              width: 50,
              height: 50,
              padding: EdgeInsets.all(10),
              child: getIconLinhVuc(data.tenLVRutGon) == data.tenLVRutGon
                  ? Text(
                      data.tenLVRutGon == null ? "" : data.tenLVRutGon,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: selectedDVCLinhVuc == data
                            ? Colors.white
                            : ColorExtends.fromHex("#9fabb1"),
                      ),
                    )
                  : ImageIcon(
                      AssetImage(getIconLinhVuc(data.tenLVRutGon)),
                      color: selectedDVCLinhVuc == data
                          ? Colors.white
                          : ColorExtends.fromHex("#9fabb1"),
                    ),
              decoration: BoxDecoration(
                  color: selectedDVCLinhVuc == data
                      ? ColorExtends.fromHex("#079bd2")
                      : ColorExtends.fromHex("#eff2f3"),
                  borderRadius: BorderRadius.circular(50)),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              width: 60,
              child: Text(
                data.tenLinhVuc,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: selectedDVCLinhVuc == data
                      ? ColorExtends.fromHex("#079bd2")
                      : ColorExtends.fromHex("#9fabb1"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  String getIconLinhVuc(String tenRutGon) {
    switch (tenRutGon) {
      case "TCLV":
        return "images/dichvucong/start_danhsachthutuc.png";
      case "LVDT":
        return "images/dichvucong/lvdt_danhsachthutuc.png";
      default:
        return tenRutGon;
    }
  }
}
