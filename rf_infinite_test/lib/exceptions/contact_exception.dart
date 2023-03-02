// ignore_for_file: public_member_api_docs, sort_constructors_first
class ContactException implements Exception {
  String msg;
  ContactException([this.msg = 'Something went wrong']) {
    msg = 'Contact Exception: $msg';
  }

  @override
  String toString() {
    return msg;
  }
}
