import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:image_recovery/modules/phananhtructuyen/widgets/progress_loading.dart';
import 'package:image_recovery/pages/CustomFilter/bloc/CustomFilterBloc.dart';
import 'package:image_recovery/pages/CustomFilter/event/CustomFilterEvent.dart';
import 'package:image_recovery/pages/CustomFilter/state/CustomFilterState.dart';
import 'package:image_recovery/pages/Filter/bloc/FilterBloc.dart';
import 'package:image_recovery/pages/Filter/event/FilterEvent.dart';
import 'package:image_recovery/pages/Filter/model/matrix.dart';
import 'dart:typed_data';
import 'package:image_recovery/routes.dart';
import 'dart:ui' as ui;
import 'package:image_recovery/utils/navigations/navigation_datasource.dart';
import 'package:sailor/sailor.dart';
class CustomFilterHome extends StatefulWidget {
  @override
  _CustomFilterHomeState createState() => _CustomFilterHomeState();
}

class _CustomFilterHomeState extends State<CustomFilterHome> {
  Uint8List provider;
  GlobalKey<_CustomFilterHomeState> filterKey = GlobalKey<_CustomFilterHomeState>();
  final _navigation = GetIt.instance.get<NavigationDataSource>();
  double sat = 1;
  double bright = 0;
  double con = 1;

  final defaultColorMatrix = const <double>[
  1.0, 0.0, 0.0, 0.0, 0.0,
  0.0, 1.0, 0.0, 0.0, 0.0,
  0.0, 0.0, 1.0, 0.0, 0.0,
  0.0, 0.0, 0.0, 1.0, 0.0];

  List<double> calculateSaturationMatrix(double saturation) {
    final m = List<double>.from(defaultColorMatrix);
    final invSat = 1 - saturation;
    final R = 0.213 * invSat;
    final G = 0.715 * invSat;
    final B = 0.072 * invSat;

    m[0] = R + saturation;
    m[1] = G;
    m[2] = B;
    m[5] = R;
    m[6] = G + saturation;
    m[7] = B;
    m[10] = R;
    m[11] = G;
    m[12] = B + saturation;

    return m;
  }

  List<double> calculateContrastMatrix(double contrast) {
    final m = List<double>.from(defaultColorMatrix);
    m[0] = contrast;
    m[6] = contrast;
    m[12] = contrast;
    return m;
  }

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
    provider = Sailor.param<Uint8List>(context, 'image');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: _getCustomBody(),
      ),
    );
  }

  _getCustomBody() {
    return BlocBuilder<CustomFilterBloc, CustomFilterState>(
      builder: (context, state) {
        if (state is CustomFilterMainStateInitial) {
          return ProgressLoading();
        } 
        else if(state is CustomFilterStartSuccess)
          {
            return getFilterView(state);
          }
        return Container();
      },
    );
  }

  getFilterView(CustomFilterStartSuccess stateFilter) {
    return Container(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height
                *0.75,
            width: MediaQuery.of(context).size.width,
            padding: new EdgeInsets.only(
              top: MediaQuery.of(context).padding.top
            ),
            child: Center(
              child: GestureDetector(
                behavior:HitTestBehavior.translucent,
                  child: RepaintBoundary(
                  key: filterKey,
                  child: ColorFiltered(
                    colorFilter: ColorFilter.matrix(calculateContrastMatrix(stateFilter.con)),
                    child: ColorFiltered(
                      colorFilter: ColorFilter.matrix(calculateSaturationMatrix(stateFilter.sat)),
                      child: Image.memory(
                        provider,
                        color: stateFilter.bright > 0
                            ? Colors.white.withOpacity(stateFilter.bright)
                            : Colors.black.withOpacity(-stateFilter.bright),
                        colorBlendMode: stateFilter.bright > 0 ? BlendMode.lighten : BlendMode.darken,
                      ),
                    ),
                  )
                ),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height
                *0.25,
            width: MediaQuery.of(context).size.width,
            color: Colors.blue.withOpacity(0.1),
            child: Column(
              children: [
                Container(
                    height: MediaQuery.of(context).size.height
                        *0.05,
                    child: _buildSat()
                ),
                Container(
                    height: MediaQuery.of(context).size.height
                        *0.05,
                    child: _buildBrightness()
                ),
                Container(
                    height: MediaQuery.of(context).size.height
                        *0.05,
                    child: _buildCon()
                ),
                Container(
                  height: MediaQuery.of(context).size.height*0.1,
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
                            ' Custom',
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

  Widget _buildSat() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.05,
        ),
        Expanded(
          flex: 2,
          child: Text(
            "Saturation",
          ),
        ),
        Expanded(
          flex: 7,
          child: Container(
              width: MediaQuery.of(context).size.width * 0.6,
              child: Slider(
                label: 'sat : ${sat.toStringAsFixed(2)}',
                onChanged: (double value) {
                  setState(() {
                    sat= value;
                    BlocProvider.of<CustomFilterBloc>(context)
                      ..add(
                        CustomFilterEventStart(provider, sat, bright, con));
                  });
                },
                divisions: 50,
                value: sat,
                min: 0,
                max: 2,
              )
          ),
        ),
        Expanded(
            flex: 1,
            child:Text(sat.toStringAsFixed(2))
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.03,
        ),
      ],
    );
  }

  Widget _buildBrightness() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.05,
        ),
        Expanded(
          flex: 2,
          child: Text(
            "Brightness",
          ),
        ),
        Expanded(
          flex: 7,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Slider(
              label: '${bright.toStringAsFixed(2)}',
              onChanged: (double value) {
                setState(() {
                  bright = value;
                  BlocProvider.of<CustomFilterBloc>(context)
                    ..add(
                        CustomFilterEventStart(provider, sat, bright, con));
                });
              },
              divisions: 50,
              value: bright,
              min: -1,
              max: 1,
            ),
          ),
        ),
        Expanded(
            flex: 1,
            child: Text(bright.toStringAsFixed(2))
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.03,
        ),
      ],
    );
  }

  Widget _buildCon() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.05,
        ),
        Expanded(
          flex: 2,
          child: Text(
            "Contrast",
          ),
        ),
        Expanded(
          flex: 7,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Slider(
              label: 'con : ${con.toStringAsFixed(2)}',
              onChanged: (double value) {
                setState(() {
                  con = value;
                  BlocProvider.of<CustomFilterBloc>(context)
                    ..add(
                        CustomFilterEventStart(provider, sat, bright, con));
                });
              },
              divisions: 50,
              value: con,
              min: 0,
              max: 4,
            ),
          ),
        ),
        Expanded(
          flex: 1,
            child: Text(con.toStringAsFixed(2))
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.03,
        ),
      ],
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
