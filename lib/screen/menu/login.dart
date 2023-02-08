import 'package:get/get.dart';
import 'package:pelelangan/model/service.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}
// enum LoginStatus { notSignIn, SignIn }

class _LoginState extends State<Login> {
  final akunService = AkunService();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  Future<void> login() async {
    final isLoginSuccess =
        await akunService.getLogin(username.text, password.text);

    if (isLoginSuccess) {
      Get.snackbar(
        "Login Berhasil",
        'Selamat Datang',
        backgroundColor: Colors.blue,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/Menu');
      }
    } else {
      Get.snackbar(
        "Password Salah",
        'silahkan Isi kembali',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  // cek salah password
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    // switch (_loginStatus) {
    //   case LoginStatus.notSignIn:
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 50, right: 30, left: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30.0),
                const Center(
                  child: Text('LOGIN',
                      style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue)),
                ),
                const SizedBox(height: 60),
                const Text('Silahkan Masukan Username Dan Password Anda!!!',
                    style: TextStyle(fontSize: 10.0, color: Colors.blue)),
                const SizedBox(height: 12.0),
                TextFormField(
                  // validator: (e) {
                  //   if (e!.isEmpty) {
                  //     return " Tolong Masukan Username Dengan Benar";
                  //   }
                  // },
                  // onSaved: (e) => username = e!,
                  controller: username,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 1.0)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 1.0)),
                      hintText: 'Username',
                      prefixIcon: Icon(Icons.person, color: Colors.blue)),
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: password,
                  obscureText: isPasswordVisible ? false : true,
                  // onSaved: (e) => username = e!,
                  decoration: InputDecoration(
                      suffixIconConstraints:
                          const BoxConstraints(minWidth: 45, maxWidth: 46),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                        child: Icon(
                          isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.white70,
                          size: 22,
                        ),
                      ),
                      border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 8.0)),
                      enabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 1.0)),
                      hintText: 'Password',
                      prefixIcon: const Icon(Icons.lock, color: Colors.blue)),
                ),
                const SizedBox(height: 20.0),
                InkWell(
                  splashColor: Colors.red,
                  onTap: () {
                    login();
                    // check();
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => Daftar()));
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: [
                          Color.fromARGB(255, 7, 79, 235),
                          Color.fromARGB(255, 51, 13, 218)
                        ]),
                        borderRadius: BorderRadius.circular(100.0)),
                    child: const Text('Login',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 20.0)),
                  ),
                ),
              ],
            ),
          ),
        ));
    // case LoginStatus.SignIn:
    //   return Dashboard();
    //   break;
  }
}
// }
