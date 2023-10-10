import 'package:flutter/material.dart';
import 'package:flutter_contact_book/blocs/register/register_blocs_exports.dart'; // Certifique-se de importar corretamente o pacote Bloc

class ContactDeleteDialogService {
  static Future<bool?> confirmDismissDialog({
    required BuildContext context,
    required String objectId,
  }) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirme'),
          content:
              const Text('Are you sure you want to remove this contact?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                BlocProvider.of<RegisterContactBloc>(context).add(DeleteContact(objectId));
                Navigator.of(context).pop(true);
              },
              child: const Text('REMOVE'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('CANCEL'),
            ),
          ],
        );
      },
    );
  }
}