import 'package:book_exchange/core/route_paths.dart';
import 'package:book_exchange/presentation/view_models/pre_home_viewmodel.dart';
import 'package:book_exchange/presentation/view_models/sign_up_view_model.dart';
import 'package:book_exchange/presentation/views/screens/pre_home/forgot_password.dart';
import 'package:book_exchange/presentation/views/widgets/filled_button.dart';
import 'package:book_exchange/presentation/views/widgets/outline_button.dart';
import 'package:book_exchange/presentation/views/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../../colors/colors.dart';

class SignUpScreen extends ConsumerWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: ModalProgressHUD(
        inAsyncCall:
            ref.watch(registerSettingNotifierProvider).isLoadingRegister,
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: S.size.length_40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: S.size.length_40,
                  ),
                  Image.asset(
                    'assets/logo/logo_other.png',
                    scale: 1,
                  ),
                  SizedBox(
                    height: S.size.length_40,
                  ),
                  Text(
                    'SIGN UP YOUR ACCOUNT',
                    style: S.textStyles.login.bigTitle,
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    height: S.size.length_40,
                  ),
                  CustomTextField(
                    textEditingController: ref
                        .watch(registerSettingNotifierProvider)
                        .emailController,
                    text: 'Email',
                    icon: FontAwesomeIcons.xmark,
                    obscure: false,
                    onClickSuffixIcon: () {
                      ref
                          .watch(registerSettingNotifierProvider.notifier)
                          .clearEmail();
                    },
                  ),
                  SizedBox(
                    height: S.size.length_20,
                  ),
                  CustomTextField(
                    textEditingController: ref
                        .watch(registerSettingNotifierProvider)
                        .usernameController,
                    text: 'Username',
                    icon: FontAwesomeIcons.xmark,
                    obscure: false,
                    onClickSuffixIcon: () {
                      ref
                          .watch(registerSettingNotifierProvider.notifier)
                          .clearUsername();
                    },
                  ),
                  SizedBox(
                    height: S.size.length_20,
                  ),
                  CustomTextField(
                    textEditingController: ref
                        .watch(registerSettingNotifierProvider)
                        .passwordController,
                    text: 'Password',
                    icon: ref
                            .watch(registerSettingNotifierProvider)
                            .passwordVisible
                        ? FontAwesomeIcons.eye
                        : FontAwesomeIcons.eyeLowVision,
                    obscure: ref
                        .watch(registerSettingNotifierProvider)
                        .passwordVisible,
                    onClickSuffixIcon: () {
                      ref
                          .watch(registerSettingNotifierProvider.notifier)
                          .setPasswordVisible();
                    },
                  ),
                  SizedBox(
                    height: S.size.length_20,
                  ),
                  CustomTextField(
                    textEditingController: ref
                        .watch(registerSettingNotifierProvider)
                        .confirmPasswordController,
                    text: 'Confirm Password',
                    icon: ref
                            .watch(registerSettingNotifierProvider)
                            .confirmPasswordVisible
                        ? FontAwesomeIcons.eye
                        : FontAwesomeIcons.eyeLowVision,
                    obscure: ref
                        .watch(registerSettingNotifierProvider)
                        .confirmPasswordVisible,
                    onClickSuffixIcon: () {
                      ref
                          .watch(registerSettingNotifierProvider.notifier)
                          .setConfirmPasswordVisible();
                    },
                  ),
                  SizedBox(
                    height: S.size.length_50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomOutlineButton(
                        width: S.size.length_130,
                        text: 'SIGN IN',
                        onPress: () {
                          Navigator.pushNamed(
                            context,
                            RoutePaths.logIn,
                          );
                        },
                      ),
                      CustomFilledButton(
                        width: S.size.length_130,
                        text: 'SIGN UP',
                        onPress: () {
                          ref
                              .watch(registerSettingNotifierProvider.notifier)
                              .checkExistUsername(context);
                        },
                      ),
                    ],
                  ),
                  // const SizedBox(
                  //   height: 0,
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
