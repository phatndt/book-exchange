class ApiResponse<T> {
  final T data;
  final int statusCode;
  final String message;

  ApiResponse(
      {required this.data, required this.statusCode, required this.message});

  Map<dynamic, dynamic> toMap() {
    return {
      'data': data,
      'statusCode': statusCode,
      'message': message,
    };
  }

  factory ApiResponse.fromMap(Map<dynamic, dynamic> map) {
    return ApiResponse(
      data: map['data'],
      statusCode: map['statusCode'],
      message: map['message'],
    );
  }
}
