import 'package:flutter/material.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

class ProgressDialogCustom {
  static ProgressDialog createProgressDialog(
      BuildContext context, String text) {
    final BuildContext parentContext = context;
    ProgressDialog progressDialog = ProgressDialog(parentContext,
        type: ProgressDialogType.normal, isDismissible: false, showLogs: false);
    progressDialog.style(
      message: text,
      // widgetAboveTheDialog: const Text('meow'),
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      progress: 0.0,
      progressWidget: const CircularProgressIndicator(),
      progressWidgetAlignment: Alignment.center,
      textAlign: TextAlign.start,
      maxProgress: 100.0,
      progressTextStyle: const TextStyle(
          color: Colors.black, fontSize: 12.0, fontWeight: FontWeight.w400),
      messageTextStyle: const TextStyle(
          color: Colors.black, fontSize: 17.0, fontWeight: FontWeight.w600),
    );
    return progressDialog;
  }
}
