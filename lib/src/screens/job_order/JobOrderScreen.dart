import 'package:flutter/material.dart';
import 'package:e_pod/src/components/navigation/drawers/DrawerNavigator.dart';
import 'package:e_pod/src/components/navigation/tabs/BottomTabNavigator.dart';
import 'package:e_pod/src/screens/job_order/widgets/Card.dart';
import 'package:e_pod/src/components/api/Request.dart';

class JobOrderScreen extends StatefulWidget {
  const JobOrderScreen({Key? key}) : super(key: key);

  @override
  _JobOrderScreenState createState() => _JobOrderScreenState();
}

class _JobOrderScreenState extends State<JobOrderScreen> {
  int selectedJobStatus = 0;
  int selectedTabPage = 0;
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerNavigator(),
      appBar: AppBar(
        title: const Text(
          'Job Order',
          textAlign: TextAlign.start,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: false,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25.0), bottomRight: Radius.circular(25.0)),
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(200, 200, 200, 0.75),
                    borderRadius: BorderRadius.circular(30.0),
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
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildTabButton('All', 0),
                _buildTabButton('Opened', 1),
                _buildTabButton('Assigned', 2),
                _buildTabButton('Started', 3),
              ],
            ),
          ),
          Expanded(
            child: Request(
              endpoint: '/job_order/api/job-order/get-all-job-order-has-assignment',
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData) {
                  return const Text('No data found');
                } else {
                  final responseData = snapshot.data as Map<String, dynamic>;
                  final jobOrders = (responseData['rows'] as List).cast<Map<String, dynamic>>();
                  
                  final filteredJobOrders = jobOrders.where((jobOrder) {
                    final customerName = jobOrder['customerName']?.toLowerCase() ?? '';
                    final docNo = jobOrder['docNo']?.toLowerCase() ?? '';
                    final query = searchQuery.toLowerCase();
                    return customerName.contains(query) || docNo.contains(query);
                  }).toList();

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
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomTabNavigator(
        currentIndex: selectedTabPage,
        onTap: (index) {
          setState(() {
            selectedTabPage = index;
          });
        },
      ),
    );
  }

  Widget _buildTabButton(String text, int index) {
    return OutlinedButton(
      onPressed: () {
        setState(() {
          selectedJobStatus = index;
        });
      },
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(
          selectedJobStatus == index ? Colors.deepOrange : Colors.transparent,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: selectedJobStatus == index ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
