import 'package:book_exchange/presentation/views/screens/pre_home/login.dart';
import 'package:book_exchange/presentation/views/widgets/filled_button.dart';
import 'package:book_exchange/presentation/views/widgets/outline_button.dart';
import 'package:flutter/material.dart';
import '../../../../colors/colors.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // const SizedBox(
            //   height: 20,
            // ),
            Image.asset(
              'assets/images/20.png',
              height: S.size.length_230,
              width: S.size.length_200,
            ),
            SizedBox(
              height: S.size.length_50,
            ),
            Text(
              'Experience reading and sharing \nbooks like never before',
              style: S.textStyles.bigTitle,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: S.size.length_50,
            ),
            CustomOutlineButton(
              text: 'EXISTING USER',
              onPress: () {},
              width: S.size.length_280,
            ),
            SizedBox(
              height: S.size.length_10,
            ),
            CustomFilledButton(
              width: S.size.length_280,
              text: 'NEW USER',
              onPress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
