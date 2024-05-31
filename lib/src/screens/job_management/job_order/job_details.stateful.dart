import 'package:flutter/material.dart';

import 'package:e_pod/src/components/api/Request.dart';

import 'package:e_pod/src/screens/job_management/job_order/job_details.stateless.dart';


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