import 'package:flutter/material.dart';

class BottomShape extends StatelessWidget {
  BottomShape({
    Key key,
  }) : super(key: key) {
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: new EdgeInsets.only(
          top: MediaQuery.of(context).size.height*0.83
      ),
      child: ClipPath(
        clipper: CustomShapeClipper(),
        child: Container(height: MediaQuery.of(context).size.height/8,color: Color(0xff56AAE7),),
      ),
    );
  }
}

class CustomShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var controlPoint1 = Offset(size.width*0.25, size.height - 100);
    var controlPoint2 = Offset(size.width*0.75, size.height);
    var endPoint = Offset(size.width, size.height - 50);

    Path path = Path()
      ..moveTo(size.width, size.height-50)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..lineTo(0, size.height-50)
      ..cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx,
          controlPoint2.dy, endPoint.dx, endPoint.dy)
      ..close();
    return path;
  }
  @override
  bool shouldReclip(CustomClipper oldClipper) => true;
}