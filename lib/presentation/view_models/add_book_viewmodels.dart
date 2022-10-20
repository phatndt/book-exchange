import 'dart:developer';
import 'dart:io';

import 'package:book_exchange/core/core.dart';
import 'package:book_exchange/core/route_paths.dart';
import 'package:book_exchange/data/entities/book.dart';
import 'package:book_exchange/data/repos/book_repo.dart';
import 'package:book_exchange/domain/use_cases/upload_image_to_cloudinary_use_case.dart';
import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../core/extension/function_extension.dart';
import '../../data/repos/user_repo.dart';

class AddBookSetting {
  final TextEditingController bookName;
  final TextEditingController bookAuthor;
  final TextEditingController bookDescription;
  double bookRating;
  XFile bookImage;

  bool isLoadingAddBook = false;

  AddBookSetting({
    required this.bookName,
    required this.bookAuthor,
    required this.bookDescription,
    required this.bookRating,
    required this.bookImage,
    required this.isLoadingAddBook,
  });

  AddBookSetting copy({
    TextEditingController? bookName,
    TextEditingController? bookAuthor,
    TextEditingController? bookDescription,
    double? bookRating,
    XFile? bookImage,
    bool? isLoadingAddBook,
  }) =>
      AddBookSetting(
          bookAuthor: bookAuthor ?? this.bookAuthor,
          bookImage: bookImage ?? this.bookImage,
          bookName: bookName ?? this.bookName,
          bookDescription: bookDescription ?? this.bookDescription,
          bookRating: bookRating ?? this.bookRating,
          isLoadingAddBook: isLoadingAddBook ?? this.isLoadingAddBook);

  //AddBookSetting copyWith({}) {return AddBookSetting(emailClear: emailClear, isVisible: isVisible, emailController: emailController, passwordController: passwordController)}
}

class AddBookSettingNotifier extends StateNotifier<AddBookSetting> {
  AddBookSettingNotifier(this.ref, this._uploadImageToCloudinaryUseCase)
      : super(
          AddBookSetting(
            bookAuthor: TextEditingController(),
            bookDescription: TextEditingController(),
            bookImage: XFile(''),
            bookName: TextEditingController(),
            bookRating: 0.0,
            isLoadingAddBook: false,
          ),
        ) {
    // _authRepo = ref.watch(authRepoProvider);
    _bookRepo = ref.watch(bookRepoProvider);
    _userRepo = ref.watch(userRepoProvider);
  }

  final Ref ref;
  final UploadImageToCloudinaryUseCase _uploadImageToCloudinaryUseCase;
  late UserRepo _userRepo;
  late BookRepo _bookRepo;

  void setLoadingAddBook() {
    final newState = state.copy(isLoadingAddBook: !state.isLoadingAddBook);
    state = newState;
  }

  void clearImage() {
    final newState = state.copy(bookImage: XFile(''));
    state = newState;
  }

  void clearInput() {
    state.bookName.text = "";
    state.bookAuthor.text = "";
    state.bookDescription.text = "";
    state.bookRating = 0.0;
    clearImage();
  }

  void showImageSourceActionSheet(BuildContext context) {
    if (Platform.isIOS) {
      showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              child: const Text('Camera'),
              onPressed: () {
                Navigator.pop(context);
                selectImageSource(ImageSource.camera);
              },
            ),
            CupertinoActionSheetAction(
              child: const Text('Gallery'),
              onPressed: () {
                Navigator.pop(context);
                selectImageSource(ImageSource.gallery);
              },
            )
          ],
        ),
      );
    } else {
      showModalBottomSheet(
        context: context,
        builder: (context) => Wrap(children: [
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text('Camera'),
            onTap: () {
              Navigator.pop(context);
              selectImageSource(ImageSource.camera);
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_album),
            title: const Text('Gallery'),
            onTap: () {
              Navigator.pop(context);
              selectImageSource(ImageSource.gallery);
            },
          ),
        ]),
      );
    }
  }

  bool checkAddBookInput(context) {
    if (state.bookName.text.isEmpty ||
        state.bookAuthor.text.isEmpty ||
        state.bookDescription.text.isEmpty ||
        state.bookImage.path.isEmpty) {
      showTopSnackBar(
        context,
        const CustomSnackBar.error(
          message: "Fill up the blank space",
        ),
        displayDuration: const Duration(seconds: 2),
      );
      return false;
    } else {
      return true;
    }
  }

  void updateImagePath(XFile a) {
    final newState = state.copy(bookImage: a);
    state = newState;
  }

  void selectImageSource(ImageSource imageSource) async {
    // final _picker = ImagePicker();
    // final pickedImage = await _picker.pickImage(source: imageSource);
    final pickedImage = await ImagePicker().pickImage(source: imageSource);

    if (pickedImage == null) {
      return;
    }
    updateImagePath(pickedImage);
  }

  void uploadBookToDB(context, String imageURL) async {
    await _bookRepo
        .uploadBook(
            Book(
              id: '',
              name: state.bookName.text,
              author: state.bookAuthor.text,
              description: state.bookDescription.text,
              rate: state.bookRating,
              imageURL: imageURL,
              userId: getUserIdFromToken(_userRepo.jwtToken),
            ),
            _userRepo.jwtToken)
        .then(
      (value) {
        Navigator.pushNamed(
          context,
          RoutePaths.home,
        );
        showTopSnackBar(
          context,
          CustomSnackBar.error(
            message: value.message,
          ),
          displayDuration: const Duration(seconds: 2),
        );
        clearInput();
        setLoadingAddBook();
      },
    ).catchError((onError) {
      setLoadingAddBook();
      catchOnError(context, onError);
    });
  }

  void updateImageToCloudinary(context) {
    setLoadingAddBook();
    if (!checkAddBookInput(context)) {
      setLoadingAddBook();
      return;
    }
    _uploadImageToCloudinaryUseCase
        .uploadImageToCloudinary(state.bookImage.path,
            state.bookImage.readAsBytes(), state.bookImage.name)
        .then((value) {
      log('Get your image from with ${value.secureUrl}');
      uploadBookToDB(context, value.secureUrl!);
    }).catchError(
      (onError) {
        showTopSnackBar(
          context,
          CustomSnackBar.error(
            message: "Error: $onError",
          ),
          displayDuration: const Duration(seconds: 2),
        );
        setLoadingAddBook();
      },
    );
  }
}
