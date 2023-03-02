// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rf_infinite_test/constants/constants.dart';
import 'package:rf_infinite_test/exceptions/contact_exception.dart';
import 'package:rf_infinite_test/models/contact.dart';
import 'package:rf_infinite_test/services/error_handler_service.dart';

class ContactApiService {
  final http.Client httpClient;
  ContactApiService({
    required this.httpClient,
  });

  Future<Contact> getContact(int? page) async {
    final Uri uri = Uri(
      scheme: 'https',
      host: kContactHost,
      path: '/api/users',
      queryParameters: {
        'page': page.toString(),
      },
    );

    try {
      final http.Response response = await httpClient.get(uri);

      if (response.statusCode != 200) {
        throw httpErrorHandler(response);
      }

      final responseBody = json.decode(response.body);

      if (responseBody.isEmpty) {
        throw ContactException();
      }

      final Contact contact = Contact.fromJson(responseBody);

      return contact;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addContact() async {
    final Uri uri = Uri(
      scheme: 'https',
      host: kContactHost,
      path: '/users',
      queryParameters: {},
    );

    try {
      final http.Response response = await httpClient.post(uri);

      if (response.statusCode != 201) {
        throw httpErrorHandler(response);
      }
    } catch (e) {
      rethrow;
    }
  }
}
