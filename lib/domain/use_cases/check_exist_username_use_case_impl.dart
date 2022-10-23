
import 'package:book_exchange/domain/repository/auth_repo.dart';
import 'package:book_exchange/domain/use_cases/check_exist_username_use_case.dart';

import '../entities/api_response.dart';

class CheckExistUsernameUseCaseImpl extends CheckExistUsernameUseCase {
  final AuthRepo _authRepo;

  CheckExistUsernameUseCaseImpl(this._authRepo);

  @override
  Future<ApiResponse<bool>> checkExistUsername(String username) async {
    return await _authRepo.checkExistUsername(username);
  }
}
