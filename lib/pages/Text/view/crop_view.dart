import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:image_recovery/modules/phananhtructuyen/widgets/progress_loading.dart';
import 'package:image_recovery/pages/Crop/bloc/CropBloc.dart';
import 'package:image_recovery/pages/Crop/state/CropState.dart';
import 'package:image_recovery/pages/Filter/model/ImageEditorHelper.dart';
import 'dart:typed_data';
import 'package:image_recovery/routes.dart';

import 'package:image_recovery/utils/navigations/navigation_datasource.dart';
import 'package:sailor/sailor.dart';

class TextHome extends StatefulWidget {
  @override
  _TextHomeState createState() => _TextHomeState();
}

class _TextHomeState extends State<TextHome> {
  Uint8List provider;
  GlobalKey<ExtendedImageEditorState> editorKey = GlobalKey<ExtendedImageEditorState>();
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
  @override
  void initState() {
    super.initState();
    aspectRatio= aspectRatioList['Custom'];
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black12.withOpacity(0.1),//or set color with: Color(0xFF0000FF)
    ));
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xff56AAE7), //or set color with: Color(0xFF0000FF)
    ));
    super.dispose();
  }

  @override
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
    return BlocBuilder<CropBloc, CropState>(
      builder: (context, state) {
        if (state is CropMainStateInitial) {
          return ProgressLoading();
        } 
        else if(state is CropStateStart)
          {
            return getCopView(state);
          }
        return Container();
      },
    );
  }

  getCopView(CropStateStart stateCrop) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height
                *0.75,
            width: MediaQuery.of(context).size.width,
            child: ExtendedImage.memory(
              provider,
              fit: BoxFit.contain,
              mode: ExtendedImageMode.editor,
              enableLoadState: true,
              extendedImageEditorKey: editorKey,
              initEditorConfigHandler: (ExtendedImageState state) {
                return EditorConfig(
                    lineHeight: 1.5,
                    maxScale: 8.0,
                    hitTestSize: 20.0,
                    initCropRectType: InitCropRectType.imageRect,
                    cropAspectRatio: aspectRatio);
              },
            )
          ),
          Container(
            height: MediaQuery.of(context).size.height
                *0.25,
            width: MediaQuery.of(context).size.width,
            color: Colors.blue.withOpacity(0.1),
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height*0.15,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              editorKey.currentState.flip();
                            });
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width/4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.flip),
                                Padding(
                                  padding: new EdgeInsets.all(4),
                                ),
                                Text(
                                    'Flip'
                                )
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          behavior:HitTestBehavior.translucent,
                          onTap: () {
                            setState(() {
                              editorKey.currentState.rotate();
                            });
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width/4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.rotate_left),
                                Padding(
                                  padding: new EdgeInsets.all(4),
                                ),
                                Text(
                                    'Rotate'
                                )
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          behavior:HitTestBehavior.translucent,
                          onTap: () {
                            setState(() {
                              aspectRatio= aspectRatioList['Custom'];
                            });
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width/4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.crop),
                                Padding(
                                  padding: new EdgeInsets.all(4),
                                ),
                                Text(
                                    'Custom'
                                )
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          behavior:HitTestBehavior.translucent,
                          onTap: () {
                            setState(() {
                              aspectRatio= aspectRatioList['Original'];
                            });
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width/4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.crop_original),
                                Padding(
                                  padding: new EdgeInsets.all(4),
                                ),
                                Text(
                                    'Original'
                                )
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          behavior:HitTestBehavior.translucent,
                          onTap: () {
                            setState(() {
                              aspectRatio= aspectRatioList['3:2'];
                            });
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width/4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.crop_3_2),
                                Padding(
                                  padding: new EdgeInsets.all(4),
                                ),
                                Text(
                                    '3 : 2'
                                )
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          behavior:HitTestBehavior.translucent,
                          onTap: () {
                            setState(() {
                              aspectRatio= aspectRatioList['5:4'];
                            });
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width/4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.crop_5_4),
                                Padding(
                                  padding: new EdgeInsets.all(4),
                                ),
                                Text(
                                    '5 : 4'
                                )
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          behavior:HitTestBehavior.translucent,
                          onTap: () {
                            setState(() {
                              aspectRatio= aspectRatioList['7:5'];
                            });
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width/4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.crop_7_5),
                                Padding(
                                  padding: new EdgeInsets.all(4),
                                ),
                                Text(
                                    '7 : 5'
                                )
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          behavior:HitTestBehavior.translucent,
                          onTap: () {
                            setState(() {
                              aspectRatio= aspectRatioList['16:9'];
                            });
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width/4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.crop_16_9),
                                Padding(
                                  padding: new EdgeInsets.all(4),
                                ),
                                Text(
                                    '16 : 9'
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
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
                            _navigation.popNavigation(context, params: null);
                          },
                            child: Icon(Icons.clear)
                        ),
                        Expanded(child: SizedBox()),
                        GestureDetector(
                          behavior:HitTestBehavior.translucent,
                          onTap: () {
                            editorKey.currentState.reset();
                          },
                          child: Text(
                            'Cắt',
                            style: new TextStyle(
                                fontSize: 18
                            ),
                          ),
                        ),
                        Expanded(child: SizedBox()),
                        GestureDetector(
                            behavior:HitTestBehavior.translucent,
                          onTap: ()=> _cropImage(editorKey),
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

  Future<void> _cropImage(editorKey) async {
    var fileData = Uint8List.fromList(await cropImageDataWithNativeLibrary(
        state: editorKey.currentState));
    Routes.sailor.pop(fileData);
  }

}
