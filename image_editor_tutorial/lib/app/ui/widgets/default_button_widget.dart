import 'package:flutter/material.dart';

class DefaultButtonWidget extends StatelessWidget {
  const DefaultButtonWidget({
    super.key,
    required this.onPressed,
    required this.color,
    required this.textColor,
    required this.child,
  });
  final void Function()? onPressed;
  final Color color;
  final Color textColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(color),
        textStyle: MaterialStateProperty.all<TextStyle>(
          TextStyle(
            color: textColor,
          ),
        ),
      ),
      child: child,
    );
  }
}
