import 'dart:io';
import 'dart:typed_data';
import 'package:circular_check_box/circular_check_box.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_recovery/modules/phananhtructuyen/widgets/progress_loading.dart';
import 'package:image_recovery/pages/home/model/ModelImage.dart';
import 'package:image_recovery/routes.dart';
import 'package:image_recovery/utils/navigations/navigation_datasource.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_manager/photo_manager.dart';
typedef Uint8ListCallBack = Function(Uint8List bytes);

class ModalInsideModal extends StatefulWidget {
  ModalInsideModal(
      {Key key,
        this.title,
        this.multi=false,
        this.isAvatarEdit=false,
        this.ContinuePick=false,
        this.images,
        this.methodChange
      }) : super(key: key);
  final String title;
  final bool multi;
  final bool isAvatarEdit;
  final bool ContinuePick;
  final images;
  final Uint8ListCallBack methodChange;
  @override
  _ModalInsideModalState createState() => _ModalInsideModalState();
}

class _ModalInsideModalState extends State<ModalInsideModal> {
  final getIt = GetIt.instance;
  final _navigation = GetIt.instance.get<NavigationDataSource>();
  int currentPage = 0;
  List<ModelImage> images= [];
  List<ModelImage> imagestemp= new List<ModelImage>();
  List<int> selected=[];
  int lastPage;
  @override
  void initState() {
    super.initState();
    _fetchNewMedia();
  }
  _handleScrollEvent(ScrollNotification scroll) {
    if (scroll.metrics.pixels / scroll.metrics.maxScrollExtent > 0.33) {
      if (currentPage != lastPage) {
        _fetchNewMedia();
      }
    }
  }
  _fetchNewMedia() async {
    lastPage = currentPage;
    var result = await PhotoManager.requestPermission();
    if (result) {
      List<AssetPathEntity> albums =
      await PhotoManager.getAssetPathList(type: RequestType.image);
      var media = await albums[0].getAssetListPaged(currentPage, 30);
      for (var asset in media) {
        await asset.thumbDataWithSize(200, 200).then((value) => {
          asset.file.then((file) => {
            imagestemp.add(new ModelImage(file, value))
          })
        });
      }
      setState(() {
        images = imagestemp;
        currentPage++;
      });
    } else {
      print('fail');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Material(
        child: CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
              leading: Container(),
              middle: Text('Image Recovery'),
              trailing: selected.length!=0?GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () async {
                  Navigator.of(context).pop();
                  if(widget.multi) {
                      List<ModelImage> params= new List<ModelImage>();
                      for(int i=0;i< selected.length;i++){
                        params.add(images[selected[i]]);
                      }
                      var params1={
                        'image': params
                      };
                      if(widget.ContinuePick)
                          widget.images(params);
                      else
                        _navigation.pushNavigation(NamePage.detailImageRecoverPage, params: params1);
                  }
                  else {
                    if(widget.isAvatarEdit){
                      Uint8List image;
                      image= await testCompressFile(images[selected[0]].file);
                      widget.methodChange(image);
                    }
                    else{
                      Uint8List image;
                      image= await testCompressFile(images[selected[0]].file);
                      var params={
                        'image': image
                      };
                      _navigation.pushNavigation(NamePage.detailImagePage, params: params);
                    }
                  }
                },
                child: Icon(
                  Icons.send,
                  color: Color(0xff56AAE7)),
              ):
                SizedBox(width: 1,height: 1,)
          ),
          child: SafeArea(
            bottom: false,
            child: getBody(),
          ),
        ));
  }

  getBody() {
    if(images.length==0)
      return GridView.builder(
          itemCount: 50,
          gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemBuilder: (BuildContext context, int index) {
            return ProgressLoading(
            );
          });
    else
      return Container(
      color: Colors.white30,
      child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scroll) {
          _handleScrollEvent(scroll);
          return;
        },
        child: GridView.builder(
            itemCount: images.length+2,
            gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemBuilder: (BuildContext context, int index) {
              if(index==0) {
                  return getImageFromCamera();
              }
              if(index==1) {
                  return getImageFromLink();
              }
              return GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: (){
                  setState(() {
                    if(widget.multi) {
                        if(selected.indexOf(index-2)>0)
                        {
                          selected.removeAt(selected.indexOf(index-2));
                        }
                      }
                    else{
                      if(selected.length>=1)
                      {
                        images[selected[0]].ticked = false;
                        selected.removeAt(0);
                      }
                    }
                    selected.add(index-2);
                    images[index-2].ticked = !images[index-2].ticked;
                  });
                },
                child: Container(
                  margin: new EdgeInsets.all(2),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.memory(
                            images[index-2].image,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: CircularCheckBox(
                              value: images[index-2].ticked,
                              materialTapTargetSize: MaterialTapTargetSize.padded,
                              onChanged: (bool x) {
                                setState(() {
                                  if(x)
                                    {
                                      if(widget.multi)
                                        {
                                          selected.add(index-2);
                                        }
                                      else
                                      {
                                        selected.add(index-2);
                                        if(selected.length>1)
                                          {
                                            images[selected[0]].ticked = false;
                                            selected.removeAt(0);
                                          }
                                      }
                                    }
                                  else{
                                    selected.removeAt(selected.indexOf(index-2));
                                  }
                                  images[index-2].ticked = !images[index-2].ticked;
                                });
                              }
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
        ),
      ),
    );
  }

  getImageFromCamera() {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () async {
        File imageFile= await ImagePicker.pickImage(source: ImageSource.camera);
        Navigator.of(context).pop();
        if(widget.multi) {
          List<ModelImage> params= new List<ModelImage>();
          params.add(new ModelImage(imageFile, null));
          var params1={
            'image': params
          };
          if(widget.ContinuePick)
            widget.images(params);
          else
            _navigation.pushNavigation(NamePage.detailImageRecoverPage, params: params1);
        }
        else {
          Uint8List image;
          image= await testCompressFile(imageFile);
          var params={
            'image': image
          };
          _navigation.pushNavigation(NamePage.detailImagePage, params: params);
        }
      },
      child: Container(
        margin: new EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.5),
          borderRadius: BorderRadius.all(
              Radius.circular(10.0)
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
                Icons.camera,
              size: 35,
            ),
            Text('Camera')
          ],
        ),
      ),
    );
  }

  getImageFromLink() {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: (){
        showDialogLink();
      },
      child: Container(
        margin: new EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.5),
          borderRadius: BorderRadius.all(
              Radius.circular(10.0)
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.link,
              size: 35,
            ),
            Text('Link')
          ],
        ),
      ),
    );
  }

  Future<void> _download(String url) async {
    print(url);
    Dio dio = Dio();
    var path;
    final DateTime now= DateTime.now();
    int value= now.millisecondsSinceEpoch;
    var directory =  getExternalStorageDirectories(type: StorageDirectory.pictures);
    directory.then((value) => {
      path= value[0].path
    });
    try{
      String urlTemp= 'https://picsum.photos/250?image=9';
      Response response = await dio.get(
        urlTemp,
          onReceiveProgress: (rec, total) {
            setState(() {
              print(((rec / total) * 100).toStringAsFixed(0) + "%");
            });
          },
        //Received data with List<int>
        options: Options(
            responseType: ResponseType.bytes,
        ),
      );
      File file = File('$path/Image-$value.png');
      var raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
      Navigator.of(context).pop();
      if(widget.multi) {
        List<ModelImage> params= new List<ModelImage>();
        params.add(new ModelImage(file, null));
        var params1={
          'image': params
        };
        if(widget.ContinuePick)
          widget.images(params);
        else
          _navigation.pushNavigation(NamePage.detailImageRecoverPage, params: params1);
      }
      else {
        Uint8List image;
        image= await testCompressFile(file);
        var params={
          'image': image
        };
        _navigation.pushNavigation(NamePage.detailImagePage, params: params);
      }
    } catch (e) {
      print(e);
      showDialogFail();
    }
  }

  showDialogLink()
  {
    TextEditingController input= new TextEditingController();
    showGeneralDialog(
        transitionBuilder: (context, a1, a2, widget) {
          final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
          return Transform(
            transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
            child: Opacity(
              opacity: a1.value,
              child: AlertDialog(
                shape: new RoundedRectangleBorder(
                    borderRadius:
                    new BorderRadius.circular(16.0)),
                content: Builder(
                  builder: (context) {
                    return Wrap(
                      children: [
                        new Column(
                          children: <Widget>[
                            new Text('Nhập link',
                                style: new TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Color(0xff079bd2))),
                            new Padding(padding: EdgeInsets.only(top: 10.0)),
                            Container(
                              height: MediaQuery.of(context).size.height*0.15,
                              width: MediaQuery.of(context).size.width*1,
                              child: TextField(
                                controller: input,
                                maxLines: 6,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Nhập link hình ảnh...",
                                ),
                              ),
                            ),
                            new Padding(padding: EdgeInsets.only(top: 5.0)),
                            FlatButton(
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                  new BorderRadius.circular(8.0)),
                              color: Color(0xff079bd2),
                              onPressed: () async {
                                Navigator.of(context).pop();
                                 await _download(input.text.toString());
                              },
                              padding: new EdgeInsets.only(
                                  left: 80, right: 80, top: 10, bottom: 10),
                              child: Text(
                                'Xác nhận',
                                style: new TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 700),
        barrierDismissible: false,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {});
  }
  showDialogFail()
  {
    showGeneralDialog(
        transitionBuilder: (context, a1, a2, widget) {
          final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
          return Transform(
            transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
            child: Opacity(
              opacity: a1.value,
              child: AlertDialog(
                shape: new RoundedRectangleBorder(
                    borderRadius:
                    new BorderRadius.circular(16.0)),
                content: Builder(
                  builder: (context) {
                    return Wrap(
                      children: [
                        new Column(
                          children: <Widget>[
                            new Text('Lỗi',
                                style: new TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Color(0xff079bd2))),
                            new Padding(padding: EdgeInsets.only(top: 10.0)),
                            FlatButton(
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                  new BorderRadius.circular(8.0)),
                              color: Color(0xff079bd2),
                              onPressed: () => {
                                Navigator.of(context).pop(),
                              },
                              padding: new EdgeInsets.only(
                                  left: 80, right: 80, top: 10, bottom: 10),
                              child: Text(
                                'Xác nhận',
                                style: new TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 700),
        barrierDismissible: false,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {});
  }

  Future<Uint8List> testCompressFile(File file) async {
    var result = await FlutterImageCompress.compressWithFile(
      file.absolute.path,
      minWidth: 1080,
      minHeight: 1080,
      quality: 100,
      rotate: 0,
    );
    print(file.lengthSync());
    print(result.length);
    return result;
  }
}


