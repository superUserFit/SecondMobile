import 'package:flutter/material.dart';
import 'package:e_pod/src/components/navigation/drawers/DrawerNavigator.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();

  const HomeScreen({Key? key}) : super(key: key);
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerNavigator(),
      appBar: AppBar(
        title: const Text('This is Home page'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFF6500), Color(0xFFFF8A08)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white
        ),
      ),
      body: const Center(
        child: Text('Welcome to the Home Screen'),
      ),
    );
  }
}
