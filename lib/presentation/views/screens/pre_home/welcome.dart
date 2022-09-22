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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Image.asset(
                'assets/images/18.jpg',
                height: 230,
                width: 200,
              ),
              const SizedBox(
                height: 50,
              ),
              Text(
                'Experience reading and sharing \nbooks like never before',
                style: S.textStyles.bigTitle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 60,
              ),
              CustomOutlineButton(
                text: 'EXISTING USER',
                onPress: () {},
                width: 280,
              ),
              const SizedBox(
                height: 10.0,
              ),
              CustomFilledButton(
                width: 280,
                text: 'NEW USER',
                onPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
