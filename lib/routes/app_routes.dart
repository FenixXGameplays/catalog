

import 'package:catalog/routes/app_pages.dart';
import 'package:catalog/screens/addmovie.dart';
import 'package:catalog/screens/editmovie.dart';
import 'package:catalog/screens/list.dart';
import 'package:get/get.dart';

abstract class AppRoutes {

  static final pages = [
    GetPage(name: Routes.LISTADO, page:() => const ListMovie(), transition: Transition.native),
    GetPage(name: Routes.ADD, page:() => const AddMovie(), transition: Transition.native),
    GetPage(name: Routes.EDIT, page:() => const EditMovie(), transition: Transition.native),
  ];
}