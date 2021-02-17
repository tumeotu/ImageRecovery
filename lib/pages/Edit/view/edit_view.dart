import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:image_recovery/language/localization/app_translations.dart';
import 'package:image_recovery/modules/phananhtructuyen/widgets/progress_loading.dart';
import 'dart:typed_data';
import 'package:image_recovery/pages/Edit/bloc/EditBloc.dart';
import 'package:image_recovery/pages/Edit/event/EditEvent.dart';
import 'package:image_recovery/pages/Edit/state/EditState.dart';
import 'package:image_recovery/utils/navigations/navigation_datasource.dart';
import 'package:image_recovery/widgets/appbar_custom.dart';

import '../../../constants.dart';
import '../../../routes.dart';
class EditHome extends StatefulWidget {
  @override
  _EditHomeState createState() => _EditHomeState();
}

class _EditHomeState extends State<EditHome> {
  Uint8List provider;
  final _navigation = GetIt.instance.get<NavigationDataSource>();
  double height;
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black12.withOpacity(0.1),//or set color with: Color(0xFF0000FF)
    ));
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xff56AAE7), //or set color with: Color(0xFF0000FF)
    ));
    super.dispose();
  }


  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: _getCustomBody(),
        )
      ),
    );
  }

  _getCustomBody() {
    return BlocBuilder<EditBloc, EditState>(
      builder: (context, state) {
        if (state is EditMainStateInitial) {
          return ProgressLoading();
        } 
        else if(state is EditMainStateStart)
          {
            if(state.image!=null)
            {
              provider= state.image;
            }
            return getDefaulteView(state);
          }
        return Container();
      },
    );
  }

  getDefaulteView(EditMainStateStart state) {
    height= MediaQuery.of(context).size.height-MediaQuery.of(context).padding.top;
    return Container(
      color: Colors.blue.withOpacity(0.1),
      child: Column(
        children: [
          Container(
            height: height
                *0.03,
            width: MediaQuery.of(context).size.width,
            color: Colors.black12.withOpacity(0.1),
          ),
          GestureDetector(
            child: Container(
                height: height
                    *0.74,
                width: MediaQuery.of(context).size.width,
                color: Colors.black12.withOpacity(0.1),
                child: provider==null?ProgressLoading():Image.memory(provider),
            ),
          ),
          Container(
            height: height
                *0.03,
            width: MediaQuery.of(context).size.width,
            color: Colors.black12.withOpacity(0.1),
          ),
          Container(
            height: height
                *0.2,
            width: MediaQuery.of(context).size.width,
            color: Colors.blue.withOpacity(0.1),
            child: Column(
              children: [
                Container(
                  height: height*0.1,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          behavior:HitTestBehavior.translucent,
                          onTap: ()=>{
                            ShowCropView()
                          },
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.crop),
                                Padding(
                                  padding: new EdgeInsets.all(4),
                                ),
                                Text(
                                    AppTranslations.of(context).text("Crop").toString()
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          behavior:HitTestBehavior.translucent,
                          onTap: ()=>{
                            ShowFilterView()
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.filter_drama),
                              Padding(
                                padding: new EdgeInsets.all(4),
                              ),
                              Text(
                                  AppTranslations.of(context).text("FilterMode").toString()
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          behavior:HitTestBehavior.translucent,
                          onTap: ()=>{
                            ShowCustomFilterView()
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.filter_b_and_w),
                              Padding(
                                padding: new EdgeInsets.all(4),
                              ),
                              Text(
                                  AppTranslations.of(context).text("Custom").toString()
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: height*0.1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                            behavior:HitTestBehavior.translucent,
                            onTap: (){
                              _navigation.popNavigation(context);
                            },
                            child: Text(
                              AppTranslations.of(context).text("Cancel").toString(),
                              style: new TextStyle(
                                  fontSize: 18
                              ),
                            )
                        ),
                        Expanded(child: SizedBox()),
                        GestureDetector(
                            behavior:HitTestBehavior.translucent,
                            onTap: (){
                              _navigation.popNavigation(context, params: provider);
                            },
                            child: Text(
                              AppTranslations.of(context).text("Save").toString(),
                              style: new TextStyle(
                                  fontSize: 18
                              ),
                            )
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  ShowCropView() async {
    var param={
      "image": provider
    };
    Uint8List params = await _navigation.pushNavigation<Uint8List>(NamePage.cropPage,params: param);
    BlocProvider.of<EditBloc>(context)
      ..add(
          EditEventStart(params));
  }

  ShowFilterView() async {
    var param={
      "image": provider
    };
    Uint8List params = await _navigation.pushNavigation<Uint8List>(NamePage.filterPage,params: param);
    BlocProvider.of<EditBloc>(context)
      ..add(
          EditEventStart(params));
  }

  ShowCustomFilterView() async {
    var param={
      "image": provider
    };
    Uint8List params = await _navigation.pushNavigation<Uint8List>(NamePage.customFilterPage,params: param);
    BlocProvider.of<EditBloc>(context)
      ..add(
          EditEventStart(params));
  }
}
