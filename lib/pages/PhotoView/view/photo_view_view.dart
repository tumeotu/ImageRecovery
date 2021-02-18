import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get_it/get_it.dart';
import 'package:image_recovery/Common/Widget/Button.dart';
import 'package:image_recovery/language/localization/app_translations.dart';
import 'package:image_recovery/modules/phananhtructuyen/widgets/progress_loading.dart';
import 'package:image_recovery/pages/Filter/bloc/FilterBloc.dart';
import 'package:image_recovery/pages/Filter/event/FilterEvent.dart';
import 'package:image_recovery/pages/Filter/model/ImageEditorHelper.dart';
import 'package:image_recovery/pages/Filter/model/matrix.dart';
import 'package:image_recovery/pages/Filter/state/FilterState.dart';
import 'package:image_recovery/pages/PhotoView/Model/Indicator.dart';
import 'package:image_recovery/pages/PhotoView/bloc/PhotoViewBloc.dart';
import 'package:image_recovery/pages/PhotoView/event/PhotoViewEvent.dart';
import 'package:image_recovery/pages/PhotoView/state/PhotoViewState.dart';
import 'dart:typed_data';
import 'package:image_recovery/routes.dart';
import 'dart:ui' as ui;

import 'package:image_recovery/utils/navigations/navigation_datasource.dart';
import 'package:image_recovery/widgets/color_loader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:sailor/sailor.dart';
import 'package:share/share.dart';

class PhotoViewHome extends StatefulWidget {
  @override
  _PhotoViewHomeState createState() => _PhotoViewHomeState();
}

class _PhotoViewHomeState extends State<PhotoViewHome> {
  int page = -1;
  Uint8List oldImage;
  Uint8List newImage;
  final _navigation = GetIt.instance.get<NavigationDataSource>();
  double height = 0.0;
  PageController controllerHome = PageController(initialPage: 0);
  PageController controllerDetect = PageController(initialPage: 0);

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black12
          .withOpacity(0.8), //or set color with: Color(0xFF0000FF)
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
      )),
    );
  }

  _getCustomBody() {
    return BlocBuilder<PhotoViewBloc, PhotoViewState>(
      builder: (context, state) {
        if (state is PhotoViewStateInitial) {
          return ProgressLoading();
        } else if (state is PhotoViewStateStart) {
          if(this.page==-1)
            this.page = state.page;
          this.oldImage = state.oldImage;
          this.newImage = state.newImage;
          controllerDetect = PageController(initialPage: state.page);
          controllerHome = PageController(initialPage: state.page);
          if (state.isDetect == false) {
            return getBodyView(state);
          } else {
            return getBodyViewDetect(state);
          }
        }
        return Container();
      },
    );
  }

  getBodyView(PhotoViewStateStart state) {
    height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return Container(
      color: Colors.black87,
      child: Column(
        children: [
          Container(
            height: height * 0.07,
            color: Colors.black54,
            padding:
                new EdgeInsets.only(left: height * 0.01, right: height * 0.01),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    _navigation.popNavigation(context);
                  },
                  child: Icon(
                    Icons.cancel,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: height * 0.77,
            width: MediaQuery.of(context).size.width,
            child: Center(
                child: PageView(
              controller: controllerHome,
              onPageChanged: (index) {
                setState(() {
                  this.page = index;
                });
              },
              children: [
                PhotoView(
                  backgroundDecoration: BoxDecoration(
                    color: Colors.black54,
                  ),
                  imageProvider: MemoryImage(this.oldImage, scale: 1.0),
                ),
                PhotoView(
                  backgroundDecoration: BoxDecoration(
                    color: Colors.black54,
                  ),
                  imageProvider: MemoryImage(
                    this.newImage,
                  ),
                )
              ],
            )),
          ),
          Container(
            color: Colors.black54,
            height: height * 0.05,
            child: Center(
              child: Indicator(
                controller: controllerHome,
                itemCount: 2,
              ),
            ),
          ),
          Container(
            margin: new EdgeInsets.only(top: 1),
            height: height * 0.11-1,
            width: MediaQuery.of(context).size.width,
            color: Colors.black54,
            child: Container(
              height: this.height * 0.1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () => {
                        showEdit(),
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesome5.edit,
                            size: 20,
                            color: Colors.white,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              'Edit',
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () => {showSaveView(context)},
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.save_alt,
                            size: 25,
                            color: Colors.white,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              'Save',
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        BlocProvider.of<PhotoViewBloc>(context)
                          ..add(PhotoViewEventPost(this.page, this.oldImage,
                              this.newImage, context));
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.face,
                            size: 25,
                            color: Colors.white,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              'Detect',
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () => {ShowShareView()},
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesome.external_link,
                            size: 20,
                            color: Colors.white,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              'Share',
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  getBodyViewDetect(PhotoViewStateStart state) {
    height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return Stack(
      children: [
        Container(
          color: Colors.black87,
          child: Column(
            children: [
              Container(
                height: height * 0.07,
                color: Colors.black54,
                padding: new EdgeInsets.only(
                    left: height * 0.01, right: height * 0.02),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        _navigation.popNavigation(context);
                      },
                      child: Icon(
                        Icons.cancel,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: height * 0.77,
                width: MediaQuery.of(context).size.width,
                child: Center(
                    child: PageView(
                  controller: controllerDetect,
                  onPageChanged: (index) {
                    setState(() {
                      page = index;
                    });
                  },
                  children: [
                    PhotoView(
                      backgroundDecoration: BoxDecoration(
                        color: Colors.black54,
                      ),
                      imageProvider: MemoryImage(this.newImage),
                    ),
                    PhotoView(
                      backgroundDecoration: BoxDecoration(
                        color: Colors.black54,
                      ),
                      imageProvider: MemoryImage(this.oldImage),
                    )
                  ],
                )),
              ),
              Container(
                color: Colors.black54,
                height: height * 0.05,
                child: Center(
                  child: Indicator(
                    controller: controllerDetect,
                    itemCount: 2,
                  ),
                ),
              ),
              Container(
                margin: new EdgeInsets.only(top: 1),
                height: height * 0.1 - 1,
                width: MediaQuery.of(context).size.width,
                color: Colors.black54,
                child: Container(
                  height: this.height * 0.1,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () => {
                            showEdit(),
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FontAwesome5.edit,
                                size: 20,
                                color: Colors.white,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(
                                  'Edit',
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () => {showSaveView(context)},
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.save_alt,
                                size: 25,
                                color: Colors.white,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(
                                  'Save',
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            BlocProvider.of<PhotoViewBloc>(context)
                              ..add(PhotoViewEventPost(this.page, this.oldImage,
                                  this.newImage, context));
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.face,
                                size: 25,
                                color: Colors.white,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(
                                  'Detect',
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () => {ShowShareView()},
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FontAwesome.external_link,
                                size: 20,
                                color: Colors.white,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(
                                  'Share',
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: height,
            color: Colors.grey.withOpacity(0.8),
            child: Center(
              child: Container(
                height: height * 0.25,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                            state.isFalse
                                ? "Đã xảy ra lỗi\n Vui lòng thử lại!"
                                : "Đang rút trích khuôn mặt\n Vui lòng chờ trong giây lát!",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black87,
                                fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center),
                      ),
                      Container(
                        height: height * 0.1,
                        width: height * 0.1,
                        child: state.isFalse
                            ? Icon(
                                FontAwesome.frown_o,
                                size: 35,
                                color: Color(0xff56AAE7),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: ColorLoader3(),
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: !state.isFalse
                            ? Container()
                            : RaisedGradientButton(
                                height: 40,
                                width: 160,
                                child: Text(
                                  state.isFalse
                                      ? AppTranslations.of(context)
                                          .text("OK")
                                          .toString()
                                      : AppTranslations.of(context)
                                          .text("Cancel")
                                          .toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                onPressed: () async {
                                  BlocProvider.of<PhotoViewBloc>(context)
                                    ..add(PhotoViewEventStart(this.page,
                                        this.oldImage, this.newImage));
                                }),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  ShowShareView() async {
    final RenderBox box = context.findRenderObject();
    var image = null;
    if (page == 1)
      image = this.newImage;
    else
      image = oldImage;
    final File imageFile = await writeFile(image);
    await Share.shareFiles([imageFile.path],
        text: 'image recovery',
        subject: 'image',
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size / 2);
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    var path = await _localPath;
    final DateTime now = DateTime.now();
    int value = now.millisecondsSinceEpoch;
    var directory =
        getExternalStorageDirectories(type: StorageDirectory.pictures);
    directory.then((value) => {path = value[0].path});
    return File('$path/Image-$value.png');
  }

  Future<File> writeFile(Uint8List data) async {
    final file = await _localFile;
    return file.writeAsBytes(data);
  }

  Future<void> showSaveView(BuildContext context) async {
    var image = null;
    if (page == 1)
      image = this.newImage;
    else
      image = oldImage;
    final File imageFile = await writeFile(image);
    GallerySaver.saveImage(imageFile.path, albumName: 'ImageRecovery')
        .then((bool success) {
      _showToast(context);
    });
  }

  void _showToast(BuildContext context) {
    Fluttertoast.showToast(
        msg: "Saved",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        fontSize: 16.0);
  }
  showEdit() {
    if (this.page == 1) {
      var param = {"image": this.newImage};
      _navigation.pushNavigation<Uint8List>(NamePage.detailImagePage, params: param);
    } else {
      var param = {"image": this.oldImage};
      _navigation.pushNavigation<Uint8List>(NamePage.detailImagePage, params: param);
    }
  }
}
