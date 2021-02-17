import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_recovery/modules/phananhtructuyen/models/duong_danhmuc_model.dart';
import 'package:image_recovery/modules/phananhtructuyen/models/phuongxa_danhmuc_model.dart';
import 'package:image_recovery/modules/phananhtructuyen/pages/diachi_danhmuc/diachi_danhmuc.dart';
import 'package:image_recovery/modules/phananhtructuyen/pages/phananhvipham/phananh_vipham.dart';
import 'package:image_recovery/modules/phananhtructuyen/widgets/textinput_field.dart';
import 'package:image_recovery/modules/phananhtructuyen/widgets/widget.dart';
import '../../../../constants.dart';

class DiaChiDanhMucPage extends StatefulWidget {
  final BuildContext phanAnhContext;
  final Function(DuongDanhMucModel) onChangeSelectDuong;
  final Function(PhuongXaDanhMucModel) onChangeSelectPhuongXa;

  DiaChiDanhMucPage(
      {Key key,
      this.phanAnhContext,
      this.onChangeSelectDuong,
      this.onChangeSelectPhuongXa})
      : super(key: key);

  @override
  DiaChiDanhMucPageState createState() => DiaChiDanhMucPageState();
}

class DiaChiDanhMucPageState extends State<DiaChiDanhMucPage> {
  @override
  Widget build(BuildContext context) {
    bool isLoadingPhuong = false, isLoadingDuong = false;
    bool isHaveDataPhuong = false, isHaveDataDuong = false;
    List<DuongDanhMucModel> duongDanhMucs;
    List<PhuongXaDanhMucModel> phuongXaDanhMucs;
    String tenDuongSelected, tenPhuongSeleted;
    int indexPhuongXa, indexDuong;

    return BlocBuilder<DiaChiDanhMucBloc, DiaChiDanhMucState>(
      builder: (context, state) {
        /// state phuong xa
        if (state is DiaChiDanhMucStatePhuongXaDMLoading) {
          isLoadingPhuong = true;
        } else if (state is DiaChiDanhMucStatePhuongXaDMSuccess) {
          isHaveDataPhuong = true;
          phuongXaDanhMucs = state.phuongXas;
          isLoadingPhuong = false;
        } else if (state is DiaChiDanhMucStatePhuongXaDMFailure) {
          isLoadingPhuong = false;
        }

        /// state duong
        else if (state is DiaChiDanhMucStateDuongDMLoading) {
          isLoadingDuong = true;
          phuongXaDanhMucs = state.phuongXas;
          if (state.index != null) {
            indexPhuongXa = state.index;
            tenPhuongSeleted =
                state.phuongXas.elementAt(indexPhuongXa).tenPhuong;
          }
        }
        //Success load DuongDM
        else if (state is DiaChiDanhMucStateDuongDMSuccess) {
          isHaveDataDuong = true;
          isHaveDataPhuong = true;
          duongDanhMucs = state.duongs;
          phuongXaDanhMucs = state.phuongXas;
          if (state.indexPhuongXa != null) {
            indexPhuongXa = state.indexPhuongXa;
            var itemPhuong = state.phuongXas.elementAt(indexPhuongXa);
            tenPhuongSeleted = itemPhuong.tenPhuong;

            //emit phuong xa to PhanAnhViPhamCubit
            widget.phanAnhContext
                .bloc<PhanAnhViPhamCubit>()
                .phuongDanhMucSelected(itemPhuong);
            //widget.onChangeSelectPhuongXa?.call(itemPhuong);
          }
          if (state.indexDuong != null) {
            indexDuong = state.indexDuong;
            var itemDuong = state.duongs.elementAt(indexDuong);
            tenDuongSelected = itemDuong.tenDuong;

            //emit duong to PhanAnhViPhamCubit
            widget.phanAnhContext
                .bloc<PhanAnhViPhamCubit>()
                .duongDanhMucSelected(itemDuong);
            //widget.onChangeSelectDuong?.call(itemDuong);
          } else {
            indexDuong = null;
            tenDuongSelected = null;
          }
          isLoadingDuong = false;
        } else if (state is DiaChiDanhMucStateDuongDMFailure) {
          isLoadingDuong = false;
        }

        return Column(
          children: [
            TextInputField(
              //emit so nha to PhanAnhViPhamCubit
              (value) => widget.phanAnhContext
                  .bloc<PhanAnhViPhamCubit>()
                  .soNhaChanged(value),
              "",
              label: "Nhập số nhà",
            ),
            SizedBox(
              height: 5,
            ),
            SizedBox(
              height: 50,
              child: FlatButton(
                textColor: textinput_color,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    side: BorderSide(color: Color(0xFF000000))),
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      tenPhuongSeleted ?? "Chọn xã/thị trấn",
                      style: TextStyle(
                          fontSize: 16,
                          color: (tenPhuongSeleted == null)
                              ? placholderinput_color
                              : textinput_color,
                          fontWeight: FontWeight.normal),
                    ),
                    SelectionPickerIcon(
                      isLoading: isLoadingPhuong,
                      isHaveData: isHaveDataPhuong,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            SizedBox(
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
                      tenDuongSelected ?? "Chọn đường",
                      style: TextStyle(
                          fontSize: 16,
                          color: (tenDuongSelected == null)
                              ? placholderinput_color
                              : textinput_color,
                          fontWeight: FontWeight.normal),
                    ),
                    SelectionPickerIcon(
                      isLoading: isLoadingDuong,
                      isHaveData: isHaveDataDuong,
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

