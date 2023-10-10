import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_contact_book/models/contact_model.dart';
import 'package:flutter_contact_book/screens/contact_detail_screen.dart';
import 'package:flutter_contact_book/screens/contact_update_screen.dart';
import 'package:flutter_contact_book/utils/colors.dart';
import 'package:flutter_contact_book/utils/contact_delete_dialog_service.dart';

class CardContact extends StatelessWidget {
  const CardContact({
    super.key,
    required this.backgroundColorListTile,
    required this.contact,
  });

  final Color backgroundColorListTile;
  final ContactModel contact;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ContactDetailScreen(contact: contact),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: backgroundColorListTile,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: ListTile(
          leading: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.primaryColor,
                width: 2.0,
              ),
            ),
            child: CircleAvatar(
              backgroundImage:
                  (contact.imgUrl != null && contact.imgUrl!.isNotEmpty)
                      ? FileImage(File(contact.imgUrl!))
                      : const AssetImage('assets/placeholder_image.png')
                          as ImageProvider<Object>,
            ),
          ),
          title: Text(
            contact.name,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          subtitle: Text(
            contact.phoneNumber,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          trailing: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: PopupMenuButton(
              itemBuilder: (context) => [
                const PopupMenuItem<String>(
                  value: 'edit',
                  child: ListTile(
                    leading: Icon(Icons.edit),
                    title: Text('Edit'),
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'remove',
                  child: ListTile(
                    leading: Icon(Icons.delete),
                    title: Text('Remove'),
                  ),
                ),
              ],
              onSelected: (String value) {
                if (value == 'edit') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ContactUpdateScreen(contact: contact)),
                  );
                } else if (value == 'remove') {
                  ContactDeleteDialogService.confirmDismissDialog(
                      context: context, objectId: contact.objectId!);
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
