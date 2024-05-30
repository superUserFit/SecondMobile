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

  final VoidCallback? onPressed;

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

    this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
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
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(200, 200, 200, 1),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Text(
                    jobStatus,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: jobStatus == 'Assigned'
                          ? const Color.fromARGB(225, 25, 12, 139)
                          : jobStatus == 'Started'
                              ? Colors.deepOrange
                              : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            _buildTimeline(),
          ],
        ),
      ),
      ),
    );
  }

  Widget _buildTimeline() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 40.0,
          height: 100.0,
          child: FixedTimeline.tileBuilder(
            builder: TimelineTileBuilder(
              indicatorBuilder: (context, index) => DotIndicator(
                color: index == 0 ? Colors.red : Colors.green,
                child: Icon(
                  index == 0 ? Icons.location_on : Icons.location_searching_sharp,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
              startConnectorBuilder: (context, index) => const SolidLineConnector(
                color: Colors.grey,
              ),
              endConnectorBuilder: (context, index) => const SolidLineConnector(
                color: Colors.grey,
              ),
              itemExtentBuilder: (context, index) => 50.0,
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


class JobPageCard extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;

  final VoidCallback? onPressed;

  const JobPageCard({
    Key? key,
    required this.icon,
    required this.iconColor,
    required this.text,

    this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color textColor = iconColor;
    return SizedBox(
      height: 70,
      child: InkWell(
        onTap: onPressed,
        child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 80, color: iconColor),
              const SizedBox(height: 10),
              Text(
                text,
                style: TextStyle(
                  fontSize: 20.0, 
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
              ],
            ),
          ),
        ),
      )
    );
  }
}