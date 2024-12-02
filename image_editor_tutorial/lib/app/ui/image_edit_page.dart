import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_editor_tutorial/app/ui/models/text_info.dart';
import 'package:image_editor_tutorial/app/ui/widgets/default_button_widget.dart';
import 'package:image_editor_tutorial/app/ui/widgets/image_text_widget.dart';

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
  List<TextInfo> texts = [];

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

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
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
                    onTap: () {
                      debugPrint('On tap detected!');
                    },
                    child: Draggable(
                      feedback: ImageTextWidget(textInfo: texts[i]),
                      child: ImageTextWidget(textInfo: texts[i]),
                      onDragEnd: (drag) {
                        final RenderBox renderBox =
                            context.findRenderObject() as RenderBox;
                        Offset off = renderBox.globalToLocal(drag.offset);
                      },
                    ),
                  ),
                ),
            ],
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
