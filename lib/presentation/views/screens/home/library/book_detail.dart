import 'dart:developer';
import 'dart:io';

import 'package:book_exchange/presentation/models/book_app_model.dart';
import 'package:book_exchange/presentation/views/screens/home/library/edit_book.dart';
import 'package:book_exchange/presentation/views/widgets/alert_dialog.dart';
import 'package:book_exchange/presentation/views/widgets/filled_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../../core/colors/colors.dart';
import '../../../../../core/custom_text_form_fill.dart';
import '../../../../di/book_component.dart';

class BookDetailScreen extends ConsumerWidget {
  const BookDetailScreen({
    required this.bookId,
    required this.bookName,
    required this.bookAuthor,
    required this.bookDescription,
    required this.bookRating,
    required this.imageUrl,
    Key? key,
  }) : super(key: key);

  final String bookId;
  final String bookName;
  final String bookAuthor;
  final String bookDescription;
  final double bookRating;
  final String imageUrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: ModalProgressHUD(
        inAsyncCall:
            ref.watch(bookDetailSettingNotifierProvider).isLoadingBookDetail,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(S.size.length_50),
            child: AppBar(
              centerTitle: true,
              title: Text(bookName),
              leading: BackButton(onPressed: () {
                ref
                    .watch(editBookSettingNotifierProvider.notifier)
                    .updateImagePath(XFile(''));
                Navigator.pop(context);
              }),
            ),
          ),
          backgroundColor: S.colors.white,
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: S.size.length_10,
                vertical: S.size.length_20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: S.size.length_10,
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(
                              S.size.length_8,
                            ),
                            child: Material(
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  S.size.length_8,
                                ),
                              ),
                              elevation: 10,
                              child: Container(
                                width: 140,
                                height: 190,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: S.colors.black,
                                    width: 0.1,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                      S.size.length_8,
                                    ),
                                  ),
                                  image: DecorationImage(
                                    image: NetworkImage(imageUrl),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          RatingBarIndicator(
                            rating: bookRating,
                            itemBuilder: (context, index) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            itemCount: 5,
                            itemSize: 20.0,
                            direction: Axis.horizontal,
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: S.size.length_10,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Owner",
                              style: S.textStyles.collection.bigTitle,
                            ),
                            Text(
                              BookAppModel.user.username,
                              style: S.textStyles.collection.mediumTitle,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: S.size.length_10,
                            ),
                            Text(
                              "Author",
                              style: S.textStyles.collection.bigTitle,
                            ),
                            Text(
                              bookAuthor,
                              style: S.textStyles.collection.mediumTitle,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: S.size.length_10,
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              physics: AlwaysScrollableScrollPhysics(),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: S.size.length_4,
                                    ),
                                    child: ClipOval(
                                      child: Material(
                                        color: S.colors.orange, // Button color
                                        child: InkWell(
                                          splashColor:
                                              S.colors.navyBlue, // Splash color
                                          onTap: () {},
                                          child: const SizedBox(
                                            width: 45,
                                            height: 45,
                                            child: Icon(
                                              FontAwesomeIcons.cloudArrowUp,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: S.size.length_4,
                                    ),
                                    child: ClipOval(
                                      child: Material(
                                        color: S.colors.orange, // Button color
                                        child: InkWell(
                                          splashColor:
                                              S.colors.navyBlue, // Splash color
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditBookScreen(
                                                        bookId: bookId,
                                                        bookAuthor: bookAuthor,
                                                        bookDescription:
                                                            bookDescription,
                                                        bookName: bookName,
                                                        bookRating: bookRating,
                                                        imageUrl: imageUrl,
                                                      )),
                                            );
                                          },
                                          child: const SizedBox(
                                            width: 45,
                                            height: 45,
                                            child: Icon(
                                              FontAwesomeIcons.pencil,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: S.size.length_4,
                                    ),
                                    child: ClipOval(
                                      child: Material(
                                        color: S.colors.orange, // Button color
                                        child: InkWell(
                                          splashColor:
                                              S.colors.navyBlue, // Splash color
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              barrierDismissible: true,
                                              builder: (builder) =>
                                                  CustomAlertDialog(
                                                action: () {
                                                  ref
                                                      .watch(
                                                          editBookSettingNotifierProvider
                                                              .notifier)
                                                      .deleteBookByBookId(
                                                          bookId, context);
                                                  Navigator.of(context).pop();
                                                },
                                                action1Title: 'Yes',
                                                action2Title: 'No',
                                                content:
                                                    'You want to delete this book?',
                                                title: 'DELETE',
                                              ),
                                            );
                                          },
                                          child: const SizedBox(
                                            width: 45,
                                            height: 45,
                                            child: Icon(
                                              FontAwesomeIcons.trash,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: S.size.length_20,
                      vertical: S.size.length_10,
                    ),
                    child: Text(
                      'About this book',
                      style: S.textStyles.collection.bigTitle,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: S.size.length_20,
                      // vertical: S.size.length_20,
                    ),
                    child: RichText(
                      text: TextSpan(
                        text: bookDescription,
                        style: S.textStyles.collection.mediumTitle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
