// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:rf_infinite_test/exceptions/contact_exception.dart';
import 'package:rf_infinite_test/models/contact.dart';
import 'package:rf_infinite_test/models/custom_error.dart';
import 'package:rf_infinite_test/services/contact_api_service.dart';

class ContactRepository {
  final ContactApiService contactApiService;
  ContactRepository({
    required this.contactApiService,
  });

  Future<Contact> fetchContact(int? page) async {
    try {
      final Contact contact = await contactApiService.getContact(page);

      return contact;
    } on ContactException catch (e) {
      throw CustomError(errMsg: e.msg);
    } catch (e) {
      throw CustomError(errMsg: e.toString());
    }
  }

  Future<void> addContact() async {
    try {
      await contactApiService.addContact();
    } catch (e) {
      throw CustomError(errMsg: e.toString());
    }
  }
}
