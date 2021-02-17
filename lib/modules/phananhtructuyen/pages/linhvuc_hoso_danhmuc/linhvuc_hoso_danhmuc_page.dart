import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_recovery/constants.dart';
import 'package:image_recovery/modules/phananhtructuyen/models/linhvuc_hoso_danhmuc_model.dart';
import 'package:image_recovery/modules/phananhtructuyen/pages/linhvuc_hoso_danhmuc/linhvuc_hoso_danhmuc.dart';
import 'package:image_recovery/modules/phananhtructuyen/pages/phananhvipham/phananh_vipham.dart';
import 'package:image_recovery/modules/phananhtructuyen/widgets/widget.dart';

class LinhVucHosoDanhMucPage extends StatefulWidget {

  final BuildContext phanAnhContext;

  LinhVucHosoDanhMucPage({this.phanAnhContext});

  @override
  LinhVucHosoDanhMucPageState createState() => LinhVucHosoDanhMucPageState();
}

class LinhVucHosoDanhMucPageState extends State<LinhVucHosoDanhMucPage> {
  @override
  Widget build(BuildContext context) {
    bool isLoading,  isHaveData = false;
    List<LinhVucHoSoModel> linhVucHoSos = [];
    LinhVucHoSoModel linhVucSelected;
    return BlocBuilder<LinhVucHoSoDanhMucCubit, LinhVucHoSoDanhMucState>(
      builder: (context, state) {
        if(state is LinhVucHoSoDanhMucStateInitiate){
          return Container();
        }

        if (state is LinhVucHoSoDanhMucStateLoading) {
          isLoading = true;
        } else if (state is LinhVucHoSoDanhMucStateSuccess) {
          isHaveData = true;
          isLoading = false;
          if (state.linhVucs != null) {
            linhVucHoSos = state.linhVucs;
          }
          if(state.index != null){
            linhVucSelected = linhVucHoSos?.elementAt(state.index) ?? null;

            widget.phanAnhContext
                .bloc<PhanAnhViPhamCubit>()
                .linhVucHoSoSelected(linhVucSelected);
          }
        } else if (state is LinhVucHoSoDanhMucStateFailure) {
          isHaveData = false;
          isLoading = false;
        }

        return SizedBox(
          height: 50,
          child: FlatButton(
            textColor: textinput_color,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
                side: BorderSide(color: Color(0xFF000000))),
            color: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
            onPressed: () => {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  linhVucSelected?.tenLoaiViPham ?? "Chọn xã/thị trấn",
                  style: TextStyle(
                      fontSize: 16,
                      color: (linhVucSelected == null)
                          ? placholderinput_color
                          : textinput_color,
                      fontWeight: FontWeight.normal),
                ),
                SelectionPickerIcon(
                  isLoading: isLoading,
                  isHaveData: isHaveData,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
