import 'package:book_exchange/presentation/views/screens/home/library/add_book.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../colors/colors.dart';
import 'book_item.dart';

class CollectionScreen extends StatelessWidget {
  const CollectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (builder) => AddBookWidget(),
          );
        },
        child: const Icon(Icons.add),
      ),
      backgroundColor: S.colors.white,
      body: Column(
        // physics: const NeverScrollableScrollPhysics(),
        children: [
          SizedBox(
            height: S.size.length_50,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: S.size.length_10,
            ),
            child: Row(
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Icon(
                          FontAwesomeIcons.book,
                          color: S.colors.grey,
                          size: 22,
                        ),
                      ),
                      const TextSpan(text: '  '),
                      TextSpan(
                        text: '5 Book Selected',
                        style: S.textStyles.geryOnWhiteText,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.count(
              padding: EdgeInsets.symmetric(vertical: S.size.length_10),
              shrinkWrap: true,
              crossAxisCount: 3,
              mainAxisSpacing: 7.0,
              scrollDirection: Axis.vertical,
              children: List.generate(
                50,
                (index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: S.size.length_10,
                    ),
                    child: BookItem(
                      imageURL: S.colors.urlEx,
                      isPressed: false,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
