import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pelelangan/core/key_constant.dart';
import 'package:pelelangan/model/currency_format.dart';
import 'package:pelelangan/model/data_class.dart';
import 'package:pelelangan/model/service.dart';
import 'package:pelelangan/screen/widgets/confirm_dialog.dart';
import 'package:pelelangan/screen/widgets/loading_indator.dart';
import 'package:ribbon_widget/ribbon_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Lelangku extends StatefulWidget {
  const Lelangku({super.key});

  @override
  State<Lelangku> createState() => _LelangkuState();
}

class _LelangkuState extends State<Lelangku> {
  final lelang = LelangService();

  Future<List<Lelang>> getListLelang() async {
    final prefs = await SharedPreferences.getInstance();
    final idUser = prefs.getString(keyIdUserPref);

    return lelang.listLelangku(idUser);
  }

  Future<void> hapusLelang(String noLelang) async {
    Get.closeAllSnackbars();
    Get.back();
    Get.dialog(
      const LoadingIndicator(),
      barrierDismissible: false,
    );
    final response = await lelang.hapusLelang(noLelang);
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
      getListLelang();
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lelangku')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .pushNamed(
            '/TambahIkan',
          )
              .then((value) {
            setState(() {
              getListLelang();
            });
          });
        },
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            getListLelang();
          });
        },
        child: ListView(
          children: [
            FutureBuilder<List<Lelang>>(
              future: getListLelang(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  List<Lelang> isiData = snapshot.data!;
                  if (isiData.isEmpty) {
                    return Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.4),
                      child: const Center(
                        child: Text('Kamu belum pernah melelangkan ikan'),
                      ),
                    );
                  }

                  return Column(
                    children: List.generate(
                      isiData.length,
                      (index) => Card(
                        elevation: 0,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        child: Ribbon(
                          farLength: 50,
                          nearLength: 30,
                          location: RibbonLocation.topEnd,
                          color: isiData[index].status == 'mulai'
                              ? Colors.red
                              : Colors.black,
                          title: isiData[index].status.toUpperCase(),
                          titleStyle: const TextStyle(
                              color: Colors.greenAccent,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(
                                '/DetailIkan',
                                arguments: isiData[index].no_lelang,
                              )
                                  .then((value) {
                                setState(() {
                                  getListLelang();
                                });
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 80,
                                    height: 80,
                                    child: Image.network(
                                      '$imagePath/${isiData[index].gambar}',
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          bottom: 8, left: 10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${isiData[index].nama_ikan} (${isiData[index].berat} kg)',
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            'Harga Awal: ${CurrencyFormat.convertToIdr(isiData[index].harga, 2)}',
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            'Tanggal: ${isiData[index].tanggal}',
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // if(isiData[index].status== 'selesai')
                                  //   Text(''),
                                  // elseif (isiData[index].status== 'baru'),

                                  IconButton(
                                    onPressed: () => Get.dialog(
                                      ConfirmDialog(
                                        title: 'Hapus Lelang',
                                        confirmText: 'Ya, Hapus',
                                        onConfirm: () {
                                          hapusLelang(
                                            isiData[index].no_lelang,
                                          );
                                        },
                                      ),
                                    ),
                                    icon: const Icon(
                                      Icons.delete,
                                      size: 22,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }
                return const LoadingIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }
}
