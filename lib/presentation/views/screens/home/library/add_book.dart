import 'dart:io';

import 'package:book_exchange/presentation/view_models/add_book_viewmodels.dart';
import 'package:book_exchange/presentation/views/widgets/add_book_text_field.dart';
import 'package:book_exchange/presentation/views/widgets/filled_button.dart';
import 'package:book_exchange/presentation/views/widgets/outline_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xen_popup_card/xen_card.dart';

import '../../../../../colors/colors.dart';

class AddBookWidget extends ConsumerWidget {
  const AddBookWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return XenPopupCard(
      gutter: gutter,
      body: ListView(
        children: [
          Text(
            'Name',
            style: S.textStyles.geryOnWhiteText,
          ),
          AddBookTextField(
            text: '',
            obscure: false,
            textEditingController:
                ref.watch(AddBookSettingNotifierProvider).bookName,
          ),
          Text(
            'Author',
            style: S.textStyles.geryOnWhiteText,
          ),
          AddBookTextField(
            text: '',
            obscure: false,
            textEditingController:
                ref.watch(AddBookSettingNotifierProvider).bookAuthor,
          ),
          Text(
            'Description',
            style: S.textStyles.geryOnWhiteText,
          ),
          AddBookTextField(
            text: '',
            obscure: false,
            textEditingController:
                ref.watch(AddBookSettingNotifierProvider).bookDescription,
          ),
          Text(
            'Rating',
            style: S.textStyles.geryOnWhiteText,
          ),
          Padding(
            padding: EdgeInsets.all(
              S.size.length_8,
            ),
            child: Center(
              child: RatingBar(
                initialRating: 0,
                direction: Axis.horizontal,
                allowHalfRating: true,
                updateOnDrag: false,
                itemCount: 5,
                unratedColor: S.colors.grey,
                glowColor: S.colors.orange,
                ratingWidget: RatingWidget(
                  full: Image.asset('assets/images/heart.png'),
                  half: Image.asset('assets/images/heart_half.png'),
                  empty: Image.asset('assets/images/heart_border.png'),
                ),
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                onRatingUpdate: (rating) {
                  print(rating);
                  ref.watch(AddBookSettingNotifierProvider).bookRating = rating;
                },
              ),
            ),
          ),
          Text(
            'Cover',
            style: S.textStyles.geryOnWhiteText,
          ),
          // ref.watch(AddBookSettingNotifierProvider).bookImage != null
          //     ? Container()
          //     : Image.file(
          //         ref.watch(AddBookSettingNotifierProvider).bookImage,
          //         fit: BoxFit.cover,
          //       ),
          Padding(
            padding: EdgeInsets.all(
              S.size.length_8,
            ),
            child: CustomOutlineButton(
              width: S.size.length_100,
              text: 'Pick cover',
              onPress: () {
                ref
                    .watch(AddBookSettingNotifierProvider.notifier)
                    .showImageSourceActionSheet(context);
              },
            ),
          ),
          SizedBox(
            height: S.size.length_100,
          )
        ],
      ),
    );
  }
}

XenCardGutter gutter = XenCardGutter(
  child: Padding(
    padding: EdgeInsets.all(S.size.length_10),
    child: CustomFilledButton(
      onPress: () {},
      width: 0,
      text: 'Add Book',
    ),
  ),
);
