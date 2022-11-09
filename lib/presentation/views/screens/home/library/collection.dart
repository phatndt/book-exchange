import 'package:book_exchange/presentation/views/screens/home/library/add_book.dart';
import 'package:book_exchange/presentation/views/screens/home/library/book_detail.dart';
import 'package:book_exchange/presentation/views/screens/home/library/edit_book.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/colors/colors.dart';
import '../../../../di/book_component.dart';
import '../../../../view_models/collection_viewmodels.dart';
import 'book_item.dart';

class CollectionScreen extends ConsumerWidget {
  const CollectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              height: S.size.length_20,
            ),
            Center(
              child: Text(
                'YOUR BOOKS',
                style: S.textStyles.collection.bigTitleWithOrange,
              ),
            ),
            SizedBox(
              height: S.size.length_20,
            ),

            // Padding(
            //   padding: EdgeInsets.symmetric(
            //     horizontal: S.size.length_10,
            //   ),
            //   child: Row(
            //     children: [
            //       RichText(
            //         text: TextSpan(
            //           children: [
            //             WidgetSpan(
            //               child: Icon(
            //                 FontAwesomeIcons.book,
            //                 color: S.colors.grey,
            //                 size: 22,
            //               ),
            //             ),
            //             const TextSpan(text: '  '),
            //             TextSpan(
            //               text: '5 Book Selected',
            //               style: S.textStyles.geryOnWhiteText,
            //             )
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async => ref.refresh(
                    getListBookProvider(ref.watch(getListBookUseCaseProvider))),
                child: ref
                    .watch(getListBookProvider(
                        ref.watch(getListBookUseCaseProvider)))
                    .when(
                      data: (data) {
                        return GridView.builder(
                          padding:
                              EdgeInsets.symmetric(vertical: S.size.length_10),
                          shrinkWrap: true,
                          itemCount: data.length,
                          scrollDirection: Axis.vertical,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 10,
                            childAspectRatio: 0.725,
                          ),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: S.size.length_10,
                              ),
                              child: BookItem(
                                imageURL: data[index].imageURL,
                                name: data[index].name,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BookDetailScreen(
                                              bookId: data[index].id,
                                              bookAuthor: data[index].author,
                                              bookDescription:
                                                  data[index].description,
                                              bookName: data[index].name,
                                              bookRating: data[index].rate,
                                              imageUrl: data[index].imageURL,
                                            )),
                                  );
                                },
                              ),
                            );
                          },
                        );
                      },
                      error: (error, stack) => Center(
                        child: Text(
                          'You didn\'t add any books yet!',
                          style: S.textStyles.bigTitle,
                        ),
                      ),
                      loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}