import 'package:flutter/material.dart';


class EpodScreen extends StatefulWidget {
  const EpodScreen({Key? key}) : super(key: key);

  @override
  _EpodState createState() => _EpodState();
}


class _EpodState extends State<EpodScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complete EPOD Details', style: TextStyle(color: Colors.deepOrange)),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.deepOrange
        ),
      ),

      body: Container(
        color: const Color.fromRGBO(235, 235, 235, 0.9),
        child: const Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Card(
                child: Text("Photos", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16)),
              ),
            ),

            Card(
              color: Colors.grey,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                child: Column(
                  children: [
                    Icon(Icons.add_photo_alternate_outlined, size: 20),
                    Text("Add photos", style: TextStyle(color: Colors.deepOrange, fontSize: 20))
                  ],
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}
