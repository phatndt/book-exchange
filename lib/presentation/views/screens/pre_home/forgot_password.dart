import 'package:book_exchange/presentation/view_models/pre_home_viewmodel.dart';
import 'package:book_exchange/presentation/views/widgets/filled_button.dart';
import 'package:book_exchange/presentation/views/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../colors/colors.dart';

class ForgotPasswordScreen extends ConsumerWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal:
                  (MediaQuery.of(context).size.width - S.size.length_280) / 2),
          child: Column(
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
                    'FORGOT PASSWORD',
                    style: S.textStyles.bigTitle,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              SizedBox(
                height: S.size.length_40,
              ),
              Row(
                children: [
                  // SizedBox(
                  //   width: (MediaQuery.of(context).size.width - 280) / 2,
                  // ),
                  Text(
                    'Let we send you a new \npassword',
                    style: S.textStyles.smallTitle,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              SizedBox(
                height: S.size.length_40,
              ),
              CustomTextField(
                textEditingController:
                    ref.watch(preHomeSettingNotifierProvider).fpEmailController,
                text: 'EMAIL',
                icon: FontAwesomeIcons.envelope,
                obscure: false,
              ),
              SizedBox(
                height: S.size.length_100,
              ),
              CustomFilledButton(
                width: S.size.length_130,
                text: 'CONFIRM',
                onPress: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
