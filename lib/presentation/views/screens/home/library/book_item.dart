import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../../colors/colors.dart';

class BookItem extends StatelessWidget {
  BookItem({
    Key? key,
    required this.onLongPress,
    required this.imageURL,
    required this.name,
  }) : super(key: key);
  final VoidCallback onLongPress;
  final String name;
  final String imageURL;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: onLongPress,
      child: Container(
        color: Colors.transparent,
        child: Column(
          children: [
            Material(
              // color: Colors.amber,
              shadowColor: S.colors.grey,
              borderRadius: BorderRadius.all(
                Radius.circular(
                  S.size.length_8,
                ),
              ),
              elevation: 3,
              child: Container(
                width: 100,
                height: 140,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: S.colors.grey,
                    width: 1.9,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      S.size.length_8,
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
            Padding(
              padding: EdgeInsets.symmetric(vertical: S.size.length_8),
              child: Text(
                name,
                style: S.textStyles.collection.smallTitle,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
