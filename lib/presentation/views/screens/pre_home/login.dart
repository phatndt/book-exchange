import 'package:book_exchange/presentation/views/screens/pre_home/signup.dart';
import 'package:book_exchange/presentation/views/widgets/filled_button.dart';
import 'package:book_exchange/presentation/views/widgets/outline_button.dart';
import 'package:book_exchange/presentation/views/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../colors/colors.dart';

import '../../../view_models/login_viewmodels.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal:
              (MediaQuery.of(context).size.width - S.size.length_280) / 2,
        ),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: S.size.length_20,
            ),
            Row(
              children: [
                // SizedBox(
                //   width: (MediaQuery.of(context).size.width - 280) / 2,
                // ),
                Image.asset(
                  'assets/images/18.jpg',
                  height: S.size.length_200,
                  width: S.size.length_170,
                ),
              ],
            ),
            Row(
              children: [
                // SizedBox(
                //   width: (MediaQuery.of(context).size.width - 280) / 2,
                // ),
                Text(
                  'WELCOME BACK',
                  style: S.textStyles.bigTitle,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
            SizedBox(
              height: S.size.length_40,
            ),
            CustomTextField(
              textEditingController:
                  ref.watch(loginSettingNotifierProvider).emailController,
              text: 'Email',
              icon: FontAwesomeIcons.envelope,
              obscure: false,
            ),
            SizedBox(
              height: S.size.length_20,
            ),
            CustomTextField(
              textEditingController:
                  ref.watch(loginSettingNotifierProvider).passwordController,
              text: 'Password',
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
                  width: S.size.length_100,
                  text: 'SIGN UP',
                  onPress: () {
                    ref.watch(loginSettingNotifierProvider.notifier).login();
                  },
                ),
                CustomFilledButton(
                  width: S.size.length_100,
                  text: 'SIGN IN',
                  onPress: () {},
                ),
              ],
            ),
            SizedBox(
              height: S.size.length_40,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignUpScreen(),
                  ),
                );
              },
              child: Text(
                'Forgot Password?',
                style: S.textStyles.smallTitle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
