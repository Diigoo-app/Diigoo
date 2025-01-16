import 'dart:async';
import 'dart:developer';
import 'package:camera/camera.dart';
import 'package:diigoo/routes/routes.dart';
import 'package:diigoo/widgets/gradient_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class FaceScanningScreen extends StatefulWidget {
  const FaceScanningScreen({Key? key}) : super(key: key);

  @override
  _FaceScanningScreenState createState() => _FaceScanningScreenState();
}

class _FaceScanningScreenState extends State<FaceScanningScreen> {
  CameraController? _cameraController;
  late FaceDetector _faceDetector;
  bool _isDetecting = false;
  double _progress = 0;
  bool _verificationFailed = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _faceDetector = FaceDetector(
      options: FaceDetectorOptions(
        enableContours: true,
        enableLandmarks: true,
        performanceMode: FaceDetectorMode.accurate,
      ),
    );
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        log("No cameras available.");
        return;
      }

      final frontCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );

      _cameraController = CameraController(frontCamera, ResolutionPreset.high);

      await _cameraController!.initialize();
      if (!mounted) return;

      setState(() {});
      _startFaceDetection();
    } catch (e) {
      log("Error initializing camera: $e");
    }
  }

  void _startFaceDetection() {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      log("Camera controller not initialized.");
      return;
    }

    _cameraController!.startImageStream((CameraImage image) async {
      if (_isDetecting) return;
      _isDetecting = true;

      try {
        final faces =
            await _faceDetector.processImage(_convertCameraImage(image));

        if (faces.isNotEmpty) {
          log("Face detected!");
          _startProgress();
        } else {
          log("No face detected.");
          _resetProgress();
        }
      } catch (e) {
        log("Error during face detection: $e");
      } finally {
        _isDetecting = false;
      }
    });
  }

  InputImage _convertCameraImage(CameraImage image) {
    final WriteBuffer buffer = WriteBuffer();
    for (final plane in image.planes) {
      buffer.putUint8List(plane.bytes);
    }
    final bytes = buffer.done().buffer.asUint8List();

    InputImageRotation rotation = InputImageRotation.rotation270deg;

    return InputImage.fromBytes(
      bytes: bytes,
      metadata: InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: rotation,
        format: InputImageFormat.nv21,
        bytesPerRow: image.planes.first.bytesPerRow,
      ),
    );
  }

  void _startProgress() {
    if (_progress >= 100 || _timer != null) return;
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (_progress >= 100) {
        timer.cancel();
        _timer = null;
        _stopAndNavigate();
      } else {
        setState(() {
          _progress += 25;
        });
      }
    });
  }

  void _resetProgress() {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (_progress > 0) {
        setState(() {
          _progress -= 5;
        });
      } else {
        timer.cancel();
        _timer = null;
        setState(() {
          _verificationFailed = true;
        });
      }
    });
  }

  void _stopAndNavigate() {
    if (_cameraController != null &&
        _cameraController!.value.isStreamingImages) {
      _cameraController!.stopImageStream();
    }

    _cameraController!.takePicture().then((XFile file) {
      if (mounted) {
        Navigator.pushNamed(
          context,
          Routes.photoVerificationConfirm,
          arguments: {'imagePath': file.path},
        );
      }
    }).catchError((e) {
      log("Error capturing image: $e");
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _cameraController?.dispose();
    _faceDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: _cameraController == null ||
                    !_cameraController!.value.isInitialized
                ? const Center(child: CircularProgressIndicator())
                : AspectRatio(
                    aspectRatio: _cameraController!.value.aspectRatio,
                    child: CameraPreview(_cameraController!),
                  ),
          ),
          Positioned(
            top: screenSize.height * 0.09,
            left: 0,
            right: 0,
            child: const Center(
              child: Text(
                "Face Scanning",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: screenSize.height * 0.09,
            left: 20,
            right: 20,
            child: Column(
              children: [
                _verificationFailed
                    ? const Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 35,
                      )
                    : Text(
                        "${_progress.toInt()}%",
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                const SizedBox(height: 10),
                Text(
                  _verificationFailed
                      ? "Verification failed, try again."
                      : "Hold steady...",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: _verificationFailed ? Colors.red : Colors.black,
                  ),
                ),
                const SizedBox(height: 30),
                if (_verificationFailed)
                  GradientButtonWidget(
                    size: const Size(150, 50),
                    text: "Try Again",
                    onPressed: () {
                      setState(() {
                        _verificationFailed = false;
                        _progress = 0;
                      });
                    },
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
