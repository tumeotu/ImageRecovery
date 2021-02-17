import 'package:image_recovery/pages/HistoryRecover/event/HistoryRecoverEvent.dart';
import 'package:image_recovery/pages/HistoryRecover/model/Group.dart';
import 'package:image_recovery/widgets/color_loader.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get_it/get_it.dart';
import 'package:image_recovery/Common/Widget/Button.dart';
import 'package:image_recovery/data/apis/history_recover/HistoryDataSource.dart';
import 'package:image_recovery/language/localization/app_translations.dart';
import 'package:image_recovery/modules/phananhtructuyen/widgets/progress_loading.dart';
import 'package:image_recovery/pages/DetectResult/Model/ImageResultDetect.dart';
import 'package:image_recovery/pages/HistoryRecover/bloc/HistoryRecoverBloc.dart';
import 'package:image_recovery/pages/HistoryRecover/state/HistoryRecoverState.dart';
import 'package:image_recovery/pages/RecoverImageDetail/bloc/RecoverImageDetailBloc.dart';
import 'package:image_recovery/pages/RecoverImageDetail/event/RecoverImageDetailEvent.dart';
import 'package:image_recovery/pages/RecoverImageResult/model/ImageResult.dart';
import 'package:image_recovery/routes.dart';
import 'package:image_recovery/utils/navigations/navigation_datasource.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';


class HistoryRecoverPage extends StatefulWidget {
  final contextString;
  final pageController;
  HistoryRecoverPage({Key key, this.contextString, this.pageController}) : super(key: key);
  @override
  _HistoryRecoverPageState createState() => _HistoryRecoverPageState();
}

class _HistoryRecoverPageState extends State<HistoryRecoverPage> {
  final _navigation = GetIt.instance.get<NavigationDataSource>();
  List<HistoryDatasourceModel> images = new List<HistoryDatasourceModel>();
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
          body: _getCustomBody()
      ),
    );
  }
  _getCustomBody() {
    return BlocBuilder<HistoryRecoverBloc, HistoryRecoverState>(
      builder: (context, state) {
        if (state is HistoryRecoverStateInitial) {
          return _getCustomBodyInit();
        }
        else if(state is HistoryRecoverStateStart)
        {
          if(state.isGetDetail==false){
            if(this.images!=null)
              for(int i=0;i< state.images.length;i++)
              {
                if(!this.images.contains(state.images[i]))
                {
                  this.images.add(state.images[i]);
                }
              }
            else
              this.images= state.images;
            return _getCustomBodyView();
          }
          else{
            return _getCustomGetDetail();
          }
        }
        else if(state is HistoryRecoverStateFailure)
        {
          return _getCustomBodyFailure();
        }
        return Container();
      },
    );
  }
  _getCustomBodyInit() {
    return GridView.builder(
        itemCount: 30,
        gridDelegate:
        SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (BuildContext context, int index) {
          return ProgressLoading(
          );
        });
  }

  _getCustomBodyFailure() {
    return Stack(
      children: [
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.white.withOpacity(0.8),
            child: Center(
              child: Container(
                height: MediaQuery.of(context).size.height*0.25,
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
                            "Đã xảy ra lỗi\n Vui lòng thử lại!",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black87,
                                fontWeight: FontWeight.w600
                            ),
                            textAlign: TextAlign.center
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height*0.1,
                        width: MediaQuery.of(context).size.height*0.1,
                        child: Icon(
                          FontAwesome.frown_o,
                          size: 35,
                          color: Color(0xff56AAE7),
                        )
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: RaisedGradientButton(
                            height: 40,
                            width: 160,
                            child: Text(
                              AppTranslations.of(widget.contextString).text("OK").toString(),
                              style: TextStyle(
                                  color:Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                              ),
                            ),
                            onPressed: () async {
                              widget.pageController.animateToPage(0, duration: Duration(milliseconds: 20), curve: Curves.linear);
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

  _getCustomBodyView() {
    List<Group> imageGroup=[];
    int count=0;
    List<HistoryDatasourceModel> imagesTemp=[];
    for(int i=0;i<this.images.length;i++)
    {
      count++;
      imagesTemp.add(this.images[i]);
      try{
        final DateFormat formatter = DateFormat('MM - yyyy');
        final String date1= formatter.format(this.images[i].dateEdit);
        final String date2= formatter.format(this.images[i+1].dateEdit);
        if(date1!=date2)
        {
          imageGroup.add(new Group(count,imagesTemp));
          count=0;
          imagesTemp=[];
        }
      }
      catch(e){
        imageGroup.add(new Group(count,imagesTemp));
      }
    }
    return Container(
      padding: new EdgeInsets.only(left: 2, right: 2, top: 20),
      color: Colors.white,
      child:  ListView.builder(
        itemCount: imageGroup.length,
        itemBuilder: (BuildContext context, int index1){
          final DateFormat formatter = DateFormat('MM - yyyy');
          final String date= formatter.format(imageGroup[index1].items[0].dateEdit);
          return StickyHeader(
            header: new Container(
              height:30.0,
              color: Colors.blue.withOpacity(0.1),
              padding: new EdgeInsets.symmetric(horizontal: 12.0),
              alignment: Alignment.centerLeft,
              child: new Text(date,
                style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 18,fontWeight:
                FontWeight.bold),
              ),
            ),
            content: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: imageGroup[index1].items.length,
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (BuildContext context1, int index){
                return  Container(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: (){
                      // {
                      //   ImageResult data = new ImageResult(imageGroup[index1].items[index].oldImage,
                      //       imageGroup[index1].items[index].newImage);
                      //   var param={
                      //     'image': data
                      //   };
                      //   final _navigation = GetIt.instance.get<NavigationDataSource>();
                      //   _navigation.popNavigation(context);
                      //   _navigation.pushNavigation(NamePage.photoViewPage, params: param);
                      // }

                      BlocProvider.of<HistoryRecoverBloc>(context)
                        ..add(
                            HistoryRecoverEventStart(0, imageGroup[index1].items[index].iD,true, context, this.images));
                    },
                    child: Stack(
                      children: [
                        Container(
                          key: imageGroup[index1].items[index].keyRed,
                          color: Colors.white,
                          margin: new EdgeInsets.all(imageGroup[index1].items[index].minWidth/2),
                          child: Image.memory(
                            imageGroup[index1].items[index].newImage,
                            height: double.infinity,
                            width: double.infinity,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Container(
                          height: double.infinity,
                          width: imageGroup[index1].items[index].currentWidth,
                          child: Stack(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  margin: new EdgeInsets.all(imageGroup[index1].items[index].minWidth/2),
                                  child: Image.memory(
                                    imageGroup[index1].items[index].oldImage,
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
                                  width:  imageGroup[index1].items[index].minWidth,
                                  height: imageGroup[index1].items[index].minWidth,
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.translucent,
                                    onHorizontalDragStart: (s) {
                                      imageGroup[index1].items[index].startDx = s.globalPosition.dx;
                                      imageGroup[index1].items[index].startWidth=  imageGroup[index1].items[index].currentWidth;
                                    },
                                    onHorizontalDragUpdate: (a) {
                                      var _currentDx = a.globalPosition.dx;
                                      var newWidth = -( imageGroup[index1].items[index].startDx - _currentDx);
                                      setState(() {
                                        if (( imageGroup[index1].items[index].startWidth + newWidth) >=
                                            imageGroup[index1].items[index].minWidth) {
                                          imageGroup[index1].items[index].dx=-(_currentDx-newWidth);
                                          imageGroup[index1].items[index].currentWidth =
                                          ( imageGroup[index1].items[index].startWidth + newWidth);
                                        } else {
                                          imageGroup[index1].items[index].currentWidth =
                                              imageGroup[index1].items[index].minWidth;
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
        },
      ),
    );
  }

  _getCustomGetDetail() {
    return Stack(
      children: [
        _getCustomBodyView(),
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.white.withOpacity(0.8),
            child: Center(
              child: Container(
                height: MediaQuery.of(context).size.height*0.2,
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
                            "Vui lòng chờ trong giây lát!",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black87,
                                fontWeight: FontWeight.w600
                            ),
                            textAlign: TextAlign.center
                        ),
                      ),
                      Container(
                          height: MediaQuery.of(context).size.height*0.1,
                          width: MediaQuery.of(context).size.height*0.1,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: ColorLoader3(),
                          )
                      ),
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
}
