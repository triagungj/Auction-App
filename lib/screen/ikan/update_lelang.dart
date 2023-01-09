// ignore_for_file: depend_on_referenced_packages, no_leading_underscores_for_local_identifiers, deprecated_member_use

import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:async/async.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pelelangan/core/key_constant.dart';
import 'package:get/get.dart';
import 'package:pelelangan/model/data_class.dart';

class UpdateLelang extends StatefulWidget {
  const UpdateLelang({
    super.key,
    required this.detailLelang,
  });

  final DetailLelang detailLelang;

  @override
  State<UpdateLelang> createState() => _UpdateLelangState();
}

class _UpdateLelangState extends State<UpdateLelang> {
  final _formKey = GlobalKey<FormState>();

  File? image;
  bool isLoading = false;

  TextEditingController namaController = TextEditingController();
  TextEditingController beratController = TextEditingController();
  TextEditingController hargaController = TextEditingController();
  TextEditingController keteranganController = TextEditingController();

  Future gallery(ImageSource source) async {
    final _image = await ImagePicker().pickImage(
      source: source,
    );
    // image = File(imageGallery!.path);
    if (_image != null) {
      setState(() {
        image = File(_image.path);
        // _load = false;
      });
    }
  }

  String? inputValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Wajib Diisi';
    }
    return null;
  }

  void tambah() async {
    setState(() {
      isLoading = true;
    });
    try {
      var url = Uri.parse('$apiPath/lelang/api/lelang_ikan/edit_lelang.php');
      var request = http.MultipartRequest("POST", url);
      if (image != null) {
        var stream = http.ByteStream(DelegatingStream.typed(image!.openRead()));
        var length = await image!.length();
        var multipartFile = http.MultipartFile(
          "image",
          stream,
          length,
          filename: path.basename(image!.path),
        );
        request.files.add(multipartFile);
      }

      request.fields['no_lelang'] = widget.detailLelang.no_lelang;
      request.fields['nama_ikan'] = namaController.text;
      request.fields['berat'] = beratController.text;
      request.fields['harga'] = hargaController.text;
      request.fields['keterangan'] = keteranganController.text;

      var response = await request.send();
      response.stream.transform(utf8.decoder).listen((value) {
        final data = jsonDecode(value);
        int valueGet = data['value'];
        String message = data['message'];
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
    namaController.text = widget.detailLelang.nama_ikan;
    beratController.text = widget.detailLelang.berat;
    hargaController.text = widget.detailLelang.harga.toString();
    keteranganController.text = widget.detailLelang.keterangan;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Edit Data Ikan"),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            if (isLoading) const LinearProgressIndicator(),
            ListView(
              padding: const EdgeInsets.all(20.0),
              children: [
                const SizedBox(height: 5),
                const Text(
                  'Ubah Data Lelang Ikan',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: namaController,
                  keyboardType: TextInputType.multiline,
                  validator: inputValidator,
                  decoration: const InputDecoration(
                    labelText: 'Nama Ikan',
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 103, 9, 158), width: 1.0),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: beratController,
                  keyboardType: TextInputType.number,
                  validator: inputValidator,
                  decoration: const InputDecoration(
                    labelText: 'Berat (KG)',
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 103, 9, 158),
                            width: 1.0)),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: hargaController,
                  keyboardType: TextInputType.number,
                  validator: inputValidator,
                  decoration: const InputDecoration(
                    labelText: 'Harga (Rupiah)',
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 103, 9, 158),
                            width: 1.0)),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: keteranganController,
                  keyboardType: TextInputType.multiline,
                  validator: inputValidator,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    labelText: 'Keterangan',
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 103, 9, 158),
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text('Tambah Gambar'),
                const SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.deepPurple.shade50,
                  ),
                  constraints: const BoxConstraints(
                    minHeight: 150,
                  ),
                  child: InkWell(
                    onTap: () {
                      gallery(ImageSource.gallery);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        image == null
                            ? Image.network(
                                '$imagePath/${widget.detailLelang.gambar}',
                                fit: BoxFit.fitHeight,
                                height: 100,
                              )
                            : Image.file(
                                image!,
                                fit: BoxFit.fitHeight,
                              ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 80.0),
              ],
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Container(
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
                      tambah();
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
