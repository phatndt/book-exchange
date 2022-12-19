import 'package:book_exchange/data/mapper/api_response_mapper.dart';
import 'package:book_exchange/data/services/profile_service.dart';
import 'package:book_exchange/domain/entities/api_response.dart';
import 'package:book_exchange/domain/repository/profile_repo.dart';

class ProfileRepoImpl extends ProfileRepo {
  final ProfileService _profileService;

  ProfileRepoImpl(this._profileService);

  @override
  Future<ApiResponse<String>> changePassword(
    String username,
    String oldPassword,
    String newPassword,
    String token,
  ) async {
    return _profileService
        .resetPassword(username, oldPassword, newPassword, token)
        .then((value) => ApiStringResponseMapper().transfer(value));
  }

  @override
  Future<ApiResponse<String>> changeAddress(String address, String token) {
    return _profileService
        .changeAddress(address, token)
        .then((value) => ApiStringResponseMapper().transfer(value));
  }

  @override
  Future<ApiResponse<String>> changeAvatarPath(
      String avatarPath, String token) {
    return _profileService
        .changeAvatarPath(avatarPath, token)
        .then((value) => ApiStringResponseMapper().transfer(value));
  }

  @override
  Future<ApiResponse<String>> changeUsername(String username, String token) {
    return _profileService
        .changeUsername(username, token)
        .then((value) => ApiStringResponseMapper().transfer(value));
  }
}
