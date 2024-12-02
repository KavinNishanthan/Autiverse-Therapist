import 'package:flutter/material.dart';

class MyButtons extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  const MyButtons({
    super.key,
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(
            vertical: 10,
          ),
          decoration: const ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              color: Colors.blue),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}