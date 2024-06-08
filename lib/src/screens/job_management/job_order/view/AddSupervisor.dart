import 'package:e_pod/src/components/utils/UseShowToast.dart';
import 'package:e_pod/src/services/job_order/controller/JobOrderController.dart';
import 'package:e_pod/src/screens/job_management/job_order/view/JobDetails.dart';
import 'package:e_pod/src/services/user/controller/UserController.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:e_pod/src/components/utils/Request.dart' as request;

class AddSupervisor extends StatefulWidget {
  final String jobOrderId;

  const AddSupervisor({Key? key, required this.jobOrderId}) : super(key: key);

  @override
  _AddSupervisorState createState() => _AddSupervisorState();
}

class _AddSupervisorState extends State<AddSupervisor> {
  late List<dynamic> _users = [];
  ValueNotifier<List<dynamic>> selectedUsersNotifier = ValueNotifier([]);
  final jobOrderController = JobOrderController();
  final userController = UserController();

  late Map<String, dynamic> formData = {};

  void _selectUser(dynamic user) {
    final List<dynamic> updatedSelectedUsers = List.from(selectedUsersNotifier.value);

    if (updatedSelectedUsers.contains(user)) {
      UseToast.showToast(message: 'User already selected', position: 'TOP');
    } else {
      updatedSelectedUsers.add(user);
    }
    selectedUsersNotifier.value = updatedSelectedUsers;
  }

  void _removeUser(dynamic user) {
    final List<dynamic> updatedSelectedUsers = List.from(selectedUsersNotifier.value);

    if(updatedSelectedUsers.contains(user)) {
      updatedSelectedUsers.remove(user);
    } else {
      UseToast.showToast(message: 'User does not exist',position: 'TOP');
    }
    selectedUsersNotifier.value = updatedSelectedUsers;
  }

  void _saveSupervisors(String jobOrderId) {
    List<dynamic> selectedUsers = selectedUsersNotifier.value;
    for (int index = 0; index < selectedUsers.length; index++) {
      formData['jobOrderHasSupervisor[$index][UUID]'] = '';
      formData['jobOrderHasSupervisor[$index][fullName]'] = selectedUsers[index]['UUID'];
      formData['jobOrderHasSupervisor[$index][location]'] = selectedUsers[index]['baseLocation'];
    }
  
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => request.Builder<dynamic>(
          future: jobOrderController.updateJobOrderHasSupervisor(jobOrderId, formData),
          builder: (context, response) {
            if(response.isNotEmpty) {
              UseToast.showToast(                
                message: 'Supervisor saved successfully',
                status: 'success'
              );
              return JobDetailsSection(jobOrderId: jobOrderId);
            }
            return const Center(child: CircularProgressIndicator());
          },
        )
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Supervisor', style: TextStyle(color: Colors.deepOrange)),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.deepOrange,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Fixed top section
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.grey),
                      const SizedBox(width: 8.0),
                      Text('Kuching', style: TextStyle(fontSize: 16.0)),
                    ],
                  ),
                ),
                const SizedBox(height: 8.0),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.search, color: Colors.grey),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration.collapsed(
                            hintText: 'Search user...',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8.0),
                ValueListenableBuilder<List<dynamic>>(
                  valueListenable: selectedUsersNotifier,
                  builder: (context, selectedUsers, _) {
                    return selectedUsers.isNotEmpty
                        ? SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: selectedUsers.map((user) {
                                return Container(
                                  padding: const EdgeInsets.all(8.0),
                                  margin: const EdgeInsets.only(right: 8.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white30,
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(user['fullName'] ?? ''),
                                      IconButton(
                                        icon: const Icon(Icons.close),
                                        onPressed: () => _removeUser(user),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          )
                        : const SizedBox.shrink();
                  },
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            // Scrollable user list
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    request.Builder(
                      future: userController.getIndexUser(),
                      builder: (context, users) {
                        _users = users;
                        _users.sort((a, b) => (a['fullName'] ?? '').compareTo(b['fullName'] ?? ''));

                        return GroupedListView<dynamic, String>(
                          shrinkWrap: true,
                          elements: _users,
                          groupBy: (element) {
                            String fullName = element['fullName'] ?? '';
                            if (fullName.isEmpty) {
                              return '';
                            }
                            return fullName.substring(0, 1).toUpperCase();
                          },
                          groupSeparatorBuilder: (String groupByValue) {
                            return Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                groupByValue,
                                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            );
                          },

                          itemBuilder: (context, dynamic element) {
                            return GestureDetector(
                              onTap: () => _selectUser(element),
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                margin: const EdgeInsets.only(bottom: 8.0),
                                decoration: BoxDecoration(
                                  color: selectedUsersNotifier.value.contains(element)
                                      ? Colors.blue[50]
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                child: Row(
                                  children: [
                                    Text(element['fullName'] ?? ''),
                                    const SizedBox(width: 4.0),
                                    Text(element['username'] ?? '',
                                        style: const TextStyle(color: Colors.grey)),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () => _saveSupervisors(widget.jobOrderId),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  padding: EdgeInsets.zero,
                ),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.orange, Colors.deepOrange],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: const Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
