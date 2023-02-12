import 'package:flutter/material.dart';

sbDisplayDialog(
  BuildContext context, {
  String? title,
  String? message,
  String? option1Text,
  Function()? option1Action,
  String? option2Text,
  Function()? option2Action,
}) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return Expanded(
        child: SimpleDialog(
          title: Center(
            child: Text(
              title ?? '',
              style: TextStyle(color: Colors.red.shade700),
            ),
          ),
          children: [
            if (message != null)
              Text(
                message,
                textAlign: TextAlign.center,
              ),
            if (option1Text != null)
              SimpleDialogOption(
                onPressed: () {
                  if (option1Action != null) option1Action();
                  Navigator.pop(context, "Send email");
                },
                child: Center(
                    child: Text(
                  option1Text,
                  style: TextStyle(
                    color: Colors.red.shade700,
                    fontWeight: FontWeight.bold,
                  ),
                )),
              ),
            if (option2Text != null)
              SimpleDialogOption(
                onPressed: () {
                  if (option2Action != null) option2Action();
                  Navigator.pop(context, "Send email");
                },
                child: Center(
                    child: Text(
                  option2Text,
                  style: TextStyle(
                    color: Colors.red.shade700,
                    fontWeight: FontWeight.bold,
                  ),
                )),
              ),
          ],
          elevation: 10,
        ),
      );
    },
  );
}
