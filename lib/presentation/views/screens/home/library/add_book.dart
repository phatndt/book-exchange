import 'dart:io';

import 'package:book_exchange/presentation/view_models/add_book_viewmodels.dart';
import 'package:book_exchange/presentation/views/widgets/add_book_text_field.dart';
import 'package:book_exchange/presentation/views/widgets/filled_button.dart';
import 'package:book_exchange/presentation/views/widgets/outline_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xen_popup_card/xen_card.dart';

import '../../../../../colors/colors.dart';

class AddBookScreen extends ConsumerWidget {
  const AddBookScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: S.colors.background,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: S.size.length_20),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: S.size.length_20,
                ),
                Center(
                  child: Text(
                    'Adding Book',
                    style: S.textStyles.boldTitle,
                  ),
                ),
                SizedBox(
                  height: S.size.length_20,
                ),
                Text(
                  'Book Cover',
                  style: S.textStyles.whiteOnBlackText,
                ),
                Center(
                  child: Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      color: S.colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(S.size.length_8),
                      ),
                      image: ref
                                  .watch(addBookSettingNotifierProvider)
                                  .bookImage !=
                              ''
                          ? DecorationImage(
                              image: FileImage(
                                File(
                                  ref
                                      .watch(addBookSettingNotifierProvider)
                                      .bookImage
                                      .path,
                                ),
                              ),
                              fit: BoxFit.fill,
                            )
                          : DecorationImage(
                              image: ExactAssetImage('assets/images/20.png'),
                              fit: BoxFit.fill,
                            ),
                    ),
                    child: TextButton(
                      onPressed: () {
                        ref
                            .watch(addBookSettingNotifierProvider.notifier)
                            .showImageSourceActionSheet(context);
                      },
                      child:
                          ref.watch(addBookSettingNotifierProvider).bookImage ==
                                  ''
                              ? Icon(
                                  FontAwesomeIcons.plus,
                                  size: 40,
                                  color: S.colors.grey,
                                )
                              : const Icon(
                                  FontAwesomeIcons.plus,
                                  color: Colors.transparent,
                                ),
                    ),
                  ),
                ),
                SizedBox(
                  height: S.size.length_20,
                ),
                Text(
                  'Name',
                  style: S.textStyles.whiteOnBlackText,
                ),
                AddBookTextField(
                  text: '',
                  textEditingController:
                      ref.watch(addBookSettingNotifierProvider).bookName,
                ),
                SizedBox(
                  height: S.size.length_20,
                ),
                Text(
                  'Author',
                  style: S.textStyles.whiteOnBlackText,
                ),
                AddBookTextField(
                  text: '',
                  textEditingController:
                      ref.watch(addBookSettingNotifierProvider).bookAuthor,
                ),
                SizedBox(
                  height: S.size.length_20,
                ),
                Text(
                  'Description',
                  style: S.textStyles.whiteOnBlackText,
                ),
                AddBookTextField(
                  text: '',
                  textEditingController:
                      ref.watch(addBookSettingNotifierProvider).bookDescription,
                ),
                SizedBox(
                  height: S.size.length_20,
                ),
                Text(
                  'Rating',
                  style: S.textStyles.whiteOnBlackText,
                ),
                SizedBox(
                  height: S.size.length_10,
                ),
                Center(
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
                    itemPadding:
                        EdgeInsets.symmetric(horizontal: S.size.length_8),
                    onRatingUpdate: (rating) {
                      print(rating);
                      ref.watch(addBookSettingNotifierProvider).bookRating =
                          rating;
                    },
                  ),
                ),
                SizedBox(
                  height: S.size.length_40,
                ),
                Center(
                  child: CustomFilledButton(
                    width: S.size.length_130,
                    text: 'ADD BOOK',
                    onPress: () {
                      ref
                          .watch(addBookSettingNotifierProvider.notifier)
                          .updateImageToCloudinary(
                            context,
                          );
                    },
                  ),
                ),
                SizedBox(
                  height: S.size.length_40,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
