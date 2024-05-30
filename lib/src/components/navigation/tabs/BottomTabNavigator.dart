import 'package:flutter/material.dart';

import 'package:e_pod/src/screens/home/HomeScreen.dart';
import 'package:e_pod/src/screens/job_management/JobManagementScreen.dart';
import 'package:e_pod/src/screens/message/MessageScreen.dart';
import 'package:e_pod/src/screens/profile/ProfileScreen.dart';

class BottomTabNavigator extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabTapped;

  BottomTabNavigator({
    required this.currentIndex,
    required this.onTabTapped,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      {
        'icon': Icons.home_filled,
        'label': 'Home',
        'screen': const HomeScreen()
      },
      {
        'icon': Icons.work_rounded,
        'label': 'Job Management',
        'screen': const JobManagementScreen()
      },
      {
        'icon': Icons.mail_rounded,
        'label': 'Inbox',
        'screen': const MessageScreen()
      },
      {
        'icon': Icons.person,
        'label': 'Profile',
        'screen': const ProfileScreen()
      },
    ];

    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 10,
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(items.length, (index) {
            return Expanded(
              child: MaterialButton(
                onPressed: () {
                  onTabTapped(index);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      items[index]['icon'],
                      color: currentIndex == index ? Colors.deepOrange : Colors.black,
                    ),
                    Flexible(
                      child: Text(
                        items[index]['label'],
                        textAlign: TextAlign.center,
                        style: TextStyle(color: currentIndex == index ? Colors.deepOrange : Colors.black),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
