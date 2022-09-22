import 'package:flutter/material.dart';

class S {
  static final colors = _Colors();
  static final textStyles = _TextStyles();
}

class _Colors {
  final black = const Color.fromARGB(255, 53, 53, 53);
  final white = const Color.fromARGB(255, 247, 246, 247);
  final orange = const Color.fromARGB(255, 150, 27, 25);
  final mainColor = const MaterialColor(
    0xFF961B19,
    <int, Color>{
      50: Color(0xFF961B19),
      100: Color(0xFF961B19),
      200: Color(0xFF961B19),
      300: Color(0xFF961B19),
      400: Color(0xFF961B19),
      500: Color(0xFF961B19),
      600: Color(0xFF961B19),
      700: Color(0xFF961B19),
      800: Color(0xFF961B19),
      900: Color(0xFF961B19),
    },
  );
}

class _TextStyles {
  final bigTitle = const TextStyle(
    fontFamily: 'Lato',
    color: Colors.white,
    fontSize: 20,
  );

  final smallTitle = const TextStyle(
    fontFamily: 'Lato',
    color: Colors.white,
    fontSize: 16,
  );

  final buttonText = const TextStyle(
    fontFamily: 'Lato',
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  final textfieldText = const TextStyle(
    fontFamily: 'Lato',
    //color: Color.fromARGB(255, 150, 27, 25),
    color: Colors.white,
    fontSize: 20,
    fontWeight: FontWeight.w400,
  );

  final textfieldTitle = const TextStyle(
    fontFamily: 'Lato',
    color: Colors.white,
    fontSize: 18,
    fontWeight: FontWeight.w400,
  );
}
