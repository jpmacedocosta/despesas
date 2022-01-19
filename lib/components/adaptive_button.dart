import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class AdaptiveButton extends StatelessWidget {

  final String label;
  final VoidCallback onPressed;

  const AdaptiveButton ({
    required this.label,
    required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
          child: Text(label),
          onPressed: onPressed,
          color: Colors.green,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
        )
        : ElevatedButton(
          child: Text(
            label,
            style: TextStyle(
              color: Theme.of(context).textTheme.button?.color,
            ),
          ),
          onPressed: onPressed,
        );
  }
}
