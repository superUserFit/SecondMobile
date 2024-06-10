import 'package:riverpod/riverpod.dart';
import 'package:e_pod/src/components/utils/Request.dart';
import 'package:e_pod/src/services/job_order/models/JobOrder.dart';


class JobOrderController {
  Future<List<Map<String, dynamic>>> getAllJobOrderHasAssignment(String selectedJobStatus) async {
    final request = Request(
      endpoint: '/job_order/api/job-order/get-all-job-order-has-assignment?jobStatus=$selectedJobStatus', 
      method: 'GET'
    );

    final response = await request.fetchData();

    if (response == null || response['rows'] == null) {
      return [];
    }

    final List jobOrderHasAssignments = response['rows'];

    return jobOrderHasAssignments.cast<Map<String, dynamic>>();
  }


  Future<List<Map<String, dynamic>>> getJobOrderHasAssignment(String jobOrderId, String selectedJobStatus) async {
    final request = Request(
      endpoint: '/job_order/api/job-order/get-update-job-order-has-assignment-data?id=$jobOrderId&jobStatus=$selectedJobStatus',
      method: 'GET'
    );

    final response = await request.fetchData();
    if (response == null || response['rows'] == null) {
      return [];
    }

    final List jobOrderHasAssignments = response['rows'];

    return jobOrderHasAssignments.cast<Map<String, dynamic>>();
  }


  Future<Map<String, dynamic>> getUpdateJobOrder(String jobOrderId) async {
    final request = Request(
      endpoint: "/job_order/api/job-order/get-update-job-order-data?id=$jobOrderId", 
      method: 'GET'
    );

    final jobOrder = await request.fetchData();

    return jobOrder.cast<String, dynamic>();
  }


  Future<List<Map<String, dynamic>>> getUpdateJobOrderHasDetails(String jobOrderId, String selectedItemType) async {
    final request = Request(
      endpoint: '/job_order/api/job-order/get-update-job-order-has-details-data?id=$jobOrderId&itemType=$selectedItemType', 
      method: 'GET',
    );

    final response = await request.fetchData();

    if (response == null || response['rows'] == null) {
      return [];
    }

    final List jobOrderHasDetails = response['rows'];

    return jobOrderHasDetails.cast<Map<String, dynamic>>();
  } 


  Future<dynamic> updateJobOrderHasSupervisor(String jobOrderId, dynamic formData) async {
    final request = Request(
      endpoint: '/job_order/api/job-order/update-job-order-has-supervisor-data?id=$jobOrderId', 
      method: 'POST',
      body: formData
    );

    final response = await request.fetchData();

    return response;
  }


  Future<List<dynamic>> getJobOrderHasSupervisors(String jobOrderId) async {
    final request = Request(
      endpoint: '/job_order/api/job-order/get-update-job-order-has-supervisor-data?id=$jobOrderId',
      method: 'POST',
    );

    final response = await request.fetchData();

    if (response == null || response['rows'] == null) {
      return [];
    }

    final List jobOrderHasSupervisors = response['rows'];

    return jobOrderHasSupervisors.cast<Map<String, dynamic>>();
  }


  Future<Map<String, dynamic>> removeJobOrderHasSupervisor(dynamic formData) async {
    final request = Request(
      endpoint: '/job_order/api/job-order/remove-job-order-has-supervisor-data', 
      method: 'POST',
      body: formData
    );

    final response = await request.fetchData();

    return response;
  }


  Future<Map<String, dynamic>> getUpdateJobOrderHasAssignment(String jobOrderHasAssignmentId) async {
    final request = Request(
      endpoint: '/job_order/api/job-order/get-update-job-order-has-assignment?id=$jobOrderHasAssignmentId', 
      method: 'GET'
    );

    final jobOrderHasAssignment = await request.fetchData();

    return jobOrderHasAssignment.cast<String, dynamic>();
  }


  Future<List<Map<String, dynamic>>> getUpdateJobOrderHasAssignee(String jobOrderId) async {
    final request = Request(
      endpoint: '/job_order/api/job-order/get-update-job-order-has-assignee-data?id=$jobOrderId', 
      method: 'GET'
    );

    final response = await request.fetchData();

    if (response == null || response['rows'] == null) {
      return [];
    }

    final List jobOrderHasAssignees = response['rows'];

    return jobOrderHasAssignees.cast<Map<String, dynamic>>();
  }
}
