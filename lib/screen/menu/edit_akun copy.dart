// ignore_for_file: depend_on_referenced_packages, deprecated_member_use

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pelelangan/core/key_constant.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

class EditAkun extends StatefulWidget {
  const EditAkun({
    super.key,
    required this.idUser,
    required this.nama,
    required this.noHp,
    required this.alamat,
    this.avatarUrl,
  });

  final String idUser;
  final String nama;
  final String noHp;
  final String alamat;
  final String? avatarUrl;

  @override
  State<EditAkun> createState() => _EditAkunState();
}

class _EditAkunState extends State<EditAkun> {
  final _formKey = GlobalKey<FormState>();

  final namaController = TextEditingController();
  final noHpController = TextEditingController();
  final alamatController = TextEditingController();
  File? _image;

  bool isLoading = false;

  Future gallery(ImageSource source) async {
    final image = await ImagePicker().pickImage(
      source: source,
    );

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  void updateData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var url = Uri.parse('$apiPath/lelang/api/user/edit_akun.php');
      var request = http.MultipartRequest("POST", url);
      if (_image != null) {
        var stream =
            http.ByteStream(DelegatingStream.typed(_image!.openRead()));
        var length = await _image!.length();
        var multipartFile = http.MultipartFile(
          "image",
          stream,
          length,
          filename: path.basename(_image!.path),
        );
        request.files.add(multipartFile);
      }

      request.fields['id_user'] = widget.idUser;
      request.fields['username'] = namaController.text;
      request.fields['no_hp'] = noHpController.text;
      request.fields['alamat'] = alamatController.text;

      var response = await request.send();
      response.stream.transform(utf8.decoder).listen((value) {
        final data = jsonDecode(value);
        int valueGet = data['value'];
        String message = data['message'];
        log(message);
        if (valueGet == 1) {
          Get.snackbar(
            "Berhasil",
            message,
            backgroundColor: Colors.green,
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
          );
          Navigator.pop(context);
        } else {
          Get.snackbar(
            "Gagal",
            'Gagal Menambahkan Data',
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
          );
        }
      });
    } catch (e) {
      debugPrint("Error $e");
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    namaController.text = widget.nama;
    noHpController.text = widget.noHp;
    alamatController.text = widget.alamat;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Akun'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              Center(
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(100),
                      ),
                      child: CircleAvatar(
                        backgroundColor: Colors.grey.shade200,
                        radius: 100,
                        child: _image != null
                            ? Image.file(
                                _image!,
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                widget.avatarUrl != null
                                    ? '$imagePath/${widget.avatarUrl}'
                                    : dummyImagePath,
                              ),
                      ),
                    ),
                    Positioned(
                      bottom: 1,
                      right: 1,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(100),
                        ),
                        child: ColoredBox(
                          color: Colors.blue,
                          child: IconButton(
                            onPressed: () {
                              gallery(ImageSource.gallery);
                            },
                            icon: const Icon(Icons.edit, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: namaController,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  labelText: 'Nama',
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 103, 9, 158), width: 1.0),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: noHpController,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  labelText: 'No HP',
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 103, 9, 158), width: 1.0),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: alamatController,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  labelText: 'Alamat',
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 103, 9, 158), width: 1.0),
                  ),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [
                Color.fromARGB(255, 65, 165, 223),
                Color.fromARGB(255, 9, 24, 158)
              ]),
              borderRadius: BorderRadius.circular(100.0)),
          child: InkWell(
            onTap: isLoading
                ? null
                : () {
                    if (_formKey.currentState!.validate()) {
                      updateData();
                    }
                  },
            child: const Text(
              'Simpan',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
          ),
        ),
      ),
    );
  }
}
