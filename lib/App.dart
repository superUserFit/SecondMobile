import 'package:flutter/material.dart';
import 'package:e_pod/src/screens/home/HomeScreen.dart';
import 'package:e_pod/src/screens/alert/AlertScreen.dart';
import 'package:e_pod/src/screens/message/MessageScreen.dart';
import 'package:e_pod/src/screens/profile/ProfileScreen.dart';
import 'package:e_pod/src/components/navigation/tabs/BottomTabNavigator.dart';


class AppScreen extends StatefulWidget {
  const AppScreen({Key? key}) : super(key: key);

  @override
  _AppScreenState createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  int selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Widget _getScreen(int index) {
    switch (index) {
      case 0:
        return const HomeScreen();
      case 1:
        return const AlertScreen();
      case 2:
        return const MessageScreen();
      case 3:
        return const ProfileScreen();
      default:
        return const HomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getScreen(selectedIndex),
      bottomNavigationBar: BottomTabNavigator(
        currentIndex: selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}