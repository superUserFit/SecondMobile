import 'package:flutter/material.dart';

class JobAssignmentScreen extends StatefulWidget {
  const JobAssignmentScreen({Key? key}) : super(key: key);

  @override
  _JobAssignmentState createState() => _JobAssignmentState();
}

class _JobAssignmentState extends State<JobAssignmentScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Job Assignment"),
      ),

      body: const Center(
        child: Text("This is Job Assignment page"),
      ),
    );
  }
}