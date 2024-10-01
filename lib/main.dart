import 'package:catalog/controllers/moviesController.dart';
import 'package:catalog/routes/app_pages.dart';
import 'package:catalog/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put(Moviescontroller());
    return GetMaterialApp(
      getPages: AppRoutes.pages,
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.LISTADO,
      title: 'Movie List',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      
    );
  }
}