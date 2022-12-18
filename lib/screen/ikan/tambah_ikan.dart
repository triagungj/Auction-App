import 'dart:convert';
import 'dart:core';
import 'dart:developer';
import 'dart:io';
import 'dart:async';

import 'package:path/path.dart' as path;
import 'package:async/async.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pelelangan/core/key_constant.dart';
import 'package:get/get.dart';

class TambahIkan extends StatefulWidget {
  const TambahIkan({super.key});

  @override
  State<TambahIkan> createState() => _TambahIkanState();
}

class _TambahIkanState extends State<TambahIkan> {
  File? image;

  Future gallery(ImageSource source) async {
    final _image = await ImagePicker().pickImage(
      source: source,
    );
    // image = File(imageGallery!.path);
    setState(() {
      image = File(_image!.path);
      // _load = false;
    });
  }

  TextEditingController namaController = TextEditingController();
  TextEditingController beratController = TextEditingController();
  TextEditingController hargaController = TextEditingController();
  TextEditingController keteranganController = TextEditingController();

  void tambah() async {
    try {
      var stream = http.ByteStream(DelegatingStream.typed(image!.openRead()));
      var lenght = await image!.length();
      var url = Uri.http(apiPath, '/lelang/api/ikan/tambah_ikan.php');
      var request = http.MultipartRequest("POST", url);
      var multipartFile = http.MultipartFile(
        "image",
        stream,
        lenght,
        filename: path.basename(image!.path),
      );

      request.fields['nama_ikan'] = namaController.text;
      request.fields['berat'] = beratController.text;
      request.fields['harga'] = hargaController.text;
      request.fields['keterangan'] = keteranganController.text;
      request.files.add(multipartFile);

      var response = await request.send();
      response.stream.transform(utf8.decoder).listen((value) {
        final data = jsonDecode(value);
        int valueGet = data['value'];
        String message = data['message'];
        if (valueGet == 1) {
          Navigator.pop(context);
          print(message);
        } else {
          Navigator.pop(context);
          print(message);
        }
        //     var data = jsonDecode(value);
        //     if (data.toString() == "Berhasil") {
        //       Get.snackbar(
        //         "Berhasil Menambah Ikan",
        //         '',
        //         backgroundColor: Colors.blue,
        //         colorText: Colors.white,
        //         snackPosition: SnackPosition.TOP,
        //       );
        //       Navigator.of(context).pushNamed('/Menu');
        //     } else if (data.toString() == "Gagal") {
        //       Get.snackbar(
        //         "Gagal",
        //         'silahkan Isi kembali',
        //         backgroundColor: Colors.red,
        //         colorText: Colors.white,
        //         snackPosition: SnackPosition.TOP,
        //       );
        //     }
      });
    } catch (e) {
      debugPrint("Error $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Jual Ikan"),
        ),
        body: Container(
            padding: EdgeInsets.all(20.0),
            child: ListView(
              children: [
                Text(
                  'Masukan Informasi Ikan',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30.0, color: Colors.blue),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: namaController,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: 'Nama Ikan',
                    // prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 103, 9, 158),
                            width: 1.0)),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: beratController,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: 'Berat',
                    // prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 103, 9, 158),
                            width: 1.0)),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: hargaController,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: 'Harga',
                    // prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 103, 9, 158),
                            width: 1.0)),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: keteranganController,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: 'Keterangan',
                    // prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 103, 9, 158),
                            width: 1.0)),
                  ),
                ),
                SizedBox(height: 20.0),
                InkWell(
                    onTap: () {
                      gallery(ImageSource.gallery);
                    },
                    child: image == null
                        ? Image.asset(
                            "assets/img/Placeholder.png",
                            fit: BoxFit.cover,
                          )
                        : Image.file(
                            image!,
                            fit: BoxFit.cover,
                          )),
                SizedBox(height: 20.0),
                InkWell(
                  onTap: () {
                    tambah();
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          Color.fromARGB(255, 65, 165, 223),
                          Color.fromARGB(255, 9, 24, 158)
                        ]),
                        borderRadius: BorderRadius.circular(100.0)),
                    child: Text('Simpan',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 20.0)),
                  ),
                ),
              ],
            )));
  }
}
