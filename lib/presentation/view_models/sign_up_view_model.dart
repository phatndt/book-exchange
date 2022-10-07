import 'package:book_exchange/core/extension/function_extension.dart';
import 'package:book_exchange/presentation/views/screens/pre_home/login.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../data/repos/user_repo.dart';

class RegisterSetting {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController usernameController;

  bool isLoadingRegister = false;
  bool isPasswordVisible = true;
  bool isConfirmPasswordVisible = true;

  RegisterSetting({
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.usernameController,
    this.isLoadingRegister = false,
    this.isPasswordVisible = true,
    this.isConfirmPasswordVisible = true,
  });

  RegisterSetting copy({
    TextEditingController? emailController,
    TextEditingController? passwordController,
    TextEditingController? confirmPasswordController,
    TextEditingController? usernameController,
    bool? isLoadingRegister,
    bool? isPasswordVisible,
    bool? isConfirmPasswordVisible,
  }) =>
      RegisterSetting(
        emailController: emailController ?? this.emailController,
        passwordController: passwordController ?? this.passwordController,
        confirmPasswordController:
            confirmPasswordController ?? this.confirmPasswordController,
        usernameController: usernameController ?? this.usernameController,
        isLoadingRegister: isLoadingRegister ?? this.isLoadingRegister,
        isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
        isConfirmPasswordVisible:
            isConfirmPasswordVisible ?? this.isConfirmPasswordVisible,
      );

  void clearEmail() {
    emailController.clear();
  }

  get passwordVisible => isPasswordVisible;
  get loadingRegister => isLoadingRegister;
  get confirmPasswordVisible => isConfirmPasswordVisible;
}

class RegisterSettingNotifier extends StateNotifier<RegisterSetting> {
  RegisterSettingNotifier(this.ref)
      : super(
          RegisterSetting(
            emailController: TextEditingController(),
            passwordController: TextEditingController(),
            confirmPasswordController: TextEditingController(),
            usernameController: TextEditingController(),
            isPasswordVisible: true,
            isLoadingRegister: false,
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

  void setLoadingRegister() {
    final newState = state.copy(isLoadingRegister: !state.isLoadingRegister);
    state = newState;
  }

  void setConfirmPasswordVisible() {
    final newState =
        state.copy(isConfirmPasswordVisible: !state.isConfirmPasswordVisible);
    state = newState;
  }

  void clearEmail() {
    final newState = state.copy(emailController: TextEditingController());
    state = newState;
  }

  void clearUsername() {
    final newState = state.copy(usernameController: TextEditingController());
    state = newState;
  }

  register(context) async {
    if (state.emailController.text.isNotEmpty ||
        state.passwordController.text.isNotEmpty) {
      await _userRepo
          .register(
        state.usernameController.text,
        state.passwordController.text,
        state.emailController.text,
      )
          .then((value) {
        if (value.message == "Register success") {
          setLoadingRegister();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
          showTopSnackBar(
            context,
            CustomSnackBar.info(
              message: value.message,
            ),
            displayDuration: const Duration(seconds: 2),
          );
        } else {
          setLoadingRegister();
          showTopSnackBar(
            context,
            const CustomSnackBar.info(
              message: "Error when register. Please try later!",
            ),
            displayDuration: const Duration(seconds: 2),
          );
        }
      }).catchError(
        (onError) {
          setLoadingRegister();
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
      setLoadingRegister();
      showTopSnackBar(
        context,
        const CustomSnackBar.info(
          message: "Please enter username and password",
        ),
      );
    }
  }

  checkExistUsername(context) async {
    setLoadingRegister();
    if (state.emailController.text.isNotEmpty ||
        state.passwordController.text.isNotEmpty ||
        state.usernameController.text.isNotEmpty ||
        state.confirmPasswordController.text.isNotEmpty) {
      await _userRepo
          .checkExistUsername(state.usernameController.text)
          .then((value) {
        if (value.data) {
          setLoadingRegister();
          showTopSnackBar(
            context,
            CustomSnackBar.info(
              message: value.message,
            ),
            displayDuration: const Duration(seconds: 2),
          );
        } else {
          register(context);
        }
      }).catchError(
        (onError) {
          setLoadingRegister();
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
      setLoadingRegister();
      showTopSnackBar(
        context,
        const CustomSnackBar.info(
          message: "Please enter information!",
        ),
      );
    }
  }
}

final registerSettingNotifierProvider =
    StateNotifierProvider<RegisterSettingNotifier, RegisterSetting>(
        ((ref) => RegisterSettingNotifier(ref)));
