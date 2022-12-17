import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../domain/entities/post.dart';

class EditPostState {
  final TextEditingController content;
  final File image;
  final bool isLoadingAddPost;
  final String selectedBookId;
  Post post;

  EditPostState({
    required this.content,
    required this.image,
    required this.isLoadingAddPost,
    required this.selectedBookId,
    required this.post,
  });

  EditPostState copy({
    TextEditingController? content,
    File? image,
    bool? isLoadingAddPost,
    String? selectedBookId,
    Post? post,
  }) =>
      EditPostState(
        content: content ?? this.content,
        image: image ?? this.image,
        isLoadingAddPost: isLoadingAddPost ?? this.isLoadingAddPost,
        selectedBookId: selectedBookId ?? this.selectedBookId,
        post: post ?? this.post,
      );
}

class EditPostStateNotifier extends StateNotifier<EditPostState> {
  EditPostStateNotifier(this.ref)
      : super(
          EditPostState(
            content: TextEditingController(),
            image: File(""),
            isLoadingAddPost: false,
            selectedBookId: "",
            post: Post(
              id: "",
              content: "",
              createDate: "",
              nLikes: 0,
              nComments: 0,
              userId: "",
              imageUrl: "",
              bookId: "",
              isDeleted: false,
            ),
          ),
        );

  Ref ref;

  void updateState(String text, File image, String selectedBookId) {
    final newState = state.copy(
      content: TextEditingController(text: text),
      image: image,
      selectedBookId: selectedBookId,
    );
    state = newState;
  }

  void updateImage(File file) {
    final newState = state.copy(image: file);
    state = newState;
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
