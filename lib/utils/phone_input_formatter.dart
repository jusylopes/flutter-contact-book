import 'package:flutter/services.dart';

class PhoneInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    String text = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (text.length > 10) {
      text = text.substring(0, 10);
    }

    final StringBuffer newText = StringBuffer();
    if (text.isNotEmpty) {
      newText.write('(${text.substring(0, 3)}');
    }
    if (text.length > 3) {
      newText.write('( ${text.substring(3, 6)}');
    }
    if (text.length > 6) {
      newText.write('-${text.substring(6)}');
    }

    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}