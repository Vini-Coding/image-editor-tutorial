import 'package:flutter/material.dart';
import 'package:image_editor_tutorial/app/ui/image_edit_page.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  static String routeName = '/';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IconButton(
          onPressed: () async {
            XFile? file =
                await ImagePicker().pickImage(source: ImageSource.gallery);
            
            if (file != null) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ImageEditPage(selectedImage: file.path),
                ),
              );
            }
          },
          icon: const Icon(
            Icons.upload,
          ),
        ),
      ),
    );
  }
}
