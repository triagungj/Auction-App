import 'package:flutter/material.dart';
import 'package:pelelangan/core/key_constant.dart';
import 'package:pelelangan/model/currency_format.dart';
import 'package:pelelangan/model/data_class.dart';

class RiwayatCard extends StatelessWidget {
  const RiwayatCard({
    super.key,
    required this.riwayatLelang,
    this.onTap,
  });

  final RiwayatLelang riwayatLelang;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: InkWell(
        onTap: onTap,
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
                  '$imagePath/${riwayatLelang.gambar}',
                  fit: BoxFit.fill,
                ),
              ),
              Expanded(
                  child: Container(
                padding: const EdgeInsets.only(bottom: 8, left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${riwayatLelang.nama_ikan} (${riwayatLelang.berat} KG)',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Harga Awal: ${CurrencyFormat.convertToIdr(riwayatLelang.harga, 2)}',
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Harga Terakhir: ${riwayatLelang.harga_terakhir != null ? CurrencyFormat.convertToIdr(riwayatLelang.harga_terakhir, 2) : '-'}',
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Tanggal: ${riwayatLelang.tanggal}',
                    ),
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
