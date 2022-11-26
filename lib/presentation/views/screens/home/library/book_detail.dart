import 'package:book_exchange/presentation/models/book_app_model.dart';
import 'package:book_exchange/presentation/views/screens/home/library/add_contribution_book.dart';
import 'package:book_exchange/presentation/views/screens/home/library/edit_book.dart';
import 'package:book_exchange/presentation/views/widgets/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../../core/colors/colors.dart';
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
                    height: S.size.length_10Vertical,
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(
                              S.size.length_10,
                            ),
                            child: Material(
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  S.size.length_8,
                                ),
                              ),
                              elevation: 10,
                              child: Container(
                                width: S.size.length_150,
                                height: S.size.length_200Vertical,
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
                            itemSize: 25.0,
                            direction: Axis.horizontal,
                          ),
                        ],
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: S.size.length_10,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: S.colors.gray_6,
                                      backgroundImage: const NetworkImage(
                                          "https://www.pngitem.com/pimgs/m/576-5768680_avatar-png-icon-person-icon-png-free-transparent.png"),
                                      // BookAppModel.user.image.isNotEmpty
                                      //     ? NetworkImage(
                                      //         BookAppModel.user.image,
                                      //       )
                                      //     : const NetworkImage(
                                      //         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSegCgK5aWTTuv_K5TPd10DcJxphcBTBct6R170EamgcCOcYs7LGKVy7ybRc-MCwOcHljg&usqp=CAU",
                                      //       ),
                                      radius: S.size.length_25Vertical,
                                    ),
                                    SizedBox(
                                      width: S.size.length_8Vertical,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Owner",
                                          style: S.textStyles.collection
                                              .mediumTitle,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          BookAppModel.user.username,
                                          style: S
                                              .textStyles.collection.smallTitle,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: S.size.length_10Vertical,
                              ),
                              Text(
                                "Author",
                                style: S.textStyles.collection.mediumTitle,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                bookAuthor,
                                style: S.textStyles.collection.smallTitle,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                              ),
                              SizedBox(
                                height: S.size.length_10Vertical,
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                physics: const BouncingScrollPhysics(),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: S.size.length_4,
                                      ),
                                      child: ClipOval(
                                        child: Material(
                                          color:
                                              S.colors.orange, // Button color
                                          child: InkWell(
                                            splashColor: S.colors
                                                .navyBlue, // Splash color
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      AddContributionBookScreen(
                                                    bookAuthor: bookAuthor,
                                                    bookDescription:
                                                        bookDescription,
                                                    bookName: bookName,
                                                    imageUrl: imageUrl,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: SizedBox(
                                              width: S.size.length_40,
                                              height: S.size.length_40Vertical,
                                              child: const Icon(
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
                                          color:
                                              S.colors.orange, // Button color
                                          child: InkWell(
                                            splashColor: S.colors
                                                .navyBlue, // Splash color
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
                                                  ),
                                                ),
                                              );
                                            },
                                            child: SizedBox(
                                              width: S.size.length_40,
                                              height: S.size.length_40Vertical,
                                              child: const Icon(
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
                                          color:
                                              S.colors.orange, // Button color
                                          child: InkWell(
                                            splashColor: S.colors
                                                .navyBlue, // Splash color
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
                                            child: SizedBox(
                                              width: S.size.length_40,
                                              height: S.size.length_40Vertical,
                                              child: const Icon(
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
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: S.size.length_10,
                      vertical: S.size.length_10,
                    ),
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 0.8,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      child: Text(
                        'About this book',
                        style: S.textStyles.collection.bigTitle,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: S.colors.gray_6,
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            S.size.length_8,
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: S.size.length_10,
                          vertical: S.size.length_8Vertical,
                          // vertical: S.size.length_20,
                        ),
                        child: RichText(
                          text: TextSpan(
                            text: bookDescription,
                            style: S.textStyles.bookDetail.description,
                          ),
                        ),
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
