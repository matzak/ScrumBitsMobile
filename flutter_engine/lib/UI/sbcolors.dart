import 'package:flutter/material.dart';

final Map<int, Color> _red700Map = {
  50: Color(Colors.red.shade700.value),
  100: Colors.red[100]!,
  200: Colors.red[200]!,
  300: Colors.red[300]!,
  400: Colors.red[400]!,
  500: Colors.red[500]!,
  600: Colors.red[600]!,
  700: Colors.red[800]!,
  800: Colors.red[900]!,
  900: Colors.red[700]!,
};

class SBColors {
  static final MaterialColor sbRed =
      MaterialColor(Colors.red.shade700.value, _red700Map);
}
