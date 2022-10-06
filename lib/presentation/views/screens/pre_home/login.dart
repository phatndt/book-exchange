import 'dart:developer';

import 'package:book_exchange/core/route_paths.dart';
import 'package:flutter/foundation.dart';
import 'package:book_exchange/presentation/views/screens/pre_home/signup.dart';
import 'package:book_exchange/presentation/views/widgets/filled_button.dart';
import 'package:book_exchange/presentation/views/widgets/outline_button.dart';
import 'package:book_exchange/presentation/views/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../colors/colors.dart';

import '../../../view_models/login_viewmodel.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
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
                  'WELCOME BACK',
                  style: S.textStyles.login.bigTitle,
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: S.size.length_40,
                ),
                CustomTextField(
                  textEditingController:
                      ref.watch(loginSettingNotifierProvider).emailController,
                  text: 'Email',
                  obscure: false,
                ),
                SizedBox(
                  height: S.size.length_20,
                ),
                CustomTextField(
                  textEditingController: ref
                      .watch(loginSettingNotifierProvider)
                      .passwordController,
                  text: 'Password',
                  icon:
                      ref.watch(loginSettingNotifierProvider).isPasswordVisible
                          ? FontAwesomeIcons.eye
                          : FontAwesomeIcons.eyeLowVision,
                  obscure:
                      ref.watch(loginSettingNotifierProvider).isPasswordVisible,
                  onClickSuffixIcon: () {
                    ref
                        .watch(loginSettingNotifierProvider.notifier)
                        .setPasswordVisible();
                    log(ref
                        .watch(loginSettingNotifierProvider)
                        .isPasswordVisible
                        .toString());
                  },
                ),
                SizedBox(
                  height: S.size.length_50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomOutlineButton(
                      width: S.size.length_100,
                      text: 'SIGN UP',
                      onPress: () {
                        FocusScope.of(context).unfocus();
                        Navigator.pushNamed(context, RoutePaths.signUp);
                      },
                    ),
                    CustomFilledButton(
                      width: S.size.length_100,
                      text: 'SIGN IN',
                      onPress: () {
                        FocusScope.of(context).unfocus();
                        ref
                            .watch(loginSettingNotifierProvider.notifier)
                            .login(context);
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: S.size.length_40,
                ),
                GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    Navigator.pushNamed(
                      context,
                      RoutePaths.forgot,
                    );
                  },
                  child: Center(
                    child: Text(
                      'Forgot Password?',
                      style: S.textStyles.login.smallTitle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
