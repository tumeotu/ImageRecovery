import 'package:flutter/material.dart';

class ProgressLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        semanticsLabel: "Loading ...",
      ),
    );
  }
}
