import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';

class FlushBarNotification {
  static dynamic showErrorMessage({
    @required BuildContext context,
    String title = '',
    @required String message,
  }) {
    FlushbarHelper.createError(
      message: message,
      title: title,
      duration: Duration(
        seconds: 10,
      ),
    )..show(context);
  }

  static dynamic showSuccessMessage({
    @required BuildContext context,
    String title = '',
    @required String message,
  }) {
    FlushbarHelper.createSuccess(
      message: message,
      title: title,
      duration: Duration(
        seconds: 10,
      ),
    )..show(context);
  }

  static dynamic showInfoMessage({
    @required BuildContext context,
    String title = '',
    @required String message,
  }) {
    FlushbarHelper.createInformation(
      message: message,
      title: title,
      duration: Duration(
        seconds: 10,
      ),
    )..show(context);
  }
}
