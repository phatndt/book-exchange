import 'package:dio/dio.dart';

import '../entities/api_response_dto.dart';
import '../entities/jwt_response_dto.dart';
import 'dio_exception.dart';
import 'dio_service.dart';
import 'end_points.dart';

class AuthService {
  Future<ApiResponseDTO<JwtResponseDTO>> login(
    String username,
    String password,
  ) async {
    try {
      final body = {
        "username": username,
        "password": password,
      };
      final response = await DioService().dio.post(Endpoints.login, data: body);
      return ApiResponseDTO<JwtResponseDTO>(
        data: JwtResponseDTO.fromMap(response.data['data']),
        statusCode: response.data['statusCode'],
        message: response.data['message'],
      );
    } on DioError catch (e) {
      throw DioExceptions.fromDioError(e).toString();
    }
  }

  
  Future<ApiResponseDTO<String>> register(
    String username,
    String password,
    String email,
  ) async {
    try {
      final body = {
        "username": username,
        "password": password,
        "email": email,
      };
      final response =
          await DioService().dio.post(Endpoints.register, data: body);
      return ApiResponseDTO<String>(
        data: response.data['data'],
        statusCode: response.data['statusCode'],
        message: response.data['message'],
      );
    } on DioError catch (e) {
      throw DioExceptions.fromDioError(e).toString();
    }
  }

  Future<ApiResponseDTO<bool>> checkExistUsername(
    String username,
  ) async {
    try {
      final body = {
        "username": username,
      };
      final response = await DioService().dio.post(
            Endpoints.username,
            data: body,
          );
      return ApiResponseDTO<bool>(
        data: response.data['data'],
        statusCode: response.data['statusCode'],
        message: response.data['message'],
      );
    } on DioError catch (e) {
      throw DioExceptions.fromDioError(e).toString();
    }
  }

  Future<ApiResponseDTO<String>> resetPassword(
    String username,
    String oldPassword,
    String newPassword,
    String token,
  ) async {
    try {
      final body = {
        "username": username,
        "oldPassword": oldPassword,
        "newPassword": newPassword
      };
      final response = await DioService().dio.post(Endpoints.changePassword,
          data: body,
          options: Options(headers: {"Authorization": "Bearer $token"}));
      return ApiResponseDTO<String>(
        data: response.data['data'],
        statusCode: response.data['statusCode'],
        message: response.data['message'],
      );
    } on DioError catch (e) {
      throw DioExceptions.fromDioError(e);
    }
  }
}