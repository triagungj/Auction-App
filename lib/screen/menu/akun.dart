import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pelelangan/core/key_constant.dart';
import 'package:pelelangan/model/class_user.dart';
import 'package:pelelangan/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class Akun extends StatefulWidget {
  const Akun({super.key});

  @override
  State<Akun> createState() => _AkunState();
}

class _AkunState extends State<Akun> {
  var User = Users().obs;
  Future<void> AkunLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final id = prefs.getString("id_user");
    var url = Uri.http(
        apiPath, '/lelang/api/user/akun.php?id_user=$id', {'q': '{http}'});
    // var url = Uri.parse("http:192.168.0.117/lelang/api/user/login.php");
    final response = await http.get(url);
    final body = jsonDecode(response.body);
    print(body);

    User.value = Users.fromJson(body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: AkunLogin(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // var isiData = snapshot.data!
        }
        return Obx(
          () => Column(
            children: [
              Container(
                child: Text(User.value.id_user!),
              )
            ],
          ),
        );
      },
    ));
  }
}
