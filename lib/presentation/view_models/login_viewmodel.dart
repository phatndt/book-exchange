import 'package:book_exchange/core/extension/function_extension.dart';
import 'package:book_exchange/core/route_paths.dart';
import 'package:flutter/material.dart';
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
  get loadingLogin => isLoadingLogin;
}

class LoginSettingNotifier extends StateNotifier<LoginSetting> {
  LoginSettingNotifier(this.ref)
      : super(
          LoginSetting(
            emailController: TextEditingController(),
            passwordController: TextEditingController(),
            isPasswordVisible: true,
            isLoadingLogin: false,
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

  void cleanEmail() {
    final newState = state.copy(emailController: TextEditingController());
    state = newState;
  }

  void setLoadingLogin() {
    final newState = state.copy(isLoadingLogin: !state.isLoadingLogin);
    state = newState;
  }

  login(context) async {
    setLoadingLogin();
    if (state.emailController.text.isNotEmpty ||
        state.passwordController.text.isNotEmpty) {
      await _userRepo
          .login(state.emailController.text, state.passwordController.text)
          .then((value) {
        value.data.token.ifNotEmpty(
          () => {
            setLoadingLogin(),
            _userRepo.jwtToken = value.data.token,
            _userRepo.user = value.data.user,
            Navigator.pushNamedAndRemoveUntil(
                context, RoutePaths.main, (route) => false),
            state.emailController.clear(),
            state.passwordController.clear(),
          },
          () => {
            showTopSnackBar(
              context,
              const CustomSnackBar.info(
                message: "Error when register. Please try later!",
              ),
              displayDuration: const Duration(seconds: 2),
            )
          },
        );
      }).catchError(
        (onError) {
          setLoadingLogin();
          showTopSnackBar(
            context,
            CustomSnackBar.info(
              message: "Error: $onError",
            ),
            displayDuration: const Duration(seconds: 2),
          );
        },
      );
    } else {
      setLoadingLogin();
      showTopSnackBar(
        context,
        const CustomSnackBar.info(
          message: "Please enter username and password",
        ),
      );
    }
  }
}

final loginSettingNotifierProvider =
    StateNotifierProvider.autoDispose<LoginSettingNotifier, LoginSetting>(
        ((ref) => LoginSettingNotifier(ref)));
