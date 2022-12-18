import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pelelangan/core/key_constant.dart';
import 'package:pelelangan/model/data_class.dart';
import 'package:pelelangan/model/service.dart';
import 'package:pelelangan/network/network.dart';
import 'package:pelelangan/screen/ikan/detail_ikan.dart';
import 'package:pelelangan/screen/ikan/tambah_ikan.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ListIkan ikann = ListIkan();
  late Future<List<Ikan>> ListData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ListData = ikann.dataikan(); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Dashboard')),
        floatingActionButton: InkWell(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => TambahIkan()));
          },
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18), color: Colors.blue),
            child: Text(
              "Tambah Ikan",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        body: FutureBuilder(
          future: ListData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Ikan> isiData = snapshot.data!;
              return ListView.builder(
                  itemCount: isiData.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => dataikan(id_ikan, nama_ikan, berat, harga, tanggal, cover, keterangan),
                        //     ));
                        Navigator.of(context).pushNamed('/DetailIkan');
                      },
                      child: Card(
                        elevation: 0,
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                child: Image.network(
                                  'http://$apiPath/lelang/api/image/${isiData[index].cover}',
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Expanded(
                                  child: Container(
                                padding: EdgeInsets.only(bottom: 8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 8, right: 8),
                                      child: Text(
                                        isiData[index].nama_ikan,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 8, right: 8),
                                      child: Text(
                                        isiData[index].berat,
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 18, 167, 5)),
                                      ),

                                      //   ),,),
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

  // Future<List<Ikan>> ReadJsonData() async {
  //   final jsondata = await rootBundle.loadString('/TambahIkan');
  //   final list = json.decode(jsondata) as List<dynamic>;
  //   return list.map((e) => Ikan.fromJson(e)).toList();
  // }
}
