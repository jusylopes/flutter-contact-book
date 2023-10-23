import 'package:dio/dio.dart';
import 'package:flutter_contact_book/models/contact_model.dart';

class ContactRepository {
  final Dio dio;
  final Map<String, String> _headers;

  ContactRepository({required this.dio})
      : _headers = {
          'X-Parse-Application-Id': _applicationId,
          'X-Parse-REST-API-Key': _apiKey,
          'Content-Type': 'application/json',
        };

  static const String _baseUrlBack4app =
      'https://parseapi.back4app.com/classes/contact';
  static const String _applicationId =
      'IWJlH52mAMcmk9AQMUV9d1JvWCkVJfASpNtSjQ7G';
  static const String _apiKey = '3Y5XhlOTqDGekIVQlRYHewuhzK2fOYfhOr3B1NGe';

  Future<List<ContactModel>> fetchAllContacts() async {
    try {
      Response response =
          await dio.get(_baseUrlBack4app, options: Options(headers: _headers));
      final data = response.data['results'] as List<dynamic>;

      final List<ContactModel> contacts = data
          .map((item) => ContactModel.fromMap(item as Map<String, dynamic>))
          .toList();

      return contacts;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ContactModel>> fetchAllContactsSorted() async {
    List<ContactModel> allContacts = await fetchAllContacts();
    allContacts.sort((a, b) => a.name.compareTo(b.name));

    return allContacts;
  }

  Future<List<ContactModel>> searchContact({required query}) async {
    try {
      final Map<String, dynamic> queryParams = {
        'where': {
          'name': {
            '\$regex': '.*$query.*',
            '\$options': 'i',
          }
        }
      };

      Response response = await dio.get(
        _baseUrlBack4app,
        queryParameters: queryParams,
        options: Options(headers: _headers),
      );
      final data = response.data['results'] as List<dynamic>;

      final List<ContactModel> contacts = data
          .map((item) => ContactModel.fromMap(item as Map<String, dynamic>))
          .toList();

      return contacts;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addContact(ContactModel newContact) async {
    try {
      await dio.post(
        _baseUrlBack4app,
        options: Options(headers: _headers),
        data: newContact.toJson(),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteContact(String objectId) async {
    try {
      await dio.delete(
        '$_baseUrlBack4app/$objectId',
        options: Options(headers: _headers),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateContact(ContactModel updatedContact) async {
    try {
      await dio.put(
        '$_baseUrlBack4app/${updatedContact.objectId}',
        options: Options(headers: _headers),
        data: updatedContact.toJson(),
      );
    } catch (e) {
      rethrow;
    }
  }
}
