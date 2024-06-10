import 'package:e_pod/src/components/navigation/drawers/DrawerNavigator.dart';
import 'package:e_pod/src/components/navigation/tabs/BottomTabNavigator.dart';
import 'package:flutter/material.dart';

import 'package:e_pod/src/screens/job_management/widgets/Card.dart';
import 'package:e_pod/src/screens/job_management/job_order/view/JobDetails.dart';
import 'package:e_pod/src/services/job_order/controller/JobOrderController.dart';


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
    final jobOrderController = JobOrderController();

    return Scaffold(
      drawer: const DrawerNavigator(),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          title: Container(
            margin: const EdgeInsets.only(left: 8.0),
            child: const Text('Job Order', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(28.0), bottomRight: Radius.circular(28.0)),
              gradient: LinearGradient(
                colors: [Colors.orange, Colors.deepOrange],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(200, 200, 200, 0.75),
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    child: TextField(
                      textAlignVertical: TextAlignVertical.center,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 4.0),
                        hintText: "Search Job Order...",
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
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: jobOrderController.getAllJobOrderHasAssignment(selectedJobStatus),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final jobOrders = snapshot.data!;
                if (jobOrders.isEmpty) {
                  return const Center(
                    child: Text("No available Job Order"),
                  );
                }

                List<Map<String, dynamic>> filteredJobOrders = [];
                if (searchQuery.isNotEmpty) {
                  filteredJobOrders = jobOrders.where((jobOrder) {
                    final customerName = jobOrder['customerName']?.toLowerCase() ?? '';
                    final query = searchQuery.toLowerCase();
                    return customerName.startsWith(query);
                  }).toList();
                } else {
                  filteredJobOrders = jobOrders;
                }

                if(filteredJobOrders.isEmpty) {
                  return const Center(
                    child: Text('No available Job Order'),
                  );
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
                          MaterialPageRoute(
                            builder: (context) => JobDetailsSection(jobOrderId: jobOrder['jobOrder']),
                          ),
                        );
                      },
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
