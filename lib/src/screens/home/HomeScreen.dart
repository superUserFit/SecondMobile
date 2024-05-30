import 'package:flutter/material.dart';
import 'package:e_pod/src/screens/job_management/job_assignment/e_pod/EpodScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  int selectedTabPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepOrange
          ),
          onPressed: () {
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => const EpodScreen())
            );
          },
          child: const Text(
            'Go To EPOD Details', 
            style: TextStyle(color: Colors.white),
          ), 
        ),
      ),
    );
  }
}
