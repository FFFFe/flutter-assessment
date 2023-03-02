// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'contact_bloc.dart';

abstract class ContactEvent extends Equatable {
  const ContactEvent();

  @override
  List<Object> get props => [];
}

class FetchContactEvent extends ContactEvent {
  final int page;
  const FetchContactEvent({
    this.page = 1,
  });

  @override
  List<Object> get props => [page];
}

class AddContactEvent extends ContactEvent {
  final ContactList contact;
  const AddContactEvent({
    required this.contact,
  });

  @override
  List<Object> get props => [contact];
}

class DeleteContactEvent extends ContactEvent {
  final String id;
  const DeleteContactEvent({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}

class MarkFavouriteContactEvent extends ContactEvent {
  final String id;
  const MarkFavouriteContactEvent({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}

class UpdateContactEvent extends ContactEvent {}
