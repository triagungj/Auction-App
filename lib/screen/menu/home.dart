import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pelelangan/core/key_constant.dart';
import 'package:pelelangan/model/currency_format.dart';
import 'package:pelelangan/model/data_class.dart';
import 'package:pelelangan/model/service.dart';
import 'package:pelelangan/screen/ikan/detail_ikan.dart';
import 'package:pelelangan/screen/ikan/tambah_ikan%20copy.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final lelang = LelangService();
  late Future<List<Lelang>> ListData;

  @override
  void initState() {
    super.initState();
    ListData = lelang.listLelang();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Dashboard')),
        body: FutureBuilder(
          future: ListData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Lelang> isiData = snapshot.data!;
              return ListView.builder(
                  itemCount: isiData.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          '/DetailIkan',
                          arguments: isiData[index].no_lelang,
                        );
                      },
                      child: Card(
                        elevation: 0,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                child: Image.network(
                                  '$imagePath/${isiData[index].gambar}',
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Expanded(
                                  child: Container(
                                padding: EdgeInsets.only(bottom: 8, left: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${isiData[index].nama_ikan} (${isiData[index].berat} kg)',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      'Harga Awal: ${CurrencyFormat.convertToIdr(isiData[index].harga, 2)}',
                                    ),
                                  ],
                                ),
                              ))
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
