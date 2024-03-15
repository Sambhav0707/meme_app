import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:screenshot/screenshot.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:memes_by_sam/view/nav_drawer.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class MemeCreator extends StatefulWidget {
  const MemeCreator({super.key});

  @override
  State<MemeCreator> createState() => _MemeCreatorState();
}

class _MemeCreatorState extends State<MemeCreator> {
  late String headerText = "";
  late String footerText = "";
  File? selectedImage;
  bool showEditedText = false; // Flag to determine whether to show edited text
  final picker = ImagePicker();
  final screenshotController = ScreenshotController();

  TextEditingController headerController = TextEditingController();
  TextEditingController footerController = TextEditingController();

  Color headerTextColor = Colors.white;
  Color footerTextColor = Colors.white;

  Future<void> _pickImage() async {
    XFile? file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      setState(() {
        selectedImage = File(file.path);
        showEditedText = false; // Reset flag when a new image is selected
        headerController.clear(); // Clear the header text field
        footerController.clear(); // Clear the footer text field
        headerTextColor = Colors.white;
        footerTextColor = Colors.white;
      });
    }
  }

  Future<bool> _onWillPop() async {
    if (selectedImage != null) {
      bool confirmed = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Are you sure to go back?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Yes'),
            ),
          ],
        ),
      );

      if (confirmed) {
        setState(() {
          selectedImage = null; // Reset the selected image
        });
      }

      return false; // Prevent the system back button action
    } else {
      return true;
    }
  }

  void _editText() {
    setState(() {
      headerText = headerController.text;
      footerText = footerController.text;
      showEditedText = true;
    });
  }

  Future<void> _saveImage() async {
    // Call _editText before taking a screenshot
    _editText();

    // Take a screenshot of the stack containing the selected image and text
    Uint8List? imageBytes = await screenshotController.capture();
    if (imageBytes != null) {
      // Save the screenshot to the device gallery using ImageGallerySaver
      final result = await ImageGallerySaver.saveImage(
        imageBytes,
        quality: 80, // Adjust quality as needed (0-100)
        name: 'savedImage.jpg', // Specify the custom name for the saved image
      );

      if (result['isSuccess']) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Image saved to gallery!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to save image.'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  @Deprecated(
    'Use PopScope instead. '
        'This feature was deprecated after v3.12.0-1.0.pre.',
  )
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "CREATE A MEME",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900),
          ),
          backgroundColor: Colors.transparent,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.indigo, Colors.grey],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              if (selectedImage != null)
                Center(
                  child: Screenshot(
                    controller: screenshotController,
                    child: Stack(
                      children: [
                        Image.file(
                          selectedImage!,
                          height: 300,
                          fit: BoxFit.fitHeight,
                        ),
                        if (showEditedText)
                          Positioned(
                            top: 10,
                            left: 0,
                            right: 0,
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: GestureDetector(
                                onTap: () => _pickColor(true),
                                child: Text(
                                  headerText,
                                  style: TextStyle(
                                    color: headerTextColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24, // Adjust the font size
                                  ),
                                ),
                              ),
                            ),
                          ),
                        if (showEditedText)
                          Positioned(
                            bottom: 10,
                            left: 0,
                            right: 0,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: GestureDetector(
                                onTap: () => _pickColor(false),
                                child: Text(
                                  footerText,
                                  style: TextStyle(
                                    color: footerTextColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24, // Adjust the font size
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 20),
              if (selectedImage == null)
                Center(
                  child: ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.indigo),
                      shadowColor: MaterialStatePropertyAll(Colors.grey),
                    ),
                    onPressed: _pickImage,
                    child: const Text(
                      'SELECT AN IMAGE',
                      style: TextStyle(color: Colors.cyan),
                    ),
                  ),
                ),
              const SizedBox(height: 300),
              if (selectedImage == null)
                const Text(
                  'Nothing is selected',
                  style: TextStyle(fontSize: 16, color: Colors.red, fontWeight: FontWeight.w800),
                ),
              const SizedBox(height: 20),
              if (selectedImage != null) // Show text fields only when an image is selected
                Column(
                  children: [
                    TextField(
                      controller: headerController,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 18), // Adjust the font size
                      decoration: const InputDecoration(
                        labelText: 'Header Text',
                        alignLabelWithHint: true,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: footerController,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 18), // Adjust the font size
                      decoration: const InputDecoration(
                        labelText: 'Footer Text',
                        alignLabelWithHint: true,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: _editText,
                          child: const Text('EDIT'),
                        ),
                        const SizedBox(width: 16),
                        ElevatedButton(
                          onPressed: _saveImage,
                          child: const Text('SAVE'),
                        ),
                      ],
                    ),
                  ],
                ),
            ],
          ),
        ),
        drawer: const NavDrawer(selected: DrawerSelection.creator),
        backgroundColor: const Color(0xFFC5CAE9),
      ),
    );
  }

  void _pickColor(bool isHeader) {
    Color initialColor = isHeader ? headerTextColor : footerTextColor;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isHeader ? 'Pick Header Text Color' : 'Pick Footer Text Color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: initialColor,
              onColorChanged: (color) {
                setState(() {
                  if (isHeader) {
                    headerTextColor = color;
                  } else {
                    footerTextColor = color;
                  }
                });
              },
              enableAlpha: false,
              showLabel: true,
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
