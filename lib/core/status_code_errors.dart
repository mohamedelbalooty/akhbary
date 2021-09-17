import 'server_exception.dart';

dynamic returnResponse(var response) {
  switch (response.statusCode) {
    case 400:
      return BadRequestException().errorResult();
    case 401:
    case 403:
      return UnauthorisedException().errorResult();
    case 500:
    case 503:
    default:
      return FetchDataException().errorResult();
  }
}