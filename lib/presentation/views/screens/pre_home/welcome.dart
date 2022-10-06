import 'package:book_exchange/core/route_paths.dart';
import 'package:book_exchange/presentation/views/screens/pre_home/login.dart';
import 'package:book_exchange/presentation/views/widgets/filled_button.dart';
import 'package:book_exchange/presentation/views/widgets/outline_button.dart';
import 'package:flutter/material.dart';
import '../../../../colors/colors.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: S.size.length_50,
              ),
              Image.asset(
                'assets/logo/logo.png',
                scale: 1,
              ),
              SizedBox(
                height: S.size.length_50,
              ),
              Text(
                'Experience reading and sharing \nbooks like never before',
                style: S.textStyles.mediumTitle,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: S.size.length_50,
              ),
              Column(
                children: [
                  CustomOutlineButton(
                    text: 'EXISTING USER',
                    onPress: () {
                      Navigator.pushNamed(context, RoutePaths.logIn);
                    },
                    width: S.size.length_280,
                  ),
                  SizedBox(
                    height: S.size.length_20,
                  ),
                  CustomFilledButton(
                    width: S.size.length_280,
                    text: 'NEW USER',
                    onPress: () {
                      Navigator.pushNamed(context, RoutePaths.signUp);
                    },
                  ),
                ],
              ),
              SizedBox(
                height: S.size.length_50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
