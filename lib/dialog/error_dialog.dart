import 'package:flutter/material.dart';
import 'package:flutter_chat_app/widget/button/primary_button.dart';

class ErrorDialog extends StatelessWidget {
  final String text;
  ErrorDialog(this.text);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      title: Text(text),
      actions: <Widget>[
        PrimaryButton(
          text: '閉じる',
          onPressed: () => Navigator.of(context).pop(),
        )
      ],
    );
  }
}
