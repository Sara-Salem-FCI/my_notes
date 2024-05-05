import 'package:flutter/material.dart';
import 'package:my_notes/constants/colors.dart';

class CustomMaterialButton extends StatelessWidget {
  const CustomMaterialButton({super.key, required this.onPressed});
final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: MaterialButton(
        height: 45,
          color: kActiveColor,
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          onPressed: onPressed,
          child: const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'Start',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ),
    );
  }
}
