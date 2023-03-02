// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'contact_bloc.dart';

enum ContactStatus {
  initial,
  loading,
  loaded,
  error;

  String toJson() => name;

  static ContactStatus fromJson(String json) => values.byName(json);
}

class ContactState extends Equatable {
  final ContactStatus contactStatus;
  final List<ContactList> contactList;
  final CustomError customError;
  const ContactState({
    required this.contactStatus,
    required this.contactList,
    required this.customError,
  });

  factory ContactState.initial() {
    return const ContactState(
        contactStatus: ContactStatus.initial,
        contactList: [],
        customError: CustomError(errMsg: ''));
  }

  @override
  List<Object> get props => [contactStatus, contactList, customError];

  @override
  bool get stringify => true;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'contactStatus': contactStatus.toJson(),
      'contactList': contactList.map((x) => x.toJson()).toList(),
      'customError': customError.toJson(),
    };
  }

  factory ContactState.fromJson(Map<String, dynamic> json) {
    return ContactState(
      contactStatus: ContactStatus.fromJson(json['contactStatus']),
      contactList: List<ContactList>.from(
        (json['contactList'] as List<dynamic>).map<ContactList>(
          (x) => ContactList.fromJson(x as Map<String, dynamic>),
        ),
      ),
      customError: CustomError.fromJson(json['customError']),
    );
  }

  ContactState copyWith({
    ContactStatus? contactStatus,
    List<ContactList>? contactList,
    CustomError? customError,
  }) {
    return ContactState(
      contactStatus: contactStatus ?? this.contactStatus,
      contactList: contactList ?? this.contactList,
      customError: customError ?? this.customError,
    );
  }
}
