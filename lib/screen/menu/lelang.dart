import 'package:flutter/material.dart';

class Lelang extends StatefulWidget {
  const Lelang({super.key});

  @override
  State<Lelang> createState() => _LelangState();
}

class _LelangState extends State<Lelang> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lelang')),
      body: Container(
        child: Center(
          child: Text("Lelang"),
        ),
      ),
    );
  }
}
