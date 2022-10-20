import 'dart:developer';
import 'dart:ffi';

import 'package:book_exchange/data/repos/book_repo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/entities/api_response.dart';
import '../../data/entities/book.dart';
import '../../data/repos/user_repo.dart';

class CollectionSetting {
  final bool isPressed;
  List<Book> listBook;

  CollectionSetting({
    required this.isPressed,
    required this.listBook,
  });

  CollectionSetting copy({
    bool? isPressed,
    List<Book>? listBook,
  }) =>
      CollectionSetting(
        isPressed: isPressed ?? false,
        listBook: listBook ?? this.listBook,
      );

  //CollectionSetting copyWith({}) {return CollectionSetting(emailClear: emailClear, isVisible: isVisible, emailController: emailController, passwordController: passwordController)}
}

class CollectionSettingNotifier extends StateNotifier<CollectionSetting> {
  CollectionSettingNotifier(this.ref)
      : super(
          CollectionSetting(
            isPressed: false,
            listBook: [],
          ),
        ) {
    _userRepo = ref.watch(userRepoProvider);
    _bookRepo = ref.watch(bookRepoProvider);
  }

  final Ref ref;
  late UserRepo _userRepo;
  late BookRepo _bookRepo;

  getBookByUserId() async {
    await _bookRepo.getBookByUserId(_userRepo.jwtToken).then((value) {
      log(value.toMap().toString());
    }).catchError((onError) {});
  }
}

final collectionSettingNotifierProvider =
    StateNotifierProvider<CollectionSettingNotifier, CollectionSetting>(
        ((ref) => CollectionSettingNotifier(ref)));

final listBooksProvider =
    FutureProvider.family<ApiResponse<List<Book>>, String>(
        ((ref, token) => ref.watch(bookRepoProvider).getBookByUserId(token)));
