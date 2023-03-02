// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rf_infinite_test/blocs/contact/contact_bloc.dart';
import 'package:rf_infinite_test/cubits/filter/filter_cubit.dart';
import 'package:rf_infinite_test/cubits/search/search_cubit.dart';
import 'package:rf_infinite_test/models/contact.dart';

part 'filtered_contact_state.dart';

class FilteredContactCubit extends Cubit<FilteredContactState> {
  final List<ContactList> initialContact;
  final ContactBloc contactBloc;
  final SearchCubit searchCubit;
  final FilterCubit filterCubit;
  late final StreamSubscription contactStream;
  late final StreamSubscription searchStream;
  late final StreamSubscription filterStream;
  FilteredContactCubit({
    required this.initialContact,
    required this.contactBloc,
    required this.searchCubit,
    required this.filterCubit,
  }) : super(FilteredContactState(filteredContactList: initialContact)) {
    print('initial contact: ${initialContact}');

    contactStream = contactBloc.stream.listen((state) {
      _setFilteredContact();
    });
    searchStream = searchCubit.stream.listen((state) {
      _setFilteredContact();
    });
    filterStream = filterCubit.stream.listen((state) {
      _setFilteredContact();
    });
  }

  void _setFilteredContact() {
    List<ContactList> filteredContactList;

    switch (filterCubit.state.contactFilter) {
      case ContactFilter.favourite:
        filteredContactList = contactBloc.state.contactList
            .where((contact) => contact.favourite)
            .toList();
        break;
      case ContactFilter.all:
      default:
        filteredContactList = contactBloc.state.contactList;
        break;
    }

    if (searchCubit.state.searchTerm.isNotEmpty) {
      filteredContactList = contactBloc.state.contactList
          .where((contact) =>
              '${contact.firstName} ${contact.lastName}'
                  .toLowerCase()
                  .contains(searchCubit.state.searchTerm) ||
              contact.email
                  .toLowerCase()
                  .contains(searchCubit.state.searchTerm))
          .toList();
    }

    emit(state.copyWith(filteredContactList: filteredContactList));
  }

  @override
  Future<void> close() {
    contactStream.cancel();
    searchStream.cancel();
    filterStream.cancel();
    return super.close();
  }
}
