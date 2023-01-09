import 'package:flutter/material.dart';
import 'package:pelelangan/model/data_class.dart';
import 'package:pelelangan/model/service.dart';
import 'package:pelelangan/screen/ikan/detail_riwayat.dart';
import 'package:pelelangan/screen/widgets/loading_indator.dart';
import 'package:pelelangan/screen/widgets/riwayat_card.dart';

class Riwayat extends StatefulWidget {
  const Riwayat({super.key});

  @override
  State<Riwayat> createState() => _RiwayatState();
}

class _RiwayatState extends State<Riwayat> {
  final lelang = LelangService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Riwayat Lelang')),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            lelang.getRiwayat();
          });
        },
        child: ListView(
          children: [
            FutureBuilder<List<RiwayatLelang>>(
              future: lelang.getRiwayat(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  List<RiwayatLelang> isiData = snapshot.data!;
                  if (isiData.isEmpty) {
                    return Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.4),
                      child: const Center(
                        child: Text('Belum ada Riwayat Lelang'),
                      ),
                    );
                  }

                  return Column(
                    children: List.generate(
                      isiData.length,
                      (index) => RiwayatCard(
                        riwayatLelang: isiData[index],
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailRiwayat(
                                riwayatLelang: isiData[index],
                              ),
                            ),
                          ).then((value) {
                            setState(() {
                              lelang.getRiwayat();
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
