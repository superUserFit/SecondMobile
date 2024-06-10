import 'package:flutter/material.dart';

import 'package:e_pod/src/screens/job_management/job_assignment/widgets/job_assignment_details.stateful.dart';
import 'package:e_pod/src/screens/job_management/job_assignment/widgets/job_assignment_details.stateless.dart';


class JobAssignmentDetails extends StatefulWidget {
  final String jobOrderHasAssignmentId;
  final String jobOrderId;

  const JobAssignmentDetails({
    super.key,

    required this.jobOrderId,
    required this.jobOrderHasAssignmentId,
  });

  @override
  _JobAssignmentState createState() => _JobAssignmentState();
}

class _JobAssignmentState extends State<JobAssignmentDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Job Assignment',
          style: TextStyle(color: Colors.deepOrange),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.deepOrange),
      ),
      body: Stack(
        children: [
          DefaultTabController(
            length: 2,
            child: Container(
              decoration: const BoxDecoration(
                color: Color.fromRGBO(235, 235, 235, 0.9)
              ),
              child: Column(
              children: [
                const SizedBox(height: 4.0),
                Card(
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  child: Center(
                    child: Container(
                      width: 250,
                      margin: const EdgeInsets.all(8.0),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      ),
                      child: TabBar(
                        indicator: const BoxDecoration(
                          color: Color.fromARGB(160, 255, 155, 5),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        indicatorSize: TabBarIndicatorSize.tab,
                        tabs: [
                          Tab(
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 5.0),
                              child: const Text(
                                'Delivery',
                                style: TextStyle(fontSize: 12.0),
                              ),
                            ),
                          ),
                          Tab(
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 5.0),
                              child: const Text(
                                'Job Order',
                                style: TextStyle(fontSize: 12.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      DeliveryDetailsTab(jobOrderHasAssignmentId: widget.jobOrderHasAssignmentId),
                      JobOrderDetailsTab(jobOrderId: widget.jobOrderId)
                    ],
                  ),
                ),
              ],
            ),
            )
          ),
        ],
      ),

      bottomNavigationBar: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ButtonStyle(
            padding: WidgetStateProperty.all(EdgeInsets.zero),
            backgroundColor: WidgetStateProperty.all(Colors.transparent),
          ),
          onPressed: () => showModalBottomSheet(
            enableDrag: true,
            context: context,
            isScrollControlled: true,
            builder: (context) => BottomSheetTab(jobOrderHasAssignmentId: widget.jobOrderHasAssignmentId),
          ),
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.orange, Colors.deepOrange],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: SizedBox(
              height: 50.0,
              child: Center(
                child: SizedBox(
                  width: 50,
                  child: Container(
                    width: 50,
                    height: 5,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(16.0))
                    ),
                  )
                )
              ),
            ),
          )
        )
      ),
    );
  }
}
