import 'package:book_exchange/data/repos/auth_repo_impl.dart';
import 'package:book_exchange/data/services/auth_service.dart';
import 'package:book_exchange/domain/use_cases/check_exist_username_use_case_impl.dart';
import 'package:book_exchange/domain/use_cases/login_use_case_impl.dart';
import 'package:book_exchange/domain/use_cases/register_use_case_impl.dart';
import 'package:book_exchange/presentation/view_models/sign_up_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../view_models/login_viewmodel.dart';

final authServiceProvider = Provider<AuthService>((ref) => AuthService());

final authRepoProvider = Provider<AuthRepoImpl>(
    (ref) => AuthRepoImpl(ref.watch(authServiceProvider)));

final loginUseCaseProvider = Provider<LoginUseCaseImpl>(
    (ref) => LoginUseCaseImpl(ref.watch(authRepoProvider)));

final loginSettingNotifierProvider =
    StateNotifierProvider.autoDispose<LoginSettingNotifier, LoginSetting>(
        ((ref) => LoginSettingNotifier(ref, ref.watch(loginUseCaseProvider))));

final checkExistUsernameUseCaseProvider =
    Provider<CheckExistUsernameUseCaseImpl>(
        (ref) => CheckExistUsernameUseCaseImpl(ref.watch(authRepoProvider)));

final registerUseCaseProvider = Provider<RegisterUseCaseImpl>(
    (ref) => RegisterUseCaseImpl(ref.watch(authRepoProvider)));

final registerSettingNotifierProvider =
    StateNotifierProvider<RegisterSettingNotifier, RegisterSetting>(((ref) =>
        RegisterSettingNotifier(
            ref,
            ref.watch(checkExistUsernameUseCaseProvider),
            ref.watch(registerUseCaseProvider))));


