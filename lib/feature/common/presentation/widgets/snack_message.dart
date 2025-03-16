import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

enum SnackMessageType { error, success, warning }

void showSnackMessage({
  required String message,
  required BuildContext context,
  SnackMessageType type = SnackMessageType.success,
}) {
  final toastificationType = type == SnackMessageType.error
      ? ToastificationType.error
      : type == SnackMessageType.warning
      ? ToastificationType.warning
      : ToastificationType.success;

  toastification.show(
    context: context,
    type: toastificationType,
    applyBlurEffect: false,
    style: ToastificationStyle.flatColored,
    title: Text(
      type == SnackMessageType.error
          ? 'Error'
          : type == SnackMessageType.warning
          ? 'Warning'
          : 'Success',
    ),
    description: Text(message),
    showProgressBar: false,
    alignment: Alignment.topCenter,
    autoCloseDuration: const Duration(seconds: 3),
    borderRadius: BorderRadius.circular(12),
  );
}