import 'package:book_exchange/data/mapper/api_response_mapper.dart';
import 'package:book_exchange/data/services/auth_service.dart';
import 'package:book_exchange/domain/entities/jwt_response.dart';
import 'package:book_exchange/domain/repository/auth_repo.dart';

import '../../domain/entities/api_response.dart';

class AuthRepoImpl extends AuthRepo {
  final AuthService _authService;

  AuthRepoImpl(this._authService);

  @override
  Future<ApiResponse<JwtResponse>> login(
    String username,
    String password,
  ) async {
    return await _authService.login(username, password).then(
          (value) => ApiJwtResponseMapper().transfer(value),
        );
  }

  @override
  Future<ApiResponse<bool>> checkExistUsername(String username) async {
    return await _authService.checkExistUsername(username).then(
          (value) => ApiBoolResponseMapper().transfer(value),
        );
  }

  @override
  Future<ApiResponse<String>> register(
      String username, String password, String email) async {
    return await _authService.register(username, password, email).then(
          (value) => ApiStringResponseMapper().transfer(value),
        );
  }

  @override
  Future<ApiResponse<String>> resetPassword(String username, String oldPassword,
      String newPassword, String token) async {
    return await _authService
        .resetPassword(username, oldPassword, newPassword, token)
        .then(
          (value) => ApiStringResponseMapper().transfer(value),
        );
  }
}
