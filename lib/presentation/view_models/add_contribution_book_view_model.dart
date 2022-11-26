import 'package:book_exchange/domain/entities/book_contribution.dart';
import 'package:book_exchange/domain/use_cases/book_contribution/upload_contribution_book_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../core/extension/function_extension.dart';
import '../../core/route_paths.dart';
import '../di/book_component.dart';
import '../models/book_app_model.dart';
import 'collection_viewmodels.dart';

class AddContributionBookSetting {
  final ContributionBook contributionBook;
  bool isLoadingContributionBook = false;
  final TextEditingController normalBarcode;
  final TextEditingController isbnBarcode;
  AddContributionBookSetting({
    required this.contributionBook,
    required this.isLoadingContributionBook,
    required this.isbnBarcode,
    required this.normalBarcode,
  });

  AddContributionBookSetting copy({
    ContributionBook? contributionBook,
    bool? isLoadingContributionBook,
    TextEditingController? normalBarcode,
    TextEditingController? isbnBarcode,
  }) =>
      AddContributionBookSetting(
        isbnBarcode: isbnBarcode ?? this.isbnBarcode,
        normalBarcode: normalBarcode ?? this.normalBarcode,
        contributionBook: contributionBook ?? this.contributionBook,
        isLoadingContributionBook:
            isLoadingContributionBook ?? this.isLoadingContributionBook,
      );
}

class AddContributionBookSettingNotifier
    extends StateNotifier<AddContributionBookSetting> {
  AddContributionBookSettingNotifier(
      this.ref, this._uploadContributionBookUseCase)
      : super(
          AddContributionBookSetting(
            isbnBarcode: TextEditingController(),
            normalBarcode: TextEditingController(),
            isLoadingContributionBook: false,
            contributionBook: ContributionBook(
              id: '',
              name: '',
              author: '',
              description: '',
              imageUrl: '',
              delete: false,
              verified: false,
              normalBarcode: '',
              isbnBarcode: '',
            ),
          ),
        );

  final Ref ref;
  final UploadContributionBookUseCase _uploadContributionBookUseCase;

  void setLoadingContributiontBook() {
    final newState =
        state.copy(isLoadingContributionBook: !state.isLoadingContributionBook);
    state = newState;
  }

  void clearInput() {
    state.isbnBarcode.text = '';
    state.normalBarcode.text = '';
  }

  Future<String> scanBarcode(String barcodeScanRes) async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      return (barcodeScanRes);
    } on PlatformException {
      return barcodeScanRes = 'Failed to get platform version.';
    }
  }

  bool checkInput(context) {
    if (state.isbnBarcode.text.isEmpty || state.normalBarcode.text.isEmpty) {
      showTopSnackBar(
        context,
        const CustomSnackBar.info(
          message: "Fill out all the Barcodes",
        ),
        displayDuration: const Duration(seconds: 2),
      );
      return false;
    } else {
      return true;
    }
  }

  void contributeBook(context, ContributionBook contributionBook) async {
    await _uploadContributionBookUseCase
        .uploadContributionBook(contributionBook, BookAppModel.jwtToken)
        .then(
      (value) {
        Navigator.pushNamed(
          context,
          RoutePaths.main,
        );
        ref.refresh(getListBookProvider(ref.watch(getListBookUseCaseProvider)));
        showTopSnackBar(
          context,
          CustomSnackBar.error(
            message: value.message,
          ),
          displayDuration: const Duration(seconds: 2),
        );
        clearInput();
        // setLoadingContributiontBook;
      },
    ).catchError((onError) {
      // setLoadingContributiontBook();
      catchOnError(context, onError);
    });
  }
}
