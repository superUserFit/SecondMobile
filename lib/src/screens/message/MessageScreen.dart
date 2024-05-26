import 'package:flutter/material.dart';
import 'package:e_pod/src/components/navigation/drawers/DrawerNavigator.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  int selectedTabPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerNavigator(),
      appBar: AppBar(
        title: const Text(
          'Home',
          textAlign: TextAlign.start,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: false,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orange, Colors.deepOrange],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: const Center(
        child: Text('This is Message Screen'),
      ),
    );
  }
}
