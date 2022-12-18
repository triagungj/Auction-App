import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pelelangan/core/key_constant.dart';
import 'package:pelelangan/model/data_class.dart';
import 'package:pelelangan/model/service.dart';

class dataikan extends StatefulWidget {
  final String id_ikan;
  final String nama_ikan;
  final String berat;
  final int harga;
  final String tanggal;
  final String cover;
  final String keterangan;
  // const dataikan(this.ikan, {Key? key}) : super(key: key);
  const dataikan(this.id_ikan, this.nama_ikan, this.berat, this.harga,
      this.tanggal, this.cover, this.keterangan,
      {Key? key})
      : super(key: key);

  @override
  State<dataikan> createState() => _dataikanState(
      id_ikan, nama_ikan, berat, harga, tanggal, cover, keterangan);
}

class _dataikanState extends State<dataikan> {
  final String _id_ikan;
  final String _nama_ikan;
  final String _berat;
  final int _harga;
  final String _tanggal;
  final String _cover;
  final String _keterangan;

  _dataikanState(this._id_ikan, this._nama_ikan, this._berat, this._harga,
      this._tanggal, this._cover, this._keterangan);
  ListIkan2 ikan = ListIkan2();

  late Future<List<Ikan1>> listdata;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listdata = ikan.dataikan2(ikan.toString());
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
            List<Ikan1> isiData = snapshot.data!;
            return ListView.builder(
              itemCount: isiData.length,
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    ClipRRect(
                      child: Image.network(
                        'http://$apiPath/lelang/api/image/${isiData[index].cover}',
                      ),
                    ),
                    Text(
                      isiData[index].nama_ikan,
                    ),
                    Text(isiData[index].berat),
                    Text(isiData[index].harga.toString()),
                    Text(isiData[index].tanggal),
                    Text(isiData[index].keterangan),
                  ],
                );
              },
              // child: ListView(
              //
              // ),
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
