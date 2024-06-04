import 'package:flutter/material.dart';
import 'package:e_pod/src/screens/home/HomeScreen.dart';
import 'package:e_pod/src/screens/job_management/job_order/view/JobOrderScreen.dart';

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
            const UserAccountsDrawerHeader(
              accountName: Text('Fitenson'),
              accountEmail: Text('fitenson@infollective.com'),
              currentAccountPicture: CircleAvatar(
                radius: 60,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange, Colors.deepOrange],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            DrawerItem(
              icon: Icons.home,
              name: 'Home',
              onPressed: () => onItemPressed(context, index: 0),
            ),
            DrawerItem(
              icon: Icons.business_center_rounded,
              name: 'Job Order',
              onPressed: () => onItemPressed(context, index: 1))
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
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
        break;

      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const JobOrderScreen()),
        );
        break;
    }
  }
}
