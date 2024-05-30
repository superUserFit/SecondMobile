import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraState();
}

class _CameraState extends State<CameraScreen> {
  late List<CameraDescription> cameras;
  late CameraController cameraController;

  bool isCameraInitialized = false;
  int cameraDirection = 0;

  @override
  void initState() {
    super.initState();
    startCamera(cameraDirection);
  }

  Future<void> startCamera(int direction) async {
    try {
      cameras = await availableCameras();

      cameraController = CameraController(
        cameras[direction],
        ResolutionPreset.high,
        enableAudio: false,
      );

      await cameraController.initialize();
      if (!mounted) return;

      setState(() {
        isCameraInitialized = true;
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isCameraInitialized
          ? Stack(
              children: [
                CameraPreview(cameraController),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      cameraDirection = cameraDirection == 0 ? 1 : 0;
                      startCamera(cameraDirection);
                    });
                  },
                  child: _button(Icons.flip_camera_android_rounded, Alignment.bottomLeft),
                ),
                GestureDetector(
                  onTap: () async {
                    try {
                      XFile? file = await cameraController.takePicture();
                      if (file != null) {
                        print("Saved Picture: $file");
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: _button(Icons.camera_alt_rounded, Alignment.bottomCenter),
                )
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _button(IconData icon, Alignment alignment) {
    return Align(
      alignment: alignment,
      child: Container(
        margin: const EdgeInsets.only(
          left: 20,
          bottom: 20,
        ),
        height: 50,
        width: 50,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(2, 2),
              blurRadius: 12,
            )
          ],
        ),
        child: Center(
          child: Icon(
            icon,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}
