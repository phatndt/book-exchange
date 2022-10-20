import 'package:book_exchange/data/base/base_mapper.dart';
import 'package:book_exchange/data/entities/api_response_dto.dart';
import 'package:book_exchange/domain/entities/api_response.dart';

class ApiResponseMapper extends BaseMapper<ApiResponseDTO<String>, ApiResponse<String>> {
  @override
  ApiResponse<String> transfer(ApiResponseDTO<String> d) {
     return ApiResponse(
        data: d.data, statusCode: d.statusCode, message: d.message);
  }
}
