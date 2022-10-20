import 'package:book_exchange/data/repos/book_repo_impl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../data/services/book_service.dart';
import '../../domain/use_cases/upload_image_to_cloudinary_use_case_impl.dart';
import '../view_models/add_book_viewmodels.dart';

final bookServiceProvider = Provider<BookService>((ref) => BookService());

final bookRepoProvider = Provider<BookRepoImpl>(
    (ref) => BookRepoImpl(ref.watch(bookServiceProvider)));

final uploadImageToCloudinaryUseCaseProvider =
    Provider<UploadImageToCloudinaryUseCaseImpl>((ref) =>
        UploadImageToCloudinaryUseCaseImpl(ref.watch(bookRepoProvider)));


final addBookSettingNotifierProvider =
    StateNotifierProvider<AddBookSettingNotifier, AddBookSetting>(
        ((ref) => AddBookSettingNotifier(ref, ref.watch(uploadImageToCloudinaryUseCaseProvider))));
