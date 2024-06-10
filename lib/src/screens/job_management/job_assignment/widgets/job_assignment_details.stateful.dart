import 'package:flutter/material.dart';

import 'package:e_pod/src/components/utils/Request.dart' as request;
import 'package:e_pod/src/services/job_order/controller/JobOrderController.dart';
import 'package:e_pod/src/screens/job_management/job_assignment/widgets/job_assignment_details.stateless.dart';


class DeliveryDetailsTab extends StatefulWidget {
  final String jobOrderHasAssignmentId;

  const DeliveryDetailsTab({super.key, required this.jobOrderHasAssignmentId});

  @override
  _DeliveryDetailsState createState() => _DeliveryDetailsState();
}

class _DeliveryDetailsState extends State<DeliveryDetailsTab> {
  @override
  Widget build(BuildContext context) {
    final jobOrderController = JobOrderController();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: request.Builder<Map<String, dynamic>>(
          future: jobOrderController.getUpdateJobOrderHasAssignment(widget.jobOrderHasAssignmentId),
          builder: (context, jobOrderHasAssignment) {

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 16, top: 24),
                  child: const Text(
                    "Delivery Details",
                    style: TextStyle(fontWeight: FontWeight.w600, color: Color.fromRGBO(64, 64, 64, 0.8)),
                  ),
                ),
                DeliveryDetailsCard(data: jobOrderHasAssignment['data']),

                Container(
                  margin: const EdgeInsets.only(left: 16, top: 24),
                  child: const Row(
                    children: [
                      Text(
                        "Pickup",
                        style: TextStyle(fontWeight: FontWeight.w600, color: Colors.red),
                      ),
                      SizedBox(width: 8.0),
                      Icon(Icons.location_on_sharp, color: Colors.red),
                    ],
                  )
                ),
                PickupCard(data: jobOrderHasAssignment['data']),

                Container(
                  margin: const EdgeInsets.only(left: 16, top: 24),
                  child: const Row(
                    children: [
                      Text(
                        "Delivery",
                        style: TextStyle(fontWeight: FontWeight.w600, color: Colors.green),
                      ),
                      SizedBox(width: 8.0),
                      Icon(Icons.location_searching_sharp, color: Colors.green),
                    ],
                  )
                ),
                DeliveryCard(data: jobOrderHasAssignment['data']),

                const SizedBox(height: 100.0)
              ],
            );
          },
        ),
      ),
    );
  }
}


class BottomSheetTab extends StatefulWidget {
  final String jobOrderHasAssignmentId;

  const BottomSheetTab({super.key, required this.jobOrderHasAssignmentId});

  @override
  _BottomSheetState createState() => _BottomSheetState();
}

class _BottomSheetState extends State<BottomSheetTab> {
  final ValueNotifier<Map<String, dynamic>> selectedAssigneeNotifier = ValueNotifier<Map<String, dynamic>>({});

  @override
  Widget build(BuildContext context) {
    final jobOrderController = JobOrderController();

    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
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
      child: FutureBuilder<List<Map<String, dynamic>>>(
        future: jobOrderController.getUpdateJobOrderHasAssignee(widget.jobOrderHasAssignmentId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final jobOrderHasAssignee = snapshot.data!;

          return Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 24.0, top: 32.0),
                    child: Text(
                      'Assignee',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  if (jobOrderHasAssignee.isEmpty)
                    const SizedBox()
                  else
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: jobOrderHasAssignee.map((assignee) {
                            return GestureDetector(
                              onTap: () {
                                selectedAssigneeNotifier.value = assignee;
                              },
                              child: ValueListenableBuilder<Map<String, dynamic>>(
                                valueListenable: selectedAssigneeNotifier,
                                builder: (context, selectedAssignee, _) {
                                  return _buildAssigneeBadge(assignee, selectedAssignee);
                                },
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(top: 32.0),
                      child: Card(
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(50.0), topRight: Radius.circular(50.0))),
                        color: Colors.white,
                        child: Column(
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                child: Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                                  child: ValueListenableBuilder<Map<String, dynamic>>(
                                    valueListenable: selectedAssigneeNotifier,
                                    builder: (context, selectedAssignee, _) {
                                      return Column(
                                        children: [
                                          AssigneeDetails(selectedAssignee: selectedAssignee),
                                          const SizedBox(height: 32.0),
                                          VehicleDetails(selectedAssignee: selectedAssignee),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Colors.orange, Colors.deepOrange],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                  elevation: WidgetStateProperty.all(0),
                                  backgroundColor: WidgetStateProperty.all(Colors.transparent),
                                  shape: WidgetStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                                child: const Text(
                                  'Start',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAssigneeBadge(Map<String, dynamic> assignee, Map<String, dynamic> selectedAssignee) {
    final isSelected = selectedAssignee['UUID'] == assignee['UUID'];
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.white70,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Text(
          assignee['assigneeFullName'],
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

