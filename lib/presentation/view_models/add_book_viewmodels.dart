import 'dart:io';

import 'package:book_exchange/core/core.dart';
import 'package:book_exchange/core/route_paths.dart';
import 'package:book_exchange/domain/use_cases/book/upload_book_use_case.dart';
import 'package:book_exchange/domain/use_cases/upload_image_use_case.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../core/extension/function_extension.dart';
import '../../domain/entities/book.dart';
import '../models/book_app_model.dart';

class AddBookSetting {
  final TextEditingController bookName;
  final TextEditingController bookAuthor;
  final TextEditingController bookDescription;
  double bookRating;
  File bookImage;

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
    File? bookImage,
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
  AddBookSettingNotifier(
      this.ref, this._uploadImageToCloudinaryUseCase, this._uploadBookUseCase)
      : super(
          AddBookSetting(
            bookAuthor: TextEditingController(),
            bookDescription: TextEditingController(),
            bookImage: File(''),
            bookName: TextEditingController(),
            bookRating: 0.0,
            isLoadingAddBook: false,
          ),
        );

  final Ref ref;
  final UploadImageToCloudinaryUseCase _uploadImageToCloudinaryUseCase;
  final UploadBookUseCase _uploadBookUseCase;

  void setLoadingAddBook() {
    final newState = state.copy(isLoadingAddBook: !state.isLoadingAddBook);
    state = newState;
  }

  void clearImage() {
    final newState = state.copy(bookImage: File(''));
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

  void updateImagePath(File a) {
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
    updateImagePath(File(pickedImage.path));
  }

  void uploadBookToDB(context, String imageURL) async {
    await _uploadBookUseCase
        .uploadBook(
            Book(
              id: '',
              name: state.bookName.text,
              author: state.bookAuthor.text,
              description: state.bookDescription.text,
              rate: state.bookRating,
              imageURL: imageURL,
              userId: getUserIdFromToken(BookAppModel.jwtToken),
            ),
            BookAppModel.jwtToken)
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

  void updateImageToCloud(context) {
    setLoadingAddBook();
    if (!checkAddBookInput(context)) {
      setLoadingAddBook();
      return;
    }
    _uploadImageToCloudinaryUseCase
        .uploadImageToSpaces(BookAppModel.user.id + "/book", state.bookImage)
        .then((value) {
      if (value != null) {
        uploadBookToDB(context, value);
      }
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
