import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class ProfileSetting {
  XFile file;
  String avatarPath;

  ProfileSetting({
    required this.file,
    required this.avatarPath,
  });

  ProfileSetting copy({
    XFile? file,
    String? avatarPath,
  }) =>
      ProfileSetting(
        file: file ?? this.file,
        avatarPath: avatarPath ?? this.avatarPath,
      );
}

class ProfileNotifier extends StateNotifier<ProfileSetting> {
  ProfileNotifier(this.ref)
      : super(ProfileSetting(file: XFile(''), avatarPath: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSTTePuOPXGxeejH4JuEO25wUWo-2jSefa3JUOCkwZKcfzi5rw7Z0XgR6-3OON8yrCOIlg&usqp=CAU"));
  final Ref ref;
  setAvatarPath(String path) {
    final newState = state.copy(avatarPath: path);
    state = newState;
  }
}
