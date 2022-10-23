import 'dart:io';

import 'package:book_exchange/core/app_bar.dart';
import 'package:book_exchange/presentation/views/widgets/filled_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../../core/colors/colors.dart';
import '../../../../../core/custom_text_form_fill.dart';
import '../../../../di/book_component.dart';

class AddBookScreen extends ConsumerWidget {
  const AddBookScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: ModalProgressHUD(
        inAsyncCall: ref.watch(addBookSettingNotifierProvider).isLoadingAddBook,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(S.size.length_50),
            child: const AppBarImpl(
              title: 'Create a new book',
            ),
          ),
          backgroundColor: S.colors.white,
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: S.size.length_20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: S.size.length_20,
                  ),
                  Text(
                    'Book Cover',
                    style: S.textStyles.titleText,
                  ),
                  SizedBox(
                    height: S.size.length_20,
                  ),
                  Center(
                    child: Container(
                      width: 130,
                      height: 160,
                      decoration: BoxDecoration(
                        color: S.colors.accent_8,
                        borderRadius: BorderRadius.all(
                          Radius.circular(S.size.length_8),
                        ),
                        image: ref
                                    .watch(addBookSettingNotifierProvider)
                                    .bookImage
                                    .path !=
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
                            : null,
                      ),
                      child: TextButton(
                        onPressed: () {
                          ref
                              .watch(addBookSettingNotifierProvider.notifier)
                              .showImageSourceActionSheet(context);
                        },
                        child: ref
                                    .watch(addBookSettingNotifierProvider)
                                    .bookImage
                                    .path ==
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
                    style: S.textStyles.titleText,
                  ),
                  CustomTextFormField(
                    controller:
                        ref.watch(addBookSettingNotifierProvider).bookName,
                    obscureText: false,
                  ),
                  Text(
                    'Author',
                    style: S.textStyles.titleText,
                  ),
                  CustomTextFormField(
                    controller:
                        ref.watch(addBookSettingNotifierProvider).bookAuthor,
                    obscureText: false,
                  ),
                  Text(
                    'Description',
                    style: S.textStyles.titleText,
                  ),
                  CustomTextFormField(
                    controller: ref
                        .watch(addBookSettingNotifierProvider)
                        .bookDescription,
                    obscureText: true,
                  ),
                  Text(
                    'Rating',
                    style: S.textStyles.titleText,
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
                      width: MediaQuery.of(context).size.width,
                      text: 'ADD BOOK',
                      onPress: () {
                        ref
                            .watch(addBookSettingNotifierProvider.notifier)
                            .updateImageToCloud(
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
      ),
    );
  }
}
