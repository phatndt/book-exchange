import 'dart:typed_data';

import 'package:book_exchange/data/services/book_service.dart';
import 'package:book_exchange/domain/repository/book_repo.dart';
import 'package:cloudinary_sdk/src/models/cloudinary_response.dart';

class BookRepoImpl extends BookRepo {
  final BookService _bookService;

  BookRepoImpl(this._bookService);

  @override
  Future<CloudinaryResponse> updateImageToCloudinary(
    String imagePath,
    Future<Uint8List> fileBytes,
    String imageName,
  ) async {
    return await _bookService.uploadImageToCloudinary(
      imagePath,
      fileBytes,
      imageName,
    );
  }
}
