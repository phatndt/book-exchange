import 'dart:developer';
import 'dart:io';

import 'package:book_exchange/domain/use_cases/change_information/change_address_use_case.dart';
import 'package:book_exchange/domain/use_cases/change_information/change_avatar_path_use_case.dart';
import 'package:book_exchange/domain/use_cases/change_information/change_username_use_case.dart';
import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../core/colors/colors.dart';
import '../../core/extension/function_extension.dart';
import '../models/book_app_model.dart';

class ChangeInformationSetting {
  bool isLoadingChangeInformation = false;
  final TextEditingController username;
  final TextEditingController address;
  XFile avatarPath;
  DecorationImage? decorationImage;
  Icon icon;
  ChangeInformationSetting({
    required this.isLoadingChangeInformation,
    required this.username,
    required this.address,
    required this.avatarPath,
    required this.icon,
    required this.decorationImage,
  });

  ChangeInformationSetting copy({
    XFile? avatarPath,
    bool? isLoadingChangeInformation,
    TextEditingController? username,
    Icon? icon,
    DecorationImage? decorationImage,
    TextEditingController? address,
  }) =>
      ChangeInformationSetting(
        icon: icon ?? this.icon,
        decorationImage: decorationImage ?? this.decorationImage,
        username: username ?? this.username,
        address: address ?? this.address,
        avatarPath: avatarPath ?? this.avatarPath,
        isLoadingChangeInformation:
            isLoadingChangeInformation ?? this.isLoadingChangeInformation,
      );
}

class ChangeInformationSettingNotifier
    extends StateNotifier<ChangeInformationSetting> {
  ChangeInformationSettingNotifier(this.ref, this._changeAdressUseCase,
      this._changeAvatarPathUseCase, this._changeUsernameUseCase)
      : super(ChangeInformationSetting(
          icon: Icon(
            FontAwesomeIcons.plus,
            size: 40,
            color: S.colors.grey,
          ),
          decorationImage: null,
          address: TextEditingController(),
          username: TextEditingController(),
          avatarPath: XFile(''),
          isLoadingChangeInformation: false,
        ));

  final Ref ref;
  final ChangeAdressUseCase _changeAdressUseCase;
  final ChangeAvatarPathUseCase _changeAvatarPathUseCase;
  final ChangeUsernameUseCase _changeUsernameUseCase;

  void setLoadingChangeInformation() {
    final newState = state.copy(
        isLoadingChangeInformation: !state.isLoadingChangeInformation);
    state = newState;
  }

  bool checkInput(context) {
    if (state.address.text.isEmpty &&
        state.avatarPath.path.isEmpty &&
        state.username.text.isEmpty) {
      showTopSnackBar(
        context,
        const CustomSnackBar.info(
          message: "You didn't change anything!",
        ),
        displayDuration: const Duration(seconds: 2),
      );
      return false;
    } else {
      if (state.address.text.isEmpty) {
        state.address.text = BookAppModel.user.address;
      }
      if (state.username.text.isEmpty) {
        state.username.text = BookAppModel.user.username;
      }
      return true;
    }
  }

  void clearInput() {
    state.address.text = '';
    state.username.text = '';
    state.avatarPath = XFile('');
  }

  void updateDecorationImage(
    DecorationImage? decorationImage,
  ) {
    final newState = state.copy(
      decorationImage: decorationImage,
    );
    state = newState;
    if (decorationImage != null) {
      updateIcon(const Icon(
        FontAwesomeIcons.plus,
        color: Colors.transparent,
      ));
    }
  }

  void updateImagePath(XFile a) {
    final newState = state.copy(avatarPath: a);
    state = newState;
  }

  void updateIcon(Icon icon) {
    final newState = state.copy(icon: icon);
    state = newState;
  }

  void changeInformation(BuildContext context) {
    if (state.avatarPath.path == '') {
      setLoadingChangeInformation();
      changeAddress(state.address.text, context);
      changeUsername(state.username.text, context);
      clearInput();
      setLoadingChangeInformation();
    } else {
      updateImageToCloudinary(context);
      setLoadingChangeInformation();
      changeAddress(state.address.text, context);
      changeUsername(state.username.text, context);
      changeAvatarPath(state.avatarPath.path, context);
      clearInput();
      setLoadingChangeInformation();
    }
  }

  void changeAddress(String address, BuildContext context) {
    setLoadingChangeInformation();
    _changeAdressUseCase
        .changeAdress(address, BookAppModel.jwtToken)
        .then((value) {
      setLoadingChangeInformation();
    }).catchError((onError) {
      catchOnError(context, onError);
      setLoadingChangeInformation();
    });
  }

  void changeAvatarPath(String avatarPath, BuildContext context) {
    setLoadingChangeInformation();
    _changeAvatarPathUseCase
        .changeAvatarPath(avatarPath, BookAppModel.jwtToken)
        .then((value) {
      setLoadingChangeInformation();
    }).catchError((onError) {
      catchOnError(context, onError);
      setLoadingChangeInformation();
    });
  }

  void changeUsername(String username, BuildContext context) {
    setLoadingChangeInformation();
    _changeUsernameUseCase
        .changeUsername(username, BookAppModel.jwtToken)
        .then((value) {
      setLoadingChangeInformation();
    }).catchError((onError) {
      catchOnError(context, onError);
      setLoadingChangeInformation();
    });
  }

  void selectImageSource(BuildContext context, ImageSource imageSource) async {
    final pickedImage = await ImagePicker().pickImage(source: imageSource);
    if (pickedImage == null) {
      return;
    }
    updateImagePath(pickedImage);
    updateDecorationImage(
      DecorationImage(
        image: FileImage(File(pickedImage.path)),
        fit: BoxFit.fill,
      ),
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
                selectImageSource(context, ImageSource.camera);
              },
            ),
            CupertinoActionSheetAction(
              child: const Text('Gallery'),
              onPressed: () {
                Navigator.pop(context);
                selectImageSource(context, ImageSource.gallery);
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
              selectImageSource(context, ImageSource.camera);
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_album),
            title: const Text('Gallery'),
            onTap: () {
              Navigator.pop(context);
              selectImageSource(context, ImageSource.gallery);
            },
          ),
        ]),
      );
    }
  }

  void updateImageToCloudinary(context) async {
    final cloudinary = Cloudinary.full(
      apiKey: '735947945251852',
      apiSecret: 'O-Rd18L74ukuNN91I8vrzBJXeGI',
      cloudName: 'du7lkcbqm',
    );

    final response = await cloudinary
        .uploadResource(CloudinaryUploadResource(
            filePath: state.avatarPath.path,
            fileBytes: await state.avatarPath.readAsBytes(),
            resourceType: CloudinaryResourceType.image,
            folder: 'adu',
            fileName: state.avatarPath.name,
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
    });

    if (response.isSuccessful) {
      log('Get your image from with ${response.secureUrl}');
    } else {}
  }
}
