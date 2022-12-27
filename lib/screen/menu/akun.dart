import 'package:flutter/material.dart';
import 'package:pelelangan/core/key_constant.dart';
import 'package:pelelangan/model/service.dart';
import 'package:pelelangan/model/user.dart';
import 'package:pelelangan/screen/widgets/loading_indator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class Akun extends StatefulWidget {
  const Akun({super.key});

  @override
  State<Akun> createState() => _AkunState();
}

class _AkunState extends State<Akun> {
  final akunService = AkunService();

  Future<bool?> getPrevilege() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getBool(keyIsAdmin);
  }

  @override
  void initState() {
    super.initState();
    getPrevilege();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<bool?>(
          future: getPrevilege(),
          builder: (context, snapshotAccount) {
            final isAdmin = snapshotAccount.data;

            if (isAdmin != null && !isAdmin) {
              return RefreshIndicator(
                onRefresh: () async {
                  setState(() {
                    akunService.fetchAkun();
                  });
                },
                child: ListView(
                  children: [
                    FutureBuilder<Users>(
                      future: akunService.fetchAkun(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const LoadingIndicator();
                        }
                        if (snapshot.connectionState == ConnectionState.done &&
                            snapshot.hasData) {
                          return Column(
                            children: [
                              akunProfile(
                                nama: snapshot.data!.username!,
                                alamat: snapshot.data?.alamat,
                                avatarUrl: snapshot.data?.avatar,
                                nohp: snapshot.data?.no_hp,
                              ),
                              const SizedBox(height: 20),
                              logoutButton(),
                            ],
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  ],
                ),
              );
            } else if (isAdmin != null && isAdmin) {
              return Column(
                children: [
                  akunProfile(
                    nama: 'Admin',
                  ),
                  const SizedBox(height: 20),
                  logoutButton(),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget akunProfile({
    required String nama,
    String? alamat,
    String? nohp,
    String? avatarUrl,
  }) {
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
              avatarUrl != null ? '$imagePath/$avatarUrl' : dummyImagePath,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                nama,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 5),
              if (alamat != null)
                Text(
                  alamat,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              if (nohp != null)
                Text(
                  nohp,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
            ],
          ),
        )
      ],
    );
  }

  Widget logoutButton() {
    return ListTile(
      title: const Text('Logout'),
      shape: const RoundedRectangleBorder(
        side: BorderSide(color: Colors.black26),
      ),
      onTap: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.clear();
        Get.offAllNamed<void>('/Login');
      },
      trailing: const Icon(Icons.logout),
    );
  }
}
