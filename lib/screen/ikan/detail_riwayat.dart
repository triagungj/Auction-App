import 'package:flutter/material.dart';
import 'package:pelelangan/core/key_constant.dart';
import 'package:pelelangan/model/currency_format.dart';
import 'package:pelelangan/model/data_class.dart';

class DetailRiwayat extends StatelessWidget {
  const DetailRiwayat({
    super.key,
    required this.riwayatLelang,
  });
  final RiwayatLelang riwayatLelang;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Riwayat'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Image.network('$imagePath/${riwayatLelang.gambar}'),
            ),
            const SizedBox(height: 5),
            rowTable('Nama Ikan', riwayatLelang.nama_ikan),
            rowTable('Berat', '${riwayatLelang.berat} KG'),
            rowTable(
              'Harga Awal',
              CurrencyFormat.convertToIdr(riwayatLelang.harga, 2),
            ),
            rowTable('Pemilik', riwayatLelang.nama_pemilik),
            rowTable(
              'Harga Terakhir',
              riwayatLelang.harga_terakhir != null
                  ? CurrencyFormat.convertToIdr(riwayatLelang.harga_terakhir, 2)
                  : '-',
            ),
            rowTable('Pelelang', riwayatLelang.nama_pelelang ?? '-'),
            rowTable('Tanggal', riwayatLelang.tanggal),
            const Divider(),
          ],
        ),
      ),
    );
  }

  Widget rowTable(String title, String value) {
    return Column(
      children: [
        const Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
