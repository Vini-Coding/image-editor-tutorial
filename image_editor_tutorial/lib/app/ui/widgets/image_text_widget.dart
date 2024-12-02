import 'package:flutter/material.dart';
import 'package:image_editor_tutorial/app/ui/models/text_info.dart';

class ImageTextWidget extends StatelessWidget {
  const ImageTextWidget({super.key, required this.textInfo});
  final TextInfo textInfo;

  @override
  Widget build(BuildContext context) {
    return Text(
      textInfo.text,
      textAlign: textInfo.textAlign,
      style: TextStyle(
        fontSize: textInfo.fontSize,
        fontWeight: textInfo.fontWeight,
        fontStyle: textInfo.fontStyle,
        color: textInfo.color,
      ),
    );
  }
}
