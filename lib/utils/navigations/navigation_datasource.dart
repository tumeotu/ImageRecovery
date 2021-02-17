

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_recovery/routes.dart';
import 'package:sailor/sailor.dart';

abstract class NavigationDataSource{
   Future<T> pushNavigation<T>( NamePage namePage,{params});//@required NamePage namePage
   Future<T> pushMainAndRemoveAllNavigation<T>( BuildContext context);//@required NamePage namePage
   Future popNavigation( BuildContext context,{ params});//@required NamePage namePage
}