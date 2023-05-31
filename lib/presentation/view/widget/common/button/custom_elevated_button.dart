import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isEnabled = true,
    this.minimumSize = 50.0,
    this.borderRadius = 10,
  }) : super(key: key);

  final String text;
  final Function onPressed;
  final bool isEnabled;
  final double minimumSize;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed();
      },
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: isEnabled
            ? Theme.of(context).primaryColor
            : Theme.of(context).disabledColor,
      ),
      child: Text(text),
    );
  }
}
