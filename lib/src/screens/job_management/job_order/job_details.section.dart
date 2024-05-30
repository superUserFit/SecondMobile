import 'package:flutter/material.dart';

class JobDetailsSection extends StatefulWidget {
  final String id;
  const JobDetailsSection({Key? key, required this.id}) : super(key: key);

  @override
  _JobDetailsSectionState createState() => _JobDetailsSectionState();
}

class _JobDetailsSectionState extends State<JobDetailsSection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Details', style: TextStyle(color: Colors.deepOrange),),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.deepOrange,
        ),
      ),
      body: Center(
        child: Text("Job Details ID: ${widget.id}"),
      ),
    );
  }
}
