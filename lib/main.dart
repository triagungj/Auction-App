import 'package:flutter/material.dart';
import 'package:pelelangan/model/data_class.dart';
import 'package:pelelangan/screen/ikan/tambah_ikan.dart';
import 'package:pelelangan/screen/menu.dart';
import 'package:get/get.dart';
import 'package:pelelangan/screen/menu/akun.dart';
import 'package:pelelangan/screen/menu/home.dart';
import 'package:pelelangan/screen/menu/login.dart';
import 'package:pelelangan/screen/ikan/detail_ikan.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
      routes: {
        '/Menu': (context) => Menu(),
        '/Home': (context) => Home(),
        '/TambahIkan': (context) => TambahIkan(),
        '/DetailIkan': (context) => DetailIkan(
              noLelang: "6",
            )
      },
    );
  }
}
