import 'package:book_exchange/data/repos/user_repo.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PreHomeSetting {
  // SIGN UP ===================
  final TextEditingController suEmailController;
  final TextEditingController suPasswordController;
  final TextEditingController suConfirmpasswordController;
  //FORGOT PASSWORD
  final TextEditingController fpEmailController;

  bool isLoadingLogin = false;

  PreHomeSetting({
    required this.fpEmailController,
    required this.suEmailController,
    required this.suPasswordController,
    required this.suConfirmpasswordController,
    this.isLoadingLogin = false,
  });

  PreHomeSetting copy({
    TextEditingController? suEmailController,
    TextEditingController? suPasswordController,
    TextEditingController? suConfirmpasswordController,
    TextEditingController? fpEmailController,
    bool? isLoadingLogin,
  }) =>
      PreHomeSetting(
        fpEmailController: fpEmailController ?? this.fpEmailController,
        suEmailController: suEmailController ?? this.suEmailController,
        suPasswordController: suPasswordController ?? this.suPasswordController,
        suConfirmpasswordController:
            suConfirmpasswordController ?? this.suConfirmpasswordController,
        isLoadingLogin: isLoadingLogin ?? this.isLoadingLogin,
      );

  // void clearEmail() {
  //   emailController.clear();
  // }

  //LoginSetting copyWith({}) {return LoginSetting(emailClear: emailClear, isVisible: isVisible, emailController: emailController, passwordController: passwordController)}
}

class PreHomeSettingNotifier extends StateNotifier<PreHomeSetting> {
  PreHomeSettingNotifier(this.ref)
      : super(
          PreHomeSetting(
            fpEmailController: TextEditingController(),
            suConfirmpasswordController: TextEditingController(),
            suEmailController: TextEditingController(),
            suPasswordController: TextEditingController(),
          ),
        ) {
    // _authRepo = ref.watch(authRepoProvider);
    _userRepo = ref.watch(userRepoProvider);
  }

  final Ref ref;
  // late AuthRepo _authRepo;
  late UserRepo _userRepo;
}

final preHomeSettingNotifierProvider =
    StateNotifierProvider<PreHomeSettingNotifier, PreHomeSetting>(
        ((ref) => PreHomeSettingNotifier(ref)));
