import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    required this.title,
    this.onTap,
  });
  VoidCallback? onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        height: 50,
        width: double.infinity,
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontFamily: "Pacifico",
            ),
          ),
        ),
      ),
    );
  }
}
