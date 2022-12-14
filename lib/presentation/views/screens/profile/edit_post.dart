import 'package:hooks_riverpod/hooks_riverpod.dart';

class EditPostState {}

class EditPostStateNotifier extends StateNotifier<EditPostState> {
  EditPostStateNotifier(this.ref) : super(EditPostState());

  Ref ref;
}
