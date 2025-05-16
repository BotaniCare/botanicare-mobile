import 'package:flutter/material.dart';

class CustomSnackBar extends StatelessWidget {
  final String message;
  final bool isError;

  const CustomSnackBar({
    super.key,
    required this.message,
    this.isError = false,
  });

  static void show(BuildContext context, String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Theme.of(context).colorScheme.error : null,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
