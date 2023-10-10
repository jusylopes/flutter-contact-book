
import 'package:flutter/material.dart';

class TextFormName extends StatelessWidget {
  const TextFormName({
    super.key,
    required TextEditingController nameController,
  }) : _nameController = nameController;

  final TextEditingController _nameController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextFormField(
        textInputAction: TextInputAction.next,
        onEditingComplete: () => FocusScope.of(context).nextFocus(),
        controller: _nameController,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: 'Name',
        ),
        validator: (value) {
          if (value == null || value.isEmpty || value.length <= 2) {
            return 'Invalid format';
          }
          return null;
        },
      ),
    );
  }
}
