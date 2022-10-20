import 'dart:typed_data';

import 'package:cloudinary_sdk/cloudinary_sdk.dart';

abstract class UploadImageToCloudinaryUseCase {
  Future<CloudinaryResponse> uploadImageToCloudinary(
    String imagePath,
    Future<Uint8List> fileBytes,
    String imageName,
  );
}
