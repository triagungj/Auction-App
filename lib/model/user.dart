// ignore_for_file: non_constant_identifier_names

class Users {
  String? id_user;
  String? username;
  String? password;
  String? no_hp;
  String? alamat;
  String? avatar;

  Users({
    this.id_user,
    this.username,
    this.password,
    this.no_hp,
    this.alamat,
    this.avatar,
  });

  Users.fromJson(Map<String, dynamic> json) {
    id_user = json['id_user'];

    username = json['username'];
    password = json['password'];
    no_hp = json['no_hp'];
    alamat = json['alamat'];
    avatar = json['avatar'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id_user'] = id_user;
    data['username'] = username;
    data['password'] = password;
    data['no_hp'] = no_hp;
    data['alamat'] = alamat;
    data['avatar'] = avatar;
    return data;
  }
}
