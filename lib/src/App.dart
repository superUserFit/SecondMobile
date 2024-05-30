import 'package:flutter/material.dart';

import 'package:e_pod/src/screens/home/HomeScreen.dart';
import 'package:e_pod/src/screens/job_management/JobManagementScreen.dart';
import 'package:e_pod/src/screens/message/MessageScreen.dart';
import 'package:e_pod/src/screens/profile/ProfileScreen.dart';

import 'package:e_pod/src/components/navigation/tabs/BottomTabNavigator.dart';


class AppScreen extends StatefulWidget {
  const AppScreen({Key? key}) : super(key: key);

  @override
  _AppScreenState createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  int _currentIndex = 0;

  final List<Widget> _tabScreens = [
    const HomeScreen(),
    const JobManagementScreen(),
    const MessageScreen(),
    const ProfileScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: PageStorageBucket(),
        child: _tabScreens[_currentIndex],
      ),
      bottomNavigationBar: BottomTabNavigator(
        currentIndex: _currentIndex,
        onTabTapped: _onTabTapped,
      ),
    );
  }
}
