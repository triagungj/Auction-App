import 'package:flutter/material.dart';
import 'package:pelelangan/screen/ikan/tambah_ikan.dart';
import 'package:pelelangan/screen/menu/akun.dart';
import 'package:pelelangan/screen/menu/home.dart';
import 'package:pelelangan/screen/menu/jadwal.dart';
import 'package:pelelangan/screen/menu/lelang.dart';
import 'package:pelelangan/screen/menu/login.dart';
import 'package:pelelangan/screen/menu/riwayat.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  int _selectedNavbar = 0;

  void _changeSelectedNavBar(int index) {
    setState(() {
      _selectedNavbar = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _Listpage = [
      Home(),
      Home(),
      TambahIkan(),
      Home(),
      // Lelang(),
      // Riwayat(),
      // Jadwal(),
      // Akun(),
    ];

    return Scaffold(
      body: Center(
        // child: Text("Tab Index yang aktif : $_selectedNavbar",
        //     style: TextStyle(fontSize: 16)),
        child: _Listpage[_selectedNavbar],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: ('Beranda'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket),
            label: ('Lelang'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_business_outlined),
            label: ('Tambah Ikan'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: ('Akun'),
          ),
        ],
        currentIndex: _selectedNavbar,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: _changeSelectedNavBar,
      ),
    );
  }
}

// class Menu extends StatefulWidget {
//   const Menu({super.key});

//   @override
//   State<Menu> createState() => _MenuState();
// }

// class _MenuState extends State<Menu> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Stack(
//         children: <Widget>[
//           Offstage()
//         ],
//       ),
//       bottomNavigationBar: BottomAppBar(
//         color: Colors.blue,
//         child: Container(
//           height: 60,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: <Widget>[
//               InkWell(
//                 onTap: () {
//                   setState(() {
                    
//                   });
//                 },
//                 child: Icon(
//                   Icons.home,
//                   color: Colors.white,
//                 ),
//               ),
//               Icon(
//                 Icons.shopping_basket,
//                 color: Colors.white,
//               ),
//               Icon(
//                 Icons.message,
//                 color: Colors.white,
//               ),
//               Icon(
//                 Icons.timelapse,
//                 color: Colors.white,
//               ),
//               Icon(
//                 Icons.account_circle,
//                 color: Colors.white,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
