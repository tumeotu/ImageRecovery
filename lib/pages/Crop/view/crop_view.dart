import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:image_recovery/language/localization/app_translations.dart';
import 'package:image_recovery/language/localization/application.dart';
import 'package:image_recovery/modules/phananhtructuyen/widgets/progress_loading.dart';
import 'package:image_recovery/pages/Crop/bloc/CropBloc.dart';
import 'package:image_recovery/pages/Crop/state/CropState.dart';
import 'package:image_recovery/pages/Filter/model/ImageEditorHelper.dart';
import 'dart:typed_data';
import 'package:image_recovery/routes.dart';
import 'package:image_recovery/utils/navigations/navigation_datasource.dart';
import 'package:sailor/sailor.dart';

class CropHome extends StatefulWidget {
  @override
  _CropHomeState createState() => _CropHomeState();
}

class _CropHomeState extends State<CropHome> {
  Uint8List provider;
  GlobalKey<ExtendedImageEditorState> editorKey = GlobalKey<ExtendedImageEditorState>();
  static final List<String> languagesList = application.supportedLanguages;
  static final List<String> languageCodesList =
      application.supportedLanguagesCodes;

  final Map<dynamic, dynamic> languagesMap = {
    languagesList[0]: languageCodesList[0],
    languagesList[1]: languageCodesList[1],
  };
  List<String> _dropdownItems = new List();

  String _dropdownValue = "Nam";
  void onLocaleChange(Locale locale) async {
    setState(() {
      AppTranslations.load(locale);
    });
  }
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
  @override
  void initState() {
    super.initState();
    aspectRatio= aspectRatioList['Custom'];
    application.onLocaleChanged = onLocaleChange;

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
        body: SafeArea(
          child: _getCustomBody(),
        )
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
    height= MediaQuery.of(context).size.height-MediaQuery.of(context).padding.top;
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            height: height
                *0.03,
            color: Colors.grey.withOpacity(0.05),
            width: MediaQuery.of(context).size.width,
          ),
          Container(
            height: height
                *0.74,
            width: MediaQuery.of(context).size.width,
            child: provider==null?Container():ExtendedImage.memory(
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
              height: height
                  *0.03,
              color: Colors.grey.withOpacity(0.05),
              width: MediaQuery.of(context).size.width,
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
                  height: height*0.1,
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
                            onLocaleChange(Locale(languagesMap["Vietnamese"]));
                            editorKey.currentState.reset();
                          },
                          child: Text(
                            AppTranslations.of(context).text("Crop").toString(),
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
