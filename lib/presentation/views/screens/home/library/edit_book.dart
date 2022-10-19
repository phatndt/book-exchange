import 'dart:developer';
import 'dart:io';

import 'package:book_exchange/core/app_bar.dart';
import 'package:book_exchange/presentation/views/widgets/alert_dialog.dart';
import 'package:book_exchange/presentation/views/widgets/filled_button.dart';
import 'package:book_exchange/presentation/views/widgets/recustom_elevated_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../../colors/colors.dart';
import '../../../../../core/custom_text_form_fill.dart';
import '../../../../view_models/edit_book_viewmodels.dart';

class EditBookScreen extends ConsumerWidget {
  const EditBookScreen({
    required this.bookId,
    required this.bookName,
    required this.bookAuthor,
    required this.bookDescription,
    required this.bookRating,
    required this.imagePath,
    Key? key,
  }) : super(key: key);

  final String bookId;
  final String bookName;
  final String bookAuthor;
  final String bookDescription;
  final double bookRating;
  final String imagePath;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: ModalProgressHUD(
        inAsyncCall:
            ref.watch(editBookSettingNotifierProvider).isLoadingEditBook,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(S.size.length_50),
            child: AppBar(
              centerTitle: true,
              title: Text("Edit Your Book"),
              leading: BackButton(onPressed: () {
                ref
                    .watch(editBookSettingNotifierProvider.notifier)
                    .updateImagePath(XFile(''));
                Navigator.pop(context);
              }),
              actions: [
                IconButton(
                  icon: Icon(
                    FontAwesomeIcons.trashCan,
                  ),
                  onPressed: () {
                    deletePress(context, () {
                      ref
                          .watch(editBookSettingNotifierProvider.notifier)
                          .deleteBookByBookId(this.bookId, context);
                    });
                  },
                ),
              ],
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Book Cover',
                        style: S.textStyles.titleText,
                      ),
                      // ReCustomElevatedButton(
                      //   height: 40,
                      //   width: 100,
                      //   text: "DELETE",
                      //   onPress: () {
                      //     showDialog(
                      //       context: context,
                      //       barrierDismissible: true,
                      //       builder: (builder) => CustomAlertDialog(
                      //         action: () {
                      //           //deletethisbook
                      //           ref
                      //               .watch(editBookSettingNotifierProvider
                      //                   .notifier)
                      //               .deleteBookByBookId(this.bookId, context);
                      //         },
                      //         action1Title: 'Yes',
                      //         action2Title: 'No',
                      //         content: 'You want to delete this book?',
                      //         title: 'DELETE',
                      //       ),
                      //     );
                      //   },
                      // ),
                    ],
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
                                    .watch(editBookSettingNotifierProvider)
                                    .bookImage
                                    .path ==
                                ''
                            ? DecorationImage(
                                image: NetworkImage(imagePath),
                                fit: BoxFit.fill,
                              )
                            : DecorationImage(
                                image: FileImage(
                                  File(
                                    ref
                                        .watch(editBookSettingNotifierProvider)
                                        .bookImage
                                        .path,
                                  ),
                                ),
                                fit: BoxFit.fill,
                              ),
                      ),
                      child: TextButton(
                        onPressed: () {
                          ref
                              .watch(editBookSettingNotifierProvider.notifier)
                              .showImageSourceActionSheet(context);
                          log(ref
                              .watch(editBookSettingNotifierProvider)
                              .bookImage
                              .path);
                        },
                        child:
                            // ? Icon(
                            //     FontAwesomeIcons.plus,
                            //     size: 40,
                            //     color: S.colors.grey,
                            //   )
                            // :
                            const Icon(
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
                    hintText: bookName,
                    controller:
                        ref.watch(editBookSettingNotifierProvider).bookName,
                    obscureText: false,
                  ),
                  Text(
                    'Author',
                    style: S.textStyles.titleText,
                  ),
                  CustomTextFormField(
                    hintText: bookAuthor,
                    controller:
                        ref.watch(editBookSettingNotifierProvider).bookAuthor,
                    obscureText: false,
                  ),
                  Text(
                    'Description',
                    style: S.textStyles.titleText,
                  ),
                  CustomTextFormField(
                    hintText: bookDescription,
                    controller: ref
                        .watch(editBookSettingNotifierProvider)
                        .bookDescription,
                    obscureText: false,
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
                      initialRating: bookRating,
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
                        ref.watch(editBookSettingNotifierProvider).bookRating =
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
                      text: 'EDIT BOOK',
                      onPress: () {
                        // ref
                        //     .watch(editBookSettingNotifierProvider.notifier)
                        //     .updateImageToCloudinary(
                        //       context,
                        //     );
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

  void deletePress(context, VoidCallback onPress) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (builder) => CustomAlertDialog(
        action: () {
          //deletethisbook
          onPress;
          Fluttertoast.showToast(msg: "adu toi day!");
        },
        action1Title: 'Yes',
        action2Title: 'No',
        content: 'You want to delete this book?',
        title: 'DELETE',
      ),
    );
  }
}
