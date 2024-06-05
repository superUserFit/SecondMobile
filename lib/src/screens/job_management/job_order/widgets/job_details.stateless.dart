import 'package:e_pod/src/components/utils/Request.dart';
import 'package:e_pod/src/screens/job_management/job_order/widgets/job_details.stateful.dart';
import 'package:flutter/material.dart';

class DocumentDetails extends StatelessWidget {
  final dynamic data;

  const DocumentDetails({
    Key? key,

    required this.data
  }): super(key: key);


  @override
  Widget build(BuildContext context) {
    final String docNo = data['docNo'] ?? '';
    final String docDate = data['docDateFormat'] ?? '';
    final String deadline = data['deadlineFormat'] ?? '';
    final String description = data['description'] ?? '';

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
                child: Text("Doc No", style: TextStyle(color: Color.fromRGBO(96, 96, 96, 1))),
              ),
              Text(docNo)
            ],
          ),

          Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: const Divider(height: 1, color: Color.fromRGBO(200, 200, 200, 0.8)),
          ),

          Row(
            children: [
              const SizedBox(
                width: 125,
                child: Text("Date", style: TextStyle(color: Color.fromRGBO(96, 96, 96, 1))),
              ),
              Text(docDate)
            ],
          ),

          Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: const Divider(height: 1, color: Color.fromRGBO(200, 200, 200, 0.8)),
          ),

          Row(
            children: [
              const SizedBox(
                width: 125,
                child: Text("Deadline", style: TextStyle(color: Color.fromRGBO(96, 96, 96, 1))),
              ),
              Text(deadline)
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
                height: 100,
                child: Text("Description", style: TextStyle(color: Color.fromRGBO(96, 96, 96, 1))),
              ),
              Text(description)
            ],
          )
        ],
      ),
      )
    );
  }
}


class CustomerDetails extends StatelessWidget {
  final dynamic data;

  const CustomerDetails({
    Key? key,

    required this.data
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String customerName = data['customerName'] ?? '';
    final String attentionName = data['attentionName'] ?? '';
    final String phoneNo = data['phoneNo'] ?? '';
    final String address = data['address'] ?? '';


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
                  child: Text("Customer", style: TextStyle(color: Color.fromRGBO(96, 96, 96, 1))),
                ),
                Text(customerName)
              ],
            ),

            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: const Divider(height: 1, color: Color.fromRGBO(200, 200, 200, 0.8)),
            ),

            Row(
              children: [
                const SizedBox(
                  width: 125,
                  child: Text("Attention",  style: TextStyle(color: Color.fromRGBO(96, 96, 96, 1))),
                ),
                Text(attentionName)
              ],
            ),

            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: const Divider(height: 1, color: Color.fromRGBO(200, 200, 200, 0.8)),
            ),

            Row(
              children: [
                const SizedBox(
                  width: 125,
                  child: Text("Phone No",  style: TextStyle(color: Color.fromRGBO(96, 96, 96, 1))),
                ),
                Text(phoneNo)
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
                  height: 100,
                  child: Text("Address",  style: TextStyle(color: Color.fromRGBO(96, 96, 96, 1))),
                ),
                Text(address)
              ],
            ),
          ],
        ),
      )
    );
  }
}


class ItemDetails extends StatelessWidget {
  final dynamic data;

  const ItemDetails({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ...data.map<Widget>((item) {
            final String itemCode = item['itemCode'] ?? '';
            final String itemType = item['type'] ?? '';
            final String itemDescription = item['description'] ?? '';
            final String itemQuantity = item['quantity'] ?? '';
            final String itemUOM = item['itemUOM'] ?? '';

            return Card(
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: ExpansionTile(
                  title: Text(itemType),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                      children: [
                        const SizedBox(
                            width: 125,
                            child: Text("Code", style: TextStyle(color: Color.fromRGBO(96, 96, 96, 1), fontWeight: FontWeight.w600)),
                          ),
                          Text(itemCode)
                        ],
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      child: const Divider(height: 1, color: Color.fromRGBO(200, 200, 200, 1)),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                      children: [
                        const SizedBox(
                            width: 125,
                            child: Text("Type", style: TextStyle(color: Color.fromRGBO(96, 96, 96, 1), fontWeight: FontWeight.w600)),
                          ),
                          Text(itemType)
                        ],
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      child: const Divider(height: 1, color: Color.fromRGBO(200, 200, 200, 1)),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                      children: [
                        const SizedBox(
                            width: 125,
                            child: Text("Description", style: TextStyle(color: Color.fromRGBO(96, 96, 96, 1), fontWeight: FontWeight.w600)),
                          ),
                          Text(itemDescription)
                        ],
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      child: const Divider(height: 1, color: Color.fromRGBO(200, 200, 200, 1)),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                      children: [
                        const SizedBox(
                            width: 125,
                            child: Text("Quantity", style: TextStyle(color: Color.fromRGBO(96, 96, 96, 1), fontWeight: FontWeight.w600)),
                          ),
                          Text(itemQuantity)
                        ],
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      child: const Divider(height: 1, color: Color.fromRGBO(200, 200, 200, 1)),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                      children: [
                        const SizedBox(
                            width: 125,
                            child: Text("UOM", style: TextStyle(color: Color.fromRGBO(96, 96, 96, 1), fontWeight: FontWeight.w600)),
                          ),
                          Text(itemUOM)
                        ],
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      child: const Divider(height: 1, color: Color.fromRGBO(200, 200, 200, 1)),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}


class MoreDetails extends StatelessWidget {
  final dynamic data;

  const MoreDetails({
    Key? key,

    required this.data
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String containerNo = data['containerNo'];
    final String containerSize = data['containerSize'];
    final String containerType = data['containerType'];
    final String deliveryAddress = data['deliveryAddress'];

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
                  child: Text("Container No",  style: TextStyle(color: Color.fromRGBO(96, 96, 96, 1))),
                ),
                Text(containerNo)
              ],
            ),

            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: const Divider(height: 1, color: Color.fromRGBO(200, 200, 200, 0.8)),
            ),

            Row(
              children: [
                const SizedBox(
                  width: 125,
                  child: Text("Container Size",  style: TextStyle(color: Color.fromRGBO(96, 96, 96, 1))),
                ),
                Text(containerSize)
              ],
            ),

            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: const Divider(height: 1, color: Color.fromRGBO(200, 200, 200, 0.8)),
            ),

            Row(
              children: [
                const SizedBox(
                  width: 125,
                  child: Text("Container Type",  style: TextStyle(color: Color.fromRGBO(96, 96, 96, 1))),
                ),
                Text(containerType)
              ],
            ),

            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: const Divider(height: 1, color: Color.fromRGBO(200, 200, 200, 0.8)),
            ),

            Row(
              children: [
                const SizedBox(
                  width: 125,
                  child: Text("Delivery Address",  style: TextStyle(color: Color.fromRGBO(96, 96, 96, 1))),
                ),
                Text(deliveryAddress)
              ],
            ),
          ],
        ),
      ),
    );
  }
}


class BottomSheetTab extends StatelessWidget {
  final dynamic jobOrderId;

  const BottomSheetTab({ 
    Key? key,

    required this.jobOrderId
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
  late dynamic jobOrderHasSupervisors = [];

    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
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
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            bottom: TabBar(
              indicator: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 10,
              indicatorColor: Colors.transparent,
              labelColor: Colors.deepOrange,
              labelStyle: const TextStyle(fontWeight: FontWeight.w700),
              unselectedLabelColor: Colors.white,
              unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w700),
              tabs: const [
                Tab(text: "Supervisor"),
                Tab(text: "Job Card"),
              ],
            ),
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: TabBarView(
            children: [
              Request(
                endpoint: '/job_order/api/job-order/get-update-job-order-has-supervisor-data?id=$jobOrderId', 
                builder: ((context, snapshot) {
                  final dynamic responseData = snapshot.data;
                  
                  jobOrderHasSupervisors = responseData['rows'];
                  return SupervisorTab(jobOrderHasSupervisors: jobOrderHasSupervisors);
                }) 
              ),
              Center(child: Text("This is Job Card tab")),
            ],
          ),
        ),
      ),
    );
  }
}
