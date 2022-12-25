import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pelelangan/core/key_constant.dart';
import 'package:pelelangan/model/class_user.dart';
import 'package:pelelangan/model/user.dart';
import 'package:pelelangan/screen/widgets/loading_indator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class Akun extends StatefulWidget {
  const Akun({super.key});

  @override
  State<Akun> createState() => _AkunState();
}

class _AkunState extends State<Akun> {
  Future<Users> fetchAkun() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final id = prefs.getString(keyIdUserPref);
    var url = Uri.parse('$apiPath/lelang/api/user/akun.php?id_user=$id');
    final response = await http.get(url);
    final body = jsonDecode(response.body);
    print(body);

    return Users.fromJson(body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            setState(() {
              fetchAkun();
            });
          },
          child: ListView(
            children: [
              FutureBuilder<Users>(
                future: fetchAkun(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const LoadingIndicator();
                  }
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 25),
                        CircleAvatar(
                          minRadius: 10,
                          maxRadius: 100,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.network(
                              snapshot.data!.avatar != null
                                  ? '$imagePath/${snapshot.data!.avatar}'
                                  : dummyImagePath,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Text(
                                snapshot.data!.username!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                snapshot.data!.alamat!,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              if (snapshot.data!.no_hp != null)
                                Text(
                                  snapshot.data!.no_hp!,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        ListTile(
                          title: const Text('Logout'),
                          shape: const RoundedRectangleBorder(
                            side: BorderSide(color: Colors.black26),
                          ),
                          onTap: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.remove(keyIdUserPref);
                            Get.offAllNamed<void>('/Login');
                          },
                          trailing: Icon(Icons.logout),
                        ),
                      ],
                    );
                  }
                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
