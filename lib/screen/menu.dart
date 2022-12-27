// ignore_for_file: non_constant_identifier_names, no_leading_underscores_for_local_identifiers, constant_identifier_names

import 'package:flutter/material.dart';
import 'package:pelelangan/screen/menu/akun.dart';
import 'package:pelelangan/screen/menu/home.dart';
import 'package:pelelangan/screen/menu/lelangku.dart';
import 'package:pelelangan/screen/menu/riwayat.dart';

class Menu extends StatefulWidget {
  const Menu({
    super.key,
    required this.isAdmin,
  });

  final bool isAdmin;

  @override
  State<Menu> createState() => _MenuState();
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
    const _Listpage = [
      Home(),
      Lelangku(),
      Riwayat(),
      Akun(),
    ];
    const _Adminpage = [
      Home(),
      Lelangku(),
      Riwayat(),
      Akun(),
    ];

    return Scaffold(
      body: Center(
        child: widget.isAdmin
            ? _Adminpage[_selectedNavbar]
            : _Listpage[_selectedNavbar],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: ('Beranda'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_business_outlined),
            label: ('Lelangku'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: ('Riwayat'),
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
