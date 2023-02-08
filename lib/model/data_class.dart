// ignore_for_file: non_constant_identifier_names

class Lelang {
  final String no_lelang;
  final String? id_user;
  final String nama_ikan;
  final String berat;
  final int harga;
  final String tanggal;
  final String gambar;
  final String keterangan;
  final String status;

  const Lelang({
    required this.no_lelang,
    this.id_user,
    required this.nama_ikan,
    required this.berat,
    required this.harga,
    required this.tanggal,
    required this.gambar,
    required this.keterangan,
    required this.status,
  });

  factory Lelang.fromJson(Map<String, dynamic> json) {
    return Lelang(
      no_lelang: json['no_lelang'],
      id_user: json['id_user'],
      nama_ikan: json['nama_ikan'],
      berat: json['berat'],
      harga: json['harga'],
      tanggal: json['tanggal'],
      gambar: json['gambar'],
      keterangan: json['keterangan'],
      status: json['status'],
    );
  }
}

class DetailLelang {
  final String no_lelang;
  final String? id_user;
  final String nama_ikan;
  final String berat;
  final int harga;
  final String tanggal;
  final String gambar;
  final String keterangan;
  final String status;
  final List<ListUserDetailLelang> list_lelang_user;

  DetailLelang({
    required this.no_lelang,
    this.id_user,
    required this.nama_ikan,
    required this.berat,
    required this.harga,
    required this.tanggal,
    required this.gambar,
    required this.keterangan,
    required this.status,
    required this.list_lelang_user,
  });

  factory DetailLelang.fromJson(Map<String, dynamic> json) {
    return DetailLelang(
      no_lelang: json['no_lelang'],
      id_user: json['id_user'],
      nama_ikan: json['nama_ikan'],
      berat: json['berat'],
      harga: json['harga'],
      tanggal: json['tanggal'],
      gambar: json['gambar'],
      keterangan: json['keterangan'],
      status: json['status'],
      list_lelang_user: (json['list_lelang_user'] as List<dynamic>)
          .map((e) => ListUserDetailLelang.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class ListUserDetailLelang {
  final String id_user;
  final String username;
  final int harga_lelang;

  ListUserDetailLelang({
    required this.id_user,
    required this.username,
    required this.harga_lelang,
  });
  factory ListUserDetailLelang.fromJson(Map<String, dynamic> json) {
    return ListUserDetailLelang(
      id_user: json['id_user'],
      username: json['username'],
      harga_lelang: int.parse(json['harga_lelang']),
    );
  }
}

class RiwayatLelang {
  final String no_lelang;
  final String nama_ikan;
  final String berat;
  final int harga;
  final String id_pemilik;
  final String nama_pemilik;
  final String? id_pelelang;
  final String? nama_pelelang;
  final int? harga_terakhir;
  final String tanggal;
  final String gambar;
  final String keterangan;
  final String status;

  RiwayatLelang({
    required this.no_lelang,
    required this.nama_ikan,
    required this.berat,
    required this.harga,
    required this.id_pemilik,
    required this.nama_pemilik,
    this.id_pelelang,
    this.nama_pelelang,
    this.harga_terakhir,
    required this.tanggal,
    required this.gambar,
    required this.keterangan,
    required this.status,
  });

  factory RiwayatLelang.fromJson(Map<String, dynamic> json) {
    return RiwayatLelang(
      no_lelang: json['no_lelang'],
      nama_ikan: json['nama_ikan'],
      berat: json['berat'],
      harga: json['harga'],
      id_pemilik: json['id_pemilik'],
      nama_pemilik: json['nama_pemilik'],
      id_pelelang: json['id_pelelang'],
      nama_pelelang: json['nama_pelelang'],
      harga_terakhir: json['harga_terakhir!'],
      tanggal: json['tanggal'],
      gambar: json['gambar'],
      keterangan: json['keterangan'],
      status: json['status'],
    );
  }
}

class DefaultClass {
  final int status;
  final String message;

  DefaultClass({
    required this.status,
    required this.message,
  });

  factory DefaultClass.fromJson(Map<String, dynamic> json) {
    return DefaultClass(
      status: json['status'],
      message: json['message'],
    );
  }
}
