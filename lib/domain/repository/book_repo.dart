import 'dart:typed_data';

import 'package:cloudinary_sdk/cloudinary_sdk.dart';

abstract class BookRepo {
  Future<CloudinaryResponse> updateImageToCloudinary(
    String imagePath,
    Future<Uint8List> fileBytes,
    String imageName,
  );
}
