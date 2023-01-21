import 'package:ai_app/views/dir/create_post_page.dart';
import 'package:ai_app/views/dir/home_real_page.dart';
import 'package:ai_app/views/dir/profile_page.dart';
import 'package:ai_app/views/sign_up.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<dynamic> page = [
    RealHomePage(),
    CreatePostPage(),
    ProfilePage(),
  ];

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: page[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _navigateBottomBar,
        backgroundColor: Colors.black,
        currentIndex: _selectedIndex,
        selectedItemColor: CupertinoColors.activeGreen,
        iconSize: 50,
        elevation: 0,
        // selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Colors.black,
            icon: Icon(
              Icons.home,
              size: 30,
            ),
            label: '',
            // tooltip: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.black,
            icon: Icon(
              Icons.add,
              size: 30,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.black,
            icon: Icon(
              Icons.import_contacts_sharp,
              size: 30,
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
