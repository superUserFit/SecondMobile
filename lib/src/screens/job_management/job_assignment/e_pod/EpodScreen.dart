import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


class EpodScreen extends StatefulWidget {
  const EpodScreen({Key? key}) : super(key: key);

  @override
  _EpodState createState() => _EpodState();
}

class _EpodState extends State<EpodScreen> {
  final List<File> _selectedImages = [];

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if(pickedFile != null) {
      setState(() {
        _selectedImages.add(File(pickedFile.path));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Complete EPOD Details',
          style: TextStyle(color: Colors.deepOrange),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.deepOrange,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: const Color.fromRGBO(235, 235, 235, 0.9),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Photo section
              const Text(
                "Photo 3/12",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  Expanded(
                    child: Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: List.generate(
                        3,
                        (index) => Container(
                          width: 100,
                          height: 100,
                          color: Colors.grey,
                          child: Center(
                            child: Text('Photo ${index + 1}'),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.deepOrange),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_photo_alternate_outlined,
                          color: Colors.deepOrange,
                          size: 30,
                        ),
                        Text(
                          "Add Photo",
                          style: TextStyle(color: Colors.deepOrange, fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              
              // Delivery details
              const Card(
                child: ListTile(
                  title: Text(
                    "Delivery Details",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Address: No. 99, Taman999, Jalan 9999, 99999 Kuching, Sarawak, Malaysia."),
                      SizedBox(height: 4),
                      Text("Coordinates: 1.466424, 110.32912"),
                      SizedBox(height: 4),
                      Image(
                        image: NetworkImage('https://via.placeholder.com/150'), // Replace with actual map
                      ),
                    ],
                  ),
                ),
              ),
              
              // Date & Time
              const Card(
                child: ListTile(
                  title: Text(
                    "Date & Time",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text("2024-01-01 5:00:00 PM"),
                ),
              ),
              
              // Remark
              const Card(
                child: ListTile(
                  title: Text(
                    "Remark",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "Delivery Done.\nNo issues encountered during delivery process.\nCustomer acknowledged receipt of goods.",
                  ),
                ),
              ),
              
              // Recipient details
              const Card(
                child: ListTile(
                  title: Text(
                    "Recipient Details",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Recipient: John Amos"),
                      SizedBox(height: 4),
                      Text("NRIC: -"),
                      SizedBox(height: 16),
                      Image(
                        image: NetworkImage('https://via.placeholder.com/150'), // Replace with actual signature image
                        height: 100,
                      ),
                      Center(
                        child: Text(
                          "Tap to sign",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              // Submit button
              const SizedBox(height: 16.0),
              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: () {
                      // Handle submit action
                    },
                    child: const Text(
                      'Submit',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
