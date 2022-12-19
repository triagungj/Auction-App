import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pelelangan/core/key_constant.dart';
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
        title: Text('Data Ikan'),
      ),
      body: FutureBuilder(
        future: listdata,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Lelang isiData = snapshot.data!;
            return Column(
              children: <Widget>[
                ClipRRect(
                  child: Image.network(
                    'http://$apiPath/lelang/api/image/${isiData.gambar}',
                  ),
                ),
                Text(
                  isiData.nama_ikan,
                ),
                Text(isiData.berat),
                Text(isiData.harga.toString()),
                Text(isiData.tanggal),
                Text(isiData.keterangan),
              ],
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
