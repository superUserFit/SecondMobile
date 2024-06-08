class JobOrder {
  final String id;
  final String docNo;
  final String docDate;
  final String customerName;

  final String pickupLocation;
  final String pickupAddress;
  final String deliveryLocation;
  final String deliveryAddress;

  final String startPickupAt;
  final String endPickupAt;

  JobOrder({
    required this.id,
    required this.docNo,
    required this.docDate,
    required this.customerName,

    required this.pickupLocation,
    required this.pickupAddress,
    required this.deliveryLocation,
    required this.deliveryAddress,

    required this.startPickupAt,
    required this.endPickupAt
  });

  factory JobOrder.fromJson(Map<String, dynamic> data) {
    return JobOrder(
      id: data['id'], 
      docNo: data['docNo'], 
      docDate: data['docDate'], 
      customerName: data['customerName'], 
      pickupLocation: data['pickupLocation'], 
      pickupAddress: data['pickupAddress'], 
      deliveryLocation: data['deliveryLocation'], 
      deliveryAddress: data['deliveryAddress'], 
      startPickupAt: data['startPickupAt'], 
      endPickupAt: data['endPickupAt']
    );
  }
}