
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_recovery/constants.dart';
import 'package:image_recovery/modules/phananhtructuyen/models/loaiphananh_danhmuc_model.dart';
import 'package:image_recovery/modules/phananhtructuyen/models/model.dart';
import 'package:image_recovery/modules/phananhtructuyen/pages/diachi_danhmuc/diachi_danhmuc.dart';
import 'package:image_recovery/modules/phananhtructuyen/pages/linhvuc_hoso_danhmuc/linhvuc_hoso_danhmuc.dart';
import 'package:image_recovery/modules/phananhtructuyen/pages/phananhvipham/phananh_vipham.dart';
import 'package:image_recovery/modules/phananhtructuyen/widgets/widget.dart';
import 'package:image_recovery/utils/color_extends.dart';

class PhanAnhViPhamPage extends StatefulWidget {
  final LoaiViPham loaiViPhamItem;
  final bool isHoSo;
  final GlobalKey<ScaffoldState> scaffoldKey;

  PhanAnhViPhamPage(
      {Key key, this.isHoSo, this.loaiViPhamItem, this.scaffoldKey})
      : super(key: key);

  @override
  PhanAnhViPhamPageState createState() => PhanAnhViPhamPageState();
}

class PhanAnhViPhamPageState extends State<PhanAnhViPhamPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<PhanAnhViPhamCubit, PhanAnhViPhamState>(
      listenWhen: (previous, current) =>
          ((previous.message != current.message &&
                  current.message.isNotEmpty == true) ||
              (current.submitStatus != null &&
                  current.submitStatus != PhanAnhSubmitStatus.none)),
      listener: (context, state) {
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 70.0,
                      ),
                      Expanded(
                        child: Text(
                          widget.loaiViPhamItem.tenLoaiViPham,
                          style: TextStyle(
                              fontSize: 20.0,
                              color: ColorExtends.fromHex("#333b60"),
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.close,
                          ),
                          iconSize: 28.0,
                          color: ColorExtends.fromHex("#333b60"),
                          onPressed: () => Navigator.pop(context))
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  MediaPhanAnhPage(
                    phanAnhContext: context,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  (widget.isHoSo)
                      ? LinhVucHosoDanhMucPage(
                          phanAnhContext: context,
                        )
                      : DiaChiDanhMucPage(
                          phanAnhContext: context,
                        ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 118.0,
                    child: EditableTextInput(
                      (value) => context
                          .bloc<PhanAnhViPhamCubit>()
                          .noiDungPhanAnhChanged(value),
                      "",
                      label: "Nhập nội dung",
                      maxLines: 5,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  (widget.isHoSo)
                      ? Container()
                      : TextInputField(
                          (value) => context
                              .bloc<PhanAnhViPhamCubit>()
                              .thongTinNguoiPhanAnhChanged(value),
                          "",
                          label: "Nhập thông tin liên hệ (Email hoặc SĐT)",
                        ),
                  SizedBox(
                    height: 5,
                  ),
                  RaisedButton(
                    color: button_submit_color,
                    textColor: Colors.white,
                    onPressed: () {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      context.bloc<PhanAnhViPhamCubit>().submitPhanAnhViPham(widget.isHoSo);
                    },
                    child: Container(
                        alignment: Alignment.center,
                        height: 40,
                        width: MediaQuery.of(context).size.height - 20,
                        child: Text(
                          "Gửi",
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        )),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
