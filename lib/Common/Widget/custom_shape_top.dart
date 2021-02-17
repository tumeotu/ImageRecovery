import 'package:flutter/material.dart';

class TopShape extends StatelessWidget {

  TopShape({
    Key key,
  }) : super(key: key) {}
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ClipPath(
        clipper: CustomShapeTopClipper(),
        child: Container(height: MediaQuery.of(context).size.height/2.5,color: Color(0xff56AAE7),),
      ),
    );
  }

}

class CustomShapeTopClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double radius=size.height/1.6;
    Path path = Path()
      ..addOval(Rect.fromCircle(center: Offset(size.height / 2,0), radius: size.height/2))
      ..addRRect(RRect.fromRectAndRadius(
      Rect.fromLTWH(size.height/2,0, size.width-size.height/2, size.height/2), Radius.circular(0)))
      ..addOval(Rect.fromCircle(center: Offset(size.height / 2,0), radius: size.height/2))
      ..moveTo(size.width/2, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..arcToPoint(Offset(size.width/2, size.height/2), radius: Radius.circular(radius), clockwise: false)
      ..close();

    return path;
  }
  @override
  bool shouldReclip(CustomClipper oldClipper) => true;
}
// ..addOval(Rect.fromCircle(center: Offset(size.height / 2,0), radius: size.height/2))
// ..addRRect(RRect.fromRectAndRadius(
// Rect.fromLTWH(size.height/2,0, size.width-size.height/2, size.height/2), Radius.circular(0)))
// ..addOval(Rect.fromCircle(center: Offset(size.height / 2,0), radius: size.height/2))