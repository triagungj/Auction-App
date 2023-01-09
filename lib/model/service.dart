import 'dart:convert';

import 'package:pelelangan/core/key_constant.dart';
import 'package:pelelangan/model/data_class.dart';
import 'package:http/http.dart' as http;
import 'package:pelelangan/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LelangService {
  Future<List<Lelang>> listLelang() async {
    final uri = Uri.parse(
      '$apiPath/lelang/api/lelang_ikan/api_tampil.php',
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((e) => Lelang.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<Lelang>> listLelangku(String? idUser) async {
    final uri = Uri.parse(
      '$apiPath/lelang/api/lelang_ikan/list_lelangku.php?id_user=${idUser ?? ''}',
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((e) => Lelang.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<DetailLelang> detailLelang(String id) async {
    final uri = Uri.parse(
      '$apiPath/lelang/api/lelang_ikan/detail_lelang.php?no_lelang=$id',
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return DetailLelang.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<DefaultClass> mulaiLelang(String id) async {
    final uri = Uri.parse(
      '$apiPath/lelang/api/lelang_ikan/mulai_lelang.php',
    );

    final response = await http.post(uri, body: {
      'no_lelang': id,
    });

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return DefaultClass.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<DefaultClass> selesaiLelang(String id) async {
    final uri = Uri.parse(
      '$apiPath/lelang/api/lelang_ikan/selesai_lelang.php',
    );

    final response = await http.post(uri, body: {
      'no_lelang': id,
    });

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return DefaultClass.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<DefaultClass> hapusLelang(String id) async {
    final uri = Uri.parse(
      '$apiPath/lelang/api/lelang_ikan/hapus_lelang.php',
    );

    final response = await http.post(uri, body: {
      'no_lelang': id,
    });

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return DefaultClass.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<DefaultClass> joinLelang(
    String idUser,
    String noLelang,
    String hargaLelang,
  ) async {
    final uri = Uri.parse(
      '$apiPath/lelang/api/lelang_ikan/join_lelang.php',
    );

    final response = await http.post(uri, body: {
      'no_lelang': noLelang,
      'id_user': idUser,
      'harga_lelang': hargaLelang,
    });

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return DefaultClass.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<RiwayatLelang>> getRiwayat() async {
    final prefs = await SharedPreferences.getInstance();
    final idUser = prefs.getString(keyIdUserPref);

    final uri = Uri.parse(
      '$apiPath/lelang/api/lelang_ikan/riwayat_lelang.php?id_user=${idUser ?? ''}',
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((e) => RiwayatLelang.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<RiwayatLelang> getDetailRiwayat(String noLelang) async {
    final uri = Uri.parse(
      '$apiPath/lelang/api/lelang_ikan/riwayat_lelang_detail.php?no_lelang=$noLelang',
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return RiwayatLelang.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load data');
    }
  }
}

class AkunService {
  Future<bool> getLogin(String username, String password) async {
    var url = Uri.parse('$apiPath/lelang/api/user/login.php');
    final response = await http.post(url, body: {
      "username": username,
      "password": password,
    });

    var data = jsonDecode(response.body);
    if (data['status'] == "User" || data['status'] == "Admin") {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (data['status'] == "User") {
        final user = Users.fromJson(data['data']);
        prefs.setString(keyIdUserPref, user.id_user!);
        prefs.setBool(keyIsAdmin, false);
      } else {
        prefs.setBool(keyIsAdmin, true);
      }
      return true;
    } else {
      return false;
    }
  }

  Future<Users> fetchAkun() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final id = prefs.getString(keyIdUserPref);
    var url = Uri.parse('$apiPath/lelang/api/user/akun.php?id_user=$id');
    final response = await http.get(url);
    final body = jsonDecode(response.body);

    return Users.fromJson(body);
  }
}
