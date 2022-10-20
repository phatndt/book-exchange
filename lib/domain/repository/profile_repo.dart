
import '../entities/api_response.dart';

abstract class ProfileRepo {

  Future<ApiResponse<String>> changePassword(
    String username,
     String oldPassword,
     String newPassword,
     String token,
  );
}
