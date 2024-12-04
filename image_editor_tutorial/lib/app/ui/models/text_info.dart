// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class TextInfo {
  String text;
  double left;
  double top;
  double fontSize;
  Color color;
  FontWeight fontWeight;
  FontStyle fontStyle;
  TextAlign textAlign;

  TextInfo({
    required this.text,
    required this.left,
    required this.top,
    required this.fontSize,
    required this.color,
    required this.fontWeight,
    required this.fontStyle,
    required this.textAlign,
  });
}
