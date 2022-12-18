class Users {
  String? id_user;
  String? username;
  String? password;
  String? alamat;

  Users({
    this.id_user,
    this.username,
    this.password,
    this.alamat,
  });

  Users.fromJson(Map<String, dynamic> json) {
    id_user = json['id_user'];
    username = json['username'];
    password = json['password'];
    alamat = json['alamat'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id_user'] = id_user;
    data['username'] = username;
    data['password'] = password;
    data['alamat'] = alamat;
    return data;
  }
}
