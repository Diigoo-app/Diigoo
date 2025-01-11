import 'dart:ui';
import 'package:diigoo/routes/routes.dart';
import 'package:diigoo/widgets/gradient_button.dart';
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
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("QR Code saved to gallery!")),
      );
    } catch (e) {
      print("Error saving QR Code: $e");
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to save QR Code")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Image and Name
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
                vertical: screenHeight * 0.02,
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: screenWidth * 0.08,
                    backgroundImage: widget.profileImage != null
                        ? FileImage(widget.profileImage!)
                        : const AssetImage('assets/images/Profile.png')
                            as ImageProvider,
                  ),
                  SizedBox(width: screenWidth * 0.03),
                  Text(
                    "Hey, Mayank",
                    style: TextStyle(
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: screenHeight * 0.03),

            // QR Code Section
            RepaintBoundary(
              key: globalKey,
              child: QrImageView(
                data: widget.userName,
                version: QrVersions.auto,
                size: screenWidth * 0.5,
                backgroundColor: Colors.white,
              ),
            ),

            SizedBox(height: screenHeight * 0.02),

            // QR Code and Download Button - FIXED HEIGHT
            Container(
              width: screenWidth * 0.84,
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.04,
                vertical: screenHeight * 0.001, // **Reduced height**
              ),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(30),
              ),
              child: IntrinsicHeight(
                // **Ensures height is based on content**
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'bkdskljdx545hfgd34354hkhdfkcjn',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: screenWidth * 0.035),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.download,
                        color: Colors.purple,
                      ),
                      onPressed: _saveQRCode,
                    ),
                  ],
                ),
              ),
            ),

            const Expanded(
                child: SizedBox()), // **Pushes content to the bottom**

            Padding(
              padding: EdgeInsets.only(
                right: screenWidth * 0.05,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 3,
                    child: Image.asset(
                      'assets/images/icon.png',
                      width: screenWidth * 0.75,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(
                          bottom: screenHeight * 0.02), // **Lowers button**
                      child: GradientButtonWidget(
                        size: const Size(150, 50),
                        text: "Next",
                        onPressed: () {
                          Navigator.pushNamed(
                              context, Routes.signupHashtagPage);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
