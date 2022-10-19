import 'dart:developer';
import 'dart:io';

import 'package:book_exchange/core/core.dart';
import 'package:book_exchange/core/route_paths.dart';
import 'package:book_exchange/data/entities/book.dart';
import 'package:book_exchange/data/repos/book_repo.dart';
import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../core/extension/function_extension.dart';
import '../../data/repos/user_repo.dart';

class EditBookSetting {
  final TextEditingController bookName;
  final TextEditingController bookAuthor;
  final TextEditingController bookDescription;
  double bookRating;
  XFile bookImage;
  final String bookId;

  bool isLoadingEditBook = false;

  EditBookSetting({
    required this.bookId,
    required this.bookName,
    required this.bookAuthor,
    required this.bookDescription,
    required this.bookRating,
    required this.bookImage,
    required this.isLoadingEditBook,
  });

  EditBookSetting copy({
    TextEditingController? bookName,
    TextEditingController? bookAuthor,
    TextEditingController? bookDescription,
    double? bookRating,
    XFile? bookImage,
    bool? isLoadingEditBook,
    String? bookId,
  }) =>
      EditBookSetting(
        bookId: bookId ?? this.bookId,
        bookAuthor: bookAuthor ?? this.bookAuthor,
        bookImage: bookImage ?? this.bookImage,
        bookName: bookName ?? this.bookName,
        bookDescription: bookDescription ?? this.bookDescription,
        bookRating: bookRating ?? this.bookRating,
        isLoadingEditBook: isLoadingEditBook ?? this.isLoadingEditBook,
      );

  //EditBookSetting copyWith({}) {return EditBookSetting(emailClear: emailClear, isVisible: isVisible, emailController: emailController, passwordController: passwordController)}
}

class EditBookSettingNotifier extends StateNotifier<EditBookSetting> {
  EditBookSettingNotifier(this.ref)
      : super(
          EditBookSetting(
            bookId: '',
            bookAuthor: TextEditingController(),
            bookDescription: TextEditingController(),
            bookImage: XFile(''),
            bookName: TextEditingController(),
            bookRating: 0.0,
            isLoadingEditBook: false,
          ),
        ) {
    // _authRepo = ref.watch(authRepoProvider);
    _bookRepo = ref.watch(bookRepoProvider);
    _userRepo = ref.watch(userRepoProvider);
  }

  final Ref ref;
  // late AuthRepo _authRepo;
  late UserRepo _userRepo;
  late BookRepo _bookRepo;

  void setLoadingEditBook() {
    final newState = state.copy(isLoadingEditBook: !state.isLoadingEditBook);
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

  bool checkEditBookInput(context) {
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

  void editBookById(context, String imageURL) async {
    await _bookRepo
        .editBook(
            Book(
              id: state.bookId,
              author: state.bookAuthor.text,
              description: state.bookDescription.text,
              imageURL: imageURL,
              name: state.bookName.text,
              rate: state.bookRating,
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
        setLoadingEditBook();
      },
    ).catchError((onError) {
      setLoadingEditBook();
      catchOnError(context, onError);
    });
  }

  void updateImageToCloudinary(context) async {
    setLoadingEditBook();
    if (!checkEditBookInput(context)) {
      setLoadingEditBook();
      return;
    }
    final cloudinary = Cloudinary.full(
      apiKey: '735947945251852',
      apiSecret: 'O-Rd18L74ukuNN91I8vrzBJXeGI',
      cloudName: 'du7lkcbqm',
    );

    final response = await cloudinary
        .uploadResource(CloudinaryUploadResource(
            filePath: state.bookImage.path,
            fileBytes: await state.bookImage.readAsBytes(),
            resourceType: CloudinaryResourceType.image,
            folder: 'adu',
            fileName: state.bookImage.name,
            progressCallback: (count, total) {
              log('Uploading image from file with progress: $count/$total');
            }))
        .catchError((onError) {
      showTopSnackBar(
        context,
        CustomSnackBar.error(
          message: "Error: $onError",
        ),
        displayDuration: const Duration(seconds: 2),
      );
      setLoadingEditBook();
    });

    if (response.isSuccessful) {
      log('Get your image from with ${response.secureUrl}');
      editBookById(context, response.secureUrl!);
    } else {}
  }

  void deleteBookByBookId(String bookId, context) async {
    await _bookRepo.deleteBook(bookId, _userRepo.jwtToken).then((value) {
      Navigator.pushNamed(
        context,
        RoutePaths.home,
      );
      showTopSnackBar(
        context,
        CustomSnackBar.error(
          message: "Delete sucessfully",
        ),
        displayDuration: const Duration(seconds: 2),
      );
      // clearInput();
      setLoadingEditBook();
    }).catchError((onError) {
      setLoadingEditBook();
      catchOnError(context, onError);
    });
  }

  // String base64Image = base64Encode(await pickedImage.readAsBytes());

  // ref.watch(EditBookSettingNotifierProvider).bookImage = base64Image;
  // state.bookImage = base64Image;
  // log(base64Image);
}

final editBookSettingNotifierProvider =
    StateNotifierProvider<EditBookSettingNotifier, EditBookSetting>(
        ((ref) => EditBookSettingNotifier(ref)));
