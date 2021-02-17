import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:image_recovery/modules/dichvucong/blocs/dichvucong_bloc.dart';
import 'package:image_recovery/modules/dichvucong/blocs/dichvucong_event.dart';
import 'package:image_recovery/modules/dichvucong/blocs/dichvucong_state.dart';
import 'package:image_recovery/modules/dichvucong/models/dichvucong_model.dart';
import 'package:image_recovery/utils/color_extends.dart';
import 'package:image_recovery/utils/navigations/navigation_datasource.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sailor/sailor.dart';

import '../../../constants.dart';

class DichVuCongChiTietPage extends StatefulWidget {
  @override
  _DichVuCongChiTietPageState createState() => _DichVuCongChiTietPageState();
}

class _DichVuCongChiTietPageState extends State<DichVuCongChiTietPage> {
  String thuTucId, linhVucId;
  DVC_ThuTuc_Detail dvc_thuTuc_Detail = new DVC_ThuTuc_Detail();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    thuTucId = Sailor.param<String>(context, 'thuTucID');
    linhVucId = Sailor.param<String>(context, 'linhVucID');
    print(thuTucId);
    print(linhVucId);
    BlocProvider.of<DichVuCongBloc_ThuTuc>(context)
      ..add(DichVuCongEventThutucDetail(thuTucID: thuTucId));

    return BlocBuilder<DichVuCongBloc_ThuTuc, DichVuCongState>(
      builder: (context, state) {
        dvc_thuTuc_Detail = new DVC_ThuTuc_Detail();
        if (state is DichVuCongStateSuccessfulThuTuc_Detail) {
          dvc_thuTuc_Detail = state.dataModel;
        }

        return Scaffold(
          appBar: _getCustomAppBar_Search(),
          body: SafeArea(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                  child: Container(
                    color: Colors.grey,
                  ),
                ),
                Expanded(
                  child: Stack(children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                            dvc_thuTuc_Detail.tenThuTuc ?? "",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 80,
                          )
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Stack(
                          children: [
                            Opacity(
                              opacity: 0.8799999952316284,
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 80,
                                  decoration: BoxDecoration(
                                      color: const Color(0xffeff2f3))),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Center(
                                child: Container(
                                  width: 180,
                                  height: 56,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(30)),
                                      boxShadow: [
                                        BoxShadow(
                                            color: const Color(0x1a000000),
                                            offset: Offset(0, 0),
                                            blurRadius: 8,
                                            spreadRadius: 0)
                                      ],
                                      color: const Color(0xffffffff)),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Center(
                                          child: Image(
                                        image: AssetImage(
                                            "images/dichvucong/nophoso_icon.png"),
                                        width: 46,
                                        height: 46,
                                      )),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Nộp hồ sơ",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    )
                  ]),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _getCustomAppBar_Search() {
    return PreferredSize(
      preferredSize: Size.fromHeight(heightNavigationBar),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: 30,
                    ),
                    color: Colors.black,
                    onPressed: () {
                      GetIt.instance<NavigationDataSource>()
                          .popNavigation(context);
                    }),
                Expanded(
                  child: Text(
                    "",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: 18,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    print(dvc_thuTuc_Detail?.maThuTuc);
                    _showModalBottomSheet(thisContext: context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Tài liệu",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Column(
                        children: [
                          Image(
                            image: AssetImage(
                                "images/dichvucong/dvc_icon_appbar.png"),
                            height: 30,
                            alignment: Alignment.topCenter,
                          ),
                          SizedBox(
                            height: 8,
                          )
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showModalBottomSheet({thisContext}) {
    showMaterialModalBottomSheet(
        context: thisContext,
        backgroundColor: Colors.transparent,
        builder: (context, scrollController) {
          return Container(
            height: MediaQuery.of(thisContext).size.height / 2,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
              child: Column(
                children: [
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          style: const TextStyle(
                              color: const Color(0xff768992),
                              fontWeight: FontWeight.w400,
                              fontFamily: "Roboto",
                              fontStyle: FontStyle.normal,
                              fontSize: 16.0),
                          text:
                              "Những tài liệu đính kèm này liên quan đến thủ tục "),
                      TextSpan(
                          style: const TextStyle(
                              color: const Color(0xff079bd2),
                              fontWeight: FontWeight.w400,
                              fontFamily: "Roboto",
                              fontStyle: FontStyle.normal,
                              fontSize: 16.0),
                          text:
                              "Cấp giấy phép xây dựng có thời hạn đối với công trình. "),
                      TextSpan(
                          style: const TextStyle(
                              color: const Color(0xff768992),
                              fontWeight: FontWeight.w400,
                              fontFamily: "Roboto",
                              fontStyle: FontStyle.normal,
                              fontSize: 16.0),
                          text:
                              "Bạn có thể nhấp vào biểu tượng tải để tải tài liệu mẫu:"),
                    ]),
                  ),

                ],
              ),
            ),
          );
        });
  }

  Widget getItemTaiLieu(String tenFile,String template_Trong){

    return Row(
      children: [
        Text(tenFile??"",style: TextStyle(
          color: ColorExtends.fromHex("#1f274a"),
          fontSize: 16
        ),),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(40),
              border: Border.all(color: Colors.grey)),
          child: Icon(Icons.file_download,color: Colors.grey,),
        )
      ],
    );

  }

}
