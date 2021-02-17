

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get_it/get_it.dart';
import 'package:image_recovery/Common/Widget/Button.dart';
import 'package:image_recovery/language/localization/app_translations.dart';
import 'package:image_recovery/modules/phananhtructuyen/widgets/progress_loading.dart';
import 'package:image_recovery/pages/DetectResult/Model/ImageResultDetect.dart';
import 'package:image_recovery/pages/RecoverImageDetail/bloc/RecoverImageDetailBloc.dart';
import 'package:image_recovery/pages/RecoverImageDetail/event/RecoverImageDetailEvent.dart';
import 'package:image_recovery/pages/RecoverImageDetail/state/RecoverImageDetailState.dart';
import 'package:image_recovery/pages/RecoverImageResult/model/ImageResult.dart';
import 'package:image_recovery/pages/home/model/ModelImage.dart';
import 'package:image_recovery/pages/home/model/bottomSheet.dart';
import 'package:image_recovery/routes.dart';
import 'package:image_recovery/utils/navigations/navigation_datasource.dart';
import 'package:image_recovery/widgets/appbar_custom.dart';
import 'package:image_recovery/widgets/color_loader.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../constants.dart';


class RecoverImageDetailPage extends StatefulWidget {
  @override
  _RecoverImageDetailPageState createState() => _RecoverImageDetailPageState();
}

class _RecoverImageDetailPageState extends State<RecoverImageDetailPage> {

  final _navigation = GetIt.instance.get<NavigationDataSource>();
  List<Color> colors = new List<Color>();

  List<ModelImage> images;
  double height;
  @override
  void initState() {
    super.initState();
    colors.add(Colors.blue);
    colors.add(Colors.green);
    colors.add(Colors.red);
    colors.add(Colors.amber);
    colors.add(Colors.cyanAccent);
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
        endTitle: 'Khôi Phục',
        actionRightTitle: (){
          // List<ImageResultDetect> detectes = new List<ImageResultDetect>();
          // detectes.add(new ImageResultDetect(images[0].image, 10, 'Nam', 'Vui'));
          // detectes.add(new ImageResultDetect(images[1].image, 20, 'Nu', 'Vui'));
          // var param={
          //   'image': detectes
          // };
          // _navigation.popNavigation(context);
          // _navigation.pushNavigation(NamePage.detectViewPage, params: param);

          List<ImageResult> list= new List<ImageResult>();
          for(int i=0;i<images.length;i++)
          {
            list.add(new ImageResult(images[i].image, images[i].image));
          }
          var param={
            'image': list
          };
          BlocProvider.of<RecoverImageDetailBloc>(context)
            ..add(
                RecoverImageDetailEventPost(list, context, true));
        },
        actionLeftIcon: (){
          _navigation.popNavigation(context);
        },
      ),
    );
  }

  _getCustomBody() {
    height= MediaQuery.of(context).size.height-MediaQuery.of(context).padding.top;
    return BlocBuilder<RecoverImageDetailBloc, RecoverImageDetailState>(
      builder: (context, state) {
        if (state is RecoverImageDetailStateInitial) {
          return ProgressLoading();
        } 
        else if(state is RecoverImageDetailStateStart)
          {
            if(!state.isRecover)
              {
                if(this.images!=null&&state.isCancelRecover!=true)
                {
                  for(int i=0;i< state.images.length;i++)
                  {
                    if(!this.images.contains(state.images[i]))
                    {
                      this.images.add(state.images[i]);
                    }
                  }
                }
                else
                  this.images= state.images;
                return _getCustomBodyView();
              }
            else{
              return _getCustomBodyViewRecover(state);
            }
          }
        return Container();
      },
    );
  }

  _getCustomBodyView() {
    return Container(
      padding: new EdgeInsets.only(left: 2, right: 2, top: 10),
      color: Colors.black12.withOpacity(0.1),
      child: GridView.builder(
        itemCount: images.length+1,
        gridDelegate:
        SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (BuildContext context, int index) {
          if(index== images.length){
            return getImageFromCamera();
          }
          else
          {
            if(images[index].image==null) {
              return ProgressLoading();
            }
          }
          return Container(
            margin: new EdgeInsets.all(2),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.memory(
                images[index].image,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }

  _getCustomBodyViewRecover(RecoverImageDetailStateStart stateStart) {
    return Stack(
      children: [
        Container(
          padding: new EdgeInsets.only(left: 2, right: 2, top: 10),
          color: Colors.black12.withOpacity(0.1),
          child: GridView.builder(
            itemCount: images.length+1,
            gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemBuilder: (BuildContext context, int index) {
              if(index== images.length){
                return getImageFromCamera();
              }
              else
              {
                if(images[index].image==null) {
                  return ProgressLoading();
                }
              }
              return Container(
                margin: new EdgeInsets.all(2),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.memory(
                    images[index].image,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: height,
            color: Colors.grey.withOpacity(0.8),
            child: Center(
              child: Container(
                height: height*0.25,
                width: MediaQuery.of(context).size.width*0.8,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)
                  ),
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
                          stateStart.isFalse?"Đã xảy ra lỗi\n Vui lòng thử lại!"
                          : "Đang khôi phục hình ảnh\n Vui lòng chờ trong giây lát!",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black87,
                            fontWeight: FontWeight.w600
                          ),
                            textAlign: TextAlign.center
                        ),
                      ),
                      Container(
                        height: height*0.1,
                        width: height*0.1,
                        child: stateStart.isFalse?
                            Icon(
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
                        child: !stateStart.isFalse ? Container()
                          :  RaisedGradientButton(
                            height: 40,
                            width: 160,
                            child: Text(
                              stateStart.isFalse?AppTranslations.of(context).text("OK").toString()
                                  : AppTranslations.of(context).text("Cancel").toString(),
                              style: TextStyle(
                                  color:Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                              ),
                            ),
                            onPressed: () async {
                              List<ImageResult> list= new List<ImageResult>();
                              for(int i=0;i<images.length;i++)
                              {
                                list.add(new ImageResult(images[i].image, images[i].image));
                              }
                              BlocProvider.of<RecoverImageDetailBloc>(context)
                                ..add(
                                    RecoverImageDetailEventPost(list, context, false));
                            }
                        ),
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

  getImageFromCamera() {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: ()=> showCupertinoModalBottomSheet(
        expand: true,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (contextModel, scroll) => ModalInsideModal(
          multi: true,
          ContinuePick: true,
          images: (List<ModelImage> imagesAdd){
            BlocProvider.of<RecoverImageDetailBloc>(context)
              ..add(
                  RecoverImageDetailEventStart(imagesAdd));
          },
        ),
      ),
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
}
