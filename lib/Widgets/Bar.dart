import 'package:flutter/material.dart';
import 'package:flutter_app/model/newsNotifier.dart';
import 'package:provider/provider.dart';

class MyBarr extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BottomNavigationBar(
        //     showUnselectedLabels: false,
        //   showSelectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 18,
            ),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.chat,
              size: 18,
            ),
            title: Text('Chat'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              size: 18,
            ),
            title: Text('Settings'),
          ),
        ],
        currentIndex: context.watch<NewsNotifier>().selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: (index) {
          context.read<NewsNotifier>().onItemTap(index);
        },
      ),
    );
  }
}

Widget myBar(BuildContext context) {
  return Container(
    child: BottomNavigationBar(
      //     showUnselectedLabels: false,
      //   showSelectedLabels: false,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            size: 18,
          ),
          title: Text('Home'),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.chat,
            size: 18,
          ),
          title: Text('Chat'),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.settings,
            size: 18,
          ),
          title: Text('Settings'),
        ),
      ],
      currentIndex: context.watch<NewsNotifier>().selectedIndex,
      selectedItemColor: Colors.amber[800],
      onTap: (index) {
        context.read<NewsNotifier>().onItemTap(index);
      },
    ),
  );
}
