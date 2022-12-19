import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:pelelangan/core/key_constant.dart';
import 'package:pelelangan/model/class_user.dart';
import 'package:pelelangan/model/data_class.dart';
import 'package:http/http.dart' as http;
import 'package:pelelangan/model/user.dart';

class LelangService {
  Future<List<Lelang>> listLelang() async {
    final uri = Uri.http(
      apiPath,
      '/lelang/api/lelang_ikan/api_tampil.php',
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((e) => Lelang.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<Lelang> detailLelang(String id) async {
    final uri = Uri.http(
      apiPath,
      '/lelang/api/lelang_ikan/detail_lelang.php',
      {'no_lelang': id},
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return Lelang.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load data');
    }
  }
}

class Control extends GetxController {
  var listAkun = <Users>[].obs;
  var User = Users().obs;
}
