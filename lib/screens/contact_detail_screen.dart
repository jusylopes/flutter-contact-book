import 'package:flutter/material.dart';
import 'package:flutter_contact_book/models/contact_model.dart';
import 'package:flutter_contact_book/utils/colors.dart';
import 'dart:io';
import 'package:share_plus/share_plus.dart';

class ContactDetailScreen extends StatelessWidget {
  const ContactDetailScreen({super.key, required this.contact});

  final ContactModel contact;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Column(children: [
            Container(
              padding: const EdgeInsets.only(bottom: 10),
              height: screenHeight / 2,
              child: Image.file(
                File(contact.imgUrl!),
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            ContactListTile(
              title: contact.name,
              label: 'Name',
              icon: Icons.person,
            ),
            ContactListTile(
                title: contact.phoneNumber,
                label: 'Phone Number',
                icon: Icons.phone),
            ContactListTile(
              title: contact.email ?? '',
              label: 'Email',
              icon: Icons.email,
            ),
            ContactListTile(
              title: 'Share contact',
              label: 'Share',
              icon: Icons.share,
              onTap: () {
                _shareContact(context);
              },
            ),
          ]),
          SafeArea(
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              color: Colors.black,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }

  void _shareContact(BuildContext context) {
    final String shareText = '''
    Name: ${contact.name}
    Phone Number: ${contact.phoneNumber}
    Email: ${contact.email ?? 'N/A'}
    ''';

    Share.share(shareText);
  }
}

class ContactListTile extends StatelessWidget {
  final String label;
  final String title;
  final IconData icon;
  final VoidCallback? onTap;

  const ContactListTile(
      {super.key,
      required this.label,
      required this.title,
      required this.icon,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: ListTile(
          leading: Icon(
            icon,
            size: 32,
          ),
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          subtitle: Text(
            label,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
      ),
    );
  }
}
