import 'package:equatable/equatable.dart';


class JobOrder extends Equatable {
  final String id;
  final String docNo;
  final String docDate;
  final String customerName;

  final String pickupLocation;
  final String pickupAddress;
  final String deliveryLocation;
  final String deliveryAddress;

  final String jobStatus;
  final String startPickupAt;
  final String endDeliveryAt;

  const JobOrder({
    required this.id,
    required this.docNo,
    required this.docDate,
    required this.customerName,

    required this.pickupLocation,
    required this.pickupAddress,
    required this.deliveryLocation,
    required this.deliveryAddress,

    required this.jobStatus,
    required this.startPickupAt,
    required this.endDeliveryAt
  }) : super();

  @override
  List<Object?> get props => [
    id, 
    docNo, 
    docDate, 
    customerName, 

    pickupLocation, 
    pickupAddress,
    deliveryLocation,
    deliveryAddress,

    jobStatus,
    startPickupAt,
    endDeliveryAt
  ];
}
