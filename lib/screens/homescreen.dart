import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:natalis_frontend/models/Scan.dart';
import 'scan_result_screen.dart';


import '../services/ScanService.dart';
import 'add_test_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Image picker instance
  final ImagePicker _picker = ImagePicker();

  List<Widget> _buildWidgetOptions(BuildContext context) {
    final ScanService scanService = ScanService();
    return <Widget>[
      // ---------------- HOME TAB ----------------
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Home',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),

            // -------- ADD NEW TEST BUTTON --------
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                    const AddTestScreen(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      const begin = Offset(0.0, 1.0);
                      const end = Offset.zero;
                      const curve = Curves.ease;
                      final tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));
                      return SlideTransition(
                        position: animation.drive(tween),
                        child: child,
                      );
                    },
                  ),
                );
              },
              icon: const FaIcon(
                FontAwesomeIcons.fileCirclePlus,
                size: 18,
              ),
              label: const Text('Add New Test'),
              style: ElevatedButton.styleFrom(
                shadowColor: Colors.transparent,
                backgroundColor: Colors.black12,
                padding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 40),

            // -------- UPLOAD SCAN BUTTON (PHOTO PICKER) --------
            ElevatedButton.icon(
              onPressed: () async {
                final XFile? image = await _picker.pickImage(
                  source: ImageSource.gallery,
                );

                if (image == null) return;

                try {
                  final scanResult = await scanService.uploadAndAnalyzeScan(
                    imageFile: File(image.path),
                    scanDate: DateTime.now(),
                    race: "Asian & Pacific Islander", // IMPORTANT: backend expects this
                    pixelSizeMm: 0.5,
                  );

                  if (!context.mounted) return;

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ScanResultScreen(result: scanResult),
                    ),
                  );


                } catch (e) {
                  debugPrint("Scan upload failed: $e");

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Upload failed')),
                  );
                }
              },

              icon: const FaIcon(
                FontAwesomeIcons.upload,
                size: 18,
              ),
              label: const Text('Upload Scan'),
              style: ElevatedButton.styleFrom(
                shadowColor: Colors.transparent,
                backgroundColor: Colors.black12,
                padding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),

      // ---------------- PATIENTS TAB ----------------
      const Center(
        child: Text(
          'Patients',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),

      // ---------------- PROFILE TAB ----------------
      const Center(
        child: Text(
          'Profile',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final widgetOptions = _buildWidgetOptions(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Natalis (Dev)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
          IconButton(
            icon: const CircleAvatar(
              radius: 16,
              child: Icon(Icons.person, size: 20),
            ),
            onPressed: () {},
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.houseMedical),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.users),
            label: 'Patients',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.solidUserCircle),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
