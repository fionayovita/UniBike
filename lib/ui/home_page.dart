import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unibike/common/styles.dart';
import 'package:unibike/ui/login_page.dart';
import 'package:unibike/ui/main_page.dart';
import 'package:unibike/ui/register_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = 'home_page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottomNavIndex = 0;
  late PageController _pageController;

  static const String _homeText = 'Home';
  static const String _StatusText = 'Status Pinjam';
  static const String _profileText = 'Profile';

  List<BottomNavigationBarItem> _bottomNavBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: _homeText,
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.note_alt_outlined),
      label: _StatusText,
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person_sharp),
      label: _profileText,
    ),
  ];

  List<Widget> _listPages = [
    MainPage(),
    LoginPage(),
    RegisterPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listPages[_bottomNavIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: secondaryColor,
        buttonBackgroundColor: primaryColor,
        height: 60,
        items: <Widget>[
          Icon(Icons.home, size: 30),
          Icon(Icons.note_alt_outlined, size: 30),
          Icon(Icons.person_sharp, size: 30),
        ],
        onTap: (index) => _onItemTapped(index),
      ),
    );
  }
}
