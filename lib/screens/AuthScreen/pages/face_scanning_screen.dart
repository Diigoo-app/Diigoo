import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class FaceScanningScreen extends StatefulWidget {
  const FaceScanningScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FaceScanningScreenState createState() => _FaceScanningScreenState();
}

class _FaceScanningScreenState extends State<FaceScanningScreen> {
  CameraController? _cameraController;
  late FaceDetector _faceDetector;
  bool _isDetecting = false;
  bool _faceInsideRegion = false;
  double _progress = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _faceDetector = FaceDetector(options: FaceDetectorOptions());
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    _cameraController = CameraController(cameras[1], ResolutionPreset.medium);

    await _cameraController!.initialize().then((_) {
      if (!mounted) return;
      setState(() {});
      _startFaceDetection();
    }).catchError((e) {
      debugPrint("Error initializing camera: $e");
    });
  }

  void _startFaceDetection() {
    _cameraController!.startImageStream((CameraImage image) async {
      if (_isDetecting) return;
      _isDetecting = true;

      try {
        final faces =
            await _faceDetector.processImage(_convertCameraImage(image));

        if (faces.isNotEmpty) {
          setState(() {
            _faceInsideRegion = _isFaceCentered(faces.first);
            if (_faceInsideRegion) {
              _startProgress();
            } else {
              _resetProgress();
            }
          });
        } else {
          setState(() {
            _faceInsideRegion = false;
            _resetProgress();
          });
        }
      } catch (e) {
        debugPrint("Error detecting face: $e");
      }

      _isDetecting = false;
    });
  }

  InputImage _convertCameraImage(CameraImage image) {
    final WriteBuffer buffer = WriteBuffer();
    for (Plane plane in image.planes) {
      buffer.putUint8List(plane.bytes);
    }
    final bytes = buffer.done().buffer.asUint8List();

    return InputImage.fromBytes(
      bytes: bytes,
      metadata: InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: InputImageRotation.rotation0deg,
        format: InputImageFormat.nv21,
        bytesPerRow: image.planes.first.bytesPerRow,
      ),
    );
  }

  bool _isFaceCentered(Face face) {
    double faceCenterX = face.boundingBox.center.dx;
    double faceCenterY = face.boundingBox.center.dy;

    double screenCenterX = MediaQuery.of(context).size.width / 2;
    double screenCenterY = MediaQuery.of(context).size.height / 2;

    return (faceCenterX - screenCenterX).abs() < 50 &&
        (faceCenterY - screenCenterY).abs() < 80;
  }

  void _startProgress() {
    _timer ??= Timer.periodic(const Duration(milliseconds: 300), (timer) {
      if (_progress >= 100) {
        timer.cancel();
      } else {
        setState(() {
          _progress += 10;
        });
      }
    });
  }

  void _resetProgress() {
    _timer?.cancel();
    setState(() {
      _progress = 0;
    });
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    _faceDetector.close();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _cameraController == null || !_cameraController!.value.isInitialized
              ? const Center(child: CircularProgressIndicator())
              : CameraPreview(_cameraController!),

          // Face Frame Overlay
          Positioned(
            left: 50,
            right: 50,
            top: 150,
            child: Container(
              width: 250,
              height: 300,
              decoration: BoxDecoration(
                border: Border.all(
                  color: _faceInsideRegion ? Colors.green : Colors.red,
                  width: 4,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),

          // Face Scanning Title
          const Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                "Face Scanning",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          // Progress Indicator & Status Text
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Text(
                  "${_progress.toInt()}%",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  _faceInsideRegion
                      ? "Verifying Your Face"
                      : "Position Your Face Inside the Frame",
                  style: const TextStyle(fontSize: 16, color: Colors.white70),
                ),
              ],
            ),
          ),

          // Back Button
          Positioned(
            top: 50,
            left: 20,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child:
                  const Icon(Icons.arrow_back, size: 28, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
