import 'package:flutter/material.dart';
import 'package:e_pod/src/components/navigation/drawers/DrawerNavigator.dart';
import 'package:e_pod/src/components/navigation/tabs/BottomTabNavigator.dart';
import 'package:e_pod/src/screens/job_order/widgets/Card.dart';

class JobOrderScreen extends StatefulWidget {
  const JobOrderScreen({Key? key}) : super(key: key);

  @override
  _JobOrderScreenState createState() => _JobOrderScreenState();
}

class _JobOrderScreenState extends State<JobOrderScreen> {
  int selectedJobStatus = 0;
  int selectedTabPage = 0;

  final List<Map<String, String>> jobOrders = [
    {
      'customerName': 'Line Clear Express & Logistics',
      'docNo': 'JQ2401',
      'pickupLocation': 'Md LocB',
      'pickupAddress': 'No. 99, Taman 999, Jalan 9999, 99999 Kuching, Sarawak, Malaysia',
      'deliveryLocation': 'Company ABC Co.',
      'deliveryAddress': 'Viva City No.999999',
      'jobStatus': 'Assigned',
      'startPickupAt': '1 Jan 2024',
      'endDeliveryAt': '9:00 AM'
    },
    {
      'customerName': 'Company Local',
      'docNo': 'JQ2402',
      'pickupLocation': 'Company LocA',
      'pickupAddress': 'No. 11, Taman 110, Jalan 1111, 94000 Kuching, Sarawak, Malaysia',
      'deliveryLocation': 'Company LocB',
      'deliveryAddress': 'No.999 Jalan Matang',
      'jobStatus': 'Started',
      'startPickupAt': '1 Jan 2024',
      'endDeliveryAt': '10:00 AM'
    },
    // Add more job orders here
  ];

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
                    borderRadius: BorderRadius.circular(30.0)
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
                    },
                  ),
                )
              ],
            )
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
            child: ListView.builder(
              itemCount: jobOrders.length,
              itemBuilder: (context, index) {
                final jobOrder = jobOrders[index];
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
        backgroundColor: selectedJobStatus == index
            ? WidgetStateProperty.all<Color>(Colors.deepOrange)
            : null,
      ),
      child: Text(
        text,
        style: TextStyle(
          color: selectedJobStatus == index ? Colors.white : null,
        ),
      ),
    );
  }
}