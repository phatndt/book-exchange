import 'dart:developer';

import 'package:book_exchange/presentation/views/screens/home/home.dart';
import 'package:book_exchange/presentation/views/screens/home/library/collection.dart';
import 'package:book_exchange/presentation/views/screens/home/library/share.dart';
import 'package:book_exchange/presentation/views/screens/pre_home/welcome.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../data/repos/user_repo.dart';

class LoginSetting {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  bool isLoadingLogin = false;
  bool isPasswordVisible = true;

  LoginSetting({
    required this.emailController,
    required this.passwordController,
    this.isLoadingLogin = false,
    this.isPasswordVisible = true,
  });

  LoginSetting copy({
    TextEditingController? emailController,
    TextEditingController? passwordController,
    bool? isLoadingLogin,
    bool? isPasswordVisible,
  }) =>
      LoginSetting(
        emailController: emailController ?? this.emailController,
        passwordController: passwordController ?? this.passwordController,
        isLoadingLogin: isLoadingLogin ?? this.isLoadingLogin,
        isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      );

  void clearEmail() {
    emailController.clear();
  }

  get passwordVisible => isPasswordVisible;
}

class LoginSettingNotifier extends StateNotifier<LoginSetting> {
  LoginSettingNotifier(this.ref)
      : super(
          LoginSetting(
            emailController: TextEditingController(),
            passwordController: TextEditingController(),
            isPasswordVisible: true,
          ),
        ) {
    // _authRepo = ref.watch(authRepoProvider);
    _userRepo = ref.watch(userRepoProvider);
  }

  final Ref ref;
  // late AuthRepo _authRepo;
  late UserRepo _userRepo;

  void setPasswordVisible() {
    final newState = state.copy(isPasswordVisible: !state.isPasswordVisible);
    state = newState;
  }

  login(context) async {
    if (state.emailController.text.isNotEmpty ||
        state.passwordController.text.isNotEmpty) {
      await _userRepo
          .login(state.emailController.text, state.passwordController.text)
          .then((value) {
        value.data.token.ifNotEmpty(() => {
              _userRepo.jwtToken = value.data.token,
              _userRepo.user = value.data.user,
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              ),
            });
      }).catchError(
        (onError) {
          showTopSnackBar(
            context,
            CustomSnackBar.error(
              message: "Lỗi: $onError",
            ),
            displayDuration: const Duration(seconds: 2),
          );
        },
      );
    } else {
      showTopSnackBar(
        context,
        const CustomSnackBar.error(
          message: "Vui lòng điền đầy đủ thông tin",
        ),
      );
    }
  }
}

final loginSettingNotifierProvider =
    StateNotifierProvider<LoginSettingNotifier, LoginSetting>(
        ((ref) => LoginSettingNotifier(ref)));

extension Ext on Object? {
  void ifNotEmpty(Function() action) {
    if (this != "") {
      action();
    }
  }
}
