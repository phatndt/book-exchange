import 'package:book_exchange/presentation/di/book_contribution_component.dart';
import 'package:book_exchange/presentation/di/changing_password_component.dart';
import 'package:book_exchange/presentation/di/profile_component.dart';
import 'package:book_exchange/presentation/models/book_app_model.dart';
import 'package:book_exchange/presentation/views/widgets/filled_button.dart';
import 'package:book_exchange/presentation/views/widgets/filled_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../core/colors/colors.dart';
import '../../../../core/custom_text_form_fill.dart';

class ChangeInformationScreen extends ConsumerWidget {
  const ChangeInformationScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: ModalProgressHUD(
        inAsyncCall: ref
            .watch(changeInformationNotifierProvider)
            .isLoadingChangeInformation,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(S.size.length_50Vertical),
            child: AppBar(
              centerTitle: true,
              title: const Text("Change your information"),
              leading: BackButton(onPressed: () {
                ref
                    .watch(changeInformationNotifierProvider.notifier)
                    .clearInput();
                // ref
                //     .watch(changeInformationNotifierProvider.notifier)
                //     .updateDecorationImage(DecorationImage(
                //         image: NetworkImage(
                //             ref.watch(profileNotifierProvider).avatarPath)));
                Navigator.pop(context);
              }),
            ),
          ),
          backgroundColor: S.colors.white,
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: S.size.length_20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: S.size.length_20Vertical,
                  ),
                  Center(
                    child: Container(
                      width: S.size.length_130,
                      height: S.size.length_170Vertical,
                      decoration: BoxDecoration(
                        color: S.colors.accent_8,
                        borderRadius: BorderRadius.all(
                          Radius.circular(S.size.length_8),
                        ),
                        image: ref
                            .watch(changeInformationNotifierProvider)
                            .decorationImage,
                      ),
                      child: TextButton(
                        onPressed: () {
                          ref
                              .watch(changeInformationNotifierProvider.notifier)
                              .showImageSourceActionSheet(context);
                        },
                        child:
                            ref.watch(changeInformationNotifierProvider).icon,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: S.size.length_20Vertical,
                  ),
                  SizedBox(
                    height: S.size.length_20Vertical,
                  ),
                  Text(
                    'Username',
                    style: S.textStyles.titleText,
                  ),
                  CustomTextFormField(
                    hintText: BookAppModel.user.username,
                    controller:
                        ref.watch(changeInformationNotifierProvider).username,
                    suffixIconData: IconButton(
                      onPressed: ref
                          .watch(changeInformationNotifierProvider)
                          .username
                          .clear,
                      icon: const Icon(FontAwesomeIcons.eraser),
                    ),
                    obscureText: false,
                  ),
                  Text(
                    'Address',
                    style: S.textStyles.titleText,
                  ),
                  CustomTextFormField(
                    hintText: BookAppModel.user.address,
                    controller:
                        ref.watch(changeInformationNotifierProvider).address,
                    obscureText: false,
                    suffixIconData: IconButton(
                      onPressed: ref
                          .watch(changeInformationNotifierProvider)
                          .address
                          .clear,
                      icon: const Icon(FontAwesomeIcons.eraser),
                    ),
                  ),
                  Center(
                    child: CustomFilledButton(
                      width: MediaQuery.of(context).size.width,
                      text: 'CHANGE INFORMATION',
                      onPress: () {
                        if (ref
                            .watch(changeInformationNotifierProvider.notifier)
                            .checkInput(context)) {
                          ref
                              .watch(changeInformationNotifierProvider.notifier)
                              .changeInformation(context);
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: S.size.length_40Vertical,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
