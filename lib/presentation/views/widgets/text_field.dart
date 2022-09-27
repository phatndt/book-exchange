import 'package:flutter/material.dart';

import '../../../colors/colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    // required this.width,
    required this.text,
    required this.icon,
    required this.obscure,
    required this.textEditingController,
  }) : super(key: key);

  // final double width;
  final String text;
  final IconData icon;
  final bool obscure;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: TextField(
        controller: textEditingController,
        style: S.textStyles.textfieldText,
        obscureText: obscure,
        decoration: InputDecoration(
          labelText: text,
          labelStyle: S.textStyles.textfieldTitle,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: S.colors.white,
            ),
          ),
          suffixIcon: Icon(
            icon,
            size: 18,
            color: S.colors.white,
          ),
        ),
      ),
    );
  }
}
