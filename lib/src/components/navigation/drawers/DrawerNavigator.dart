import 'package:flutter/material.dart';
import 'package:e_pod/src/screens/home/HomeScreen.dart';

import 'DrawerItem.dart';

class DrawerNavigator extends StatelessWidget {
  const DrawerNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.white,
        child: Column(
          children: [
            DrawerItem(
              icon: Icons.home,
              name: 'Home',
              onPressed: () => onItemPressed(context, index: 0),
            ),
            // Add more DrawerItems as needed
          ],
        ),
      ),
    );
  }

  void onItemPressed(BuildContext context, {required int index}) {
    Navigator.pop(context);
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  const HomeScreen()),
        );
        break;
    }
  }
}