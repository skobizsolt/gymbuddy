import 'package:chopper/chopper.dart';

class ResponseValidator {
  static validateResponse(Response response) {
    if (!response.isSuccessful) {
      throw Exception(response.error);
    }
  }
}
