import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/repos/user_repo.dart';

class LoginSetting {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  bool isLoadingLogin = false;

  LoginSetting({
    required this.emailController,
    required this.passwordController,
    this.isLoadingLogin = false,
  });

  LoginSetting copy({
    TextEditingController? emailController,
    TextEditingController? passwordController,
    bool? isLoadingLogin,
  }) =>
      LoginSetting(
        emailController: emailController ?? this.emailController,
        passwordController: passwordController ?? this.passwordController,
        isLoadingLogin: isLoadingLogin ?? this.isLoadingLogin,
      );

  void clearEmail() {
    emailController.clear();
  }

  //LoginSetting copyWith({}) {return LoginSetting(emailClear: emailClear, isVisible: isVisible, emailController: emailController, passwordController: passwordController)}
}

class LoginSettingNotifier extends StateNotifier<LoginSetting> {
  LoginSettingNotifier(this.ref)
      : super(
          LoginSetting(
            emailController: TextEditingController(),
            passwordController: TextEditingController(),
          ),
        ) {
    // _authRepo = ref.watch(authRepoProvider);
    _userRepo = ref.watch(userRepoProvider);
  }

  final Ref ref;
  // late AuthRepo _authRepo;
  late UserRepo _userRepo;

  login() async {
    if (state.emailController.text.isNotEmpty ||
        state.passwordController.text.isNotEmpty) {
      final jwt = await _userRepo.login(
          state.emailController.text, state.passwordController.text);
      if (jwt != null) {
        debugPrint(jwt.token);
      } else {
        debugPrint('------------------------');
      }
    } else {
      Fluttertoast.showToast(msg: 'Please fill up the blank!');
    }
  }
}

final loginSettingNotifierProvider =
    StateNotifierProvider<LoginSettingNotifier, LoginSetting>(
        ((ref) => LoginSettingNotifier(ref)));
