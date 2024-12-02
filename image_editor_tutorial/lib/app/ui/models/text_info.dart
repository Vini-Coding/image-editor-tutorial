// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class TextInfo {
  final String text;
  final double left;
  final double top;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  final FontStyle fontStyle;
  final TextAlign textAlign;

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
