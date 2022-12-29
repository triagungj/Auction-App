import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pelelangan/core/key_constant.dart';
import 'package:pelelangan/model/currency_format.dart';
import 'package:pelelangan/model/data_class.dart';
import 'package:pelelangan/model/service.dart';
import 'package:pelelangan/screen/widgets/lelang_card.dart';
import 'package:pelelangan/screen/widgets/loading_indator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailIkan extends StatefulWidget {
  final String noLelang;

  const DetailIkan({super.key, required this.noLelang});

  @override
  State<DetailIkan> createState() => _DetailIkanState();
}

class _DetailIkanState extends State<DetailIkan> {
  final ikan = LelangService();
  final hargaController = TextEditingController();
  final isLoading = ValueNotifier<bool>(false);

  Future<DetailLelang> getDetailLelang() async {
    final response = await ikan.detailLelang(widget.noLelang);

    return response;
  }

  Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyIdUserPref);
  }

  Future<bool> getPrevilege() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(keyIsAdmin) ?? false;
  }

  Future<void> selesaikanLelang(String noLelang) async {
    Get.dialog(
      const LoadingIndicator(),
      barrierDismissible: false,
    );
    final response = await ikan.selesaiLelang(noLelang);
    Get.back();

    if (response.status == 200) {
      Get.snackbar(
        "Berhasil",
        response.message,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } else {
      Get.snackbar(
        "Gagal",
        response.message,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    }
    setState(() {
      getDetailLelang();
    });
  }

  Future<void> memulaiLelang(String noLelang) async {
    Get.dialog(
      const LoadingIndicator(),
      barrierDismissible: false,
    );
    final response = await ikan.mulaiLelang(noLelang);
    Get.back();

    if (response.status == 200) {
      Get.snackbar(
        "Berhasil",
        response.message,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } else {
      Get.snackbar(
        "Gagal",
        response.message,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    }
    setState(() {
      getDetailLelang();
    });
  }

  Future<void> joinLelang(
    String noLelang,
    String userId,
    String harga,
  ) async {
    Get.dialog(
      const LoadingIndicator(),
      barrierDismissible: false,
    );
    final response = await ikan.joinLelang(
      userId,
      noLelang,
      harga,
    );
    Get.back();

    if (response.status == 200) {
      Get.snackbar(
        "Berhasil",
        response.message,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } else {
      Get.snackbar(
        "Gagal",
        response.message,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    }
    setState(() {
      getDetailLelang();
    });
  }

  @override
  void initState() {
    super.initState();
    isLoading.value = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Ikan'),
        actions: [
          IconButton(
            onPressed: () async {
              setState(() {
                getDetailLelang();
              });
            },
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: FutureBuilder<DetailLelang>(
        future: getDetailLelang(),
        builder: (context, snapshot) {
          if (!snapshot.hasData &&
              snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            DetailLelang isiData = snapshot.data!;
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              ClipRRect(
                                child: Image.network(
                                  '$imagePath/${isiData.gambar}',
                                  height: 120,
                                  width: 120,
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${isiData.nama_ikan} (${isiData.berat} KG)',
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Harga',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Text(
                                              CurrencyFormat.convertToIdr(
                                                  isiData.harga, 2),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Tanggal',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Text(
                                              isiData.tanggal,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 15),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Keterangan',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          isiData.keterangan,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(thickness: 5),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 20,
                          ),
                          child: Column(
                            children: [
                              const Text(
                                'Penawaran Tertinggi',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(height: 5),
                              const Divider(thickness: 2),
                              if (isiData.list_lelang_user.isEmpty)
                                const SizedBox(
                                  height: 200,
                                  child: Center(
                                    child: Text('Belum ada penawaran'),
                                  ),
                                ),
                              Column(
                                children: List.generate(
                                  isiData.list_lelang_user.length,
                                  (index) => LelangCard(
                                    nomor: (index + 1).toString(),
                                    username: isiData
                                        .list_lelang_user[index].username,
                                    harga: isiData
                                        .list_lelang_user[index].harga_lelang,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                if (snapshot.connectionState == ConnectionState.waiting)
                  const LinearProgressIndicator(),
                FutureBuilder<String?>(
                  future: getUserId(),
                  builder: (context, snapshotUserId) {
                    if (snapshotUserId.data == null) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            children: [
                              const Text('Status Lelang: '),
                              Text(
                                isiData.status.toUpperCase(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: isiData.status == 'mulai'
                                      ? Colors.red
                                      : null,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    if (snapshotUserId.hasData && snapshotUserId.data != null) {
                      final userId = snapshotUserId.data!;
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Text('Status Lelang: '),
                                  Text(
                                    isiData.status.toUpperCase(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: isiData.status == 'mulai'
                                          ? Colors.red
                                          : null,
                                    ),
                                  ),
                                  const Spacer(),
                                  if (userId == isiData.id_user)
                                    const Text('(Lelangku)'),
                                ],
                              ),
                              if (isiData.status == 'mulai' &&
                                  userId != isiData.id_user)
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        controller: hargaController,
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(
                                          labelText: 'Tawarkan Harga (Rupiah)',
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.auto,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    ElevatedButton(
                                      onPressed: () {
                                        joinLelang(
                                          isiData.no_lelang,
                                          userId,
                                          hargaController.text,
                                        );
                                      },
                                      child: const Text('Tawar'),
                                    ),
                                  ],
                                )
                            ],
                          ),
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
                if (isiData.status != 'selesai')
                  FutureBuilder<bool>(
                    future: getPrevilege(),
                    builder: (context, previlegeSnapshot) {
                      if (previlegeSnapshot.hasData &&
                          previlegeSnapshot.data!) {
                        return Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 15,
                              ),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: (isiData.status == 'baru')
                                      ? Colors.green
                                      : Colors.red,
                                ),
                                child: Container(
                                  margin: const EdgeInsets.all(15),
                                  child: Text(
                                    (isiData.status == 'baru')
                                        ? 'Mulai Pelelangan'
                                        : 'Selesaikan Pelelangan',
                                  ),
                                ),
                                onPressed: () {
                                  if (isiData.status == 'baru') {
                                    memulaiLelang(isiData.no_lelang);
                                  } else {
                                    selesaikanLelang(isiData.no_lelang);
                                  }
                                },
                              ),
                            ),
                          ],
                        );
                      }
                      return const SizedBox();
                    },
                  ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const SizedBox();
        },
      ),
    );
  }
}
