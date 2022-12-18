import 'package:flutter/material.dart';

class Jadwal extends StatefulWidget {
  const Jadwal({super.key});

  @override
  State<Jadwal> createState() => _JadwalState();
}

class _JadwalState extends State<Jadwal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Jadwal')),
      body: Container(
        child: Center(
          child: Text("Jadwal"),
        ),
      ),
    );
  }
}
