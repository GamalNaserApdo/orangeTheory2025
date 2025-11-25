import 'package:flutter/material.dart';
import 'package:otfksa2/utils/app_styles.dart';

class DialogUtils {
  static void showLoading({
    required BuildContext context,
    required String textLoading,
  }) {
    showDialog(
      // de ele ptmna3 el user yknsel el loading
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(textLoading),
            ),
          ],
        ),
      ),
    );
  }

  static void hideLoading({required BuildContext context}) {
    Navigator.pop(context);
  }

  static void showMessage({
    required BuildContext context,
    required String message,
    String? title,
    String? postiveActionName,
    // 3ashan law el positive action ele hwa oky or yes da py3mel action moa2en
    Function? posAction,
    String? negActionName,
    Function? negAction,
    bool barrierDismissible = true,
  }) {
    List<Widget>? actions = [];

    if (postiveActionName != null) {
      actions.add(
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            // hena law el function feha 7aga 7ynfzha mesh feha 7ynafez el Navigate
            posAction?.call();
          },
          child: Text(postiveActionName, style: AppStyles.medium16Black),
        ),
      );
    }
    if (negActionName != null) {
      actions.add(
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            negAction?.call();
          },
          child: Text(negActionName, style: AppStyles.medium16Black),
        ),
      );
    }

    showDialog(
      barrierDismissible: barrierDismissible,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(message, style: AppStyles.medium16Primary),
          title: Text(title ?? "Title", style: AppStyles.medium16Primary),
          actions: actions,
        );
      },
    );
  }
}
