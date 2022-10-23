import 'package:book_exchange/presentation/view_models/profile_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final profileNotifierProvider =
    StateNotifierProvider<ProfileNotifier, ProfileSetting>(
        ((ref) => ProfileNotifier(ref)));
