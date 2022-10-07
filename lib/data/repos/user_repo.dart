import 'dart:developer';

import 'package:book_exchange/data/entities/api_response.dart';
import 'package:book_exchange/data/services/dio_exception.dart';
import 'package:book_exchange/data/services/dio_service.dart';
import 'package:book_exchange/data/services/end_points.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dio/dio.dart';
import '../../presentation/models/user_model.dart';
import '../entities/jwt_response.dart';
import '../entities/user.dart';

final userRepoProvider = Provider<UserRepo>((ref) => UserRepo());

class UserRepo {
  String? uid;
  UserModel? userModel;
  late String jwtToken;
  late User user;

  Future<ApiResponse<JwtResponse>> login(
    String username,
    String password,
  ) async {
    try {
      final body = {
        "username": username,
        "password": password,
      };
      final response = await DioService().dio.post(Endpoints.login, data: body);
      return ApiResponse<JwtResponse>(
        data: JwtResponse.fromMap(response.data['data']),
        statusCode: response.data['statusCode'],
        message: response.data['message'],
      );
    } on DioError catch (e) {
      throw DioExceptions.fromDioError(e).toString();
    }
  }

  Future<ApiResponse<String>> register(
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
      return ApiResponse<String>(
        data: response.data['data'],
        statusCode: response.data['statusCode'],
        message: response.data['message'],
      );
    } on DioError catch (e) {
      throw DioExceptions.fromDioError(e).toString();
    }
  }

  Future<ApiResponse<bool>> checkExistUsername(
    String username,
  ) async {
    try {
      final body = {
        "username": username,
      };
      final response =
          await DioService().dio.post(Endpoints.username, data: body,options: Options(headers: {"Authorization":""}));
      return ApiResponse<bool>(
        data: response.data['data'],
        statusCode: response.data['statusCode'],
        message: response.data['message'],
      );
    } on DioError catch (e) {
      throw DioExceptions.fromDioError(e).toString();
    }
  }
}
