import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../data/repos/profile_repo_impl.dart';
import '../../data/services/profile_service.dart';
import '../../domain/use_cases/change_password_use_case_impl.dart';
import '../view_models/profile_view_model.dart';

final profileServiceProvider =
    Provider<ProfileService>((ref) => ProfileService());

final profileRepoProvider = Provider<ProfileRepoImpl>(
    (ref) => ProfileRepoImpl(ref.watch(profileServiceProvider)));

final changePasswordUserCaseProvider = Provider<ChangePasswordUseCaseImpl>(
    (ref) => ChangePasswordUseCaseImpl(ref.watch(profileRepoProvider)));

final profileSettingNotifierProvider =
    StateNotifierProvider<ProfileSettingNotifier, ProfileSetting>(((ref) =>
        ProfileSettingNotifier(
            ref, ref.watch(changePasswordUserCaseProvider))));
