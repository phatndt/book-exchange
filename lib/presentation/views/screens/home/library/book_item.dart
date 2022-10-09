import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../../../colors/colors.dart';

class BookItem extends StatelessWidget {
  BookItem({
    Key? key,
    required this.isPressed,
    required this.imageURL,
  }) : super(key: key);

  bool isPressed;
  final String imageURL;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        isPressed = !isPressed;
      },
      child: Material(
        color: Colors.transparent,
        elevation: 4,
        child: Container(
          // width: 120,
          // height: 160,
          decoration: BoxDecoration(
            border: isPressed
                ? Border.all(
                    color: S.colors.navyBlue,
                    width: 1.4,
                  )
                : Border.all(
                    color: S.colors.grey,
                    width: 1,
                  ),
            borderRadius: BorderRadius.all(
              Radius.circular(
                S.size.length_10,
              ),
            ),
            color: Colors.transparent,
            image: DecorationImage(
              image: NetworkImage(imageURL),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
