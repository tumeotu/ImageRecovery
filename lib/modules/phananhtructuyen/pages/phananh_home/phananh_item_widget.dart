import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_recovery/modules/phananhtructuyen/models/loaiphananh_danhmuc_model.dart';
import 'package:image_recovery/modules/phananhtructuyen/pages/phananh_home/phananh_home.dart';
import 'package:image_recovery/utils/color_extends.dart';

class PhanAnhItemWidget extends StatefulWidget {
  final LoaiPhanAnhDM item;
  final int index;
  final Function(LoaiViPham) showModalBottomSheetCallback;
  final AnimationController animationController;

  PhanAnhItemWidget(
      {@required this.item,
      @required this.index,
      this.animationController,
      Key key,
      this.showModalBottomSheetCallback})
      : super(key: key);

  @override
  _PhanAnhItemWidgetState createState() => _PhanAnhItemWidgetState();
}

class _PhanAnhItemWidgetState extends State<PhanAnhItemWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<Offset> _transformLoaiViPhamsAnimation;
  Animation<Offset> _transformContentAnimation;
  Animation<double> _turnsTweenAnimation;
  Animation<double> _opacityTweenAnimation;
  Animation<double> _scaleIconTweenAnimation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 750))
          ..addListener(() => setState(() {}));
//    _animationController = widget.animationController;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _transformLoaiViPhamsAnimation =
        Tween<Offset>(begin: Offset(-1.0, 0.0), end: Offset(0.0, 0.0)).animate(
            CurvedAnimation(
                curve: Interval(0.0, 0.9, curve: Curves.easeInBack),
                parent: _animationController));

    _transformContentAnimation =
        Tween<Offset>(begin: Offset(0.0, 0.0), end: Offset(1.0, 0.0)).animate(
            CurvedAnimation(
                curve: Interval(0.1, 1.0, curve: Curves.easeInOut),
                parent: _animationController));

    _turnsTweenAnimation = Tween<double>(begin: 175 / 180, end: 1).animate(
        CurvedAnimation(
            curve: Interval(0.95, 1.0, curve: Curves.easeIn),
            parent: _animationController));

    _opacityTweenAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            curve: Interval(0.6, 1.0, curve: Curves.easeOutBack),
            parent: _animationController));

    _scaleIconTweenAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            curve: Interval(0.0, 1.0, curve: Curves.easeOutBack),
            parent: _animationController));
  }

  @override
  void dispose() {
    super.dispose();
    _animationController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double heightItem =
        36.0 + 10.0 + 50.0; // title + SizedBox(margin) + content
    var listDanhMuc = widget.item.loaiViPhams;
    var content = widget.item.moTa ?? "";
    // khai báo widget
    Widget widgetContent = Container(),
        widgetIconButton = Container(),
        widgetContentLoaiVP = Container();

    if (widget.item != null && widget.item.moTa?.isNotEmpty == true) {
      widgetContent = Transform.translate(
        offset: _transformContentAnimation.value * screenWidth,
        child: Text(
          content,
          textAlign: TextAlign.left,
          style: TextStyle(
            color: ColorExtends.fromHex("#9fabb1"),
          ),
        ),
      );

      widgetIconButton = Align(
          alignment: Alignment.bottomRight,
          child: ScaleTransition(
            scale: _scaleIconTweenAnimation,
            child: Container(
              width: 22,
              height: 22,
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                  gradient: this.widget.item.gradient,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(width: 1, color: Colors.white)),
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 12,
              ),
            ),
          ));
    }
    if (widget.item != null && widget.item.loaiViPhams != null) {
      widgetContentLoaiVP = SizedBox(
        height: 50.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: listDanhMuc?.length,
          itemBuilder: (context, index) {
            return Transform.translate(
              offset: _transformLoaiViPhamsAnimation.value * (100.0 * index),
              child: RotationTransition(
                turns: _turnsTweenAnimation,
                child: FadeTransition(
                  opacity: _opacityTweenAnimation,
                  child: GestureDetector(
                    onTap: () {
                      var loaiViPhamItem =
                          listDanhMuc?.elementAt(index) ?? null;
                      this.widget.showModalBottomSheetCallback(loaiViPhamItem);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      margin: EdgeInsets.only(right: 8.0),
                      constraints:
                          BoxConstraints(minWidth: 36.0, maxWidth: 150.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        gradient: widget.item.gradient,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(listDanhMuc.elementAt(index).tenLoaiViPham,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.start,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    }
    return GestureDetector(
      onTap: _selectedItem,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        height: heightItem,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Image(
                image: AssetImage(this.widget.item.imagePhanAnh),
                width: 78,
                height: 78,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          this.widget.item.tenLoaiPhanAnh,
                          style: TextStyle(
                            color: ColorExtends.fromHex("#333b60"),
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Visibility(
                        visible: (widget.item.isSelected == true),
                        child: GestureDetector(
                          onTap: _selectedItem,
                          child: widgetIconButton,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Container(
                      width: screenWidth * 0.7,
                      child: Stack(
                        children: <Widget>[
                          widgetContentLoaiVP,
                          widgetContent,
                        ],
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _selectedItem() {
    // if (_animationController.isCompleted) {
    //   _animationController.reverse();
    // } else {
    //   _animationController.forward();
    // }
    BlocProvider.of<PhanAnhHomeBloc>(context).add(PhanAnhHomeEventSelectItem(
        item: widget.item,
        index: widget.index,
        animationController: _animationController));
  }
}
