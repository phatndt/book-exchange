import 'package:book_exchange/presentation/views/widgets/filled_button.dart';
import 'package:book_exchange/presentation/views/widgets/outline_button.dart';
import 'package:book_exchange/presentation/views/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../colors/colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: (MediaQuery.of(context).size.width - 280) / 2,
          ),
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  // SizedBox(
                  //   width: (MediaQuery.of(context).size.width - 280) / 2,
                  // ),
                  Image.asset(
                    'assets/images/18.jpg',
                    height: 230,
                    width: 200,
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
              const SizedBox(
                height: 30,
              ),
              const CustomTextField(
                text: 'Email',
                icon: FontAwesomeIcons.envelope,
                obscure: false,
              ),
              const SizedBox(
                height: 15,
              ),
              const CustomTextField(
                text: 'Password',
                icon: FontAwesomeIcons.key,
                obscure: true,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomOutlineButton(
                    width: 95,
                    text: 'SIGN UP',
                    onPress: () {},
                  ),
                  CustomFilledButton(
                    width: 95,
                    text: 'SIGN IN',
                    onPress: () {},
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'Forgot Password?',
                  style: S.textStyles.smallTitle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
