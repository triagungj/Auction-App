class Lelang {
  final String no_lelang;
  final String nama_ikan;
  final String berat;
  final int harga;
  final String tanggal;
  final String gambar;
  final String keterangan;

  const Lelang({
    required this.no_lelang,
    required this.nama_ikan,
    required this.berat,
    required this.harga,
    required this.tanggal,
    required this.gambar,
    required this.keterangan,
  });

  factory Lelang.fromJson(Map<String, dynamic> json) {
    return Lelang(
      no_lelang: json['no_lelang'],
      nama_ikan: json['nama_ikan'],
      berat: json['berat'],
      harga: json['harga'],
      tanggal: json['tanggal'],
      gambar: json['gambar'],
      keterangan: json['keterangan'],
    );
  }
}
