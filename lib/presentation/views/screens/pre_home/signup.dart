import 'package:book_exchange/core/route_paths.dart';
import 'package:book_exchange/presentation/view_models/pre_home_viewmodel.dart';
import 'package:book_exchange/presentation/views/screens/pre_home/forgot_password.dart';
import 'package:book_exchange/presentation/views/widgets/filled_button.dart';
import 'package:book_exchange/presentation/views/widgets/outline_button.dart';
import 'package:book_exchange/presentation/views/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../colors/colors.dart';

class SignUpScreen extends ConsumerWidget {
  const SignUpScreen({Key? key}) : super(key: key);

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
                  'SIGN UP YOUR ACCOUNT',
                  style: S.textStyles.login.bigTitle,
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: S.size.length_40,
                ),
                CustomTextField(
                  textEditingController: ref
                      .watch(preHomeSettingNotifierProvider)
                      .suEmailController,
                  text: 'Email',
                  icon: FontAwesomeIcons.envelope,
                  obscure: false,
                ),
                SizedBox(
                  height: S.size.length_20,
                ),
                CustomTextField(
                  textEditingController: ref
                      .watch(preHomeSettingNotifierProvider)
                      .suEmailController,
                  text: 'Username',
                  icon: FontAwesomeIcons.user,
                  obscure: false,
                ),
                SizedBox(
                  height: S.size.length_20,
                ),
                CustomTextField(
                  textEditingController: ref
                      .watch(preHomeSettingNotifierProvider)
                      .suPasswordController,
                  text: 'Password',
                  icon: FontAwesomeIcons.key,
                  obscure: true,
                ),
                SizedBox(
                  height: S.size.length_20,
                ),
                CustomTextField(
                  textEditingController: ref
                      .watch(preHomeSettingNotifierProvider)
                      .suConfirmpasswordController,
                  text: 'Confirm Password',
                  icon: FontAwesomeIcons.key,
                  obscure: true,
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
                      onPress: () {},
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
    );
  }
}
