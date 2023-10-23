import 'package:flutter/material.dart';
import 'package:flutter_contact_book/blocs/enum/bloc_status.dart';
import 'package:flutter_contact_book/blocs/register/register_blocs_exports.dart';
import 'package:flutter_contact_book/components/custom_circular_progress_indicator.dart';
import 'package:flutter_contact_book/components/text_form_email.dart';
import 'package:flutter_contact_book/components/text_form_name.dart';
import 'package:flutter_contact_book/components/text_form_phone_number.dart';
import 'package:flutter_contact_book/models/contact_model.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ContactRegisterScreen extends StatefulWidget {
  const ContactRegisterScreen({super.key});

  @override
  State<ContactRegisterScreen> createState() => _ContactRegisterScreenState();
}

class _ContactRegisterScreenState extends State<ContactRegisterScreen> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneNumberController;
  String? _selectedImagePath;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();

    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneNumberController = TextEditingController();
  }

  void _addContact() async {
    BlocProvider.of<RegisterContactBloc>(context).add(
      CreateContact(
        newContact: ContactModel(
          name: _nameController.text,
          phoneNumber: _phoneNumberController.text,
          email: _emailController.text,
          imgUrl: _selectedImagePath,
        ),
      ),
    );
  }

  Future<void> _selectImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImagePath = pickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterContactBloc, RegisterContactState>(
        builder: (context, state) {
      return Stack(
        children: [
          Opacity(
            opacity: state.status == BlocStatus.loading ? 0.3 : 1.0,
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Scaffold(
                appBar: AppBar(
                  title: Text(
                    'New Contact',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  leading: IconButton(
                    icon: const Icon(Icons.close),
                    color: Colors.black,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                body: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: 150,
                          width: 150,
                          margin: const EdgeInsets.all(12),
                          child: CircleAvatar(
                              backgroundImage: _selectedImagePath != null
                                  ? FileImage(File(_selectedImagePath!))
                                  : null,
                              child: IconButton(
                                onPressed: () async {
                                  await _selectImage();
                                },
                                icon: const Icon(
                                  Icons.camera_alt,
                                  size: 32,
                                ),
                              )),
                        ),
                        TextFormName(nameController: _nameController),
                        TextFormPhoneNumber(
                            phoneNumberController: _phoneNumberController),
                        TextFormEmail(emailController: _emailController),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  FocusScope.of(context).unfocus();
                                  _addContact();

                                  if (state.status == BlocStatus.success) {
                                    Navigator.of(context).pop();
                                  } else if (state.status == BlocStatus.error) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(state.errorMessage!),
                                        duration: const Duration(seconds: 2),
                                      ),
                                    );
                                  }
                                }
                              },
                              child: const Text('Save'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (state.status == BlocStatus.loading)
            const CustomCircularProgressIndicator()
        ],
      );
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }
}
