import 'package:e_pod/src/screens/job_management/job_assignment/view/JobAssignmentDetails.dart';
import 'package:e_pod/src/screens/job_management/widgets/Card.dart';
import 'package:flutter/material.dart';

import 'package:e_pod/src/services/job_order/controller/JobOrderController.dart';


class JobAssignmentScreen extends StatefulWidget {
  const JobAssignmentScreen({Key? key}) : super(key: key);

  @override
  _JobAssignmentState createState() => _JobAssignmentState();
}

class _JobAssignmentState extends State<JobAssignmentScreen> {
  int selectedJobStatusIndex = 0;
  String searchQuery = '';
  late String selectedJobStatus;

  @override
  void initState() {
    super.initState();
    selectedJobStatus = 'All';
    selectedJobStatusIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    final jobOrderController = JobOrderController();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.orange, Colors.deepOrange],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight
              )
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 45.0, left: 16.0, right: 16.0, bottom: 16),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(200, 200, 200, 0.75),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: TextField(
                        textAlignVertical: TextAlignVertical.center,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 4.0),
                          hintText: "Search...",
                          prefixIcon: Icon(Icons.search),
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          setState(() {
                            searchQuery = value;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 60,
            child: Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTabButton('All', 0),
                    _buildTabButton('Opened', 1),
                    _buildTabButton('Assigned', 2),
                    _buildTabButton('Started', 3),
                  ],
                ),
              ),
            ),
          ),

          Expanded(
            child: FutureBuilder(
              future: jobOrderController.getAllJobOrderHasAssignment(selectedJobStatus),
              builder: (context, snapshot) {
                if(!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final jobOrderHasAssignments = snapshot.data!;
                if(jobOrderHasAssignments.isEmpty) {
                  return const Center(
                    child: Text("No available Job Assignment"),
                  );
                }

                List<Map<String, dynamic>> filteredJobOrderHasAssignments = [];
                if(searchQuery.isNotEmpty) {
                  filteredJobOrderHasAssignments = jobOrderHasAssignments.where((assignment) {
                    final customerName = assignment['customerName']?.toLowerCase() ?? '';
                    final query = searchQuery.toLowerCase();
                    return customerName.startsWith(query);
                  }).toList();
                } else {
                  filteredJobOrderHasAssignments = jobOrderHasAssignments;
                }

                if(filteredJobOrderHasAssignments.isEmpty) {
                  return const Center(
                    child: Text('No available Job Assignment'),
                  );
                }

                return ListView.builder(
                  itemCount: filteredJobOrderHasAssignments.length,
                  itemBuilder: (context, index) {
                    final jobAssignment = filteredJobOrderHasAssignments[index];
                    return JobAssignmentCard(
                      customerName: jobAssignment['customerName'] ?? '', 
                      pickupLocation: jobAssignment['pickupLocation'] ?? '', 
                      pickupAddress: jobAssignment['pickupAddress'] ?? '', 
                      deliveryLocation: jobAssignment['deliveryLocation'] ?? '', 
                      deliveryAddress: jobAssignment['deliveryAddress'] ?? '', 
                      jobStatus: jobAssignment['jobStatus'] ?? '', 
                      startPickupAt: jobAssignment['startPickupAt'] ?? '', 
                      endDeliveryAt: jobAssignment['endDeliveryAt'] ?? '',
                      onPressed: () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => JobAssignmentDetails(jobOrderHasAssignmentId: jobAssignment['UUID'], jobOrderId: jobAssignment['jobOrder'],))
                        );
                      },
                    );
                  }
                );
              }
            )
          )
        ],
      )
    );
  }

  Widget _buildTabButton(String text, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
      child: OutlinedButton(
        onPressed: () {
          setState(() {
            selectedJobStatusIndex = index;
            selectedJobStatus = text;
          });
        },
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith<Color>(
            (Set<WidgetState> states) {
              return selectedJobStatusIndex == index ? Colors.deepOrange : Colors.transparent;
            },
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: selectedJobStatusIndex == index ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}