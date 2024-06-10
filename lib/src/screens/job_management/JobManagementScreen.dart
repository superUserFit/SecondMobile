import 'package:flutter/material.dart';

import 'package:e_pod/src/screens/job_management/job_assignment/view/JobAssignmentScreen.dart';
import 'package:e_pod/src/screens/job_management/job_order/view/JobOrderScreen.dart';
import 'package:e_pod/src/screens/job_management/widgets/Card.dart';


class JobManagementScreen extends StatefulWidget {
  const JobManagementScreen({Key? key}) : super(key: key);

  @override
  _JobManagementState createState() => _JobManagementState();
}

class _JobManagementState extends State<JobManagementScreen> {
  int selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Job Management", 
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500), 
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25.0), bottomRight: Radius.circular(25.0)),
            gradient: LinearGradient(
              colors: [Colors.orange, Colors.deepOrange],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight
            ),
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          children: [
          JobPageCard(
            icon: Icons.work_outline_rounded, 
            iconColor: Colors.deepOrange, 
            text: "Job Order", 
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const JobOrderScreen())
              );
            }
          ),

          JobPageCard(
            icon: Icons.assignment_outlined, 
            iconColor: Colors.deepOrange, 
            text: "Job Assignment",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const JobAssignmentScreen())
            );
            },
          )
        ],
        ),
      )
    );
  }
}
