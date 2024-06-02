import 'dart:io';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

import 'package:e_pod/src/components/camera/CameraScreen.dart';


class EpodScreen extends StatefulWidget {
  const EpodScreen({Key? key}) : super(key: key);

  @override
  _EpodState createState() => _EpodState();
}

class _EpodState extends State<EpodScreen> {
  final List<File> _selectedImages = [];
  static const LatLng _currentLocation = LatLng(1.466424, 110.32912);

  late GoogleMapController googleMapController;

  void _onGoogleMapCreated(GoogleMapController controller) {
    googleMapController = controller;
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if(pickedFile != null) {
      setState(() {
        _selectedImages.add(File(pickedFile.path));
      });
    }
  }


  void _showPicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext buildContext) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),

              ListTile(
                leading: const Icon(Icons.camera_alt_rounded),
                title: const Text("Camera"),
                onTap: () {
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CameraScreen()));
                  });
                }
              )
            ],
          )
        );
      }
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Complete EPOD Details',
          style: TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.w500),
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
              Text(
                "${_selectedImages.length}/12",
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8.0),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                      ..._selectedImages.map((image) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Stack(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                image: DecorationImage(
                                  image: FileImage(image),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 4,
                              right: 4,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedImages.remove(image);
                                  });
                                },
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  decoration: const BoxDecoration(color: Colors.red,shape: BoxShape.circle),
                                    child: const Center(
                                      child: Text(
                                        'X',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                        }).toList(),
                      ],
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      _showPicker(context);
                    },
                    child: Container(
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
                  ),
                ],
              ),
              ),
              const SizedBox(height: 16.0),

              // Delivery details
               Card(
                child: ListTile(
                  title: const Text(
                    "Delivery Details",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Address: No. 99, Taman999, Jalan 9999, 99999 Kuching, Sarawak, Malaysia."),
                      const SizedBox(height: 4),
                      Text("Coordinates: 1.466424, 110.32912"),
                      const SizedBox(height: 4),

                      SizedBox(
                        height: 320,
                        child: GoogleMap(
                          onMapCreated: _onGoogleMapCreated,
                          zoomGesturesEnabled: false,
                          zoomControlsEnabled: false,
                          markers: {
                            Marker(
                              markerId: MarkerId("_deliveryLocation"),
                              icon: BitmapDescriptor.defaultMarker,
                              position: _currentLocation
                            )
                          },
                          initialCameraPosition: CameraPosition(target: _currentLocation, zoom: 20)),
                      )
                    ],
                  ),
                ),
              ),

              // Date & Time
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const SizedBox(width: 125, child: Text("Date & Time", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color.fromRGBO(96, 96, 96, 1)))),
                          Text("2024-05-11", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600))
                        ],
                      ),

                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 4.0),
                        child: const Divider(height: 1, color: Color.fromRGBO(200, 200, 200, 0.8)),
                      ),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 75,
                            width: 125,
                            child: Text("Remark", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color.fromRGBO(96, 96, 96, 1)))
                          ),
                          Expanded(
                            child: TextField(
                              maxLines: 5,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(4.0),
                                disabledBorder: InputBorder.none,
                                hintText: "Enter your remarks here"
                              ),
                            )
                          )
                        ],
                      )
                    ],
                  )
                )
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
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.deepOrange, Colors.orange],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: InkWell(
                      onTap: () {
                        // Handle submit action
                      },
                      borderRadius: BorderRadius.circular(8.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                        alignment: Alignment.center,
                        child: const Text(
                          'Submit',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
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
