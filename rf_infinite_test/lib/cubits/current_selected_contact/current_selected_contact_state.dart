// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'current_selected_contact_cubit.dart';

class CurrentSelectedContactState extends Equatable {
  final ContactList selectedContact;
  CurrentSelectedContactState({
    required this.selectedContact,
  });

  factory CurrentSelectedContactState.initial() {
    return CurrentSelectedContactState(selectedContact: ContactList.initial());
  }

  @override
  List<Object> get props => [selectedContact];

  @override
  bool get stringify => true;

  CurrentSelectedContactState copyWith({
    ContactList? selectedContact,
  }) {
    return CurrentSelectedContactState(
      selectedContact: selectedContact ?? this.selectedContact,
    );
  }
}
