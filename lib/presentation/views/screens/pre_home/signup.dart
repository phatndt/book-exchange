import 'package:book_exchange/presentation/view_models/pre_home_viewmodel.dart';
import 'package:book_exchange/presentation/views/screens/pre_home/forgot_password.dart';
import 'package:book_exchange/presentation/views/widgets/filled_button.dart';
import 'package:book_exchange/presentation/views/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../colors/colors.dart';

class SignUpScreen extends ConsumerWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal:
              (MediaQuery.of(context).size.width - S.size.length_280) / 2,
        ),
        child: SingleChildScrollView(
          child: Column(
            // Listview will include the CustomOutlinedButton to MediaQuery width
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
                    'SIGN UP YOUR ACCOUNT',
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
                    ref.watch(preHomeSettingNotifierProvider).suEmailController,
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
              CustomFilledButton(
                width: S.size.length_130,
                text: 'SIGN UP',
                onPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ForgotPasswordScreen(),
                    ),
                  );
                },
              ),
              // const SizedBox(
              //   height: 0,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
