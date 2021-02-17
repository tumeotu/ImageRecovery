import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get_it/get_it.dart';
import 'package:image_recovery/modules/phananhtructuyen/widgets/progress_loading.dart';
import 'package:image_recovery/pages/DetectResult/Model/ImageResultDetect.dart';
import 'package:image_recovery/pages/DetectResult/bloc/DetectResultBloc.dart';
import 'package:image_recovery/pages/DetectResult/state/DetectResultState.dart';
import 'package:image_recovery/pages/PhotoView/Model/Indicator.dart';
import 'package:image_recovery/pages/PhotoView/bloc/PhotoViewBloc.dart';
import 'package:image_recovery/pages/PhotoView/state/PhotoViewState.dart';
import 'dart:typed_data';
import 'package:image_recovery/routes.dart';
import 'dart:ui' as ui;

import 'package:image_recovery/utils/navigations/navigation_datasource.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:sailor/sailor.dart';
import 'package:share/share.dart';
class DetectViewHome extends StatefulWidget {
  @override
  _DetectViewHomeState createState() => _DetectViewHomeState();
}

class _DetectViewHomeState extends State<DetectViewHome> {
  List<ImageResultDetect> images;
  Uint8List image;
  final _navigation = GetIt.instance.get<NavigationDataSource>();
  double height=0.0;
  final PageController controller = PageController(initialPage: 0);
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black12.withOpacity(0.8),//or set color with: Color(0xFF0000FF)
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
    return BlocBuilder<DetectViewBloc, DetectViewState>(
      builder: (context, state) {
        if (state is DetectViewStateInitial) {
          return ProgressLoading();
        } 
        else if(state is DetectViewStateStart)
          {
            this.images= state.image;
            return getFilterView(state);
          }
        return Container();
      },
    );
  }
  getFilterView(DetectViewStateStart stateFilter) {
    height= MediaQuery.of(context).size.height-MediaQuery.of(context).padding.top;
    return Container(
      color: Colors.black87,
      child: Column(
        children: [
          Container(
            height: height*0.07,
            color: Colors.black,
            padding: new EdgeInsets.only(right: height*0.02),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: (){
                    _navigation.popNavigation(context);
                  },
                  child: Icon(
                    Icons.cancel,
                    size: 30,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          Container(
            height: height
                *0.77,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child:PageView(
                controller: controller,
                onPageChanged: (index){
                  setState(() {
                    if(index==0)
                      this.image= images[0].ImageDetect;
                    if(index==1)
                      this.image= images[1].ImageDetect;
                  });
                },
                children: [
                  Container(
                    color: Colors.black,
                    child: Column(
                      children: [
                        Container(
                          height: height
                              *0.65,
                          child: PhotoView(
                            backgroundDecoration: BoxDecoration(
                              color: Colors.black54,
                            ),
                            imageProvider: MemoryImage(this.images[0].ImageDetect),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            "Tuổi: "+ this.images[0].age.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            "Giới tính: "+ this.images[0].gender.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18
                            ),
                          ),
                        ),
                        Text(
                          "Biểu cảm: "+ this.images[0].emotion.toString(),style:
                        TextStyle(
                            color: Colors.white,
                            fontSize: 18
                        ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.black,
                    child: Column(
                      children: [
                        Container(
                          height: height
                              *0.65,
                          child: PhotoView(
                            backgroundDecoration: BoxDecoration(
                              color: Colors.black54,
                            ),
                            imageProvider: MemoryImage(this.images[1].ImageDetect),
                          ),
                        ),
                        Text(
                          "Tuổi: "+ this.images[1].age.toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18
                          ),
                        ),
                        Text(
                          "Giới tính: "+ this.images[1].gender.toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18
                          ),
                        ),
                        Text(
                          "Biểu cảm: "+ this.images[1].emotion.toString(),style:
                        TextStyle(
                            color: Colors.white,
                            fontSize: 18
                        ),
                        )
                      ],
                    ),
                  ),
                ],
              )
            ),
          ),
          Container(
            color: Colors.black87,
            height: height
                *0.06,
            child: Center(
              child: Indicator(
                controller: controller,
                itemCount: 2,
              ),
            ),
          ),
          Container(
            margin: new EdgeInsets.only(top: 1),
            height: height
                *0.1-1,
            width: MediaQuery.of(context).size.width,
            color: Colors.black87,
            child: Container(
              height:this.height*0.1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      behavior:HitTestBehavior.translucent,
                      onTap: ()=>{
                        showSaveView(context)
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.save_alt,
                            size: 25,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      behavior:HitTestBehavior.translucent,
                      onTap: ()=>{
                        ShowShareView()
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesome.external_link,
                            size: 20,
                            color: Colors.white,
                          ),
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
  ShowShareView() async {
    final RenderBox box = context.findRenderObject();
    final File imageFile= await writeFile(this.image);
    await Share.shareFiles([imageFile.path],
        text: 'image recovery',
        subject: 'image',
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size/2);
  }
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    var path = await _localPath;
    final DateTime now= DateTime.now();
    int value= now.millisecondsSinceEpoch;
    var directory =  getExternalStorageDirectories(type: StorageDirectory.pictures);
    directory.then((value) => {
      path= value[0].path
    });
    return File('$path/Image-$value.png');
  }

  Future<File> writeFile(Uint8List data) async {
    final file = await _localFile;
    return file.writeAsBytes(data);
  }

  Future<void> showSaveView(BuildContext context) async {
    final File imageFile= await writeFile(this.image);
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
        fontSize: 16.0
    );
  }
}
