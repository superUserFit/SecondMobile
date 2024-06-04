import 'package:flutter/material.dart';

import 'package:e_pod/src/components/utils/Request.dart';
import 'package:e_pod/src/screens/job_management/job_order/widgets/job_details.stateful.dart';
import 'package:e_pod/src/screens/job_management/job_order/widgets/job_details.stateless.dart';

class JobDetailsSection extends StatefulWidget {
  final String jobOrderId;
  const JobDetailsSection({Key? key, required this.jobOrderId}) : super(key: key);

  @override
  _JobDetailsSectionState createState() => _JobDetailsSectionState();
}

class _JobDetailsSectionState extends State<JobDetailsSection> {
  late String selectedItemType;

  @override
  void initState() {
    super.initState();
    selectedItemType = 'All';
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Details', style: TextStyle(color: Colors.deepOrange)),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.deepOrange,
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              width: double.infinity,
              color: const Color.fromRGBO(235, 235, 235, 0.9),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Request(
                    endpoint: "/job_order/api/job-order/get-update-job-order-data?id=${widget.jobOrderId}",
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }
                      if (!snapshot.hasData) {
                        return const Center(child: Text('No data found'));
                      }

                      final jobOrder = snapshot.data;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          Container(
                            margin: const EdgeInsets.only(left: 12),
                            child: const Text("Document Details", style: TextStyle(fontWeight: FontWeight.w600, color: Color.fromRGBO(64, 64, 64, 0.8))),
                          ),
                          DocumentDetails(data: jobOrder['data']),

                          const SizedBox(height: 40),
                          Container(
                            margin: const EdgeInsets.only(left: 12),
                            child: const Text("Customer Details", style: TextStyle(fontWeight: FontWeight.w600, color: Color.fromRGBO(64, 64, 64, 0.8))),
                          ),
                          CustomerDetails(data: jobOrder['data']),

                          const SizedBox(height: 40),
                          Container(
                            margin: const EdgeInsets.only(left: 12),
                            child: const Text("Item Details", style: TextStyle(fontWeight: FontWeight.w600, color: Color.fromRGBO(64, 64, 64, 0.8))),
                          ),
                          ItemDetailsCard(jobOrderId: widget.jobOrderId),

                          const SizedBox(height: 40),
                          Container(
                            margin: const EdgeInsets.only(left: 12),
                            child: const Text("More Details", style: TextStyle(fontWeight: FontWeight.w600, color: Color.fromRGBO(64, 64, 64, 0.8))),
                          ),
                          MoreDetails(data: jobOrder['data']),

                          const SizedBox(height: 100.0)
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: SizedBox(
        width: double.infinity,
        // height: 50,
        child: DraggableBottomSheet(
          child: BottomSheetTab()
        )
      ),
    );
  }
}
