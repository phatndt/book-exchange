import 'package:book_exchange/presentation/models/jwt_respone.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dio/dio.dart';
import '../../presentation/models/user_model.dart';

final userRepoProvider = Provider<UserRepo>((ref) => UserRepo());

class UserRepo {
  String? uid;
  UserModel? userModel;
  JwtRespone? jwtRespone;

  Future<JwtRespone> login(
    String username,
    String password,
  ) async {
    try {
      final api =
          'https://book-exchange-backend-production.up.railway.app/v1/authentication/login';
      final data = {
        "username": username,
        "password": password,
      };
      final dio = Dio();
      Response response;
      response = await dio.post(api, data: data);
      if (response.statusCode == 200) {
        final body = response.data;
        return JwtRespone(token: body['token']);
      } else {
        return JwtRespone(token: 'token');
      }
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint('Dio error!');
        debugPrint('STATUS: ${e.response?.statusCode}');
        debugPrint('DATA: ${e.response?.data}');
        debugPrint('HEADERS: ${e.response?.headers}');
      } else {
        // Error due to setting up or sending the request
        debugPrint('Error sending request!');
        debugPrint(e.message);
      }
      return JwtRespone(token: 'token');
    }
  }
}
