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
      child: Container(
        // width: 120,
        // height: 160,
        decoration: BoxDecoration(
          border: Border.all(
            color: isPressed == true ? S.colors.navyBlue : S.colors.grey,
            width: isPressed == true ? 1.4 : 1,
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
    );
  }
}
