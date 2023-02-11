import 'package:flutter/material.dart';

Widget sbInput(BuildContext context,
    {String? description,
    String? hint,
    Function(String)? onChanged,
    TextInputType? keyboardType,
    bool password = false}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Text(
          description ?? '',
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Colors.red.shade700,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      TextFormField(
        keyboardType: keyboardType,
        obscureText: password,
        enableSuggestions: !password,
        autocorrect: !password,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey),
          filled: true,
          fillColor: Colors.white,
        ),
        onChanged: (String value) {
          if (onChanged != null) {
            onChanged(value);
          }
        },
      ),
    ],
  );
}
