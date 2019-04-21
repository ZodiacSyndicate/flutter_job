import 'package:flutter/material.dart';

class NavigationBar extends StatefulWidget {
  NavigationBar({Key key}) : super(key: key);

  @override
  NavigationBarState createState() => NavigationBarState();
}

class NavigationBarState extends State<NavigationBar> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(Icons.assignment_ind), title: Text('牛人')),
        BottomNavigationBarItem(
            icon: Icon(Icons.business), title: Text('business')),
        BottomNavigationBarItem(
            icon: Icon(Icons.school), title: Text('school')),
      ],
      onTap: _onItemTapped,
      currentIndex: _index,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _index = index;
    });
  }
}
