import 'package:dio/dio.dart';
import '../entities/api_response_dto.dart';
import 'dio_exception.dart';
import 'dio_service.dart';
import 'end_points.dart';

class ProfileService {
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
