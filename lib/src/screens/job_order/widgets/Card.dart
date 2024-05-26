import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';

class JobOrderCard extends StatelessWidget {
  final String customerName;
  final String docNo;

  final String pickupLocation;
  final String pickupAddress;
  final String deliveryLocation;
  final String deliveryAddress;

  final String jobStatus;
  final String startPickupAt;
  final String endDeliveryAt;

  const JobOrderCard({
    Key? key,
    required this.customerName,
    required this.docNo,
    required this.pickupLocation,
    required this.pickupAddress,
    required this.deliveryLocation,
    required this.deliveryAddress,
    required this.jobStatus,
    required this.startPickupAt,
    required this.endDeliveryAt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              customerName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: Colors.deepOrange,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.description_sharp, color: Colors.grey),
                    const SizedBox(width: 4.0),
                    Text(
                      docNo,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Text(
                  jobStatus,
                  style: TextStyle(
                    backgroundColor: const Color.fromRGBO(200, 200, 200, 1),
                    fontWeight: FontWeight.w600,
                    color: jobStatus == 'Assigned'
                        ? Colors.blue
                        : jobStatus == 'Started'
                            ? Colors.deepOrange
                            : Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            _buildTimeline(),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeline() {
    return Row(
      children: [
        Container(
          width: 40.0,
          child: FixedTimeline.tileBuilder(
            builder: TimelineTileBuilder(
              indicatorBuilder: (context, index) => DotIndicator(
                color: index == 0 ? Colors.red : Colors.green,
              ),
              startConnectorBuilder: (context, index) => const SolidLineConnector(
                color: Colors.grey,
              ),
              endConnectorBuilder: (context, index) => const SolidLineConnector(
                color: Colors.grey,
              ),
              itemCount: 2,
            ),
          ),
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(pickupLocation, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(pickupAddress),
              const SizedBox(height: 16.0),
              Text(deliveryLocation, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(deliveryAddress),
            ],
          ),
        ),
      ],
    );
  }
}