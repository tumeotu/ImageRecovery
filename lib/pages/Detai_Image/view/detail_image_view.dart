import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get_it/get_it.dart';
import 'package:image_recovery/modules/phananhtructuyen/widgets/progress_loading.dart';
import 'dart:typed_data';
import 'package:image_recovery/pages/Detai_Image/bloc/DetailImageBloc.dart';
import 'package:image_recovery/pages/Detai_Image/event/DetailImageEvent.dart';
import 'package:image_recovery/pages/Detai_Image/state/DetailImageState.dart';
import 'package:image_recovery/utils/navigations/navigation_datasource.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';

import '../../../routes.dart';
class DetailImageHome extends StatefulWidget {
  @override
  _DetailImageHomeState createState() => _DetailImageHomeState();
}

class _DetailImageHomeState extends State<DetailImageHome> {
  Uint8List provider;
  final _navigation = GetIt.instance.get<NavigationDataSource>();
  double height=0.0;
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xff56AAE7),//or set color with: Color(0xFF0000FF)
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

  @override
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
    height= MediaQuery.of(context).size.height-MediaQuery.of(context).padding.top;
    return BlocBuilder<DetailImageBloc, DetailImageState>(
      builder: (context, state) {
        if (state is DetailImageMainStateInitial) {
          return ProgressLoading();
        } 
        else if(state is DetailImageMainStateStart)
          {
            if(state.image!=null)
            {
              provider= state.image;
            }
            return getDefaultView(state, context);
          }
        return Container();
      },
    );
  }

  getDefaultView(DetailImageMainStateStart state, BuildContext context) {
    return Container(
      color: Colors.blue.withOpacity(0.1),
      child: Column(
        children: [
          Container(
            color: Colors.black12.withOpacity(0.1),
            height: this.height*0.07,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: (){
                    _navigation.popNavigation(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child:Icon(
                        FontAwesome.angle_left,
                      size: 35,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
              height: this.height*0.8,
              width: MediaQuery.of(context).size.width,
              color: Colors.black12.withOpacity(0.1),
              child: provider==null?ProgressLoading():Image.memory(provider),
          ),
          Container(
            height: this.height*0.03,
            width: MediaQuery.of(context).size.width,
            color: Colors.black12.withOpacity(0.1),
          ),
          Container(
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
                      ShowEditView()
                    },
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesome5.edit,
                            size: 20,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Text('Edit'),
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
                      showSaveView(state, context)
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.save_alt,
                          size: 25,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: Text('Save'),
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
                      ShowShareView(state)
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                            FontAwesome.external_link,
                          size: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: Text('Share'),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ShowEditView() async {
    var param={
      "image": provider
    };
    Uint8List params = await _navigation.pushNavigation<Uint8List>(NamePage.editPage,params: param);
    if(params!=null)
      {
        BlocProvider.of<DetailImageBloc>(context)
          ..add(
              DetailImageEventStart(params));
      }

  }

  ShowShareView(DetailImageMainStateStart state) async {
    final RenderBox box = context.findRenderObject();
    final File imageFile= await writeFile(provider);
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

  Future<void> showSaveView(DetailImageMainStateStart state, BuildContext context) async {
    final File imageFile= await writeFile(provider);
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
