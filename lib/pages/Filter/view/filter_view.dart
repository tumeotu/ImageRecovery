import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:image_recovery/modules/phananhtructuyen/widgets/progress_loading.dart';
import 'package:image_recovery/pages/Filter/bloc/FilterBloc.dart';
import 'package:image_recovery/pages/Filter/event/FilterEvent.dart';
import 'package:image_recovery/pages/Filter/model/ImageEditorHelper.dart';
import 'package:image_recovery/pages/Filter/model/matrix.dart';
import 'package:image_recovery/pages/Filter/state/FilterState.dart';
import 'dart:typed_data';
import 'package:image_recovery/routes.dart';
import 'dart:ui' as ui;

import 'package:image_recovery/utils/navigations/navigation_datasource.dart';
import 'package:sailor/sailor.dart';
class FilterHome extends StatefulWidget {
  @override
  _FilterHomeState createState() => _FilterHomeState();
}

class _FilterHomeState extends State<FilterHome> {
  Uint8List provider;
  GlobalKey<ExtendedImageEditorState> editorKey = GlobalKey<ExtendedImageEditorState>();
  GlobalKey<_FilterHomeState> filterKey = GlobalKey<_FilterHomeState>();
  final _navigation = GetIt.instance.get<NavigationDataSource>();
  var aspectRatioList = {
    'Custom':null,
    'Original':1.0,
    '3:2':3/2,
    '5:4':5/4,
    '7:5':7/5,
    '16:9':16/9
  };
  double aspectRatio=0.0;
  double height;
  Filter currentFilter= MatrixColor.instance.filters[0];
  @override
  void initState() {
    aspectRatio= aspectRatioList['Custom'];
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
    provider = Sailor.param<Uint8List>(context, 'image');
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
    return BlocBuilder<FilterBloc, FilterState>(
      builder: (context, state) {
        if (state is FilterMainStateInitial) {
          return ProgressLoading();
        } 
        else if(state is FilterStartSuccess)
          {
            return getFilterView(state);
          }
        return Container();
      },
    );
  }
  getFilterView(FilterStartSuccess stateFilter) {
    height= MediaQuery.of(context).size.height-MediaQuery.of(context).padding.top;
    return Container(
      child: Column(
        children: [
          Container(
            height: height
                *0.03,
            color: Colors.grey.withOpacity(0.01),
            width: MediaQuery.of(context).size.width,
          ),
          Container(
            height: height
                *0.69,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: GestureDetector(
                behavior:HitTestBehavior.translucent,
                onTapDown: (_){
                  BlocProvider.of<FilterBloc>(context)
                    ..add(
                        FilterEventStart(stateFilter.image, MatrixColor.instance.filters[0]));
                },
                onTapUp: (_){
                  BlocProvider.of<FilterBloc>(context)
                    ..add(//
                        FilterEventStart(stateFilter.image, currentFilter));
                },
                  child: RepaintBoundary(
                  key: filterKey,
                  child: ColorFiltered(
                    // value
                    colorFilter: ColorFilter.matrix(
                        stateFilter.filter.values
                    ),
                    //contrast
                    child: Image.memory(
                      provider,
                    ),
                  )
                ),
              ),
            ),
          ),
          Container(
            height: height
                *0.03,
            color: Colors.grey.withOpacity(0.01),
            width: MediaQuery.of(context).size.width,
          ),
          Container(
            height: height
                *0.25,
            width: MediaQuery.of(context).size.width,
            color: Colors.blue.withOpacity(0.1),
            child: Column(
              children: [
                Container(
                    height: height*0.17,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      padding: new EdgeInsets.all(5),
                      scrollDirection: Axis.horizontal,
                      itemCount: MatrixColor.instance.filters.length,
                      itemBuilder: (BuildContext context, int index) => GestureDetector(
                        behavior:HitTestBehavior.translucent,
                        onTap: (){
                          currentFilter=MatrixColor.instance.filters[index];
                          BlocProvider.of<FilterBloc>(context)
                            ..add(
                                FilterEventStart(stateFilter.image, MatrixColor.instance.filters[index]));
                        },
                        child: Container(
                          padding: new EdgeInsets.only(
                            top: 5,
                            left: 5, right: 5
                          ),
                          color: Colors.transparent,
                          width: MediaQuery.of(context).size.width*0.22,
                          child: Column(
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height*0.1,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: ColorFiltered(
                                    // value
                                    colorFilter: ColorFilter.matrix(
                                        MatrixColor.instance.filters[index].values
                                    ),
                                    //contrast
                                    child: Image.asset(
                                      'images/filter.jpg',
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 5
                                ),
                                child: Text(MatrixColor.instance.filters[index].name.toLowerCase()),
                              )
                            ],
                          )
                        ),
                      ),
                    ),
                ),
                Container(
                  height: height*0.05,
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
                            child: Icon(Icons.clear)
                        ),
                        Expanded(child: SizedBox()),
                        GestureDetector(
                          behavior:HitTestBehavior.translucent,
                          onTap: () {
                            BlocProvider.of<FilterBloc>(context)
                              ..add(
                                  FilterEventStart(stateFilter.image, MatrixColor.instance.filters[0]));
                          },
                          child: Text(
                            'Filter',
                            style: new TextStyle(
                                fontSize: 18
                            ),
                          ),
                        ),
                        Expanded(child: SizedBox()),
                        GestureDetector(
                            behavior:HitTestBehavior.translucent,
                            onTap: ()=> convertWidgetToImage(),
                            child: Icon(Icons.check)
                        )
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
  Future<void> convertWidgetToImage() async {
    RenderRepaintBoundary boundary =
    filterKey.currentContext.findRenderObject();
    ui.Image image = await boundary.toImage(pixelRatio: 5.0);
    ByteData byteData =
    await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List fileData = byteData.buffer.asUint8List();
    Routes.sailor.pop(fileData);
  }

}
