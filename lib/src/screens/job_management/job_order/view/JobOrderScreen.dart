import 'package:flutter/material.dart';

import 'package:e_pod/src/screens/job_management/widgets/Card.dart';
import 'package:e_pod/src/screens/job_management/job_order/view/JobDetails.dart';
import 'package:e_pod/src/components/utils/Request.dart';

class JobOrderScreen extends StatefulWidget {
  const JobOrderScreen({Key? key}) : super(key: key);

  @override
  _JobOrderScreenState createState() => _JobOrderScreenState();
}

class _JobOrderScreenState extends State<JobOrderScreen> {
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
                end: Alignment.bottomRight,
              ),
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
                      child: const TextField(
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 4.0),
                          hintText: "Search Job Order...",
                          prefixIcon: Icon(Icons.search),
                          border: InputBorder.none,
                        ),
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
            child: Request(
              endpoint: '/job_order/api/job-order/get-all-job-order-has-assignment?jobStatus=$selectedJobStatus',
              method: 'GET',
              builder: (context, snapshot) {
                final responseData = snapshot.data as Map<String, dynamic>;
                final rows = responseData['rows'] as List? ?? [];
                final jobOrders = rows.cast<Map<String, dynamic>>();

                if (jobOrders.isEmpty) {
                  return const Center(
                    child: Text('No available Job Order'),
                  );
                }

                List<Map<String, dynamic>> filteredJobOrders = [];
                if (searchQuery.contains(RegExp(r'[a-zA-Z]'))) {
                  filteredJobOrders = jobOrders.where((jobOrder) {
                    final customerName = jobOrder['customerName']?.toLowerCase() ?? '';
                    final query = searchQuery.toLowerCase();
                    return customerName.contains(query);
                  }).toList();
                } else {
                  filteredJobOrders = jobOrders;
                }

                return ListView.builder(
                  itemCount: filteredJobOrders.length,
                  itemBuilder: (context, index) {
                    final jobOrder = filteredJobOrders[index];
                    return JobOrderCard(
                      customerName: jobOrder['customerName'] ?? '',
                      docNo: jobOrder['docNo'] ?? '',
                      pickupLocation: jobOrder['pickupLocation'] ?? '',
                      pickupAddress: jobOrder['pickupAddress'] ?? '',
                      deliveryLocation: jobOrder['deliveryLocation'] ?? '',
                      deliveryAddress: jobOrder['deliveryAddress'] ?? '',
                      jobStatus: jobOrder['jobStatus'] ?? '',
                      startPickupAt: jobOrder['startPickupAt'] ?? '',
                      endDeliveryAt: jobOrder['endDeliveryAt'] ?? '',
                      onPressed: () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => JobDetailsSection(jobOrderId: jobOrder['jobOrder']))
                        );
                      }
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
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
