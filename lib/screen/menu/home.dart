import 'package:flutter/material.dart';
import 'package:pelelangan/model/data_class.dart';
import 'package:pelelangan/model/service.dart';
import 'package:pelelangan/screen/widgets/ikan_card.dart';
import 'package:pelelangan/screen/widgets/loading_indator.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final lelang = LelangService();

  Future<List<Lelang>> getListLelang() async {
    return lelang.listLelang();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lelang')),
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
                        child: Text('Belum ada lelang yang ditambahkan'),
                      ),
                    );
                  }

                  return Column(
                    children: List.generate(
                      isiData.length,
                      (index) => IkanCard(
                        status: isiData[index].status,
                        no_lelang: isiData[index].no_lelang,
                        gambar: isiData[index].gambar,
                        harga: isiData[index].harga,
                        nama_ikan: isiData[index].nama_ikan,
                        tanggal: isiData[index].tanggal,
                        berat: isiData[index].berat,
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
