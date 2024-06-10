import 'package:e_pod/src/services/job_order/controller/JobOrderController.dart';
import 'package:flutter/material.dart';

import 'package:e_pod/src/components/utils/Request.dart' as request;
import 'package:e_pod/src/screens/job_management/job_order/widgets/job_details.stateless.dart';
import 'package:e_pod/src/screens/job_management/job_order/widgets/job_details.stateful.dart';

class DeliveryDetailsCard extends StatelessWidget {
  final dynamic data;

  const DeliveryDetailsCard({
    super.key,

    required this.data
  });

  @override
  Widget build(BuildContext context) {
    final String jobType = data['jobType'] ?? '';
    final String startPickupAt = data['startPickupAtFormat'] ?? '';
    final String endPickupAt = data['endPickupAtFormat'] ?? '';

    return 
    Card(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 125,
                  child: Text(
                    "Job Type",
                    style: TextStyle(color: Color.fromRGBO(96, 96, 96, 1), fontWeight: FontWeight.w600),
                  ),
                ),
                Text(jobType),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: const Divider(height: 1, color: Color.fromRGBO(200, 200, 200, 0.8)),
            ),
            Row(
              children: [
                const Divider(height: 2, color: Color.fromRGBO(200, 200, 200, 0.8)),
                const SizedBox(
                  width: 125,
                  child: Text(
                    "Start Pickup",
                    style: TextStyle(color: Color.fromRGBO(96, 96, 96, 1), fontWeight: FontWeight.w600),
                  ),
                ),
                Text(startPickupAt)
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: const Divider(height: 1, color: Color.fromRGBO(200, 200, 200, 0.8)),
            ),
            Row(
              children: [
                const Divider(height: 2, color: Color.fromRGBO(200, 200, 200, 0.8)),
                const SizedBox(
                  width: 125,
                  child: Text(
                    "End Delivery",
                    style: TextStyle(color: Color.fromRGBO(96, 96, 96, 1), fontWeight: FontWeight.w600),
                  ),
                ),
                Text(endPickupAt)
              ],
            ),
          ],
        ),
      ),
    );
  }
}


class PickupCard extends StatelessWidget {
  final dynamic data;

  const PickupCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pickupLocation = data['pickupLocation'] ?? '';
    final pickupAddress = data['pickupAddress'] ?? '';
    final pickupContact = data['pickupContact'] ?? '';
    final pickupContactNo = data['pickupContactNo'] ?? '';

    return Card(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 125,
                  child: Text(
                    "Location",
                    style: TextStyle(color: Color.fromRGBO(96, 96, 96, 1), fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(
                  child: Text(
                    pickupLocation,
                    style: const TextStyle(
                      color: Color.fromRGBO(96, 96, 96, 1),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: const Divider(height: 1, color: Color.fromRGBO(200, 200, 200, 0.8)),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 125,
                  child: Text(
                    "Address",
                    style: TextStyle(color: Color.fromRGBO(96, 96, 96, 1), fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(
                  child: Text(
                    pickupAddress,
                    style: const TextStyle(
                      color: Color.fromRGBO(96, 96, 96, 1),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: const Divider(height: 1, color: Color.fromRGBO(200, 200, 200, 0.8)),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 125,
                  child: Text(
                    "Contact Name",
                    style: TextStyle(color: Color.fromRGBO(96, 96, 96, 1), fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(
                  child: Text(
                    pickupContact,
                    style: const TextStyle(
                      color: Color.fromRGBO(96, 96, 96, 1),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: const Divider(height: 1, color: Color.fromRGBO(200, 200, 200, 0.8)),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 125,
                  child: Text(
                    "Contact No",
                    style: TextStyle(color: Color.fromRGBO(96, 96, 96, 1), fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(
                  child: Text(
                    pickupContactNo,
                    style: const TextStyle(
                      color: Color.fromRGBO(96, 96, 96, 1),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


class DeliveryCard extends StatelessWidget {
  final dynamic data;

  const DeliveryCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deliveryLocation = data['deliveryLocation'] ?? '';
    final deliveryAddress = data['deliveryAddress'] ?? '';
    final deliveryContact = data['deliveryContact'] ?? '';
    final deliveryContactNo = data['deliveryContactNo'] ?? '';

    return Card(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 125,
                  child: Text(
                    "Location",
                    style: TextStyle(color: Color.fromRGBO(96, 96, 96, 1), fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(
                  child: Text(
                    deliveryLocation,
                    style: const TextStyle(
                      color: Color.fromRGBO(96, 96, 96, 1),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: const Divider(height: 1, color: Color.fromRGBO(200, 200, 200, 0.8)),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 125,
                  child: Text(
                    "Address",
                    style: TextStyle(color: Color.fromRGBO(96, 96, 96, 1), fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(
                  child: Text(
                    deliveryAddress,
                    style: const TextStyle(
                      color: Color.fromRGBO(96, 96, 96, 1),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: const Divider(height: 1, color: Color.fromRGBO(200, 200, 200, 0.8)),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 125,
                  child: Text(
                    "Contact Name",
                    style: TextStyle(color: Color.fromRGBO(96, 96, 96, 1), fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(
                  child: Text(
                    deliveryContact,
                    style: const TextStyle(
                      color: Color.fromRGBO(96, 96, 96, 1),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: const Divider(height: 1, color: Color.fromRGBO(200, 200, 200, 0.8)),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 125,
                  child: Text(
                    "Contact No",
                    style: TextStyle(color: Color.fromRGBO(96, 96, 96, 1), fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(
                  child: Text(
                    deliveryContactNo,
                    style: const TextStyle(
                      color: Color.fromRGBO(96, 96, 96, 1),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


class JobOrderDetailsTab extends StatelessWidget {
  final String jobOrderId;

  const JobOrderDetailsTab({ super.key, required this.jobOrderId });

  @override
  Widget build(BuildContext context) {
    final jobOrderController = JobOrderController();

    return Stack(
      children: [
        SingleChildScrollView(
          child: Container(
            width: double.infinity,
            color: const Color.fromRGBO(235, 235, 235, 0.9),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                request.Builder(
                  future: jobOrderController.getUpdateJobOrder(jobOrderId),
                  builder: (context, jobOrder) {
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
                        ItemDetailsCard(jobOrderId: jobOrderId),
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
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}


class AssigneeDetails extends StatelessWidget {
  final Map<String, dynamic> selectedAssignee;

  const AssigneeDetails({super.key, required this.selectedAssignee});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 12.0, bottom: 16.0),
          child: const Text('Assignee Details', style: TextStyle(color: Color.fromRGBO(96, 96, 96, 1), fontWeight: FontWeight.bold)),
        ),
        Row(
          children: [
            const SizedBox(
              width: 125,
              child: Text("Location: ", style: TextStyle(fontWeight: FontWeight.w600, color: Color.fromRGBO(96, 96, 96, 0.8))),
            ),
            Text(selectedAssignee['locationName'] ?? '')
          ],
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 4.0),
          child: const Divider(color: Color.fromRGBO(96, 96, 96, 0.8)),
        ),
        Row(
          children: [
            const SizedBox(
              width: 125,
              child: Text("User Group: ", style: TextStyle(fontWeight: FontWeight.w600, color: Color.fromRGBO(96, 96, 96, 0.8))),
            ),
            Text(selectedAssignee['userGroupName'] ?? '')
          ],
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 4.0),
          child: const Divider(color: Color.fromRGBO(96, 96, 96, 0.8)),
        ),
        Row(
          children: [
            const SizedBox(
              width: 125,
              child: Text("Supervisor: ", style: TextStyle(fontWeight: FontWeight.w600, color: Color.fromRGBO(96, 96, 96, 0.8))),
            ),
            Text(selectedAssignee['supervisorName'] ?? '')
          ],
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 4.0),
          child: const Divider(color: Color.fromRGBO(96, 96, 96, 0.8)),
        ),
        Row(
          children: [
            const SizedBox(
              width: 125,
              child: Text("Gender: ", style: TextStyle(fontWeight: FontWeight.w600, color: Color.fromRGBO(96, 96, 96, 0.8))),
            ),
            Text(selectedAssignee['gender'] ?? '')
          ],
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 4.0),
          child: const Divider(color: Color.fromRGBO(96, 96, 96, 0.8)),
        ),
        Row(
          children: [
            const SizedBox(
              width: 125,
              child: Text("Title: ", style: TextStyle(fontWeight: FontWeight.w600, color: Color.fromRGBO(96, 96, 96, 0.8))),
            ),
            Text(selectedAssignee['title'] ?? '')
          ],
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 4.0),
          child: const Divider(color: Color.fromRGBO(96, 96, 96, 0.8)),
        ),
        Row(
          children: [
            const SizedBox(
              width: 125,
              child: Text(
                "Email: ",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color.fromRGBO(96, 96, 96, 0.8),
                ),
              ),
            ),
            Flexible(
              child: Text(
                selectedAssignee['email'] ?? '',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),

        Container(
          margin: const EdgeInsets.symmetric(vertical: 4.0),
          child: const Divider(color: Color.fromRGBO(96, 96, 96, 0.8)),
        ),
        Row(
          children: [
            const SizedBox(
              width: 125,
              child: Text("Phone No: ", style: TextStyle(fontWeight: FontWeight.w600, color: Color.fromRGBO(96, 96, 96, 0.8))),
            ),
            Text(selectedAssignee['phoneNo'] ?? '')
          ],
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 4.0),
          child: const Divider(color: Color.fromRGBO(96, 96, 96, 0.8)),
        ),
      ],
    );
  }
}

class VehicleDetails extends StatelessWidget {
  final Map<String, dynamic> selectedAssignee;

  const VehicleDetails({super.key, required this.selectedAssignee});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 12.0, bottom: 16.0),
          child: const Text('Vehicle Details', style: TextStyle(color: Color.fromRGBO(96, 96, 96, 1), fontWeight: FontWeight.bold)),
        ),
        Row(
          children: [
            const SizedBox(
              width: 125,
              child: Text("Vehicle No: ", style: TextStyle(fontWeight: FontWeight.w600, color: Color.fromRGBO(96, 96, 96, 0.8))),
            ),
            Text(selectedAssignee['vehicleNo'] ?? '')
          ],
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 4.0),
          child: const Divider(color: Color.fromRGBO(96, 96, 96, 0.8)),
        ),
        Row(
          children: [
            const SizedBox(
              width: 125,
              child: Text("Brand: ", style: TextStyle(fontWeight: FontWeight.w600, color: Color.fromRGBO(96, 96, 96, 0.8))),
            ),
            Text(selectedAssignee['brand'] ?? '')
          ],
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 4.0),
          child: const Divider(color: Color.fromRGBO(96, 96, 96, 0.8)),
        ),
        Row(
          children: [
            const SizedBox(
              width: 125,
              child: Text("Model: ", style: TextStyle(fontWeight: FontWeight.w600, color: Color.fromRGBO(96, 96, 96, 0.8))),
            ),
            Text(selectedAssignee['model'] ?? '')
          ],
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 4.0),
          child: const Divider(color: Color.fromRGBO(96, 96, 96, 0.8)),
        ),
        Row(
          children: [
            const SizedBox(
              width: 125,
              child: Text("Color: ", style: TextStyle(fontWeight: FontWeight.w600, color: Color.fromRGBO(96, 96, 96, 0.8))),
            ),
            Text(selectedAssignee['color'] ?? '')
          ],
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 4.0),
          child: const Divider(color: Color.fromRGBO(96, 96, 96, 0.8)),
        ),
        Row(
          children: [
            const SizedBox(
              width: 125,
              child: Text("Year: ", style: TextStyle(fontWeight: FontWeight.w600, color: Color.fromRGBO(96, 96, 96, 0.8))),
            ),
            Text(selectedAssignee['year'] ?? '')
          ],
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 4.0),
          child: const Divider(color: Color.fromRGBO(96, 96, 96, 0.8)),
        ),
        Row(
          children: [
            const SizedBox(
              width: 125,
              height: 125,
              child: Text(
                "Remark: ",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color.fromRGBO(96, 96, 96, 0.8),
                ),
              ),
            ),
            Flexible(
              child: Text(
                selectedAssignee['remark'] ?? '',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
