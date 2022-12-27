// ignore_for_file: non_constant_identifier_names

class User {
  final int id;
  final String username;
  final String password;
  final String nama;
  final String alamat;
  final int Level;
  final int status;

  User({
    required this.id,
    required this.username,
    required this.password,
    required this.nama,
    required this.alamat,
    required this.Level,
    required this.status,
  });
  // Map<String, dynamic> toJson() => {
  //       'id': id.toString(),
  //       'username': username,
  //       'password': password,
  //       'nama': nama,
  //       'alamat': alamat,
  //       'Level': Level,
  //       'status': status,
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      password: json['password'],
      nama: json['nama'],
      alamat: json['alamat'],
      Level: json['Level'],
      status: json['status'],
    );
  }
}
