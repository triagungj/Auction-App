import 'package:flutter/material.dart';
import 'package:pelelangan/core/key_constant.dart';
import 'package:pelelangan/screen/ikan/tambah_ikan.dart';
import 'package:pelelangan/screen/menu.dart';
import 'package:get/get.dart';
import 'package:pelelangan/screen/menu/home.dart';
import 'package:pelelangan/screen/menu/login.dart';
import 'package:pelelangan/screen/ikan/detail_ikan.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<bool> isLogin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(keyIsAdmin);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: isLogin(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: '/Menu',
              // initialRoute: snapshot.data! ? '/Menu' : '/Login',
              routes: {
                '/Login': (context) => const Login(),
                '/Menu': (context) => Menu(
                      isAdmin: snapshot.data!,
                    ),
                '/Home': (context) => const Home(),
                '/TambahIkan': (context) => const TambahIkan(),
                '/DetailIkan': (context) => DetailIkan(
                      noLelang: Get.arguments as String,
                    )
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
