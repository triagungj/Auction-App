class Ikan {
  final String id_ikan;
  final String nama_ikan;
  final String berat;
  final int harga;
  final String tanggal;
  final String cover;
  final String keterangan;

  const Ikan({
    required this.id_ikan,
    required this.nama_ikan,
    required this.berat,
    required this.harga,
    required this.tanggal,
    required this.cover,
    required this.keterangan,
  });

  factory Ikan.fromJson(Map<String, dynamic> json) {
    return Ikan(
      id_ikan: json['id_ikan'],
      nama_ikan: json['nama_ikan'],
      berat: json['berat'],
      harga: json['harga'],
      tanggal: json['tanggal'],
      cover: json['cover'],
      keterangan: json['keterangan'],
    );
  }
}

class Ikan1 {
  final String id_ikan;
  final String nama_ikan;
  final String berat;
  final int harga;
  final String tanggal;
  final String cover;
  final String keterangan;

  const Ikan1({
    required this.id_ikan,
    required this.nama_ikan,
    required this.berat,
    required this.harga,
    required this.tanggal,
    required this.cover,
    required this.keterangan,
  });

  factory Ikan1.fromJson(Map<String, dynamic> json) {
    return Ikan1(
      id_ikan: json['id_ikan'],
      nama_ikan: json['nama_ikan'],
      berat: json['berat'],
      harga: json['harga'],
      tanggal: json['tanggal'],
      cover: json['cover'],
      keterangan: json['keterangan'],
    );
  }
}
