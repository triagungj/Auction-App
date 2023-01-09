import 'package:flutter/material.dart';
import 'package:pelelangan/core/key_constant.dart';
import 'package:pelelangan/model/service.dart';
import 'package:pelelangan/model/user.dart';
import 'package:pelelangan/screen/menu/edit_akun.dart';
import 'package:pelelangan/screen/widgets/confirm_dialog.dart';
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
                                alamat: snapshot.data!.alamat,
                                nohp: snapshot.data!.no_hp,
                                avatarUrl: snapshot.data?.avatar,
                              ),
                              const SizedBox(height: 20),
                              editAkun(
                                idUser: snapshot.data!.id_user!,
                                nama: snapshot.data!.username!,
                                alamat: snapshot.data?.alamat,
                                avatarUrl: snapshot.data?.avatar,
                                nohp: snapshot.data?.no_hp,
                              ),
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
        Center(
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(100),
            ),
            child: CircleAvatar(
              radius: 100,
              backgroundColor: Colors.grey.shade200,
              child: Image.network(
                avatarUrl != null ? '$imagePath/$avatarUrl' : dummyImagePath,
                fit: BoxFit.cover,
              ),
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

  Widget editAkun({
    required String idUser,
    required String nama,
    String? alamat,
    String? nohp,
    String? avatarUrl,
  }) {
    return ListTile(
      title: const Text('Edit Akun'),
      shape: const RoundedRectangleBorder(
        side: BorderSide(color: Colors.black26),
      ),
      onTap: () async {
        Get.to(
          () => EditAkun(
            idUser: idUser,
            nama: nama,
            alamat: alamat!,
            noHp: nohp!,
            avatarUrl: avatarUrl,
          ),
        )!
            .then((value) {
          setState(() {
            akunService.fetchAkun();
          });
        });
      },
      trailing: const Icon(Icons.edit),
    );
  }

  Widget logoutButton() {
    return ListTile(
      title: const Text('Logout'),
      iconColor: Colors.red,
      textColor: Colors.red,
      shape: const RoundedRectangleBorder(
        side: BorderSide(color: Colors.black26),
      ),
      onTap: () => Get.dialog(
        ConfirmDialog(
          title: 'Logout Akun?',
          confirmText: 'Logout',
          onConfirm: () async {
            {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.clear();
              Get.offAllNamed<void>('/Login');
            }
          },
        ),
      ),
      trailing: const Icon(Icons.logout),
    );
  }
}
