// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:pelelangan/core/key_constant.dart';
import 'package:pelelangan/model/currency_format.dart';
import 'package:ribbon_widget/ribbon_widget.dart';

class IkanCard extends StatelessWidget {
  const IkanCard({
    super.key,
    required this.status,
    required this.no_lelang,
    required this.gambar,
    required this.harga,
    required this.nama_ikan,
    required this.tanggal,
    required this.berat,
  });
  final String nama_ikan;
  final String status;
  final String no_lelang;
  final String gambar;
  final String berat;
  final int harga;
  final String tanggal;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Ribbon(
        farLength: 50,
        nearLength: 30,
        location: RibbonLocation.topEnd,
        color: status == 'mulai' ? Colors.red : Colors.black,
        title: status.toUpperCase(),
        titleStyle: const TextStyle(
          color: Colors.greenAccent,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(
              '/DetailIkan',
              arguments: no_lelang,
            );
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
                    '$imagePath/$gambar',
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
                        '$nama_ikan ($berat kg)',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Harga Awal: ${CurrencyFormat.convertToIdr(harga, 2)}',
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Tanggal: $tanggal',
                      ),
                    ],
                  ),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
