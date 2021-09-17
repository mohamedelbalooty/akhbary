import 'package:akhbary_app/model/error_result.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

abstract class ServerException {
  ErrorResult errorResult();
}

class BadRequestException extends ServerException {
  @override
  ErrorResult errorResult() {
    return ErrorResult(
        errorMessage: 'badRequestException'.tr(),
        errorImage: 'assets/images/bad_request_error.png');
  }
}

class UnauthorisedException extends ServerException {
  @override
  ErrorResult errorResult() {
    return ErrorResult(
        errorMessage: 'unauthorisedException'.tr(),
        errorImage: 'assets/images/unauthorised_error.png');
  }
}

class FetchDataException extends ServerException {
  @override
  ErrorResult errorResult() {
    return ErrorResult(
        errorMessage: 'fetchDataException'.tr(),
        errorImage: 'assets/images/fetch_data_error.png');
  }
}
