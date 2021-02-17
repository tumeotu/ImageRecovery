import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_recovery/constants.dart';

class SelectionPickerIcon extends StatelessWidget {
  final isLoading;
  final isHaveData;

  const SelectionPickerIcon({this.isLoading, this.isHaveData});

  @override
  Widget build(BuildContext context) {
    if (isLoading == true) {
      return SizedBox(
        width: 25.0,
        height: 25.0,
        child: CircularProgressIndicator(),
      );
    } else {
      return Visibility(
          visible: isHaveData,
          child: Icon(
            Icons.arrow_drop_down,
            size: 28.0,
            color: placholderinput_color,
          ));
    }
  }
}
