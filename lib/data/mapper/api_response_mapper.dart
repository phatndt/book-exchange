import 'package:book_exchange/data/base/base_mapper.dart';
import 'package:book_exchange/data/entities/api_response_dto.dart';
import 'package:book_exchange/data/entities/jwt_response_dto.dart';
import 'package:book_exchange/data/mapper/jwt_response_mapper.dart';
import 'package:book_exchange/domain/entities/api_response.dart';
import 'package:book_exchange/domain/entities/jwt_response.dart';

class ApiJwtResponseMapper extends BaseMapper<ApiResponseDTO<JwtResponseDTO>,
    ApiResponse<JwtResponse>> {
  @override
  ApiResponse<JwtResponse> transfer(ApiResponseDTO<JwtResponseDTO> d) {
    return ApiResponse(
      data: JwtResponseMapper().transfer(d.data),
      statusCode: d.statusCode,
      message: d.message,
    );
  }
}


class ApiStringResponseMapper extends BaseMapper<ApiResponseDTO<String>,
    ApiResponse<String>> {
  @override
  ApiResponse<String> transfer(ApiResponseDTO<String> d) {
    return ApiResponse(
      data: d.data,
      statusCode: d.statusCode,
      message: d.message,
    );
  }
}


class ApiBoolResponseMapper extends BaseMapper<ApiResponseDTO<bool>,
    ApiResponse<bool>> {
  @override
  ApiResponse<bool> transfer(ApiResponseDTO<bool> d) {
    return ApiResponse(
      data: d.data,
      statusCode: d.statusCode,
      message: d.message,
    );
  }
}


