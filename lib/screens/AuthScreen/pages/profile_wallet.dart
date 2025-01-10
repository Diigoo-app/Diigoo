import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/rendering.dart';
import 'package:gallery_saver/gallery_saver.dart';

class ProfileWallet extends StatefulWidget {
  final String userName;
  final String fullName;
  final File? profileImage;

  const ProfileWallet({
    Key? key,
    required this.userName,
    required this.fullName,
    this.profileImage,
  }) : super(key: key);

  @override
  State<ProfileWallet> createState() => _ProfileWalletState();
}

class _ProfileWalletState extends State<ProfileWallet> {
  GlobalKey globalKey = GlobalKey(); // Key for QR screenshot

  // Function to capture and save QR code image
  Future<void> _saveQRCode() async {
    try {
      RenderRepaintBoundary boundary =
          globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      var image = await boundary.toImage();
      ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      final directory = await getApplicationDocumentsDirectory();
      final imagePath = '${directory.path}/qr_code.png';
      File imageFile = File(imagePath);
      await imageFile.writeAsBytes(pngBytes);

      // Save to Gallery
      await GallerySaver.saveImage(imageFile.path);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("QR Code saved to gallery!")),
      );
    } catch (e) {
      print("Error saving QR Code: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to save QR Code")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Profile Image and Name
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: widget.profileImage != null
                        ? FileImage(widget.profileImage!)
                        : const AssetImage('assets/images/Profile.png')
                            as ImageProvider,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "Hey, ${widget.fullName}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // QR Code Generator
            const SizedBox(height: 20),
            RepaintBoundary(
              key: globalKey,
              child: QrImageView(
                data: widget.userName,
                version: QrVersions.auto,
                size: 200,
                backgroundColor: Colors.white,
                embeddedImage: const AssetImage('assets/images/Profile.png'),
                embeddedImageStyle: QrEmbeddedImageStyle(size: Size(40, 40)),
              ),
            ),

            // Username and Download Button
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(widget.userName, style: const TextStyle(fontSize: 16)),
                  const SizedBox(width: 10),
                  IconButton(
                    icon: const Icon(Icons.download, color: Colors.purple),
                    onPressed: _saveQRCode, // Save QR Code
                  ),
                ],
              ),
            ),

            // Bottom Image
            Expanded(
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Image.asset(
                  'assets/images/icon.png', // Add your image here
                  width: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Next Button
            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: Colors.purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    // Next Screen Logic
                  },
                  child: const Text(
                    "Next",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
