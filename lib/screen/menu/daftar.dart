import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pelelangan/core/api_koneksi.dart';

class Daftar extends StatefulWidget {
  const Daftar({Key? key}) : super(key: key);

  @override
  State<Daftar> createState() => _DaftarState();
}

class _DaftarState extends State<Daftar> {
  var fromKey = GlobalKey<FormState>();
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  var namaController = TextEditingController();
  var alamatController = TextEditingController();
  var isObsecure = true.obs;

  void validateUserName() async {
    try {
      var res = await http.post(Uri.parse(API.validasiUsername), body: {
        'username': usernameController.text.trim(),
      });
      if (res.statusCode == 200) {
        var resBody = jsonDecode(res.body);

        if (resBody['Berhasil'] == true) {
          // Fluttertoast.showToast(
          // msg: "Username Sudah dipakai. Coba yang lain.");
        } else {
          // registerAndSaveUserRecord();
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

  // registerAndSaveUserRecord() async
  // {
  //   User userModel = User.fromJson(
  //     1,
  //     usernameController.text.trim(),
  //     passwordController.text.trim(),
  //     namaController.text.trim(),
  //     );
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Daftar Akun',

        // theme: ThemeData(
        //     primaryColor: Color(0XFFF9BF3B),
        //     iconTheme: IconThemeData(color: Color(0XFFF9BF3B)),
        //     primaryIconTheme: IconThemeData(color: Color(0XFFF9BF3B))),
        home: Scaffold(
            body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 110, right: 30, left: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // SizedBox(height: 5.0),
                const Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Text('DAFTAR AKUN',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 103, 9, 158))),
                ),

                const SizedBox(height: 20.0),
                TextFormField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 103, 9, 158),
                              width: 8.0)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 103, 9, 158),
                              width: 1.0)),
                      hintText: 'Username',
                      prefixIcon: Icon(Icons.person,
                          color: Color.fromARGB(255, 103, 9, 158))),
                  obscureText: true,
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(
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
                  obscureText: true,
                ),
                const SizedBox(height: 10),

                TextFormField(
                  controller: namaController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 103, 9, 158),
                              width: 1.0)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 103, 9, 158),
                              width: 1.0)),
                      hintText: 'Nama',
                      prefixIcon: Icon(Icons.person,
                          color: Color.fromARGB(255, 103, 9, 158))),
                ),
                const SizedBox(height: 10),

                TextFormField(
                  controller: alamatController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 103, 9, 158),
                              width: 1.0)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 103, 9, 158),
                              width: 1.0)),
                      hintText: 'Alamat',
                      prefixIcon: Icon(Icons.person,
                          color: Color.fromARGB(255, 103, 9, 158))),
                ),
                const SizedBox(height: 20.0),
                InkWell(
                  splashColor: Colors.red,
                  onTap: () {
                    if (fromKey.currentState!.validate()) validateUserName();
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: [
                          Color.fromARGB(255, 196, 65, 223),
                          Color.fromARGB(255, 103, 9, 158)
                        ]),
                        borderRadius: BorderRadius.circular(100.0)),
                    child: const Text('Daftar',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 20.0)),
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('Jika Sudah Punya Akun ? '),
                    const SizedBox(width: 5.0),
                    InkWell(
                      onTap: () {},
                      child: const Center(
                        child: Text('Login',
                            style: TextStyle(
                                color: Color.fromARGB(255, 202, 47, 249))),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        )));
  }
}
