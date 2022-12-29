import 'package:flutter/material.dart';
import 'package:pelelangan/model/currency_format.dart';

class LelangCard extends StatelessWidget {
  const LelangCard({
    super.key,
    required this.nomor,
    required this.username,
    required this.harga,
  });

  final String nomor;
  final String username;
  final int harga;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            children: [
              Text(
                nomor,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  username,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Text(
                CurrencyFormat.convertToIdr(
                  harga,
                  2,
                ),
                style: const TextStyle(
                  fontSize: 16,
                ),
              )
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}
