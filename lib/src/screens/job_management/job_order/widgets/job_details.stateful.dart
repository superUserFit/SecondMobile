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


//  START: DraggableBottomSheet
class DraggableBottomSheet extends StatefulWidget {
  final Widget child;

  const DraggableBottomSheet({ 
    Key? key,

    required this.child
  }): super(key: key);

  @override
  _BottomSheetState createState() => _BottomSheetState();
}

class _BottomSheetState extends State<DraggableBottomSheet> {
  final bottomSheet = GlobalKey();
  final controller = DraggableScrollableController();

  @override
  void initState() {
    super.initState();
    controller.addListener(onChanged);
  }

  void onChanged() {
    final currentSize = controller.size;
    if(currentSize <= 0.05) collapse();
  }

  void collapse() => animatedSheet(getSheet.snapSizes!.first);
  void anchor() => animatedSheet(getSheet.snapSizes!.last);
  void expand() => animatedSheet(getSheet.maxChildSize);
  void hide() => animatedSheet(getSheet.minChildSize);

  void animatedSheet(double size) {
    controller.animateTo(
      size, 
      duration: const Duration(milliseconds: 50), 
      curve: Curves.easeInOut
    );
  }

  DraggableScrollableSheet get getSheet => (bottomSheet.currentWidget as DraggableScrollableSheet);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (builder, constraint) {
      return DraggableScrollableSheet(
        key: bottomSheet,
        initialChildSize: 0.5,
        maxChildSize: 0.8,
        minChildSize: 0,
        expand: true,
        snap: true,
        controller: controller,
        snapSizes: [50/constraint.maxHeight],
        builder: (BuildContext context, ScrollController scrollController) {
          return DecoratedBox(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.orange, Colors.deepOrange],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight
              ),
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
            ),

            child: CustomScrollView(
              controller: scrollController,
              slivers: [
                topButtonIndicator(),
                SliverToBoxAdapter(
                  child: widget.child,
                )
              ],
            ),
          );
        }
      );
    });
  }

  SliverToBoxAdapter topButtonIndicator() {
    return SliverToBoxAdapter(
      child: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              child: Center(
                child: Wrap(children: <Widget>[
                  Container(
                    width: 100,
                    margin: const EdgeInsets.symmetric(vertical: 20.0),
                    height: 8.0,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    )),
                ]))),
          ])),
    );
  }
}
//  END: DraggableBottomSheet


//  START: SupervisorTab
// class SupervisorTab extends StatefulWidget {
//   @override
//   _SupervisorTabState createState() => _SupervisorTabState();
// }

// class _SupervisorTabState extends State<SupervisorTab> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       child: 
//     );
//   }
// }