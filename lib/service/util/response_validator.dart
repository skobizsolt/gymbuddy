import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:gymbuddy/components/custom_snackbars.dart';

class ResponseValidator {
  static validateResponse(Response response, BuildContext context) {
    if (!response.isSuccessful) {
      showErrorSnackBar(context,
          "An error occured when creating this training. Please try again later!");
      throw Exception(response.error);
    }
  }
}
