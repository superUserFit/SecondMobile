import 'package:e_pod/src/components/utils/UseShowToast.dart';
import 'package:e_pod/src/screens/job_management/job_order/view/AddSupervisor.dart';
import 'package:e_pod/src/screens/job_management/job_order/view/JobDetails.dart';
import 'package:e_pod/src/screens/job_management/widgets/Card.dart';
import 'package:e_pod/src/services/job_order/controller/JobOrderController.dart';
import 'package:flutter/material.dart';

import 'package:e_pod/src/components/utils/Request.dart' as request;

import 'package:e_pod/src/screens/job_management/job_order/widgets/job_details.stateless.dart';

//  START: ItemDetailsCard
class ItemDetailsCard extends StatefulWidget {
  final String jobOrderId;

  const ItemDetailsCard({
    Key? key,

    required this.jobOrderId
  }); 

  @override
  _ItemCardState createState() => _ItemCardState();
}


class _ItemCardState extends State<ItemDetailsCard> {
  late String selectedItemType;
  late bool isItemExpand;

  void initState(){
    super.initState();
    selectedItemType = 'All';
    isItemExpand = true;
  }

  Widget _itemTab(String itemType) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedItemType = itemType;
        });
      },
      child: Text(
        itemType,
        style: TextStyle(
          color: selectedItemType == itemType ? Colors.deepOrange : Colors.black,
          fontWeight: FontWeight.w600
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final jobOrderController = JobOrderController();

    return Card(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isItemExpand = !isItemExpand;
                    });
                  },
                  child: const Icon(Icons.filter_list_off_rounded),
                ),
                Row(
                  children: [
                    _itemTab('All'),
                    const SizedBox(width: 12.0),
                    _itemTab('Stock'),
                    const SizedBox(width: 12.0),
                    _itemTab('Service'),
                    const SizedBox(width: 12.0),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            request.Builder(
              future: jobOrderController.getUpdateJobOrderHasDetails(widget.jobOrderId, selectedItemType),
              builder: (context, jobOrderHasDetails) {
                if(isItemExpand) {
                  return ItemDetails(data: jobOrderHasDetails);
                } else {
                  return const SizedBox(height: 4.0);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
//  END: ItemDetailsCard


//  START: SupervisorTab
class SupervisorTab extends StatefulWidget {
  final String jobOrderId;

  const SupervisorTab({
    Key? key,
    required this.jobOrderId,
  }) : super(key: key);

  @override
  _SupervisorTabState createState() => _SupervisorTabState();
}

class _SupervisorTabState extends State<SupervisorTab> {
  late Future<List<dynamic>> _jobOrderHasSupervisorsFuture;
  List<dynamic> jobOrderHasSupervisors = [];
  dynamic selectedSupervisor = {};
  final jobOrderController = JobOrderController();

  @override
  void initState() {
    super.initState();
    _jobOrderHasSupervisorsFuture = _fetchJobOrderHasSupervisors();
  }

  Future<List<dynamic>> _fetchJobOrderHasSupervisors() async {
    final response = request.Request(
      endpoint: '/job_order/api/job-order/get-update-job-order-has-supervisor-data?id=${widget.jobOrderId}',
      method: 'GET'
    );

    final data = await response.fetchData();
    jobOrderHasSupervisors = data['rows'] as List<dynamic>;

    return jobOrderHasSupervisors;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: _jobOrderHasSupervisorsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No data found"));
        } else {
          jobOrderHasSupervisors = snapshot.data!;
          return _buildSupervisorContent();
        }
      },
    );
  }

  Widget _buildSupervisorContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    ...jobOrderHasSupervisors.map((supervisor) =>
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedSupervisor = supervisor;
                          });
                        },
                        child: _buildSupervisorBadge(supervisor['fullNameName'] ?? ''),
                      )
                    ),
                    Container(
                      margin: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context, 
                            MaterialPageRoute(builder: (context) => AddSupervisor(jobOrderId: widget.jobOrderId))
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(12.0),
                        ),
                        child: const Icon(Icons.add),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        Expanded(
          child: Card(
            color: Colors.white,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50.0),
                  topRight: Radius.circular(50.0),
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const SizedBox(
                          width: 125,
                          child: Text("Location: ", style: TextStyle(fontWeight: FontWeight.w600, color: Color.fromRGBO(96, 96, 96, 0.8))),
                        ),
                        Text(selectedSupervisor['locationName'] ?? '')
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
                          child: Text("Full Name: ", style: TextStyle(fontWeight: FontWeight.w600, color: Color.fromRGBO(96, 96, 96, 0.8))),
                        ),
                        Text(selectedSupervisor['fullNameName'] ?? '')
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
                        Text(selectedSupervisor['title'] ?? '')
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
                        Text(selectedSupervisor['gender'] ?? '')
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
                        Text(selectedSupervisor['phoneNo'] ?? '')
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
                          child: Text("Return Reason: ", style: TextStyle(fontWeight: FontWeight.w600, color: Color.fromRGBO(96, 96, 96, 0.8))),
                        ),
                        Text(selectedSupervisor['returnReason'] ?? '')
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 4.0),
                      child: const Divider(color: Color.fromRGBO(96, 96, 96, 0.8)),
                    ),

                    const SizedBox(height: 50.0),

                    ElevatedButton(
                      onPressed: _removeJobOrderHasSupervisor, 
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                      child: const Center(child: Text("Remove", style: TextStyle(color: Colors.deepOrange))),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSupervisorBadge(String supervisor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        decoration: const BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
        child: Text(supervisor),
      ),
    );
  }

  void _removeJobOrderHasSupervisor() {
    var formData = {
      'UUIDs[]': selectedSupervisor['UUID']
    };

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => request.Builder(
          future: jobOrderController.removeJobOrderHasSupervisor(formData),
          builder: (context, response) {
            if(response.isNotEmpty) {
              UseToast.showToast(
                message: 'Supervisor successfully deleted',
                status: 'success'
              );
              // setState(() {
              //   jobOrderHasSupervisors.removeWhere((supervisor) => supervisor['UUID'] == selectedSupervisor['UUID']);
              //   selectedSupervisor = {};
              // });
              return JobDetailsSection(jobOrderId: widget.jobOrderId);
            }
            return const Center(child: CircularProgressIndicator());
          },
        )
      ),
    );
  }
}


class JobCardTab extends StatefulWidget {
  final String jobOrderId;

  const JobCardTab({
    Key? key,

    required this.jobOrderId
  }) : super(key: key);

  @override
  _JobCardState createState() => _JobCardState();
}

class _JobCardState extends State<JobCardTab> {
  final jobOrderController = JobOrderController();

  late String selectedJobStatus;

  @override
  void initState() {
    super.initState();
    selectedJobStatus = 'All';
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      height: double.infinity,
      width: double.infinity,
      margin: const EdgeInsets.only(top: 20.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
      ),
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color.fromRGBO(200, 200, 200, 0.75),
                borderRadius: BorderRadius.circular(32.0),
              ),
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    flex: 7,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: const TextField(
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 4.0),
                          hintText: "Search...",
                          prefixIcon: Icon(Icons.search),
                          border: InputBorder.none,
                        ),
                        maxLines: 1,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  ElevatedButton(
                    onPressed: () {}, 
                    child: const Icon(Icons.timer_sharp)
                  ),
                ],
              ),
            ),

            Expanded(
              child: request.Builder(
                future: jobOrderController.getJobOrderHasAssignment(widget.jobOrderId, selectedJobStatus),
                builder: (context, jobOrderHasAssignments) {
                  if(jobOrderHasAssignments.isEmpty) {
                    return const Center(
                      child: Text('No available Job Assignment'),
                    );
                  }
                  
                  return ListView.builder(
                    itemCount: jobOrderHasAssignments.length,
                    itemBuilder: (context, index) {
                      final assignment = jobOrderHasAssignments[index];
                      return JobAssignmentCard(
                        customerName: assignment['customerName'] ?? '', 
                        pickupLocation: assignment['pickupLocation'] ?? '', 
                        pickupAddress: assignment['pickupAddress'] ?? '', 
                        deliveryLocation: assignment['deliveryLocation'] ?? '', 
                        deliveryAddress: assignment['deliveryAddress'] ?? '', 
                        jobStatus: assignment['jobStatus'] ?? '', 
                        startPickupAt: assignment['startPickupAt'] ?? '', 
                        endDeliveryAt: assignment['endDeliveryAt'] ?? ''
                      );
                    }
                  );
                },
              ),
            ),
          ],
        ),
        )
      ),
    );
  }
}
