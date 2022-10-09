import 'package:book_exchange/data/repos/user_repo.dart';
import 'package:book_exchange/presentation/view_models/add_book_viewmodels.dart';
import 'package:book_exchange/presentation/view_models/collection_viewmodels.dart';
import 'package:book_exchange/presentation/views/screens/home/library/add_book.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../colors/colors.dart';
import 'book_item.dart';

class CollectionScreen extends ConsumerWidget {
  const CollectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(collectionSettingNotifierProvider.notifier).getBookByUserId();
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddBookScreen()),
            );
            // showDialog(
            //   context: context,
            //   builder: (builder) => AddBookWidget(),
            // );
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
              child: ref
                  .watch(
                      listBooksProvider(ref.watch(userRepoProvider).jwtToken))
                  .when(
                    data: (data) {
                      return GridView.builder(
                        padding:
                            EdgeInsets.symmetric(vertical: S.size.length_10),
                        shrinkWrap: true,
                        itemCount: data.data.length,
                        scrollDirection: Axis.vertical,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.725,
                        ),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: S.size.length_10,
                            ),
                            child: BookItem(
                              imageURL: data.data[index].imageURL,
                              isPressed: ref
                                  .watch(collectionSettingNotifierProvider)
                                  .isPressed,
                            ),
                          );
                        },
                      );
                    },
                    error: (error, stack) => Center(),
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
              // child: GridView.count(
              //   padding: EdgeInsets.symmetric(vertical: S.size.length_10),
              //   shrinkWrap: true,
              //   crossAxisCount: 3,
              //   mainAxisSpacing: 14,
              //   scrollDirection: Axis.vertical,
              //   children: List.generate(
              //     50,
              //     (index) {
              //       return Padding(
              //         padding: EdgeInsets.symmetric(
              //           horizontal: S.size.length_10,
              //         ),
              //         child: BookItem(
              //           imageURL: S.colors.urlEx,
              //           isPressed: ref
              //               .watch(collectionSettingNotifierProvider)
              //               .isPressed,
              //         ),
              //       );
              //     },
              //   ),
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
