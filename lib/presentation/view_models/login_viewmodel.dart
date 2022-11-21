import 'dart:developer';

import 'package:book_exchange/core/extension/function_extension.dart';
import 'package:book_exchange/core/route_paths.dart';
import 'package:book_exchange/presentation/di/profile_component.dart';
import 'package:book_exchange/presentation/models/book_app_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../../domain/use_cases/auth/login_use_case.dart';

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
  LoginSettingNotifier(this.ref, this._loginUseCaseImpl)
      : super(
          LoginSetting(
            emailController: TextEditingController(),
            passwordController: TextEditingController(),
            isPasswordVisible: true,
            isLoadingLogin: false,
          ),
        );

  final Ref ref;
  final LoginUseCase _loginUseCaseImpl;

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
      await _loginUseCaseImpl
          .login(state.emailController.text, state.passwordController.text)
          .then(
        (value) {
          setLoadingLogin();
          BookAppModel.userRegistrationId = value.data.user.id;
          value.data.token.ifNotEmpty(
            () {
              BookAppModel.user = value.data.user;
              BookAppModel.jwtToken = value.data.token;
              Navigator.pushNamedAndRemoveUntil(
                  context, RoutePaths.main, (route) => false);
              state.emailController.clear();
              state.passwordController.clear();
              ref
                  .watch(profileNotifierProvider.notifier)
                  .setAvatarPath(BookAppModel.user.image);
            },
            () => {
              showTopSnackBar(
                context,
                const CustomSnackBar.info(
                  message: "Error when login. Please try later!",
                ),
                displayDuration: const Duration(seconds: 2),
              )
            },
            () => {
              Navigator.pushNamedAndRemoveUntil(
                context,
                RoutePaths.verifyEmail,
                (route) => false,
              )
            },
          );
        },
      ).catchError(
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

  Future<void> startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            '#ff6666', 'Cancel', true, ScanMode.BARCODE)!
        .listen((barcode) => log(barcode));
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      log(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }
}
