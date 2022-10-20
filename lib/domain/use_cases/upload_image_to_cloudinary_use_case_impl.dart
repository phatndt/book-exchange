import 'dart:typed_data';

import 'package:book_exchange/domain/use_cases/upload_image_to_cloudinary_use_case.dart';
import 'package:cloudinary_sdk/src/models/cloudinary_response.dart';

import '../repository/book_repo.dart';

class UploadImageToCloudinaryUseCaseImpl
    extends UploadImageToCloudinaryUseCase {
  final BookRepo _bookRepo;

  UploadImageToCloudinaryUseCaseImpl(this._bookRepo);

  @override
  Future<CloudinaryResponse> uploadImageToCloudinary(
    String imagePath,
    Future<Uint8List> fileBytes,
    String imageName,
  ) async {
    return await _bookRepo.updateImageToCloudinary(imagePath, fileBytes, imageName);
  }
}
