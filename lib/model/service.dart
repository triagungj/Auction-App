import 'dart:convert';
import 'dart:math';

import 'package:get/get.dart';
import 'package:pelelangan/core/key_constant.dart';
import 'package:pelelangan/model/class_user.dart';
import 'package:pelelangan/model/data_class.dart';
import 'package:http/http.dart' as http;
import 'package:pelelangan/model/user.dart';

class ListIkan {
  Future<List<Ikan>> dataikan() async {
    final uri = Uri.http(
      apiPath,
      '/lelang/api/ikan/api_tampil.php',
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((e) => Ikan.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }
}

class ListIkan2 {
  Future<List<Ikan1>> dataikan2(String id_ikan) async {
    final uri = Uri.http(
      apiPath,
      '/lelang/api/ikan/api_tampil2.php?id_ikan=id_ikan',
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((e) => Ikan1.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }
}

class Control extends GetxController {
  var listAkun = <Users>[].obs;
  var User = Users().obs;
}
