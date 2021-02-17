import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get_it/get_it.dart';
import 'package:image_recovery/language/localization/app_translations.dart';
import 'package:image_recovery/modules/phananhtructuyen/widgets/progress_loading.dart';
import 'package:image_recovery/pages/RecoverImageDetail/bloc/RecoverImageDetailBloc.dart';
import 'package:image_recovery/pages/RecoverImageDetail/event/RecoverImageDetailEvent.dart';
import 'package:image_recovery/pages/RecoverImageDetail/state/RecoverImageDetailState.dart';
import 'package:image_recovery/pages/RecoverImageResult/bloc/RecoverImageResultlBloc.dart';
import 'package:image_recovery/pages/RecoverImageResult/model/ImageResult.dart';
import 'package:image_recovery/pages/RecoverImageResult/state/RecoverImageResultState.dart';
import 'package:image_recovery/pages/home/model/ModelImage.dart';
import 'package:image_recovery/pages/home/model/bottomSheet.dart';
import 'package:image_recovery/routes.dart';
import 'package:image_recovery/utils/navigations/navigation_datasource.dart';
import 'package:image_recovery/widgets/appbar_custom.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:path_provider/path_provider.dart';

import '../../../constants.dart';


class RecoverImageResultPage extends StatefulWidget {
  @override
  _RecoverImageResultPageState createState() => _RecoverImageResultPageState();
}

class _RecoverImageResultPageState extends State<RecoverImageResultPage> {

  final _navigation = GetIt.instance.get<NavigationDataSource>();
  List<ImageResult> images;
  double height;
  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: _customAppBar(context),
        body: SafeArea(
          child: _getCustomBody(),
        )
      ),
    );
  }
  
  _customAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(heightNavigationBar),
      child: AppBarCustom(
        title: AppTranslations.of(context).text('RecoverImage').toString(),
        startColor: navigationBarColorEnd,
        endColor: navigationBarColorStart,
        iconMenu: FontAwesome.angle_left,
        endTitle: '',
        actionLeftIcon: (){
          _navigation.popNavigation(context);
        },
      ),
    );
  }
  
  _getCustomBody() {
    height= MediaQuery.of(context).size.height-MediaQuery.of(context).padding.top;
    return BlocBuilder<RecoverImageResultBloc, RecoverImageResultState>(
      builder: (context, state) {
        if (state is RecoverImageResultStateInitial) {
          return ProgressLoading();
        }
        else if(state is RecoverImageResultStateStart)
          {
            images= state.images;
            return _getCustomBodyView();
          }
        return Container();
      },
    );
  }
  _getCustomBodyView() {
    var list = new List<BoxFit>();
    list.add(BoxFit.fill);
    list.add(BoxFit.fitHeight);
    return Container(
      padding: new EdgeInsets.only(left: 2, right: 2, top: 10),
      color: Colors.black12.withOpacity(0.1),
      child: GridView.builder(
        itemCount: images.length,
        gridDelegate:
        SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            alignment: Alignment.center,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: (){
                var param= {
                  'image':images[index]
                };
                _navigation.pushNavigation(NamePage.photoViewPage, params: param);
              },
              child: Stack(
                children: [
                  Container(
                    key: images[index].keyRed,
                    color: Colors.white,
                    margin: new EdgeInsets.all(images[index].minWidth/2),
                    child: Image.memory(
                      images[index].NewImage,
                      height: double.infinity,
                      alignment: Alignment.center,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                    height: double.infinity,
                    width: images[index].currentWidth,
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            margin: new EdgeInsets.all(images[index].minWidth/2),
                            child: Image.memory(
                              images[index].OldImage,
                              height: double.infinity,
                              width: double.infinity,
                              alignment: Alignment.centerLeft,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            width:  images[index].minWidth,
                            height: images[index].minWidth,
                            child: GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onHorizontalDragStart: (s) {
                                images[index].startDx = s.globalPosition.dx;
                                images[index].startWidth=  images[index].currentWidth;
                              },
                              onHorizontalDragUpdate: (a) {
                                var _currentDx = a.globalPosition.dx;
                                var newWidth = -(images[index].startDx - _currentDx);
                                setState(() {
                                  final keyContext = images[index].keyRed.currentContext;
                                  final box = keyContext.findRenderObject() as RenderBox;

                                  if (( images[index].startWidth + newWidth) >=  images[index].minWidth
                                  &&( images[index].startWidth + newWidth)<=box.size.width) {
                                    images[index].dx=-(_currentDx-newWidth);
                                    images[index].currentWidth = ( images[index].startWidth + newWidth);
                                  } else if(( images[index].startWidth + newWidth)<= box.size.width) {
                                    images[index].currentWidth=  images[index].minWidth;
                                  }
                                });
                              },
                              child: Container(
                                decoration: new BoxDecoration(
                                  color: Colors.blue,
                                  shape: BoxShape.circle,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.keyboard_arrow_left),
                                    Icon(Icons.keyboard_arrow_right),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
