import 'dart:developer';
import 'package:book_exchange/core/core.dart';

import 'package:book_exchange/data/entities/api_response.dart';

import 'package:book_exchange/data/services/dio_exception.dart';
import 'package:book_exchange/data/services/dio_service.dart';
import 'package:book_exchange/data/services/end_points.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dio/dio.dart';

import '../entities/book.dart';

final bookRepoProvider = Provider<BookRepo>((ref) => BookRepo());

class BookRepo {
  String? uid;

  late String jwtToken;
  late Book book;

  Future<ApiResponse<Book>> uploadBook(Book book, String token) async {
    try {
      final body = {
        "name": book.name,
        "author": book.author,
        "description": book.description,
        "rate": book.rate,
        "imageUrl": book.imageURL,
        "userId": book.userId
      };

      final response = await DioService().dio.post(Endpoints.uploadBook,
          // data: body,
          data: book.toMap(),
          options: Options(headers: {"Authorization": "Bearer $token"}));
      return ApiResponse<Book>(
        data: Book.fromMap(response.data['data']),
        statusCode: response.data['statusCode'],
        message: response.data['message'],
      );
    } on DioError catch (e) {
      throw DioExceptions.fromDioError(e);
    }
  }

  Future<ApiResponse<Book>> editBook(Book book, String token) async {
    try {
      // final body = {
      //   "id": book.id,
      //   "name": book.name,
      //   "author": book.author,
      //   "description": book.description,
      //   "rate": book.rate,
      //   "imageUrl": book.imageURL,
      //   "userId": book.userId
      // };
      book.toMap();

      final response = await DioService().dio.put(Endpoints.editBook,
          data: book,
          options: Options(headers: {"Authorization": "Bearer $token"}));
      return ApiResponse<Book>(
        data: Book.fromMap(response.data['data']),
        statusCode: response.data['statusCode'],
        message: response.data['message'],
      );
    } on DioError catch (e) {
      throw DioExceptions.fromDioError(e);
    }
  }

  Future<void> deleteBook(String bookId, String token) async {
    try {
      final body = {"bookId": bookId};

      // final response =
      await DioService().dio.delete(Endpoints.deleteBook,
          data: body,
          options: Options(headers: {"Authorization": "Bearer $token"}));
    } on DioError catch (e) {
      throw DioExceptions.fromDioError(e);
    }
  }

  Future<ApiResponse<List<Book>>> getBookByUserId(String token) async {
    try {
      final body = {"userId": getUserIdFromToken(token)};

      final response = await DioService().dio.post(Endpoints.getBookByUserId,
          data: body,
          options: Options(headers: {"Authorization": "Bearer $token"}));
      log(response.toString());
      var list = response.data['data'] as List;
      List<Book> T = list.map((i) => Book.fromMap(i)).toList();
      return ApiResponse<List<Book>>(
        data: T,
        statusCode: response.data['statusCode'],
        message: response.data['message'],
      );
    } on DioError catch (e) {
      throw DioExceptions.fromDioError(e);
    }
  }
}
