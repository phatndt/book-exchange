import 'package:flutter/material.dart';
import '../../../colors/colors.dart';

class CustomOutlineButton extends StatelessWidget {
  const CustomOutlineButton({
    Key? key,
    required this.width,
    required this.text,
    required this.onPress,
  }) : super(key: key);

  final double width;
  final String text;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(
        text,
        style: S.textStyles.buttonText,
      ),
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
        //padding: const EdgeInsets.all(0.8),
        maximumSize: Size(width, 60),
        minimumSize: Size(width, 60),
        side: BorderSide(
          style: BorderStyle.solid,
          color: S.colors.white,
          width: 0.6,
        ),
        primary: S.colors.black,
        onPrimary: S.colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(6.0),
          ),
        ),
        elevation: 1.2,
      ),
    );
  }
}
