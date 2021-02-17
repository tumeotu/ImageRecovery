import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_recovery/modules/dichvucong/blocs/dichvucong_bloc.dart';
import 'package:image_recovery/modules/dichvucong/blocs/dichvucong_event.dart';
import 'package:image_recovery/modules/dichvucong/blocs/dichvucong_state.dart';
import 'package:image_recovery/modules/dichvucong/widgets/list_linhvuc_widget.dart';
import 'package:image_recovery/modules/dichvucong/widgets/list_thutuc_widget.dart';
import 'package:image_recovery/utils/color_extends.dart';
import 'package:image_recovery/widgets/appbar_custom.dart';

import '../../../constants.dart';

class DichVuCongTTHCPage extends StatefulWidget {
  @override
  _DichVuCongTTHCPageState createState() => _DichVuCongTTHCPageState();
}

class _DichVuCongTTHCPageState extends State<DichVuCongTTHCPage> {
  bool checkSearchBar = false;
  final keyWord = TextEditingController();

  String maLinhVuc=null;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<DichVuCongBloc_ThuTuc>(context)
      ..add(DichVuCongEventGetDMThuTuc());
  }

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<DichVuCongBloc_LinhVuc,DichVuCongState>(
      builder: (context,state){

        if(state is DichVuCongStateSuccessfulLinhVucItemSelected)
          {
            maLinhVuc=state.itemSelected.maLinhVuc;
            print("maLinhVuc : $maLinhVuc");
          }

        return Scaffold(
          appBar: checkSearchBar ? _getCustomAppBar_Search() : _getCustomAppBar(),
          body: SafeArea(
            child: Column(
              children: [
                DichVuCongTTHCLinhVuc(keyword: keyWord.text,),
                SizedBox(
                  height: 10,
                  child: Container(
                    color: ColorExtends.fromHex("#ccd5d8"),
                  ),
                ),
                Expanded(
                    child: DichVuCongTTHCThuTuc(keyword: keyWord.text,))
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
                    color: Colors.grey[400],
                    onPressed: () {
                      keyWord.text="";
                      setState(() {
                        checkSearchBar = !checkSearchBar;
                      });
                    }),
                Expanded(
                  child: TextFormField(
                    controller: keyWord,
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.search,
                    onFieldSubmitted: (value) {
                      print(value);
                      print("maLinhVuc : $maLinhVuc");

                      BlocProvider.of<DichVuCongBloc_ThuTuc>(context)
                        ..add(DichVuCongEventGetDMThuTucReset());
                      BlocProvider.of<DichVuCongBloc_ThuTuc>(context)
                        ..add(DichVuCongEventGetDMThuTuc(
                            maLinhVuc:  this.maLinhVuc,
                            keySearch: value));

                    },
                    style: TextStyle(fontSize: 20),
                    decoration: new InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 15, right: 15),
                        hintText: "Tìm kiếm"),
                  ),
                ),
                IconButton(
                    icon: Icon(Icons.clear),
                    color: Colors.black,
                    onPressed: () {
                      print("clear");
                      keyWord.text="";
                    }),
              ],
            ),
          ),
          SizedBox(
            height: 1,
            width: MediaQuery.of(context).size.width,
            child: Container(
              color: Colors.grey[300],
            ),
          )
        ],
      ),
    );
  }

  _getCustomAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(heightNavigationBar),
      child: AppBarCustom(
        title: "DANH SÁCH THỦ TỤC",
        startColor: navigationBarColorStart,
        endColor: navigationBarColorEnd,
        iconStart: Icons.arrow_back_ios,
        iconEnd: ImageIcon(
          AssetImage("images/tintuc_timkiem_icon.png"),
        ),
        actionLightIcon: () {
          setState(() {
            checkSearchBar = !checkSearchBar;
          });
        },
      ),
    );
  }
}
