import '../entities/api_response.dart';
import '../entities/jwt_response.dart';

abstract class AuthRepo {
  Future<ApiResponse<JwtResponse>> login(
    String username,
    String password,
  );

  Future<ApiResponse<String>> register(
    String username,
    String password,
    String email,
  );

  Future<ApiResponse<bool>> checkExistUsername(
    String username,
  );

  Future<ApiResponse<String>> resetPassword(
    String username,
    String oldPassword,
    String newPassword,
    String token,
  );
}
