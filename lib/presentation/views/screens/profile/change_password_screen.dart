import 'package:book_exchange/core/custom_text_form_fill.dart';
import 'package:book_exchange/presentation/view_models/profile_view_model.dart';
import 'package:book_exchange/presentation/views/widgets/filled_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../colors/colors.dart';
import '../../../../core/app_bar.dart';
import '../../widgets/text_field.dart';

class ChangePasswordScreen extends ConsumerWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: ModalProgressHUD(
        inAsyncCall: ref.watch(profileSettingNotifierProvider).isLoadingProfile,
        child: Scaffold(
          backgroundColor: S.colors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(S.size.length_50),
            child: const AppBarImpl(
              title: 'Change password',
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: S.size.length_20,
                    horizontal: S.size.length_20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Old password',
                        style: S.textStyles.titleText,
                      ),
                      CustomTextFormField(
                        controller: ref
                            .watch(profileSettingNotifierProvider)
                            .oldPassword,
                        hintText: 'Old password',
                        obscureText: ref
                            .watch(profileSettingNotifierProvider)
                            .isOldPasswordVisible,
                        suffixIconData: InkWell(
                          onTap: () {
                            ref
                                .watch(profileSettingNotifierProvider.notifier)
                                .setOldPasswordVisible();
                          },
                          child: Icon(
                            ref
                                    .watch(profileSettingNotifierProvider)
                                    .isOldPasswordVisible
                                ? FontAwesomeIcons.eye
                                : FontAwesomeIcons.eyeLowVision,
                            size: 18,
                            color: S.colors.black,
                          ),
                        ),
                      ),
                      Text(
                        'New password',
                        style: S.textStyles.titleText,
                      ),
                      CustomTextFormField(
                        controller: ref
                            .watch(profileSettingNotifierProvider)
                            .passwordController,
                        hintText: 'New password',
                        obscureText: ref
                            .watch(profileSettingNotifierProvider)
                            .passwordVisible,
                        suffixIconData: InkWell(
                          onTap: () {
                            ref
                                .watch(profileSettingNotifierProvider.notifier)
                                .setPasswordVisible();
                          },
                          child: Icon(
                            ref
                                    .watch(profileSettingNotifierProvider)
                                    .passwordVisible
                                ? FontAwesomeIcons.eye
                                : FontAwesomeIcons.eyeLowVision,
                            size: 18,
                            color: S.colors.black,
                          ),
                        ),
                      ),
                      Text(
                        'Confirm password',
                        style: S.textStyles.titleText,
                      ),
                      CustomTextFormField(
                        controller: ref
                            .watch(profileSettingNotifierProvider)
                            .confirmPassword,
                        hintText: 'Confirm password',
                        obscureText: ref
                            .watch(profileSettingNotifierProvider)
                            .confirmPasswordVisible,
                        suffixIconData: InkWell(
                          onTap: () {
                            ref
                                .watch(profileSettingNotifierProvider.notifier)
                                .setConfirmPasswordVisible();
                          },
                          child: Icon(
                            ref
                                    .watch(profileSettingNotifierProvider)
                                    .confirmPasswordVisible
                                ? FontAwesomeIcons.eye
                                : FontAwesomeIcons.eyeLowVision,
                            size: 18,
                            color: S.colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: S.size.length_40,
                      ),
                      Center(
                        child: CustomFilledButton(
                          width: MediaQuery.of(context).size.width,
                          text: "Change password",
                          onPress: () {
                            ref
                                .watch(profileSettingNotifierProvider.notifier)
                                .changePassword(context);
                          },
                        ),
                      ),
                    ],
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
