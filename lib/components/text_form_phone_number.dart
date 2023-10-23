import 'package:flutter/material.dart';
import 'package:flutter_contact_book/utils/phone_input_formatter.dart';

class TextFormPhoneNumber extends StatelessWidget {
  const TextFormPhoneNumber({
    super.key,
    required TextEditingController phoneNumberController,
  }) : _phoneNumberController = phoneNumberController;

  final TextEditingController _phoneNumberController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextFormField(
        keyboardType: TextInputType.phone,
        textInputAction: TextInputAction.next,
        onEditingComplete: () => FocusScope.of(context).nextFocus(),
        controller: _phoneNumberController,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: 'Phone Number',
        ),
        inputFormatters: [PhoneInputFormatter()],
        validator: (value) {
          if (value == null || value.isEmpty || value.length <= 9) {
            return 'Invalid format';
          }
          return null;
        },
      ),
    );
  }
}
