import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_editor_tutorial/app/ui/models/text_info.dart';
import 'package:image_editor_tutorial/app/ui/widgets/default_button_widget.dart';
import 'package:image_editor_tutorial/app/ui/widgets/image_text_widget.dart';
import 'package:image_editor_tutorial/app/utils/utils.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

class ImageEditPage extends StatefulWidget {
  const ImageEditPage({
    super.key,
    required this.selectedImage,
  });
  final String selectedImage;

  @override
  State<ImageEditPage> createState() => _ImageEditPageState();
}

class _ImageEditPageState extends State<ImageEditPage> {
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _creatorTextController = TextEditingController();
  final ScreenshotController _screenshotController = ScreenshotController();
  List<TextInfo> texts = [];
  int currentIndex = 0;

  void setCurrentIndex(BuildContext context, int index) {
    setState(() {
      currentIndex = index;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Selected for styling',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  void changeTextColor(Color color) {
    setState(() {
      texts[currentIndex].color = color;
    });
  }

  void increaseFontSize() {
    setState(() {
      texts[currentIndex].fontSize += 2;
    });
  }

  void decreaseFontSize() {
    setState(() {
      texts[currentIndex].fontSize -= 2;
    });
  }

  void alignTextToLeft() {
    setState(() {
      texts[currentIndex].textAlign = TextAlign.left;
    });
  }

  void alignTextToCenter() {
    setState(() {
      texts[currentIndex].textAlign = TextAlign.center;
    });
  }

  void alignTextToRight() {
    setState(() {
      texts[currentIndex].textAlign = TextAlign.right;
    });
  }

  void boldText() {
    setState(() {
      texts[currentIndex].fontWeight =
          texts[currentIndex].fontWeight == FontWeight.normal
              ? FontWeight.bold
              : FontWeight.normal;
    });
  }

  void italicText() {
    setState(() {
      texts[currentIndex].fontStyle =
          texts[currentIndex].fontStyle == FontStyle.normal
              ? FontStyle.italic
              : FontStyle.normal;
    });
  }

  void addLinesToText() {
    setState(() {
      if (texts[currentIndex].text.contains('\n')) {
        texts[currentIndex].text =
            texts[currentIndex].text.replaceAll('\n', ' ');
      } else {
        texts[currentIndex].text =
            texts[currentIndex].text.replaceAll(' ', '\n');
      }
    });
  }

  void _removeText(BuildContext context) {
    setState(() {
      texts.removeAt(currentIndex);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Text removed',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  void _addNewText(BuildContext context) {
    setState(() {
      texts.add(
        TextInfo(
          text: _textController.text,
          left: 0,
          top: 0,
          fontSize: 20,
          color: Colors.black,
          fontWeight: FontWeight.normal,
          fontStyle: FontStyle.normal,
          textAlign: TextAlign.left,
        ),
      );
    });
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Text added',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  void _addNewDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Add new text"),
        content: TextField(
          controller: _textController,
          maxLines: 5,
          decoration: const InputDecoration(
            filled: true,
            suffixIcon: Icon(Icons.edit),
            hintText: "Add new text",
          ),
        ),
        actions: [
          DefaultButtonWidget(
            onPressed: () => Navigator.of(context).pop(),
            color: Colors.white,
            textColor: Colors.black,
            child: const Text('Back'),
          ),
          DefaultButtonWidget(
            onPressed: () => _addNewText(context),
            color: Colors.red,
            textColor: Colors.white,
            child: const Text('Add text'),
          ),
        ],
      ),
    );
  }

  void _saveImageToGallery(BuildContext context) {
    if (texts.isNotEmpty) {
      _screenshotController.capture().then((Uint8List? image) {
        saveImage(image!);
      }).catchError((e) {
        debugPrint(e);
      });
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Image saved to gallery',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  void saveImage(Uint8List bytes) async {
    final String time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '-')
        .replaceAll(':', '-');
    final String name = 'screenshot_$time';
    await requestPermission(Permission.storage);
    await ImageGallerySaver.saveImage(bytes, name: name);
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFE7E7E7),
        automaticallyImplyLeading: false,
        title: SizedBox(
          height: 50,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              IconButton(
                onPressed: () => _saveImageToGallery(context),
                icon: const Icon(
                  Icons.save,
                  color: Colors.black,
                ),
                tooltip: "Save image",
              ),
              IconButton(
                onPressed: increaseFontSize,
                icon: const Icon(
                  Icons.add,
                  color: Colors.black,
                ),
                tooltip: "Increase font size",
              ),
              IconButton(
                onPressed: decreaseFontSize,
                icon: const Icon(
                  Icons.remove,
                  color: Colors.black,
                ),
                tooltip: "Decrease font size",
              ),
              IconButton(
                onPressed: boldText,
                icon: const Icon(
                  Icons.format_bold,
                  color: Colors.black,
                ),
                tooltip: "Bold",
              ),
              IconButton(
                onPressed: italicText,
                icon: const Icon(
                  Icons.format_italic,
                  color: Colors.black,
                ),
                tooltip: "Italic",
              ),
              IconButton(
                onPressed: addLinesToText,
                icon: const Icon(
                  Icons.space_bar,
                  color: Colors.black,
                ),
                tooltip: "Add new line",
              ),
              IconButton(
                onPressed: alignTextToLeft,
                icon: const Icon(
                  Icons.format_align_left,
                  color: Colors.black,
                ),
                tooltip: "Align left",
              ),
              IconButton(
                onPressed: alignTextToCenter,
                icon: const Icon(
                  Icons.format_align_center,
                  color: Colors.black,
                ),
                tooltip: "Align center",
              ),
              IconButton(
                onPressed: alignTextToRight,
                icon: const Icon(
                  Icons.format_align_right,
                  color: Colors.black,
                ),
                tooltip: "Align right",
              ),
              IconButton(
                onPressed: () => _removeText(context),
                icon: const Icon(
                  Icons.delete_sharp,
                  color: Colors.black,
                ),
                tooltip: "Remove text",
              ),
              Tooltip(
                message: "White",
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.white),
                  child: const CircleAvatar(
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Tooltip(
                message: "Black",
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.black),
                  child: const CircleAvatar(
                    backgroundColor: Colors.black,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Tooltip(
                message: "Red",
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.red),
                  child: const CircleAvatar(
                    backgroundColor: Colors.red,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Tooltip(
                message: "Blue",
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.blue),
                  child: const CircleAvatar(
                    backgroundColor: Colors.blue,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Tooltip(
                message: "Yellow",
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.yellow),
                  child: const CircleAvatar(
                    backgroundColor: Colors.yellow,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Tooltip(
                message: "Green",
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.green),
                  child: const CircleAvatar(
                    backgroundColor: Colors.green,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Tooltip(
                message: "Orange",
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.orange),
                  child: const CircleAvatar(
                    backgroundColor: Colors.orange,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Tooltip(
                message: "Purple",
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.purple),
                  child: const CircleAvatar(
                    backgroundColor: Colors.purple,
                  ),
                ),
              ),
              const SizedBox(width: 5),
            ],
          ),
        ),
      ),
      body: Screenshot(
        controller: _screenshotController,
        child: SafeArea(
          child: SizedBox(
            height: screenSize.height * 0.3,
            child: Stack(
              children: [
                Center(
                  child: Image.file(
                    File(widget.selectedImage),
                    fit: BoxFit.fill,
                    width: screenSize.width,
                  ),
                ),
                for (int i = 0; i < texts.length; i++)
                  Positioned(
                    left: texts[i].left,
                    top: texts[i].top,
                    child: InkWell(
                      onLongPress: () {
                        debugPrint('On long press detected!');
                      },
                      onTap: () => setCurrentIndex(context, i),
                      child: Draggable(
                        feedback: ImageTextWidget(textInfo: texts[i]),
                        child: ImageTextWidget(textInfo: texts[i]),
                        onDragEnd: (drag) {
                          final RenderBox renderBox =
                              context.findRenderObject() as RenderBox;
                          Offset off = renderBox.globalToLocal(drag.offset);
                          setState(() {
                            texts[i].top = off.dy  - 96;
                            texts[i].left = off.dx;
                          });
                        },
                      ),
                    ),
                  ),
                _creatorTextController.text.isNotEmpty
                    ? Positioned(
                        top: 0,
                        left: 0,
                        child: Text(
                          _creatorTextController.text,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black.withOpacity(0.3),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        tooltip: 'Add new text',
        child: const Icon(
          Icons.edit,
          color: Colors.black,
        ),
        onPressed: () => _addNewDialog(context),
      ),
    );
  }
}
