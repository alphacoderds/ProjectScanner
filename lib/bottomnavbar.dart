import 'package:flutter/material.dart';
import 'package:flutter_scanner/menu_utama.dart';
import 'package:flutter_scanner/profile.dart';
import 'package:flutter_scanner/updateprofile.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[MenuUtama(), ProfileCard()];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Akun'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromRGBO(43, 56, 86, 1),
        onTap: _onItemTap,
      ),
    );
  }
}
