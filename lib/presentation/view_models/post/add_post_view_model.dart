import 'dart:io';

import 'package:book_exchange/domain/entities/post.dart';
import 'package:book_exchange/domain/use_cases/upload_image_use_case.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../core/extension/function_extension.dart';
import '../../../domain/use_cases/book/get_list_book_by_id_use_case.dart';
import '../../../domain/use_cases/post/add_post_use_case.dart';
import '../../models/book_app_model.dart';

class AddPostState {
  final TextEditingController content;
  final File image;
  final bool isLoadingAddPost;

  AddPostState({
    required this.content,
    required this.image,
    required this.isLoadingAddPost,
  });

  AddPostState copy({
    TextEditingController? content,
    File? image,
    bool? isLoadingAddPost,
  }) =>
      AddPostState(
        content: content ?? this.content,
        image: image ?? this.image,
        isLoadingAddPost: isLoadingAddPost ?? this.isLoadingAddPost,
      );
}

class AddPostNotifier extends StateNotifier<AddPostState> {
  AddPostNotifier(
      this.ref, this._addPostUseCase, this._uploadImageToCloudinaryUseCase)
      : super(
          AddPostState(
            content: TextEditingController(),
            image: File(""),
            isLoadingAddPost: false,
          ),
        );

  final Ref ref;
  final AddPostUseCase _addPostUseCase;
  final UploadImageToCloudinaryUseCase _uploadImageToCloudinaryUseCase;
  setIsLoadingAddPost() {
    final newState = state.copy(isLoadingAddPost: !state.isLoadingAddPost);
    state = newState;
  }

  void updateImage(File file) {
    final newState = state.copy(image: file);
    state = newState;
  }

  void uploadPost(context) {
    updateImageToCloud(context);
  }

  void updateImageToCloud(context) {
    setIsLoadingAddPost();
    if (!checkAddPostInput(context)) {
      setIsLoadingAddPost();
      showTopSnackBar(
        context,
        const CustomSnackBar.info(
          message: "Fill up the blank space",
        ),
        displayDuration: const Duration(seconds: 1),
      );
      return;
    }
    _uploadImageToCloudinaryUseCase
        .uploadImageToSpaces(BookAppModel.user.id + "/post", state.image)
        .then((value) {
      if (value != null) {
        createPost(context, value);
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
        setIsLoadingAddPost();
      },
    );
  }

  bool checkAddPostInput(context) {
    if (state.content.text.isEmpty || state.image.path.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  void createPost(context, uploadedUrl) {
    final post = Post(
      id: "",
      content: state.content.text,
      createDate: DateTime.now().millisecondsSinceEpoch.toString(),
      nLikes: 0,
      nComments: 0,
      userId: BookAppModel.user.id,
      imageUrl: uploadedUrl,
      isDeleted: false,
    );

    _addPostUseCase.createPost(post, BookAppModel.jwtToken).then(
      (value) {
        setIsLoadingAddPost();
        showTopSnackBar(
          context,
          const CustomSnackBar.success(
            message: "Create post successfully",
          ),
          displayDuration: const Duration(seconds: 1),
        );
        Navigator.pop(context);
      },
    ).catchError(
      (onError) {
        setIsLoadingAddPost();
        catchOnError(context, onError);
      },
    );
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

  void selectImageSource(ImageSource imageSource) async {
    // final _picker = ImagePicker();
    // final pickedImage = await _picker.pickImage(source: imageSource);
    final pickedImage = await ImagePicker().pickImage(source: imageSource);
    if (pickedImage == null) {
      return;
    }
    updateImage(File(pickedImage.path));
  }
}
