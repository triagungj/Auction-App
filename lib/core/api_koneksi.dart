import 'package:pelelangan/core/key_constant.dart';

class API {
  static const hostConnect = "http://$apiPath/lelang/api";
  static const koneksiUser = "$hostConnect/user";

  //register user
  static const register = "$koneksiUser/user/register.php";
  static const validasiUsername = "$koneksiUser/user/validasi_username.php";
}
