import '../entities/api_response.dart';

abstract class ProfileRepo {
  Future<ApiResponse<String>> changePassword(
    String username,
    String oldPassword,
    String newPassword,
    String token,
  );

  Future<ApiResponse<String>> changeAddress(
    String address,
    String token,
  );
  Future<ApiResponse<String>> changeUsername(
    String username,
    String token,
  );
  Future<ApiResponse<String>> changeAvatarPath(
    String avatarPath,
    String token,
  );
}
