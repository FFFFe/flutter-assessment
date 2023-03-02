import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:rf_infinite_test/cubits/current_selected_contact/current_selected_contact_cubit.dart';
import 'package:rf_infinite_test/models/contact.dart';
import 'package:rf_infinite_test/models/custom_error.dart';
import 'package:rf_infinite_test/repositories/contact_repository.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> with HydratedMixin {
  final ContactRepository contactRepository;
  final CurrentSelectedContactCubit currentSelectedContactCubit;
  late final StreamSubscription currentSelectedContactStream;
  ContactBloc(
      {required this.contactRepository,
      required this.currentSelectedContactCubit})
      : super(ContactState.initial()) {
    currentSelectedContactStream = currentSelectedContactCubit.stream.listen(
      (currentSelectedContactState) {
        add(UpdateContactEvent());
      },
    );

    on<ContactEvent>(
      (event, emit) async {
        if (event is FetchContactEvent) {
          await _fetchContact(event, emit);
        } else if (event is AddContactEvent) {
          _addContact(event, emit);
        } else if (event is DeleteContactEvent) {
          _deleteContact(event, emit);
        } else if (event is MarkFavouriteContactEvent) {
          _markFavourite(event, emit);
        } else if (event is UpdateContactEvent) {
          _updateContactList(event, emit);
        }
      },
      transformer: droppable(),
    );
  }

  Future<void> _fetchContact(
      FetchContactEvent event, Emitter<ContactState> emit) async {
    emit(state.copyWith(contactStatus: ContactStatus.loading));

    try {
      final contact = await contactRepository.fetchContact(event.page);
      final List<ContactList> contactList = contact.data;
      final List<ContactList> newContact = [];

      if (contact.page < contact.totalPage) {
        for (int page = contact.page + 1; page <= contact.totalPage; page++) {
          final temp = await contactRepository.fetchContact(page);
          contactList.addAll(temp.data);
        }
      }

      if (state.contactList.isNotEmpty) {
        for (var el in contact.data) {
          if (state.contactList
              .where((contact) => contact.id == el.id)
              .isEmpty) {
            newContact.add(el);
          }
        }
        emit(state.copyWith(
            contactStatus: ContactStatus.loaded,
            contactList: [...state.contactList, ...newContact]));
      } else {
        emit(state.copyWith(
          contactStatus: ContactStatus.loaded,
          contactList: contactList,
          customError: const CustomError(),
        ));
      }
    } on CustomError catch (e) {
      emit(state.copyWith(contactStatus: ContactStatus.error, customError: e));
    }
  }

  void _addContact(AddContactEvent event, Emitter<ContactState> emit) {
    emit(state.copyWith(
        contactStatus: ContactStatus.loaded,
        contactList: [...state.contactList, event.contact]));
  }

  void _deleteContact(DeleteContactEvent event, Emitter<ContactState> emit) {
    emit(state.copyWith(contactStatus: ContactStatus.loading));

    final List<ContactList> newContact =
        state.contactList.where((contact) => contact.id != event.id).toList();

    emit(state.copyWith(
        contactStatus: ContactStatus.loaded, contactList: newContact));
  }

  void _markFavourite(
      MarkFavouriteContactEvent event, Emitter<ContactState> emit) {
    emit(state.copyWith(contactStatus: ContactStatus.loading));

    final List<ContactList> newContact = state.contactList.map((contact) {
      if (event.id == contact.id) {
        return contact.copyWith(favourite: !contact.favourite);
      }
      return contact;
    }).toList();

    emit(state.copyWith(
        contactStatus: ContactStatus.loaded, contactList: newContact));
  }

  void _updateContactList(
      UpdateContactEvent event, Emitter<ContactState> emit) {
    emit(state.copyWith(contactStatus: ContactStatus.loading));

    final newContact = state.contactList.map(
      (contact) {
        if (contact.id ==
            currentSelectedContactCubit.state.selectedContact.id) {
          return currentSelectedContactCubit.state.selectedContact;
        }
        return contact;
      },
    ).toList();

    emit(state.copyWith(
        contactStatus: ContactStatus.loaded, contactList: newContact));
  }

  @override
  ContactState? fromJson(Map<String, dynamic> json) {
    try {
      print('From Json');
      print('Contact json: $json');
      final contactState = ContactState.fromJson(json);
      print('Contact state: $contactState');
      return contactState;
    } catch (e, stacktrace) {
      print(e);
      print(stacktrace);
    }
  }

  @override
  Map<String, dynamic>? toJson(ContactState state) {
    try {
      print('To Json');
      print('Contact state: $state');
      final contactJson = state.toJson();
      // print('Contact json: $contactJson');
      return contactJson;
    } catch (e, stacktrace) {
      print(e);
      print(stacktrace);
    }
  }

  @override
  Future<void> close() {
    currentSelectedContactStream.cancel();
    return super.close();
  }
}
