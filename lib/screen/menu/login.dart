import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:pelelangan/core/key_constant.dart';
import 'package:pelelangan/model/class_user.dart';
import 'package:pelelangan/model/user.dart';
import 'package:pelelangan/screen/menu/daftar.dart';
import 'package:get_storage/get_storage.dart';
import 'home.dart';
import 'package:flutter/material.dart';
import 'package:pelelangan/screen/menu/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}
// enum LoginStatus { notSignIn, SignIn }

class _LoginState extends State<Login> {
  var User = Users().obs;
  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();
  Future<void> login() async {
    var url = Uri.http(apiPath, '/lelang/api/user/login.php', {'q': '{http}'});
    // var url = Uri.parse("http:192.168.0.117/lelang/api/user/login.php");
    final response = await http.post(url, body: {
      "username": username.text,
      "password": password.text,
    });

    var data = jsonDecode(response.body);
    if (data['status'] == "Berhasil") {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      User.value = Users.fromJson(data['data']);
      prefs.setString('id_user', User.value.id_user!);
      Get.snackbar(
        "Login Berhasil",
        'Selamat Datang',
        backgroundColor: Colors.blue,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      Navigator.of(context).pushNamed('/Menu');
    } else {
      Get.snackbar(
        "Password Salah",
        'silahkan Isi kembali',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  // cek salah password
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    // switch (_loginStatus) {
    //   case LoginStatus.notSignIn:
    return Scaffold(
        body: Container(
      // key: _key,
      child: Padding(
        padding: const EdgeInsets.only(top: 50, right: 30, left: 30),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 30.0),
              Center(
                child: Text('LOGIN',
                    style: TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 103, 9, 158))),
              ),
              SizedBox(height: 60),
              Text('Silahkan Masukan Username Dan Password Anda!!!',
                  style: TextStyle(
                      fontSize: 10.0, color: Color.fromARGB(255, 103, 9, 158))),
              SizedBox(height: 12.0),
              TextFormField(
                // validator: (e) {
                //   if (e!.isEmpty) {
                //     return " Tolong Masukan Username Dengan Benar";
                //   }
                // },
                // onSaved: (e) => username = e!,
                controller: username,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 103, 9, 158),
                            width: 1.0)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 103, 9, 158),
                            width: 1.0)),
                    hintText: 'Username',
                    prefixIcon: Icon(Icons.person,
                        color: Color.fromARGB(255, 103, 9, 158))),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: password,
                obscureText: isPasswordVisible ? false : true,
                // onSaved: (e) => username = e!,
                decoration: InputDecoration(
                    suffixIconConstraints:
                        const BoxConstraints(minWidth: 45, maxWidth: 46),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                      child: Icon(
                        isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.white70,
                        size: 22,
                      ),
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 103, 9, 158),
                            width: 8.0)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 103, 9, 158),
                            width: 1.0)),
                    hintText: 'Password',
                    prefixIcon: Icon(Icons.lock,
                        color: Color.fromARGB(255, 103, 9, 158))),
              ),
              SizedBox(height: 20.0),
              InkWell(
                splashColor: Colors.red,
                onTap: () {
                  login();
                  // check();
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => Daftar()));
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Color.fromARGB(255, 196, 65, 223),
                        Color.fromARGB(255, 103, 9, 158)
                      ]),
                      borderRadius: BorderRadius.circular(100.0)),
                  child: Text('Login',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 20.0)),
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Belum Punya Akun ? '),
                  SizedBox(width: 5.0),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Daftar(),
                          ));
                    },
                    child: Center(
                      child: Text('Daftar Sekarang',
                          style: TextStyle(
                              color: Color.fromARGB(255, 202, 47, 249))),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    ));
    // case LoginStatus.SignIn:
    //   return Dashboard();
    //   break;
  }
}
// }
