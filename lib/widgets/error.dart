import 'package:flutter/material.dart';

class ErrorWidgetCustom extends StatelessWidget {
  final String message;
  const ErrorWidgetCustom({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(message),
    );
  }
}
