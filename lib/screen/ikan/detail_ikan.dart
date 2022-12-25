import 'package:flutter/material.dart';
import 'package:pelelangan/core/key_constant.dart';
import 'package:pelelangan/model/currency_format.dart';
import 'package:pelelangan/model/data_class.dart';
import 'package:pelelangan/model/service.dart';

class DetailIkan extends StatefulWidget {
  final String noLelang;

  const DetailIkan({super.key, required this.noLelang});

  @override
  State<DetailIkan> createState() => _DetailIkanState();
}

class _DetailIkanState extends State<DetailIkan> {
  final ikan = LelangService();

  late Future<Lelang> listdata;
  @override
  void initState() {
    super.initState();
    listdata = ikan.detailLelang(widget.noLelang);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Ikan'),
      ),
      body: FutureBuilder(
        future: listdata,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Lelang isiData = snapshot.data!;
            return Column(
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Keterangan',
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  isiData.keterangan,
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
