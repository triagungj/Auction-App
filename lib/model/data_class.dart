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
