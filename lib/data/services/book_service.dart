import 'dart:developer';
import 'dart:typed_data';

import 'package:cloudinary_sdk/cloudinary_sdk.dart';

class BookService {
  Future<CloudinaryResponse> uploadImageToCloudinary(
    String imagePath,
    Future<Uint8List> fileBytes,
    String imageName,
  ) async {
    final cloudinary = Cloudinary.full(
      apiKey: '735947945251852',
      apiSecret: 'O-Rd18L74ukuNN91I8vrzBJXeGI',
      cloudName: 'du7lkcbqm',
    );

    return await cloudinary
        .uploadResource(CloudinaryUploadResource(
            filePath: imagePath,
            fileBytes: await fileBytes,
            resourceType: CloudinaryResourceType.image,
            folder: 'adu',
            fileName: imageName,
            progressCallback: (count, total) {
              log('Uploading image from file with progress: $count/$total');
            }))
        .catchError(
      (onError) {
        throw onError;
      },
    );
  }
}
