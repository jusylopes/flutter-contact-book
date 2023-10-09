import 'package:flutter/material.dart';

class CustomErrorMessageApp extends StatelessWidget {
  const CustomErrorMessageApp({super.key, required this.errorMessage});

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(
        textAlign: TextAlign.center,
        errorMessage,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}
