import 'package:flutter/material.dart';

import 'package:e_pod/src/components/utils/Request.dart';

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
            FutureRequest(
              endpoint: '/job_order/api/job-order/get-update-job-order-has-details-data?id=${widget.jobOrderId}&itemType=$selectedItemType', 
              builder: ((context, snapshot) {
                final jobOrderHasDetails = snapshot.data;

                if(isItemExpand) {
                  return ItemDetails(data: jobOrderHasDetails['rows']);
                } else {
                  return const SizedBox(height: 4.0);
                }
              })
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
  final List<dynamic> jobOrderHasSupervisors;

  const SupervisorTab({
    Key? key,
    required this.jobOrderHasSupervisors,
  }) : super(key: key);

  @override
  _SupervisorTabState createState() => _SupervisorTabState();
}

class _SupervisorTabState extends State<SupervisorTab> {
  @override
  Widget build(BuildContext context) {
    dynamic? _selectedSupervisor;

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
                    ...widget.jobOrderHasSupervisors.map((supervisor) =>
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedSupervisor = supervisor;
                          });
                        },
                        child: _buildSupervisorBadge(supervisor['fullNameName'] ?? ''),
                      )
                    ),
                    Container(
                      margin: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          // Add your onPressed logic here
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
                        Text(_selectedSupervisor['locationName'] ?? '')
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 4.0),
                      child: const Divider(color: Color.fromRGBO(96, 96, 96, 0.8)),
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 125,
                          child: Text("Full Name: ", style: TextStyle(fontWeight: FontWeight.w600, color: Color.fromRGBO(96, 96, 96, 0.8))),
                        ),
                        Text(_selectedSupervisor['fullNameName'] ?? '')
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 4.0),
                      child: const Divider(color: Color.fromRGBO(96, 96, 96, 0.8)),
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 125,
                          child: Text("Title: ", style: TextStyle(fontWeight: FontWeight.w600, color: Color.fromRGBO(96, 96, 96, 0.8))),
                        ),
                        Text(_selectedSupervisor['title'] ?? '')
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 4.0),
                      child: const Divider(color: Color.fromRGBO(96, 96, 96, 0.8)),
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 125,
                          child: Text("Gender: ", style: TextStyle(fontWeight: FontWeight.w600, color: Color.fromRGBO(96, 96, 96, 0.8))),
                        ),
                        Text(_selectedSupervisor['gender'] ?? '')
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 4.0),
                      child: const Divider(color: Color.fromRGBO(96, 96, 96, 0.8)),
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 125,
                          child: Text("Phone No: ", style: TextStyle(fontWeight: FontWeight.w600, color: Color.fromRGBO(96, 96, 96, 0.8))),
                        ),
                        Text(_selectedSupervisor['phoneNo'] ?? '')
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 4.0),
                      child: const Divider(color: Color.fromRGBO(96, 96, 96, 0.8)),
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 125,
                          child: Text("Return Reason: ", style: TextStyle(fontWeight: FontWeight.w600, color: Color.fromRGBO(96, 96, 96, 0.8))),
                        ),
                        Text("For fun")
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 4.0),
                      child: const Divider(color: Color.fromRGBO(96, 96, 96, 0.8)),
                    ),

                    const SizedBox(height: 50.0)
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
          color: Colors.white60,
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
        child: Text(supervisor),
      ),
    );
  }
}
